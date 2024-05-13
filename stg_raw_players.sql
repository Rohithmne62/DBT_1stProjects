-- models/staging/stg_raw_players.sql

{{ config(materialized='table') }}

SELECT
    {{ dbt_utils.generate_surrogate_key(['PlayerName', 'Ball']) }} AS PlayerID,  -- Generate surrogate key from PlayerName and Ball
    PlayerName,
    'India' AS Nationality,  -- Static assignment
    CASE WHEN MOD(CAST(RANDOM() * 100 AS INT), 2) = 0 THEN 'Batsman' ELSE 'Bowler' END AS PlayerRole, -- Randomly assign roles
    CASE WHEN MOD(CAST(RANDOM() * 100 AS INT), 2) = 0 THEN 'Right-hand bat' ELSE 'Left-hand bat' END AS BattingStyle, -- Randomly assign batting style
    CASE WHEN MOD(CAST(RANDOM() * 100 AS INT), 2) = 0 THEN 'Spin' ELSE 'Fast' END AS BowlingStyle -- Randomly assign bowling style
FROM (
    SELECT DISTINCT
        Striker AS PlayerName,
        Ball
    FROM {{ ref('ipl') }}
) AS players
