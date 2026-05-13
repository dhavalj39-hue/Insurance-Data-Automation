-- ============================================================
-- DAY 8 — SELECT & WHERE — Filter Syndicate Data
-- Lloyd's Syndicate Data Portfolio
-- Table: "syndicate_clean"
-- Phase 2: SQL Basics
-- ============================================================
-- SELECT = choose which columns to show
-- WHERE  = filter which rows to show
-- ============================================================


-- --------------------------------------------------------
-- QUERY 1: Unprofitable syndicates (combined ratio > 100)
-- combined_ratio_pct above 100 = claims + expenses exceed premiums
-- e.g. 108 means £108 paid out for every £100 collected
-- --------------------------------------------------------
SELECT
    syndicate_number,
    syndicate_name,
    managing_agent,
    combined_ratio_pct
FROM "syndicate_clean"
WHERE combined_ratio_pct > 100;


-- --------------------------------------------------------
-- QUERY 2: Profitable syndicates
-- Positive pbt_000s = syndicate made a profit before tax
-- Figures in £000s — so 5000 = £5 million profit
-- --------------------------------------------------------
SELECT
    syndicate_number,
    syndicate_name,
    managing_agent,
    pbt_000s
FROM "syndicate_clean"
WHERE pbt_000s > 0;


-- --------------------------------------------------------
-- QUERY 3: Missing combined ratio — data quality flag
-- IS NULL = field was never entered (not the same as zero)
-- Must use IS NULL — WHERE combined_ratio_pct = NULL won't work
-- --------------------------------------------------------
SELECT
    syndicate_number,
    syndicate_name,
    managing_agent
FROM "syndicate_clean"
WHERE combined_ratio_pct IS NULL;


-- --------------------------------------------------------
-- QUERY 4: Strong performers (combined ratio under 95)
-- Under 95 = excellent underwriting discipline
-- --------------------------------------------------------
SELECT
    syndicate_number,
    syndicate_name,
    managing_agent,
    combined_ratio_pct,
    pbt_000s
FROM "syndicate_clean"
WHERE combined_ratio_pct < 95;


-- --------------------------------------------------------
-- QUERY 5: Loss-making syndicates (negative P&L)
-- pbt_000s below zero = syndicate reported a loss
-- Cross-check with Query 1 — should largely overlap
-- --------------------------------------------------------
SELECT
    syndicate_number,
    syndicate_name,
    managing_agent,
    pbt_000s,
    combined_ratio_pct
FROM "syndicate_clean"
WHERE pbt_000s < 0;


-- --------------------------------------------------------
-- QUERY 6: High GWP syndicates (over £100m written premium)
-- gwp_000s stored in £000s — so 100000 = £100 million
-- --------------------------------------------------------
SELECT
    syndicate_number,
    syndicate_name,
    managing_agent,
    gwp_000s
FROM "syndicate_clean"
WHERE gwp_000s > 100000;


-- --------------------------------------------------------
-- QUERY 7: Filter by specific managing agent
-- Text values require single quotes
-- Replace value below with a managing agent from your data
-- --------------------------------------------------------
SELECT
    syndicate_number,
    syndicate_name,
    year_of_account,
    gwp_000s,
    combined_ratio_pct,
    pbt_000s
FROM "syndicate_clean"
WHERE managing_agent = 'Beazley Furlonge Ltd';


-- --------------------------------------------------------
-- QUERY 8: Filter by year of account
-- year_of_account is INT in your table — no quotes needed
-- --------------------------------------------------------
SELECT
    syndicate_number,
    syndicate_name,
    managing_agent,
    gwp_000s,
    pbt_000s
FROM "syndicate_clean"
WHERE year_of_account = 2022;


-- --------------------------------------------------------
-- QUERY 9: AND condition — profitable AND low ratio
-- Both conditions must be true for a row to appear
-- --------------------------------------------------------
SELECT
    syndicate_number,
    syndicate_name,
    managing_agent,
    combined_ratio_pct,
    pbt_000s
FROM "syndicate_clean"
WHERE combined_ratio_pct < 100
  AND pbt_000s > 0;


-- --------------------------------------------------------
-- QUERY 10: Full record for one specific syndicate
-- SELECT * returns every column
-- Replace 2791 with a syndicate number from your data
-- --------------------------------------------------------
SELECT *
FROM "syndicate_clean"
WHERE syndicate_number = 2791;
