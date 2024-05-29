{{ config(materialized="view") }}

with
    src_promos as (select * from {{ source("sql_server_dbo", "promos") }}),

    renamed_casted as (
        select
            md5(promo_id) as promo_id,
            promo_id as promo_name,
            case
                when status like 'inactive' then 0 when status like 'active' then 1
            end as status_id,
            discount as discount_dollars,
            coalesce(_fivetran_deleted, 0) as _fivetran_deleted,
            convert_timezone('UTC', _fivetran_synced) as _fivetran_synced_utc
        from src_promos
    ),
     new_row as (
        select
            md5('sin promo') as promo_id,
            'sin promo' as promo_name,
            1 as status_id,
            0 as discount_dollars,
            false as _fivetran_deleted,
            convert_timezone('UTC', CURRENT_DATE())  as _fivetran_synced
        from src_promos
    )

select *
from renamed_casted
union
select *
from new_row
