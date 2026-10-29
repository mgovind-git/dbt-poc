
select
    p.category,
    c.gender,
    sum(r.refund_amount) as total_refunds
from {{ ref('bronze_returns') }} r
inner join {{ ref('bronze_sales') }} s
    on r.sales_id = s.sales_id
inner join {{ ref('bronze_customer') }} c
    on s.customer_sk = c.customer_sk
inner join {{ ref('bronze_products') }} p
    on r.product_sk = p.product_sk
group by
    p.category,
    c.gender
