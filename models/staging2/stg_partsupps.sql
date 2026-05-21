with source as (
select * from {{ source('src', 'partsupps') }}
),
changed as (
select
    ps_partkey as part_id,
    ps_suppkey as supplier_id,
    ps_comment as comment,
    ps_availqty as available_quantity,
    ps_supplycost as cost
from source

)

select * from changed