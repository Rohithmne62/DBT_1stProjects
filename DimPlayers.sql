-- models/dim_players.sql

{{ config(materialized='table') }}

SELECT
    PlayerID as PlayerID,
    PlayerName as PlayerName,
    PlayerRole as PlayerRole,
    BattingStyle as BattingStyle,
    BowlingStyle as BowlingStyle,
    Nationality as Nationality
FROM {{ source('ipl','raw_players') }}

