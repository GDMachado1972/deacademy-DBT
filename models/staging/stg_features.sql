WITH source AS (
    SELECT * FROM {{ source('raw', 'RAW_FEATURES') }}
)

SELECT
    store                           AS store_id,
    date                            AS store_date,
    temperature                     AS store_temperature,
    fuel_price,
    markdown1,
    markdown2,
    markdown3,
    markdown4,
    markdown5,
    cpi,
    unemployment,
    CAST(isholiday AS VARCHAR)      AS isholiday,
    CURRENT_TIMESTAMP()             AS insert_date,
    CURRENT_TIMESTAMP()             AS update_date
FROM source