

select
    sp.*,
    ac.average_available_quantity,
    ac.average_supply_cost

from {{ ref('suppliers_parts') }} as sp

join {{ ref('average_cost') }} as ac
    on ac.part_key = sp.part_key