select
    invoice_id,
    account_id,
    status,
    amount,
    invoice_date
from {{ source('helphub', 'hh_invoices') }}