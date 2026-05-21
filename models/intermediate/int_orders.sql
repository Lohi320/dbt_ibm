{{ config(
    materialized='incremental',
    unique_key='order_id'
) }}

select
    {{ dbt_utils.generate_surrogate_key(['order_id','customer_id']) }} as order_key,
    order_id,
    customer_id,
    comment,
    clerk_name,
    total_price,
    {{ usd_eur('total_price', 2) }} as total_price_eur,
    status_code,
    order_priority,
    ship_priority,
    order_date

from {{ ref('stg_orders') }}

{% if is_incremental is false %}

where upd_date > (
    select max(order_date)
    from {{ this }}
)

{% endif %}