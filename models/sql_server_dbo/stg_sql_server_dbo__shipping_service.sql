{{ config(materialized="view") }}

with
    src_shipping_service as (
        select * from {{ source("sql_server_dbo", "orders") }} group by shipping_service
    ),

    renamed_casted as (
        select
            md5(shipping_service) as shipping_id,
            case
                when shipping_service like '' then 'indefinido' else shipping_service
            end as shipping_service_name
        from src_shipping_service
    )

select *
from renamed_casted
