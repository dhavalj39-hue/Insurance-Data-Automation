-- ============================================================
-- DAY 9 — COUNT & NULL — Data Quality Check
-- Lloyd's Syndicate Data Portfolio
-- Phase 2: SQL Basics
-- ============================================================
-- This is your automated validation work.
-- Run these queries after EVERY new batch of data you add.
-- Record completeness rate in your notebook each week.
-- ============================================================


-- --------------------------------------------------------
-- QUERY 1: Full completeness summary — run this daily
-- COUNT(*) counts all rows in the table
-- SUM(CASE WHEN ... END) counts rows where field IS NULL
-- Returns 1 row showing missing count per key field
-- --------------------------------------------------------
SELECT
    COUNT(*)                                                         AS total_syndicates,
    SUM(CASE WHEN gross_written_premium  IS NULL THEN 1 ELSE 0 END)  AS missing_gwp,
    SUM(CASE WHEN net_written_premium    IS NULL THEN 1 ELSE 0 END)  AS missing_net_premium,
    SUM(CASE WHEN net_claims_incurred    IS NULL THEN 1 ELSE 0 END)  AS missing_claims,
    SUM(CASE WHEN net_operating_expenses IS NULL THEN 1 ELSE 0 END)  AS missing_expenses,
    SUM(CASE WHEN combined_ratio         IS NULL THEN 1 ELSE 0 END)  AS missing_ratio,
    SUM(CASE WHEN profit_loss_before_tax IS NULL THEN 1 ELSE 0 END)  AS missing_profit,
    SUM(CASE WHEN total_assets           IS NULL THEN 1 ELSE 0 END)  AS missing_assets,
    SUM(CASE WHEN members_funds          IS NULL THEN 1 ELSE 0 END)  AS missing_members_funds,
    SUM(CASE WHEN managing_agent         IS NULL THEN 1 ELSE 0 END)  AS missing_agent
FROM syndicate_financials;


-- --------------------------------------------------------
-- QUERY 2: Data completeness rate %
-- Checks whether all 3 KEY fields are present per record
-- 100.0 not 100 — forces decimal division in SQLite
--   (100/8 = 12 in SQLite; 100.0/8 = 12.5 — correct)
-- ROUND(..., 1) = one decimal place e.g. 87.5
-- RECORD THIS NUMBER IN YOUR NOTEBOOK EVERY WEEK
-- --------------------------------------------------------
SELECT
    ROUND(
        100.0 * SUM(
            CASE WHEN
                combined_ratio         IS NOT NULL
                AND profit_loss_before_tax IS NOT NULL
                AND gross_written_premium  IS NOT NULL
            THEN 1 ELSE 0 END
        ) / COUNT(*),
    1) AS completeness_rate_percent
FROM syndicate_financials;


-- --------------------------------------------------------
-- QUERY 3: Row-by-row status check — MISSING or OK
-- Shows exactly which syndicates have gaps
-- Use this to decide which PDFs to re-extract
-- --------------------------------------------------------
SELECT
    syndicate_number,
    managing_agent,
    year_of_account,
    CASE WHEN gross_written_premium  IS NULL THEN 'MISSING' ELSE 'OK' END AS gwp_status,
    CASE WHEN net_claims_incurred    IS NULL THEN 'MISSING' ELSE 'OK' END AS claims_status,
    CASE WHEN net_operating_expenses IS NULL THEN 'MISSING' ELSE 'OK' END AS expenses_status,
    CASE WHEN combined_ratio         IS NULL THEN 'MISSING' ELSE 'OK' END AS ratio_status,
    CASE WHEN profit_loss_before_tax IS NULL THEN 'MISSING' ELSE 'OK' END AS profit_status,
    CASE WHEN total_assets           IS NULL THEN 'MISSING' ELSE 'OK' END AS assets_status
FROM syndicate_financials
WHERE
    gross_written_premium  IS NULL
    OR net_claims_incurred    IS NULL
    OR net_operating_expenses IS NULL
    OR combined_ratio         IS NULL
    OR profit_loss_before_tax IS NULL
    OR total_assets           IS NULL;


-- --------------------------------------------------------
-- QUERY 4: Quick combined ratio check — present vs missing
-- One line to verify your most important field
-- Run this immediately after adding new rows
-- --------------------------------------------------------
SELECT
    SUM(CASE WHEN combined_ratio IS NOT NULL THEN 1 ELSE 0 END) AS ratio_present,
    SUM(CASE WHEN combined_ratio IS NULL     THEN 1 ELSE 0 END) AS ratio_missing,
    COUNT(*)                                                     AS total
FROM syndicate_financials;


-- --------------------------------------------------------
-- QUERY 5: Missing data by year of account
-- Shows whether older or newer years have worse coverage
-- Useful once you have data across 2+ years
-- --------------------------------------------------------
SELECT
    year_of_account,
    COUNT(*)                                                         AS total_syndicates,
    SUM(CASE WHEN combined_ratio         IS NULL THEN 1 ELSE 0 END)  AS missing_ratio,
    SUM(CASE WHEN profit_loss_before_tax IS NULL THEN 1 ELSE 0 END)  AS missing_profit,
    SUM(CASE WHEN gross_written_premium  IS NULL THEN 1 ELSE 0 END)  AS missing_gwp
FROM syndicate_financials
GROUP BY year_of_account
ORDER BY year_of_account DESC;


-- --------------------------------------------------------
-- QUERY 6: Completeness rate per managing agent
-- Shows which agents have the most data gaps
-- Agents appearing at the top need priority re-extraction
-- --------------------------------------------------------
SELECT
    managing_agent,
    COUNT(*) AS syndicate_count,
    ROUND(
        100.0 * SUM(
            CASE WHEN
                combined_ratio         IS NOT NULL
                AND profit_loss_before_tax IS NOT NULL
                AND gross_written_premium  IS NOT NULL
            THEN 1 ELSE 0 END
        ) / COUNT(*),
    1) AS completeness_pct
FROM syndicate_financials
GROUP BY managing_agent
ORDER BY completeness_pct ASC;


-- ============================================================
-- WEEKLY LOG — paste your completeness rate here each week
-- This becomes your quality improvement story for Day 24
--
-- Week 1 completeness rate: _____%   Date: __________
-- Week 2 completeness rate: _____%   Date: __________
-- Week 3 completeness rate: _____%   Date: __________
-- Week 4 completeness rate: _____%   Date: __________
--
-- Target: below 2% missing by end of Phase 4 (Day 26)
-- ============================================================
