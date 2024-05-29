{{
  config(
    materialized='view'
  )
}}

WITH src_users AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'users') }}
    ),

count_total_orders as (
    select
        USER_ID,
        COUNT(USER_ID) AS TOTAL_ORDERS
        FROM {{ source('sql_server_dbo', 'orders') }}
        GROUP BY USER_ID
),

users_casted AS (
    SELECT
        SU.USER_ID,
        UPDATED_AT,
        ADDRESS_ID,
        LAST_NAME,
        CREATED_AT,
        PHONE_NUMBER,
        CTO.TOTAL_ORDERS,
        FIRST_NAME,
        EMAIL,
            coalesce(_fivetran_deleted, 0) as _fivetran_deleted,
            convert_timezone('UTC', _fivetran_synced) as _fivetran_synced_utc
    FROM src_users SU
    LEFT JOIN count_total_orders CTO
    ON SU.USER_ID = CTO.USER_ID
    )

SELECT * FROM users_casted