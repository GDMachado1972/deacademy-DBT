WITH source AS (
    SELECT * FROM {{ source('raw', 'RAW_SALES') }}
)

SELECT
    store                           AS store_id,
    dept                            AS dept_id,
    date                            AS store_date,
    weekly_sales                    AS store_weekly_sales,
    CAST(isholiday AS VARCHAR)      AS isholiday,
    CURRENT_TIMESTAMP()             AS insert_date,
    CURRENT_TIMESTAMP()             AS update_date
FROM source