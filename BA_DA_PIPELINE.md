# BA / DA Delivery Pipeline

## Business question
How exposed is the Tiruppur export order book to tariff shocks and market concentration?

## 01 — Excel — mandatory first pass
Clean monthly orders, standardise market/product fields, use formulas and pivots to calculate margin/tariff exposure, concentration and exception cases.

## 02 — Python (Pandas + NumPy) — optional
Use Python for EDA, concentration metrics, sensitivity testing, market clustering or automated transformations when it improves repeatability.

## 03 — SQL — mandatory analytical layer
Use joins, CTEs, aggregations and window functions for market KPIs, concentration ranking, tariff-shock scenarios, peer comparisons and diversification gaps.

## 04 — Power BI — mandatory decision interface
Build the model, DAX measures, slicers and drill-through: Export Executive → Market Mix → Tariff & Margin → Diversification Scenario.

## 05 — Decision — mandatory outcome
Recommend markets/products to grow, defend or exit with priority, owner, margin guardrail, expected impact and assumptions.

## Acceptance criteria
Order-value totals reconcile; tariff and margin measures have clear definitions; scenario logic is auditable; synthetic portfolio data is disclosed.
