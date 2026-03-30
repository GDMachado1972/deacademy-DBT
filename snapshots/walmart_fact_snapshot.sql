{#
  SCD2 JUSTIFICATION:
  Weekly sales figures in this dataset are subject to retroactive correction —
  Walmart adjusts reported weekly_sales after returns, voids, and accounting
  reconciliations are processed. SCD2 allows us to preserve the originally
  reported figure alongside the corrected value, enabling audit trails and
  point-in-time reporting. For standard BI consumption, always use the
  walmart_fact_current view which filters dbt_valid_to IS NULL.
#}
{% snapshot walmart_fact_snapshot %}

{{
    config(
        target_schema='MARTS',
        unique_key='fact_key',       
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
    MD5(
            CAST(dep.store_id AS VARCHAR) || '-' ||
            CAST(dep.dept_id  AS VARCHAR) || '-' ||
            CAST(dep.store_date AS VARCHAR)
        ) AS fact_key,                  -- hashed surrogate
        sd.store_id,
        sd.dept_id,
        dd.date_id,
        dep.store_date,                 -- ← added this
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