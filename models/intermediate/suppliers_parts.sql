{{ config(materialized='ephemeral') }}

with supplier_parts as (

    select
        s.s_suppkey,
        s.s_name,
        s.s_nationkey,
        s.s_acctbal,

        ps.ps_availqty,
        ps.ps_supplycost,
        ps.ps_partkey,

        p.p_partkey,
        p.p_name,
        p.p_mfgr,
        p.p_brand,
        p.p_type,
        p.p_size,
        p.p_container,
        p.p_retailprice

    from {{ source('src', 'suppliers') }} as s

    join {{ source('src', 'partsupps') }} as ps
        on s.s_suppkey = ps.ps_suppkey

    join {{ source('src', 'parts') }} as p
        on ps.ps_partkey = p.p_partkey

)

select
    s_suppkey as supplier_key,
    s_name as supplier_name,
    s_nationkey as nation_key,
    s_acctbal as account_balance,

    ps_availqty as available_quantity,
    ps_supplycost as supply_cost,

    p_partkey as part_key,
    p_name as part_name,
    p_mfgr as part_manufacturer,
    p_brand as part_brand,
    p_type as part_type,
    p_size as part_size,
    p_container as part_container,
    p_retailprice as part_retail_price

from supplier_parts