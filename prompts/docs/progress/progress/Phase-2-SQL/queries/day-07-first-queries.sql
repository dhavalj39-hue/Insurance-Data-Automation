-- Day 7 - SQL Setup - Create Lloyd's Database
-- Date: 05-05-2026
-- Phase: 2 - SQL Basics

-- =============================================
-- STEP 1: CREATE TABLE
-- =============================================

CREATE TABLE syndicate_financials (
  record_id INTEGER PRIMARY KEY,
  syndicate_number TEXT,
  managing_agent TEXT,
  year_of_account TEXT,
  gross_written_premium REAL,
  net_written_premium REAL,
  gross_claims_paid REAL,
  net_claims_incurred REAL,
  net_operating_expenses REAL,
  profit_loss_before_tax REAL,
  combined_ratio REAL,
  total_assets REAL,
  members_funds REAL,
  currency_unit TEXT,
  data_source TEXT,
  extraction_date TEXT
);

-- =============================================
-- STEP 2: FIRST SELECT QUERY
-- =============================================

-- Show all data in table
SELECT * FROM "SQL Master files";

-- Result: 7 rows returned in 15ms
-- All syndicates visible with correct columns

-- =============================================
-- STEP 3: WHAT I LEARNED TODAY
-- =============================================

-- TEXT vs REAL problem found and fixed using CAST
-- combined_ratio_pct was stored as TEXT
-- WHERE combined_ratio_pct > 100 returned wrong results
-- Fixed by creating new table with CAST

CREATE TABLE "SQL Master files" AS
SELECT *,
  CAST(combined_ratio_pct AS REAL) AS combined_ratio_pct
FROM "SQL Master files";

-- After fix: WHERE queries returned correct results

-- =============================================
-- STEP 4: BASIC QUERIES PRACTISED TODAY
-- =============================================

-- 1. Biggest GWP syndicates
SELECT syndicate_name, gwp_000s
FROM "SQL Master files"
ORDER BY gwp_000s DESC;
-- Result: Beazley top (974,700) Arcus/Barbican bottom

-- 2. Loss making syndicates
SELECT syndicate_name, managing_agent, combined_ratio_pct
FROM "SQL Master files"
WHERE combined_ratio_pct > 100;

-- 3. Profitable syndicates biggest profit first
SELECT syndicate_name, gwp_000s, pbt_000s
FROM "SQL Master files"
WHERE pbt_000s > 1
ORDER BY pbt_000s DESC;

-- 4. Count total syndicates
SELECT COUNT(syndicate_name)
FROM "SQL Master files";
-- Result: 7 syndicates

-- 5. Find missing combined ratio
SELECT syndicate_name
FROM "SQL Master files"
WHERE combined_ratio_pct IS NULL;

-- 6. GWP converted to millions
SELECT syndicate_name,
       gwp_000s / 1000 AS gwp_millions
FROM "SQL Master files";
