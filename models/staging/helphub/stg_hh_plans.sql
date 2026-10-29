
select
    plan_id,
    trim(plan_name) as plan_name,
    lower(trim(tier)) as tier,
    cast(monthly_price as decimal(18, 2)) as monthly_price
from {{ ref('bronze_hh_plans') }}
