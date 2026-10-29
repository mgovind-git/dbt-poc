
select
    account_id,
    trim(company_name) as company_name,
    trim(region) as region,
    cast(created_at as timestamp) as created_at
from {{ ref('bronze_hh_accounts') }}
