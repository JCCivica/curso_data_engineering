WITH products AS (
    SELECT * 
    FROM {{ref('stg_sql_server_dbo__products')}}
),

final AS (
    SELECT
        product_id,
        name,
        price_dollars
    FROM products
)

SELECT * FROM final