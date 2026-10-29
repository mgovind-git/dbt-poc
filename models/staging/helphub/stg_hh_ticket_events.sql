
select
    event_id,
    account_id,
    lower(trim(event_name)) as event_name,
    cast(event_timestamp as timestamp) as event_timestamp
from {{ ref('bronze_hh_ticket_events') }}
