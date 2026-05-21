{{ config(materialized='table')}}

select 
	ORDER_ID,
	PART_ID,
	SUPPLIER_ID,
	LINE_NUMBER,
	COMMENT,
	SHIP_MODE,
	SHIP_INSTRUCTIONS,
	QUANTITY,
	EXTENDED_PRICE,
    {{ usd_eur('EXTENDED_PRICE')}} as 	EXTENDED_PRICE_eur,
	DISCOUNT_PERCENTAGE,
	TAX_RATE,
	STATUS_CODE,
	RETURN_FLAG,
	SHIP_DATE,
	COMMIT_DATE,
	RECEIPT_DATE
 from  {{ ref('stg_lineitems') }}