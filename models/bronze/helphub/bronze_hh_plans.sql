select
    plan_id,
    plan_name,
    tier,
    monthly_price
from {{ source('helphub', 'hh_plans') }}