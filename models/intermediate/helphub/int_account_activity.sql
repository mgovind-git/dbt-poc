
select
    account_id,
    count(*) as total_events,
    sum(
        case when event_name = 'ticket_created' then 1 else 0 end
    ) as tickets_created,
    sum(
        case when event_name = 'ticket_resolved' then 1 else 0 end
    ) as tickets_resolved,
    sum(
        case when event_name = 'ticket_reopened' then 1 else 0 end
    ) as tickets_reopened
from {{ ref('stg_hh_ticket_events') }}
group by account_id
