-- models/staging/stg_raw_dismissal_types.sql

{{ config(materialized='table') }}

SELECT
    {{ dbt_utils.generate_surrogate_key(['Wicket_type']) }} AS Wicket_typeID,  -- Generate a surrogate key for each dismissal type
    Wicket_type
FROM (
    SELECT DISTINCT Wicket_type
    FROM {{ ref('ipl') }}
    WHERE Wicket_type IS NOT NULL AND Wicket_type != 'Not Out'
) AS unique_dismissal_types
