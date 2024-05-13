-- models/dim_teams.sql

{{ config(materialized='table') }}

SELECT
    TeamID as TeamID,
    TeamName as TeamName
FROM {{source('ipl','raw_teams') }}

