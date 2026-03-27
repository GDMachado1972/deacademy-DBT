WITH source AS (

    SELECT * 
    FROM {{ source('raw', 'raw_department') }}

),

cleaned AS (

    SELECT
        TO_DATE(date) AS store_date,
        isholiday

    FROM source

)

SELECT * FROM cleaned