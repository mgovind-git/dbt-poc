
{% snapshot source_gold_items %}

{{
    config(
        target_schema='gold',
        unique_key='id',
        strategy='timestamp',
        updated_at='updateDate'
    )
}}

select
    id,
    name,
    category,
    updateDate
from {{ ref('bronze_items') }}

{% endsnapshot %}
