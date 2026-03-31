-- Fails if any store/dept/date combination has more than one active row
-- Every unique key should have exactly one record where dbt_valid_to IS NULL

SELECT
    store_id,
    dept_id,
    store_date,
    COUNT(*) AS active_row_count
FROM {{ ref('walmart_fact_snapshot') }}
WHERE dbt_valid_to IS NULL
GROUP BY store_id, dept_id, store_date
HAVING COUNT(*) > 1