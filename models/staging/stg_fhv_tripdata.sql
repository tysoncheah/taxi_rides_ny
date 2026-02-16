with source as (
    select * from {{ source('raw', 'fhv_tripdata') }}
),

renamed as (

    select
        -- identifiers
        dispatching_base_num,
        affiliated_base_number,
        
        -- timestamps
        pickup_datetime,
        dropOff_datetime as dropoff_datetime,
        
        -- location ids
        PUlocationID as pickup_location_id,
        DOlocationID as dropoff_location_id,
        
        -- flags
        SR_Flag as sr_flag

    from source
    -- Filter out records with null dispatching_base_num (data quality requirement)
    where dispatching_base_num is not null
)

select * from renamed

-- Sample records for dev environment using deterministic date filter
{% if target.name == 'dev' %}
where pickup_datetime >= '2019-01-01' and pickup_datetime < '2019-02-01'
{% endif %}