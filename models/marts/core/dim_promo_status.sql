WITH promos_status AS (
    SELECT *
    FROM {{ref('stg_sql_server_dbo__status')}}
    ),

status AS (
    SELECT DISTINCT
        status_id,
        status
    FROM promos_status
)

SELECT * FROM status