-- models/staging/stg_raw_matches.sql

{{ config(materialized='table') }}

WITH TotalRuns AS (
    SELECT
        Start_Date,
        Venue,
        Batting_Team,
        SUM(Runs_Off_Bat) AS Runs
    FROM {{ ref('ipl') }}
    GROUP BY Start_Date, Venue, Batting_Team
),
MaxRuns AS (
    SELECT
        Start_Date,
        Venue,
        MAX(Runs) AS MaxRuns
    FROM TotalRuns
    GROUP BY Start_Date, Venue
),
WinningTeam AS (
    SELECT
        t.Start_Date,
        t.Venue,
        t.Batting_Team AS Winner
    FROM TotalRuns t
    JOIN MaxRuns m ON t.Start_Date = m.Start_Date AND t.Venue = m.Venue AND t.Runs = m.MaxRuns
)

SELECT
    w.Start_Date AS MatchDate,
    w.Venue,
    w.Winner,
    'India' AS Nationality  -- Static assignment if required
FROM WinningTeam w
