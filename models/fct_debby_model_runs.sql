{{
    config(
        materialized='view'
    )
}}

select
    query_id,
    node:node_name::varchar as name,
    error_code is null as is_success,
    node:node_id::varchar as unique_id,
    start_time,
    end_time,
    total_elapsed_time::float / 1000 as elapsed_time_in_seconds,
    error_code,
    error_message,
    execution_time,
    rows_produced,
    rows_inserted,
    rows_deleted,
    rows_updated
from {{ ref('fct_debby_query_history') }}
where resource_type = 'model'
order by start_time desc