
with account_mrr as (
    select
        account_id,
        region,
        tier,
        current_mrr
    from {{ ref('int_account_mrr') }}
    where current_mrr > 0
)

select
    region,
    tier,
    count(distinct account_id) as paying_accounts,
    round(sum(current_mrr), 2) as total_mrr,
    round(sum(current_mrr) * 12, 2) as total_arr
from account_mrr
group by
    region,
    tier
order by total_mrr desc
