with 

source as (

    select * from {{ source('sql_server_dbo', 'promos') }}

),

renamed as (

    select
        promo_id,
        discount as discount_dollars,
        status,
        _fivetran_deleted,
        _fivetran_synced,
    from source
)

select * from renamed