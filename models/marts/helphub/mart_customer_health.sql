
with accounts as (
    select *
    from {{ ref('stg_hh_accounts') }}
),

mrr as (
    select *
    from {{ ref('int_account_mrr') }}
),

invoices as (
    select *
    from {{ ref('int_account_invoices') }}
),

activity as (
    select *
    from {{ ref('int_account_activity') }}
),

joined as (
    select
        a.account_id,
        a.company_name,
        a.region,
        coalesce(m.tier, 'unknown') as tier,
        coalesce(m.current_mrr, 0) as current_mrr,
        coalesce(i.total_paid, 0) as total_paid,
        coalesce(i.has_billing_issue, 0) as has_billing_issue,
        coalesce(ac.total_events, 0) as total_events,
        coalesce(ac.tickets_created, 0) as tickets_created,
        coalesce(ac.tickets_resolved, 0) as tickets_resolved,
        coalesce(ac.tickets_reopened, 0) as tickets_reopened
    from accounts a
    left join mrr m
        on a.account_id = m.account_id
    left join invoices i
        on a.account_id = i.account_id
    left join activity ac
        on a.account_id = ac.account_id
),

scored as (
    select
        *,
        case when current_mrr = 0 then 1 else 0 end
        + case when has_billing_issue = 1 then 1 else 0 end
        + case when tickets_reopened >= 1 then 1 else 0 end
            as churn_risk_score
    from joined
)

select
    *,
    case
        when churn_risk_score >= 2 then 'High'
        when churn_risk_score = 1 then 'Medium'
        else 'Low'
    end as churn_risk_band
from scored
