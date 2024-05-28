{{ config(materialized="view") }}

with
    src_orders as (select * from {{ source("sql_server_dbo", "orders") }}),

    renamed_casted as (
        select
            order_id,
            md5(shipping_service) as shipping_id,
            shipping_cost,
            address_id,
            create_at,
            case when promo_id like '' then md5('sin promo') else md5(promo_id) end as promo_id,
            ESTIMATED_DELIVERY_AT,
            order_cost,
            user_id,
            order_total,
            delivered_at,
            tracking_id,
            status,
            coalesce(_fivetran_deleted, 0),
            _fivetran_synced
        from src_orders
    )

select *
from renamed_casted
