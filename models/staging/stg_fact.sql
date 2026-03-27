WITH source AS (

    SELECT * 
    FROM {{ source('raw', 'raw_fact') }}

),

cleaned AS (

    SELECT
        store_id,
        dept_id,
        TO_DATE(date) AS store_date,

        TRY_TO_DECIMAL(store_weekly_sales) AS store_weekly_sales,
        TRY_TO_DECIMAL(fuel_price) AS fuel_price,
        TRY_TO_DECIMAL(temperature) AS temperature,
        TRY_TO_DECIMAL(unemployment) AS unemployment,
        TRY_TO_DECIMAL(cpi) AS cpi,

        TRY_TO_DECIMAL(markdown1) AS markdown1,
        TRY_TO_DECIMAL(markdown2) AS markdown2,
        TRY_TO_DECIMAL(markdown3) AS markdown3,
        TRY_TO_DECIMAL(markdown4) AS markdown4,
        TRY_TO_DECIMAL(markdown5) AS markdown5

    FROM source

)

SELECT * FROM cleaned