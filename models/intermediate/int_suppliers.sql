{{ config(materialized='table')}}

select
    supplier_id,
    nation_id,
    supplier_name,
    supplier_address,
    phone_number,
    comment,
    account_balance,
    {{ usd_eur('account_balance')}} as account_balance_eur,
    updated_time
 from  {{ ref('stg_suppliers') }}
