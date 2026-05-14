-- ============================================================
-- MASTER LLOYD'S QUALITY CHECK
-- Day 13 | Phase-2-SQL/queries/
-- Table: syndicate_clean
-- Run after every new batch of syndicate data is loaded
-- ============================================================

-- MASTER QUALITY CHECK: surfaces all records with any missing key field
SELECT
    syndicate_number,
    managing_agent,
    year_of_account,
    CASE WHEN gwp_000s            IS NULL THEN 'MISSING' ELSE 'OK' END AS gwp_status,
    CASE WHEN net_claims_000s     IS NULL THEN 'MISSING' ELSE 'OK' END AS claims_status,
    CASE WHEN combined_ratio_pct  IS NULL THEN 'MISSING' ELSE 'OK' END AS ratio_status,
    CASE WHEN pbt_000s            IS NULL THEN 'MISSING' ELSE 'OK' END AS profit_status
FROM syndicate_clean
WHERE
    gwp_000s              IS NULL
    OR net_claims_000s    IS NULL
    OR combined_ratio_pct IS NULL
    OR pbt_000s           IS NULL;


-- ============================================================
-- REVISION QUERIES — Day 13 checkpoint (no notes allowed)
-- ============================================================

-- 1. Show all loss-making syndicates
SELECT syndicate_number, managing_agent, combined_ratio_pct, pbt_000s
FROM syndicate_clean
WHERE pbt_000s < 0
   OR combined_ratio_pct > 100;

-- 2. Count syndicates by managing agent
SELECT
    managing_agent,
    COUNT(*) AS syndicate_count
FROM syndicate_clean
GROUP BY managing_agent
ORDER BY syndicate_count DESC;

-- 3. Find syndicates with missing combined ratio
SELECT syndicate_number, managing_agent, year_of_account
FROM syndicate_clean
WHERE combined_ratio_pct IS NULL;

-- 4. JOIN financials with syndicate details table
SELECT
    f.syndicate_number,
    f.year_of_account,
    d.main_class_of_business,
    f.gwp_000s,
    f.combined_ratio_pct,
    f.pbt_000s
FROM syndicate_clean f
JOIN syndicate_details d
    ON f.syndicate_number = d.syndicate_number;

-- 5. Label each syndicate: Strong / Marginal / Loss Making / Significant Loss
SELECT
    syndicate_number,
    managing_agent,
    combined_ratio_pct,
    CASE
        WHEN combined_ratio_pct <  95  THEN 'Strong Performer'
        WHEN combined_ratio_pct < 100  THEN 'Marginal'
        WHEN combined_ratio_pct < 110  THEN 'Loss Making'
        WHEN combined_ratio_pct >= 110 THEN 'Significant Loss'
        ELSE                                'No Data'
    END AS performance_label
FROM syndicate_clean;
