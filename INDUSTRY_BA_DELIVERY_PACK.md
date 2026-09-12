# Industry BA Delivery Pack — Tiruppur Textile Tariff Shock & Diversification

## Executive decision
Quantify export concentration and tariff-driven margin exposure, then identify alternative markets that reduce dependency risk without destroying margin.

## Stakeholders
Export sales, merchandising, finance, buyers, trade/compliance teams and executive management.

## Requirements
- Track order value, units, market and product mix.
- Model tariff and order-loss scenarios.
- Calculate concentration and revenue-at-risk.
- Compare diversification targets.
- Export decision-ready order slices.

## KPI dictionary
Export value, top-market share, tariff rate, order-units index, export margin and revenue-at-risk.

## Analytical model
`dim_month` + `dim_market` + `dim_product` → `fact_export_order` → concentration/risk KPI layer.

## Scenario model
Test tariff shock, order-loss and alternative-market uplift assumptions with explicit sensitivity ranges.

## Acceptance criteria
Market concentration reconciles to order value, scenario assumptions are visible, margin impacts are reproducible and no illustrative result is represented as verified trade data.

## Production controls
Shipment/order lineage, tariff master, buyer mapping, margin reconciliation, scenario versioning and sensitivity documentation.

## Portfolio note
Synthetic illustrative data only; scenario outputs are not trade forecasts.
