WITH users AS (
    SELECT * 
    FROM {{ref('stg_sql_server_dbo__users')}}
),

final AS (
    SELECT
        user_id,
        first_name,
        last_name,
        phone_number,
        address_id,
        email,
        updated_at_utc,
        created_at_utc
    FROM users
)

SELECT * FROM final