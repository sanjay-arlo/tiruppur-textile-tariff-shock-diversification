-- Tiruppur Textile: concentration and tariff-shock analysis
SELECT market,
       COUNT(*) AS observations,
       ROUND(SUM(order_value_inr),0) AS export_value_inr,
       ROUND(AVG(us_tariff_pct),2) AS avg_us_tariff_pct,
       ROUND(AVG(export_margin_pct),2) AS avg_margin_pct,
       ROUND(AVG(order_units_index),2) AS avg_order_units_index
FROM sample_tiruppur_export_orders
GROUP BY market
ORDER BY export_value_inr DESC;

SELECT month, market, us_tariff_pct, order_value_inr,
       order_units_index, export_margin_pct
FROM sample_tiruppur_export_orders
ORDER BY month, market;
