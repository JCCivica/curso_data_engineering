WITH addresses AS (
    SELECT * 
    FROM {{ref('stg_sql_server_dbo__addresses')}}
),

final AS (
    SELECT
        address_id,
        zipcode,
        country,
        address,
        state
    FROM addresses
)

SELECT * FROM final