
select
    invoice_id,
    account_id,
    lower(trim(status)) as status,
    cast(amount as decimal(18, 2)) as amount,
    cast(invoice_date as date) as invoice_date
from {{ ref('bronze_hh_invoices') }}
