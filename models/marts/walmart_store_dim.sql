WITH stores AS (
    SELECT * FROM {{ ref('stg_stores') }}
),

departments AS (
    SELECT DISTINCT
        store_id,
        dept_id
    FROM {{ ref('stg_department') }}
),

final AS (
    SELECT
        d.store_id,
        d.dept_id,
        s.store_type,
        s.store_size,
        CURRENT_TIMESTAMP()     AS insert_date,
        CURRENT_TIMESTAMP()     AS update_date
    FROM departments d
    LEFT JOIN stores s
        ON d.store_id = s.store_id
)

SELECT * FROM final