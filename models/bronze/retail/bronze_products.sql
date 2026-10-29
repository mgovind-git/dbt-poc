
select *
from {{ source('sales_table', 'dim_product') }}
