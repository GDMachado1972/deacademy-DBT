-- This view would always return one row per store/dept/date combination
-- We will use this for all BI reporting to avoid double counting SCD2 versions

SELECT
    store_id,
    dept_id,
    date_id,
    store_date,
    store_size,
    store_weekly_sales,
    fuel_price,
    store_temperature,
    unemployment,
    cpi,
    markdown1,
    markdown2,
    markdown3,
    markdown4,
    markdown5,
    dbt_valid_from      AS vrsn_start_date,
    dbt_valid_to        AS vrsn_end_date,
    insert_date,
    update_date
FROM {{ ref('walmart_fact_snapshot') }}
WHERE dbt_valid_to IS NULL  -- active records only