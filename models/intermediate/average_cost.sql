{{ config(materialized='ephemeral') }}

select
    part_key,
    avg(available_quantity) as average_available_quantity,
    avg(supply_cost) as average_supply_cost

from {{ ref('suppliers_parts') }}

group by
    part_key
        