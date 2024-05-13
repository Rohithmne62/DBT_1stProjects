-- models/fact_deliveries.sql

{{ config(materialized='table') }}

SELECT
    DeliveryID as DeliveryID,
    MatchID as MatchID,
    Innings as Innings,
    Over as Over,
    Ball as Ball,
    BatsmanID as BatsmanID,
    BowlerID as BowlerID,
    RunsScored as RunsScored,
    ExtraRuns as ExtraRuns,
    DismissalTypeID as DismissalTypeID,
    DismissalFielderID as DismissalFielderID
FROM {{ source('ipl','raw_deliveries') }}

