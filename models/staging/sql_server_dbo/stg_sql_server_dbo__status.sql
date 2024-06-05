source as (

    select status from {{ ref('base_sql_server_dbo__promos') }} 

),

select 1 as status_id, 'active' as status_name
union
select 0 as status_id, 'inactive' as status_name

