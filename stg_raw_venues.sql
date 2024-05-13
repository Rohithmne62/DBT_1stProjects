-- models/staging/stg_raw_venues.sql

{{ config(materialized='table') }}

SELECT
    {{ dbt_utils.generate_surrogate_key(['VenueName']) }} AS VenueID,  -- Generate surrogate key from VenueName
    VenueName
FROM (
    SELECT DISTINCT Venue AS VenueName
    FROM {{ ref('ipl') }}
) AS venues
