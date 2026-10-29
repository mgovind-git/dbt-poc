
select *
from {{ source('sales_table', 'items') }}
