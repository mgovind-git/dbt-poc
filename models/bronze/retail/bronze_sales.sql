
select *
from {{ source('sales_table', 'fact_sales') }}
