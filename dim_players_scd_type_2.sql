-- models/dim_players_scd_type_2.sql

{{ config(materialized='incremental', unique_key='player_version_id') }}

WITH source_data AS (
    SELECT
        PlayerID,
        PlayerName,
        PlayerRole,
        BattingStyle,
        BowlingStyle,
        Nationality,
        current_timestamp() AS updated_at 
    FROM {{ ref('stg_raw_players') }}  
),

scd_updates AS (
    SELECT
        s.PlayerID,
        s.PlayerName,
        s.PlayerRole,
        s.BattingStyle,
        s.BowlingStyle,
        s.Nationality,
        s.updated_at,
        COALESCE(p.effective_date, current_date()) AS effective_date,
        NULL::date AS expiration_date,
        '{{ this }}' || s.PlayerID || current_date() AS player_version_id
    FROM source_data s
    LEFT JOIN {{ this }} p ON s.PlayerID = p.PlayerID AND p.expiration_date IS NULL
    WHERE p.PlayerID IS NULL
        OR s.PlayerRole != p.PlayerRole
        OR s.BattingStyle != p.BattingStyle
        OR s.BowlingStyle != p.BowlingStyle
        OR s.Nationality != p.Nationality
)
