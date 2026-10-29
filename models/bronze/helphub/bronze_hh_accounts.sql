
select
    account_id,
    company_name,
    region,
    created_at
from {{ source('helphub', 'hh_accounts') }}
