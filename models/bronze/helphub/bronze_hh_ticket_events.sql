select
    event_id,
    account_id,
    event_name,
    event_timestamp
from {{ source('helphub', 'hh_ticket_events') }}