-- models/fact_deliveries.sql

{{ config(materialized='table') }}

SELECT
    {{ dbt_utils.generate_surrogate_key([ 'Venue', 'Innings','Ball', 'BatsmanID', 'BowlerID']) }} AS DeliveryID,  -- Creating a unique identifier for each delivery
    MatchDate,
    Venue,
    Innings,
    Ball,
    BatsmanID,
    BowlerID,
    Runs_Off_Bat AS RunsScored,
    Extras,
    Dismissal_Type,
    (CASE WHEN Dismissal_Type IS NOT NULL AND Dismissal_Type != 'Not Out' THEN 1 ELSE 0 END) AS Is_Wicket,
    {{ ref('stg_raw_players') }}.PlayerID AS BatsmanID,  -- Linking Batsman to Player dimension
    {{ ref('stg_raw_players') }}.PlayerID AS BowlerID,   -- Linking Bowler to Player dimension
    {{ ref('stg_raw_teams') }}.TeamID AS BattingTeamID,  -- Linking Batting Team
    {{ ref('stg_raw_teams') }}.TeamID AS BowlingTeamID,  -- Linking Bowling Team
    {{ ref('stg_raw_DismissalTypes') }}.DismissalTypeID  -- Linking Dismissal Type
FROM {{ ref('ipl') }}
LEFT JOIN {{ ref('stg_raw_players') }} p1 ON i.BatsmanID = p1.PlayerName
LEFT JOIN {{ ref('stg_raw_players') }} p2 ON i.BowlerID = p2.PlayerName
LEFT JOIN {{ ref('stg_raw_teams') }} t1 ON i.Batting_Team = t1.TeamName
LEFT JOIN {{ ref('stg_raw_teams') }} t2 ON i.Bowling_Team = t2.TeamNameLEFT JOIN {{ ref('stg_raw_DismissalTypes') }} ON {{ ref('ipl') }}.Dismissal_Type = {{ ref('stg_raw_DismissalTypes') }}.Dismissal_Type
