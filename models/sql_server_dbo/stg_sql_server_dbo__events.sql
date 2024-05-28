{{ config(materialized="view") }}

with
    src_events as (
        select
            event_id,
            page_url,
            event_type,
            user_id,
            case
                when product_id like '' then null
                else product_id
            end as product_id,
            session_id,
            case when created_at like '' then null else created_at end as create_at,
            _fivetran_deleted,
            _fivetran_synced
        from {{ source("sql_server_dbo", "events") }}
    ),

    renamed_casted as (
        select
            event_id,
            page_url,
            event_type,
            user_id,
            product_id,
            session_id,
            created_at,
            order_id,
            _fivetran_deleted,
            _fivetran_synced
        from src_events
    )

select *
from renamed_casted
