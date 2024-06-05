WITH addresses AS (
    SELECT * 
    FROM {{ref('stg_sql_server_dbo__addresses')}}
),

final AS (
    SELECT
        {{dbt_utils.generate_surrogate_key(['address_id'])}} as address_id,
        zipcode,
        country,
        address,
        state
    FROM addresses
)

SELECT * FROM final