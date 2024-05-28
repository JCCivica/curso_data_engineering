{{
  config(
    materialized='view'
  )
}}

WITH src_addresses AS (
    SELECT 
    FROM {{ source('sql_server_dbo', 'addresses') }} as adr
     ),
addreses_orders AS (
    SELECT
        ADDRESS_ID,
        ZIPCODE,
        COUNTRY,
        ADDRESS,
        STATE,
        _FIVETRAN_DELETED,
        _FIVETRAN_SYNCED,
    FROM src_addresses
    )

SELECT * FROM addreses_orders
