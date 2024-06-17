WITH stg_promos AS (
    SELECT status
    FROM {{ ref("base_sql_server_dbo__promos") }}
    ),

dim_status AS (
    SELECT DISTINCT
        status,
        CASE   
            WHEN status like 'active' then 1
            WHEN status like 'inactive' then 0
            END as status_id
    FROM stg_promos
)

SELECT * FROM dim_status
