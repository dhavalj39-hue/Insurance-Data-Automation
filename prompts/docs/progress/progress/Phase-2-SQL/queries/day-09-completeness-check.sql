-- ============================================================
-- DAY 9 — COUNT & NULL — Data Quality Check
-- Lloyd's Syndicate Data Portfolio
-- Table: "SQL Master files_fixed"
-- Phase 2: SQL Basics
-- ============================================================
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
    COUNT(*)                                                       AS total_syndicates,
    SUM(CASE WHEN syndicate_name       IS NULL THEN 1 ELSE 0 END)  AS missing_syndicate_name,
    SUM(CASE WHEN managing_agent       IS NULL THEN 1 ELSE 0 END)  AS missing_agent,
    SUM(CASE WHEN gwp_000s             IS NULL THEN 1 ELSE 0 END)  AS missing_gwp,
    SUM(CASE WHEN nwp_000s             IS NULL THEN 1 ELSE 0 END)  AS missing_nwp,
    SUM(CASE WHEN net_claims_000s      IS NULL THEN 1 ELSE 0 END)  AS missing_claims,
    SUM(CASE WHEN net_opex_000s        IS NULL THEN 1 ELSE 0 END)  AS missing_opex,
    SUM(CASE WHEN pbt_000s             IS NULL THEN 1 ELSE 0 END)  AS missing_pbt,
    SUM(CASE WHEN combined_ratio_pct   IS NULL THEN 1 ELSE 0 END)  AS missing_ratio,
    SUM(CASE WHEN total_assets_000s    IS NULL THEN 1 ELSE 0 END)  AS missing_assets,
    SUM(CASE WHEN members_funds_000s   IS NULL THEN 1 ELSE 0 END)  AS missing_members_funds
FROM "SQL Master files_fixed";


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
                combined_ratio_pct IS NOT NULL
                AND pbt_000s       IS NOT NULL
                AND gwp_000s       IS NOT NULL
            THEN 1 ELSE 0 END
        ) / COUNT(*),
    1) AS completeness_rate_percent
FROM "SQL Master files_fixed";


-- --------------------------------------------------------
-- QUERY 3: Row-by-row status check — MISSING or OK
-- Shows exactly which syndicates have gaps
-- Use this to decide which PDFs to re-extract from Claude
-- --------------------------------------------------------
SELECT
    syndicate_number,
    syndicate_name,
    managing_agent,
    year_of_account,
    CASE WHEN gwp_000s           IS NULL THEN 'MISSING' ELSE 'OK' END AS gwp_status,
    CASE WHEN net_claims_000s    IS NULL THEN 'MISSING' ELSE 'OK' END AS claims_status,
    CASE WHEN net_opex_000s      IS NULL THEN 'MISSING' ELSE 'OK' END AS opex_status,
    CASE WHEN pbt_000s           IS NULL THEN 'MISSING' ELSE 'OK' END AS pbt_status,
    CASE WHEN combined_ratio_pct IS NULL THEN 'MISSING' ELSE 'OK' END AS ratio_status,
    CASE WHEN total_assets_000s  IS NULL THEN 'MISSING' ELSE 'OK' END AS assets_status
FROM "SQL Master files_fixed"
WHERE
    gwp_000s           IS NULL
    OR net_claims_000s    IS NULL
    OR net_opex_000s      IS NULL
    OR pbt_000s           IS NULL
    OR combined_ratio_pct IS NULL
    OR total_assets_000s  IS NULL;


-- --------------------------------------------------------
-- QUERY 4: Quick combined ratio check — present vs missing
-- Run this immediately after adding new rows
-- --------------------------------------------------------
SELECT
    SUM(CASE WHEN combined_ratio_pct IS NOT NULL THEN 1 ELSE 0 END) AS ratio_present,
    SUM(CASE WHEN combined_ratio_pct IS NULL     THEN 1 ELSE 0 END) AS ratio_missing,
    COUNT(*)                                                         AS total
FROM "SQL Master files_fixed";


-- --------------------------------------------------------
-- QUERY 5: Missing data by year of account
-- Shows whether older or newer years have worse coverage
-- year_of_account is INT — no quotes needed
-- --------------------------------------------------------
SELECT
    year_of_account,
    COUNT(*)                                                        AS total_syndicates,
    SUM(CASE WHEN combined_ratio_pct IS NULL THEN 1 ELSE 0 END)    AS missing_ratio,
    SUM(CASE WHEN pbt_000s           IS NULL THEN 1 ELSE 0 END)    AS missing_pbt,
    SUM(CASE WHEN gwp_000s           IS NULL THEN 1 ELSE 0 END)    AS missing_gwp
FROM "SQL Master files_fixed"
GROUP BY year_of_account
ORDER BY year_of_account DESC;


-- --------------------------------------------------------
-- QUERY 6: Completeness rate per managing agent
-- Agents at the top of results need priority re-extraction
-- --------------------------------------------------------
SELECT
    managing_agent,
    COUNT(*) AS syndicate_count,
    ROUND(
        100.0 * SUM(
            CASE WHEN
                combined_ratio_pct IS NOT NULL
                AND pbt_000s       IS NOT NULL
                AND gwp_000s       IS NOT NULL
            THEN 1 ELSE 0 END
        ) / COUNT(*),
    1) AS completeness_pct
FROM "SQL Master files_fixed"
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
