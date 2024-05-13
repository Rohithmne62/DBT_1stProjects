-- models/dim_dismissal_types.sql

{{ config(materialized='table') }}

SELECT
    Wicket_typeID as Wicket_typeID,
    Wicket_type as Wicket_type
FROM {{ source('ipl','raw_dismissal_types') }}

