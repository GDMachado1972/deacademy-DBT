WITH source AS (
    SELECT * FROM {{ source('raw', 'RAW_STORES') }}
)

SELECT
    store                           AS store_id,
    type                            AS store_type,
    size                            AS store_size,
    CURRENT_TIMESTAMP()             AS insert_date,
    CURRENT_TIMESTAMP()             AS update_date
FROM source