{% macro usd_eur (col, scale=2 )%}
    ({{ col }} * 0.86 )::number(8, {{ scale }})
{% endmacro %}