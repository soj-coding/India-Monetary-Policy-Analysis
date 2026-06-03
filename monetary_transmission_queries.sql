-- ============================================
-- India Monetary Policy Analysis
-- SQL Queries — Monetary Transmission Analysis
-- Data: RBI DBIE + MOSPI | Period: 2010-2024
-- ============================================


-- ============================================
-- QUERY 1: Descriptive Statistics
-- ============================================

SELECT
AVG(INFLATION) AS avg_inflation,
AVG(REPO_RATE) AS avg_repo,
MIN(INFLATION) AS min_inflation,
MAX(INFLATION) AS max_inflation,
MIN(REPO_RATE) AS min_repo_rate,
MAX(REPO_RATE) AS max_repo_rate
FROM
  `india-macro-project.macro.indian_macro_data`

-- ============================================
-- QUERY 2: Contemporaneous Correlation
-- Purpose: Test same-month relationship
-- Finding: Near-zero correlation confirms
--          no instantaneous transmission
-- ============================================

SELECT
CORR(INFLATION, REPO_RATE) AS inflation_repo_corr
FROM
  `india-macro-project.macro.indian_macro_data`


-- ============================================
-- QUERY 3: Lagged Correlation Analysis
-- Purpose: Measure monetary transmission
--          effect at 3, 6, 9, 12 month lags
-- Finding: Transmission peaks at 9 months
-- ============================================

SELECT
CORR(INFLATION, repo_lag_3) AS corr_3m,
CORR(INFLATION, repo_lag_6) AS corr_6m,
CORR(INFLATION, repo_lag_9) AS corr_9m, 
CORR(INFLATION, repo_lag_12) AS corr_12m 
FROM(
  SELECT
INFLATION,
LAG(REPO_RATE, 3) OVER(ORDER BY DATE) AS repo_lag_3,
LAG(REPO_RATE, 6) OVER(ORDER BY DATE) AS repo_lag_6,
LAG(REPO_RATE, 9) OVER(ORDER BY DATE) AS repo_lag_9,
LAG(REPO_RATE, 12) OVER(ORDER BY DATE) AS repo_lag_12
FROM
  `india-macro-project.macro.indian_macro_data`)