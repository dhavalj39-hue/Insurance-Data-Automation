-- ================================================
-- DAY 11 — JOIN Queries
-- Phase 2 — SQL Basics
-- File: day-11-join-queries.sql
-- Folder: Phase-2-SQL/queries/
-- Date: 2026
-- ================================================
-- WHAT I LEARNED TODAY:
-- JOIN combines two tables together where a
-- matching column exists in both tables.
-- SQL Master files  = financial data (numbers)
-- syndicate_details = business data (context)
-- Bridge = syndicate_number (exists in both)
-- ================================================


-- ================================================
-- STEP 1: Create syndicate_details table
-- WHY: SQL Master files has no domicile,
--      class of business or active status.
--      This table adds that business context.
-- ================================================
CREATE TABLE IF NOT EXISTS syndicate_details (
    syndicate_number        INTEGER PRIMARY KEY,
    main_class_of_business  TEXT,
    domicile                TEXT,
    active_status           TEXT
);


-- ================================================
-- STEP 2: Insert data for all 6 syndicates
-- WHY: Must use EXACT syndicate numbers from
--      SQL Master files or JOIN returns 0 rows.
-- NOTE: Active/Inactive and domicile data sourced
--       from lloyds.com market directory
--       and syndicate PDF cover pages.
-- ================================================
INSERT OR IGNORE INTO syndicate_details VALUES
(1225, 'Casualty / Property',           'London',  'Active'),
(2488, 'Property / Financial Lines',    'London',  'Active'),
(6110, 'Property Reinsurance / Marine', 'London',  'Inactive'),
(623,  'Marine / Property / Casualty',  'London',  'Active'),
(1274, 'Property / Casualty',           'Bermuda', 'Active'),
(1856, 'Property / Casualty',           'London',  'Inactive');


-- ================================================
-- STEP 3: Basic JOIN — core Day 11 query
-- WHY: Combines financial numbers with business
--      context into one single result.
--      f. = columns from SQL Master files
--      d. = columns from syndicate_details
--      ON = matching rule (syndicate number)
-- ================================================
SELECT
    f.syndicate_number,
    f.syndicate_name,
    f.year_of_account,
    d.main_class_of_business,
    d.domicile,
    d.active_status,
    f.gwp_000s,
    f.combined_ratio_pct,
    f.pbt_000s
FROM "SQL Master files" f
JOIN syndicate_details d
    ON f.syndicate_number = d.syndicate_number
ORDER BY f.combined_ratio_pct ASC;


-- ================================================
-- STEP 4: Full data — ALL financial + business
-- WHY: See every single column from both tables
--      in one complete view.
-- ================================================
SELECT
    f.syndicate_number,
    f.syndicate_name,
    f.managing_agent,
    f.year_of_account,
    d.main_class_of_business,
    d.domicile,
    d.active_status,
    f.gwp_000s,
    f.nwp_000s,
    f.net_claims_000s,
    f.net_opex_000s,
    f.pbt_000s,
    f.combined_ratio_pct,
    f.total_assets_000s,
    f.members_funds_000s
FROM "SQL Master files" f
JOIN syndicate_details d
    ON f.syndicate_number = d.syndicate_number;


-- ================================================
-- STEP 5: GROUP BY class of business
-- WHY: See which class of business performs
--      best across all syndicates combined.
-- ================================================
SELECT
    d.main_class_of_business,
    COUNT(*)                                         AS syndicate_count,
    AVG(CAST(f.combined_ratio_pct AS REAL))          AS avg_combined_ratio
FROM "SQL Master files" f
JOIN syndicate_details d
    ON f.syndicate_number = d.syndicate_number
WHERE f.combined_ratio_pct != 'NULL'
GROUP BY d.main_class_of_business
ORDER BY avg_combined_ratio ASC;


-- ================================================
-- STEP 6: Active + profitable syndicates only
-- WHY: Morning check — who is trading well.
--      Filters out inactive and loss making.
-- ================================================
SELECT
    f.syndicate_number,
    f.syndicate_name,
    f.managing_agent,
    d.main_class_of_business,
    f.combined_ratio_pct,
    f.pbt_000s
FROM "SQL Master files" f
JOIN syndicate_details d
    ON f.syndicate_number = d.syndicate_number
WHERE d.active_status       = 'Active'
  AND f.pbt_000s           != 'NULL'
  AND f.combined_ratio_pct != 'NULL'
ORDER BY f.combined_ratio_pct ASC;


-- ================================================
-- STEP 7: LEFT JOIN — see ALL including unmatched
-- WHY: Safety check. Regular JOIN silently drops
--      syndicates with no details row.
--      LEFT JOIN shows them with blank columns
--      so you know what is missing.
-- ================================================
SELECT
    f.syndicate_number,
    f.syndicate_name,
    f.gwp_000s,
    f.combined_ratio_pct,
    d.main_class_of_business,
    d.active_status
FROM "SQL Master files" f
LEFT JOIN syndicate_details d
    ON f.syndicate_number = d.syndicate_number;


-- ================================================
-- STEP 8: Find syndicates with NO details row
-- WHY: Data quality check for the JOIN itself.
--      If this returns 0 rows you are complete.
--      If it returns rows — go fix them.
-- ================================================
SELECT
    f.syndicate_number,
    f.syndicate_name
FROM "SQL Master files" f
LEFT JOIN syndicate_details d
    ON f.syndicate_number = d.syndicate_number
WHERE d.syndicate_number IS NULL;


-- ================================================
-- RESULT:
-- syndicate_details table created with 6 rows
-- JOIN working across both tables
-- Full financial + business data visible
-- Active/inactive filter working
-- Data quality gap check working
-- ================================================
