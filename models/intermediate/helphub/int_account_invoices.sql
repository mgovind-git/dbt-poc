
select
    account_id,
    sum(
        case
            when status = 'paid' then amount
            else 0
        end
    ) as total_paid,
    max(
        case
            when status in ('open', 'void') then 1
            else 0
        end
    ) as has_billing_issue
from {{ ref('stg_hh_invoices') }}
group by account_id
