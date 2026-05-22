{% macro copydealer () %}

{% set qry = "copy into mkmotors_dev.staging.stg_dealership from @mkmotors_dev.staging.s3dealers/dealership.dat  file_format = mkmotors_dev.staging.ff_csv_nohdr_dq" %}

{% do run_query (qry) %}

{% endmacro %}