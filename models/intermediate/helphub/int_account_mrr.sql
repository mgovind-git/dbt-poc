
with subs as (
    select *
    from {{ ref('stg_hh_subscriptions') }}
    where is_active = 1
),

plans as (
    select *
    from {{ ref('stg_hh_plans') }}
),

accounts as (
    select *
    from {{ ref('stg_hh_accounts') }}
),

sub_with_tier as (
    select
        s.account_id,
        s.mrr_amount,
        p.tier,
        row_number() over (
            partition by s.account_id
            order by s.mrr_amount desc, s.subscription_id
        ) as rn
    from subs s
    left join plans p
        on s.plan_id = p.plan_id
)

select
    a.account_id,
    a.company_name,
    a.region,
    max(case when swt.rn = 1 then swt.tier end) as tier,
    coalesce(sum(swt.mrr_amount), 0) as current_mrr
from accounts a
left join sub_with_tier swt
    on a.account_id = swt.account_id
group by
    a.account_id,
    a.company_name,
    a.region
