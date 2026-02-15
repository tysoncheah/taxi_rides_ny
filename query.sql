SELECT 
    pickup_zone,
    SUM(revenue_monthly_total_amount) AS total_revenue
FROM ny_taxi.prod.fct_monthly_zone_revenue
WHERE service_type = 'Green' 
  AND revenue_month >= '2020-01-01' 
  AND revenue_month < '2021-01-01'
GROUP BY pickup_zone
ORDER BY total_revenue DESC
LIMIT 10;
