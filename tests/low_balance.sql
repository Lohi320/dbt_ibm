{{ config(severity='warn') }}

select
    customer_id,
    account_balance
from {{ ref('int_customers') }}
where account_balance < -10