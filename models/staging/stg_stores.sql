WITH source AS (

    SELECT * 
    FROM {{ source('raw', 'raw_stores') }}

),

cleaned AS (

    SELECT
        store_id,
        dept_id,
        store_type,
        store_size

    FROM source

)

SELECT * FROM cleaned