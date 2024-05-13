-- models/dim_venues.sql

{{ config(materialized='table') }}

SELECT
    VenueID as VenueID,
    VenueName as VenueName,
    City as City
FROM {{ source('ipl','raw_venues') }}

