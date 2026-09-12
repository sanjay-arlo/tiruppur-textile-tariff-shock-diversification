from pathlib import Path
import csv
p=Path(__file__).parents[1]/'sample_tiruppur_export_orders.csv'
req={'month','market','product_category','us_tariff_pct','order_value_inr','order_units_index','export_margin_pct'}
with p.open(newline='',encoding='utf-8') as f: rows=list(csv.DictReader(f))
missing=sorted(req-set(rows[0])) if rows else sorted(req)
invalid=sum(1 for r in rows if float(r['us_tariff_pct'])<0 or float(r['order_value_inr'])<0 or float(r['order_units_index'])<0)
print({'rows':len(rows),'missing_columns':missing,'invalid_rows':invalid})
