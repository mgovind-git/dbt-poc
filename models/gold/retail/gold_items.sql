
with ranked_items as (
    select
        id,
        name,
        category,
        updateDate,
        row_number() over (
            partition by id
            order by updateDate desc
        ) as rn
    from {{ ref('bronze_items') }}
)

select
    id,
    name,
    category,
    updateDate
from ranked_items
where rn = 1
