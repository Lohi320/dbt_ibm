select 
    sts.supplier_id,
    sts.supplier_name,
    pts.part_id,
    pts.available_quantity * pts.cost as inventory_value_usd,
    
    ROUND(pts.available_quantity * pts.cost * 0.86, 2) as inventory_value_eur,
    
    pt.retail_price - pts.cost as unit_margin, 
    ((pt.retail_price - pts.cost) / NULLIF(pt.retail_price, 0) * 100)::numeric(4,2) as margin_per,
    
    case 
        when pts.available_quantity >= 8000 then 'HIGH'
        when pts.available_quantity >= 3000 then 'MEDIUM'
        else 'LOW'
    end as inventory_level,
    
    case 
        when sts.account_balance > 5000 then 'PREMIUM'
        when sts.account_balance <= 0 then 'RISK'
        when sts.account_balance <= 5000 then 'STANDARD'
    end as supplier_financial_health,
    
    case 
        when sts.phone_number is null or sts.supplier_address is null then false
        else true 
    end as data_status, 
    
    case 
        when pts.cost > pt.retail_price then false
        else true 
    end as margin_normal,
    
    current_timestamp() as updated_at,
    current_user() as updated_by
from {{ ref('stg_parts') }} pt 
join {{ ref('stg_partsupps') }} pts on pts.part_id = pt.part_id 
join {{ ref('stg_suppliers') }} sts on sts.supplier_id = pts.supplier_id
limit 5