{{ config(materialized="view") }}

with
    src_users as (select * from {{ source("sql_server_dbo", "users") }}),

    count_total_orders as (
        select user_id, count(user_id) as total_orders
        from {{ source("sql_server_dbo", "orders") }}
        group by user_id
    ),

    users_casted as (
        select
            su.user_id,
            updated_at,
            address_id,
            last_name,
            created_at,
            phone_number,
            cto.total_orders,
            first_name,
            email,
            coalesce(
                regexp_like(email, '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$')
                = true,
                false
            ) as is_valid_email_address,

            coalesce(_fivetran_deleted, 0) as _fivetran_deleted,
            convert_timezone('UTC', _fivetran_synced) as _fivetran_synced_utc
        from src_users su
        left join count_total_orders cto on su.user_id = cto.user_id
    )

select *
from users_casted
