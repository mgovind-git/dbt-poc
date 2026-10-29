select
    subscription_id,
    account_id,
    plan_id,
    status,
    mrr_amount,
    started_at,
    canceled_at,
    updated_at
from {{ source('helphub', 'hh_subscriptions') }}