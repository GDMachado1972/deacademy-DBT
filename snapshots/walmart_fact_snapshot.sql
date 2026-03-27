{% snapshot walmart_fact_snapshot %}

{{
    config(
        target_schema='MARTS',
        unique_key='store_id || dept_id || store_date',
        strategy='check',
        check_cols=[
            'store_weekly_sales',
            'fuel_price',
            'store_temperature',
            'unemployment',
            'cpi',
            'markdown1',
            'markdown2',
            'markdown3',
            'markdown4',
            'markdown5'
        ]
    )
}}

WITH department AS (
    SELECT * FROM {{ ref('stg_department') }}
),

fact AS (
    SELECT * FROM {{ ref('stg_fact') }}
),

store_dim AS (
    SELECT * FROM {{ ref('walmart_store_dim') }}
),

date_dim AS (
    SELECT * FROM {{ ref('walmart_date_dim') }}
),

final AS (
    SELECT
        sd.store_id,
        sd.dept_id,
        dd.date_id,
        sd.store_size,
        dep.store_weekly_sales,
        f.fuel_price,
        f.store_temperature,
        f.unemployment,
        f.cpi,
        f.markdown1,
        f.markdown2,
        f.markdown3,
        f.markdown4,
        f.markdown5,
        CURRENT_TIMESTAMP()     AS insert_date,
        CURRENT_TIMESTAMP()     AS update_date
    FROM department dep
    LEFT JOIN fact f
        ON dep.store_id = f.store_id
        AND dep.store_date = f.store_date
    LEFT JOIN store_dim sd
        ON dep.store_id = sd.store_id
        AND dep.dept_id = sd.dept_id
    LEFT JOIN date_dim dd
        ON dep.store_date = dd.store_date
)

SELECT * FROM final

{% endsnapshot %}