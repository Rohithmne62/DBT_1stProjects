-- models/dim_matches.sql

{{ config(materialized='table') }}

SELECT
    MatchID as MatchID,
    Season as Season,
    MatchDate as MatchDate,
    VenueID as VenueID,
    TossWinnerID as TossWinnerID,
    TossDecision as TossDecision,
    Result as Result,
    WinMargin as WinMargin
FROM {{ source('ipl','raw_matches') }}

