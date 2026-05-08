- ============================================================
-- DAY 8 — SELECT & WHERE — Filter Syndicate Data
-- Lloyd's Syndicate Data Portfolio
-- Phase 2: SQL Basics
-- ============================================================
-- SELECT = choose which columns to show
-- WHERE  = filter which rows to show
-- Together: "Show me only syndicates matching this condition"
-- ============================================================


-- --------------------------------------------------------
-- QUERY 1: Unprofitable syndicates (combined ratio > 100)
-- Combined ratio above 100 = claims + expenses exceed premiums
-- e.g. ratio of 108 means £108 paid out per £100 collected
-- --------------------------------------------------------
SELECT
    syndicate_number,
    managing_agent,
    combined_ratio
FROM syndicate_financials
WHERE combined_ratio > 100;


-- --------------------------------------------------------
-- QUERY 2: Profitable syndicates
-- Positive profit_loss_before_tax = syndicate made money
-- All figures in £000s — so 5000 = £5 million profit
-- --------------------------------------------------------
SELECT
    syndicate_number,
    managing_agent,
    profit_loss_before_tax
FROM syndicate_financials
WHERE profit_loss_before_tax > 0;


-- --------------------------------------------------------
-- QUERY 3: Missing combined ratio — data quality flag
-- IS NULL = field was never entered (not the same as zero)
-- Important: WHERE combined_ratio = NULL does NOT work
-- You MUST use IS NULL
-- --------------------------------------------------------
SELECT
    syndicate_number,
    managing_agent
FROM syndicate_financials
WHERE combined_ratio IS NULL;


-- --------------------------------------------------------
-- QUERY 4: Strong performers (combined ratio under 95)
-- Under 95 = excellent underwriting — worth studying
-- --------------------------------------------------------
SELECT
    syndicate_number,
    managing_agent,
    combined_ratio,
    profit_loss_before_tax
FROM syndicate_financials
WHERE combined_ratio < 95;


-- --------------------------------------------------------
-- QUERY 5: Loss-making syndicates (negative P&L)
-- profit_loss_before_tax below zero = reported a loss
-- Cross-check with Query 1 — should largely overlap
-- --------------------------------------------------------
SELECT
    syndicate_number,
    managing_agent,
    profit_loss_before_tax,
    combined_ratio
FROM syndicate_financials
WHERE profit_loss_before_tax < 0;


-- --------------------------------------------------------
-- QUERY 6: High GWP syndicates (over £100m written premium)
-- gross_written_premium stored in £000s
-- 100000 in this column = £100 million
-- --------------------------------------------------------
SELECT
    syndicate_number,
    managing_agent,
    gross_written_premium
FROM syndicate_financials
WHERE gross_written_premium > 100000;


-- --------------------------------------------------------
-- QUERY 7: Filter by specific managing agent
-- Text values require single quotes
-- Replace value below with a managing agent in your data
-- --------------------------------------------------------
SELECT
    syndicate_number,
    year_of_account,
    gross_written_premium,
    combined_ratio,
    profit_loss_before_tax
FROM syndicate_financials
WHERE managing_agent = 'Beazley Furlonge Ltd';


-- --------------------------------------------------------
-- QUERY 8: Filter by year of account
-- year_of_account is stored as TEXT — quotes required
-- --------------------------------------------------------
SELECT
    syndicate_number,
    managing_agent,
    gross_written_premium,
    profit_loss_before_tax
FROM syndicate_financials
WHERE year_of_account = '2022';


-- --------------------------------------------------------
-- QUERY 9: AND condition — profitable AND low ratio
-- Both conditions must be true for a row to appear
-- Finds genuinely well-run syndicates
-- --------------------------------------------------------
SELECT
    syndicate_number,
    managing_agent,
    combined_ratio,
    profit_loss_before_tax
FROM syndicate_financials
WHERE combined_ratio < 100
  AND profit_loss_before_tax > 0;


-- --------------------------------------------------------
-- QUERY 10: Full record for one specific syndicate
-- SELECT * returns every column
-- Useful when you need to inspect a single syndicate fully
-- Replace '2791' with a syndicate number from your data
-- --------------------------------------------------------
SELECT *
FROM syndicate_financials
WHERE syndicate_number = '2791';
