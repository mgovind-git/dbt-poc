
-- State selection hands-on: baseline comparison test
with sales as (
    select * from {{ ref('bronze_sales') }}
),

products as (
    select * from {{ ref('bronze_products') }}
),

customers as (
    select * from {{ ref('bronze_customer') }}
),

joined_query as (
    select
        p.category,
        c.gender,
        {{ multiply('s.unit_price', 's.quantity') }} as gross_amount
    from sales s
    inner join products p
        on s.product_sk = p.product_sk
    inner join customers c
        on s.customer_sk = c.customer_sk
)

select
    category,
    gender,
    sum(gross_amount) as total_sales
from joined_query
group by category, gender
