
{% snapshot users_snapshot %}

{{
    config(
      target_schema='snapshots',
      unique_key='user_id',
      strategy='check',
      check_cols=['last_name'],
        )
}}

select * from {{ source('sql_server_dbo', 'users') }}

{% endsnapshot %}