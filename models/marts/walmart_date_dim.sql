WITH date_source AS (
    SELECT DISTINCT
        store_date,
        isholiday
    FROM {{ ref('stg_department') }}
),

final AS (
    SELECT
        ROW_NUMBER() OVER (ORDER BY store_date)     AS date_id,
        store_date,
        isholiday,
        CURRENT_TIMESTAMP()                         AS insert_date,
        CURRENT_TIMESTAMP()                         AS update_date
    FROM date_source
)

SELECT * FROM final