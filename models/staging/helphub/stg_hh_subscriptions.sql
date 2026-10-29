
select
    subscription_id,
    account_id,
    plan_id,
    lower(trim(status)) as status,
    mrr_amount,
    cast(started_at as date) as started_at,
    cast(canceled_at as date) as canceled_at,
    cast(updated_at as timestamp) as updated_at,
    case
        when lower(trim(status)) = 'active' then 1
        else 0
    end as is_active
from {{ ref('bronze_hh_subscriptions') }}
