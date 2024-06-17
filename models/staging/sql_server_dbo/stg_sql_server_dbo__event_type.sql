WITH src_events AS (
    SELECT * 
    FROM {{ ref('base_sql_server__events') }}
    ),

type AS (
    SELECT DISTINCT
     {{dbt_utils.generate_surrogate_key(['event_type'])}} AS event_type_id,
     event_type
     FROM src_events
)

SELECT * FROM type