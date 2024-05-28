{{
  config(
    materialized='view'
  )
}}

WITH src_order_items AS (
    SELECT 
    
    FROM {{ source('sql_server_dbo', 'order_items') }}
    ),

renamed_casted AS (
    SELECT
        ORDER_ID,
        PRODUCT_ID,
        QUANTITY,
        _FIVETRAN_DELETED,
        _FIVETRAN_SYNCED
    FROM src_order_items
    )

SELECT * FROM renamed_casted