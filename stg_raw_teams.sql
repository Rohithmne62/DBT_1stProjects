-- models/staging/stg_raw_teams.sql

{{ config(materialized='table') }}

WITH team_names AS (
    SELECT DISTINCT Batting_Team AS TeamName,ball 
    FROM {{ ref('ipl') }}
)

SELECT
     {{ dbt_utils.generate_surrogate_key(['TeamName','ball']) }} AS TeamID ,  -- Generate a surrogate key from the team name
    TeamName
FROM team_names
