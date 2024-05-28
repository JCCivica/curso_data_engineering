{{ config(materialized="view") }}

with
    src_status as (
        select * from {{ source("sql_server_dbo", "promos") }}
    ),

    renamed_casted as (
        select distinct
            case
                when status like 'inactive' then 0
                else 1
            end as status_id,
            status as status_name
        from src_status
    )

select *
from renamed_casted
