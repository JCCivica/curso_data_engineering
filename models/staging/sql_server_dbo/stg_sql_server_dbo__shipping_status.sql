WITH src_orders AS (
    SELECT status 
    FROM {{ref("base_sql_server__orders")}}
    ), 
    
SELECT 0 as status_id, 'preparing' as status_name
union
SELECT 1 as status_id, 'shipped' as status_name
union
SELECT 2 as status_id, 'delivered' as status_name
