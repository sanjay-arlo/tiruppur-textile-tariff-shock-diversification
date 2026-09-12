-- Tiruppur Textile: reproducible export-risk SQL
-- MySQL 8+; portfolio data is synthetic/illustrative.

-- 1) Market KPI layer
WITH market_kpi AS (
    SELECT market,
           COUNT(*) AS observations,
           SUM(order_value_inr) AS order_value_inr,
           AVG(us_tariff_pct) AS avg_tariff_pct,
           AVG(export_margin_pct) AS avg_margin_pct,
           AVG(order_units_index) AS avg_order_units_index
    FROM sample_tiruppur_export_orders
    GROUP BY market
)
SELECT market, observations,
       ROUND(order_value_inr,0) AS order_value_inr,
       ROUND(avg_tariff_pct,2) AS avg_tariff_pct,
       ROUND(avg_margin_pct,2) AS avg_margin_pct,
       ROUND(avg_order_units_index,2) AS avg_order_units_index
FROM market_kpi
ORDER BY order_value_inr DESC;

-- 2) Window function: market concentration share and rank
WITH market_kpi AS (
    SELECT market, SUM(order_value_inr) AS order_value_inr
    FROM sample_tiruppur_export_orders
    GROUP BY market
)
SELECT market,
       ROUND(order_value_inr,0) AS order_value_inr,
       ROUND(100.0 * order_value_inr / NULLIF(SUM(order_value_inr) OVER (),0),2) AS order_share_pct,
       DENSE_RANK() OVER (ORDER BY order_value_inr DESC) AS market_rank
FROM market_kpi
ORDER BY market_rank;

-- 3) CTE + join: product/market records below market margin benchmark
WITH market_avg AS (
    SELECT market, AVG(export_margin_pct) AS market_margin
    FROM sample_tiruppur_export_orders
    GROUP BY market
)
SELECT o.month, o.market, o.product_category,
       ROUND(o.export_margin_pct,2) AS margin_pct,
       ROUND(m.market_margin,2) AS market_avg_margin_pct,
       ROUND(m.market_margin - o.export_margin_pct,2) AS margin_gap
FROM sample_tiruppur_export_orders o
JOIN market_avg m ON o.market = m.market
WHERE o.export_margin_pct < m.market_margin
ORDER BY margin_gap DESC;

-- 4) Tariff-shock exception queue
SELECT month, market, product_category,
       us_tariff_pct, order_value_inr, order_units_index, export_margin_pct,
       ROUND(order_value_inr * us_tariff_pct / 100,0) AS tariff_exposure_proxy_inr
FROM sample_tiruppur_export_orders
WHERE us_tariff_pct >= 10 OR export_margin_pct < 10
ORDER BY tariff_exposure_proxy_inr DESC, export_margin_pct ASC
LIMIT 25;

-- 5) Data-quality control
SELECT COUNT(*) AS invalid_rows
FROM sample_tiruppur_export_orders
WHERE month IS NULL OR market IS NULL OR product_category IS NULL
   OR us_tariff_pct IS NULL OR order_value_inr IS NULL OR export_margin_pct IS NULL;
