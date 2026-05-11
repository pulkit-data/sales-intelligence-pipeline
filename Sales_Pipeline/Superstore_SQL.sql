 
SELECT 
    ROUND(SUM(sales)::numeric, 2) AS total_revenue,
    ROUND(SUM(profit)::numeric, 2) AS total_profit,
    COUNT(DISTINCT order_id) AS total_orders,
    COUNT(DISTINCT customer_id) AS total_customers,
    ROUND(AVG(profit_margin * 100)::numeric, 2) AS avg_profit_margin_pct
FROM sales_data;

SELECT 
    year,
    EXTRACT(MONTH FROM order_date) AS month_num,
    TO_CHAR(order_date, 'Month') AS month_name,
    ROUND(SUM(sales)::numeric, 2) AS monthly_revenue,
    ROUND(SUM(profit)::numeric, 2) AS monthly_profit
FROM sales_data
GROUP BY year, month_num, month_name
ORDER BY year, month_num;

SELECT 
    region,
    ROUND(SUM(sales)::numeric, 2) AS total_revenue,
    ROUND(SUM(profit)::numeric, 2) AS total_profit,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(AVG(profit_margin * 100)::numeric, 2) AS avg_profit_margin_pct
FROM sales_data
GROUP BY region
ORDER BY total_revenue DESC;

SELECT 
    product_name,
    category,
    ROUND(SUM(sales)::numeric, 2) AS total_revenue,
    ROUND(SUM(profit)::numeric, 2) AS total_profit,
    SUM(quantity) AS total_units_sold
FROM sales_data
GROUP BY product_name, category
ORDER BY total_revenue DESC
LIMIT 10;

SELECT 
    category,
    sub_category,
    ROUND(SUM(sales)::numeric, 2) AS total_revenue,
    ROUND(SUM(profit)::numeric, 2) AS total_profit,
    ROUND(AVG(profit_margin * 100)::numeric, 2) AS avg_profit_margin_pct
FROM sales_data
GROUP BY category, sub_category
ORDER BY category, total_revenue DESC;

SELECT 
    segment,
    COUNT(DISTINCT customer_id) AS total_customers,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(sales)::numeric, 2) AS total_revenue,
    ROUND(SUM(profit)::numeric, 2) AS total_profit,
    ROUND(AVG(profit_margin * 100)::numeric, 2) AS avg_profit_margin_pct
FROM sales_data
GROUP BY segment
ORDER BY total_revenue DESC;

SELECT 
    CASE 
        WHEN discount = 0 THEN 'No Discount'
        WHEN discount <= 0.10 THEN 'Low (1-10%)'
        WHEN discount <= 0.20 THEN 'Medium (11-20%)'
        WHEN discount <= 0.30 THEN 'High (21-30%)'
        ELSE 'Very High (30%+)'
    END AS discount_tier,
    COUNT(*) AS total_orders,
    ROUND(SUM(sales)::numeric, 2) AS total_revenue,
    ROUND(SUM(profit)::numeric, 2) AS total_profit,
    ROUND(AVG(profit_margin * 100)::numeric, 2) AS avg_profit_margin_pct
FROM sales_data
GROUP BY discount_tier
ORDER BY total_profit DESC;

SELECT 
    ship_mode,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(sales)::numeric, 2) AS total_revenue,
    ROUND(AVG(EXTRACT(DAY FROM (ship_date - order_date)))::numeric, 1) AS avg_ship_days
FROM sales_data
GROUP BY ship_mode
ORDER BY total_orders DESC;

CREATE OR REPLACE VIEW vw_business_summary AS
SELECT 
    ROUND(SUM(sales)::numeric, 2) AS total_revenue,
    ROUND(SUM(profit)::numeric, 2) AS total_profit,
    COUNT(DISTINCT order_id) AS total_orders,
    COUNT(DISTINCT customer_id) AS total_customers,
    ROUND(AVG(profit_margin * 100)::numeric, 2) AS avg_profit_margin_pct
FROM sales_data;

CREATE OR REPLACE VIEW vw_monthly_trend AS
SELECT 
    year,
    EXTRACT(MONTH FROM order_date) AS month_num,
    TO_CHAR(order_date, 'Month') AS month_name,
    ROUND(SUM(sales)::numeric, 2) AS monthly_revenue,
    ROUND(SUM(profit)::numeric, 2) AS monthly_profit
FROM sales_data
GROUP BY year, month_num, month_name
ORDER BY year, month_num;

CREATE OR REPLACE VIEW vw_region_performance AS
SELECT 
    region,
    ROUND(SUM(sales)::numeric, 2) AS total_revenue,
    ROUND(SUM(profit)::numeric, 2) AS total_profit,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(AVG(profit_margin * 100)::numeric, 2) AS avg_profit_margin_pct
FROM sales_data
GROUP BY region
ORDER BY total_revenue DESC;

CREATE OR REPLACE VIEW vw_top_products AS
SELECT 
    product_name,
    category,
    ROUND(SUM(sales)::numeric, 2) AS total_revenue,
    ROUND(SUM(profit)::numeric, 2) AS total_profit,
    SUM(quantity) AS total_units_sold
FROM sales_data
GROUP BY product_name, category
ORDER BY total_revenue DESC
LIMIT 10;

CREATE OR REPLACE VIEW vw_category_performance AS
SELECT 
    category,
    sub_category,
    ROUND(SUM(sales)::numeric, 2) AS total_revenue,
    ROUND(SUM(profit)::numeric, 2) AS total_profit,
    ROUND(AVG(profit_margin * 100)::numeric, 2) AS avg_profit_margin_pct
FROM sales_data
GROUP BY category, sub_category
ORDER BY category, total_revenue DESC;

CREATE OR REPLACE VIEW vw_customer_segment AS
SELECT 
    segment,
    COUNT(DISTINCT customer_id) AS total_customers,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(sales)::numeric, 2) AS total_revenue,
    ROUND(SUM(profit)::numeric, 2) AS total_profit,
    ROUND(AVG(profit_margin * 100)::numeric, 2) AS avg_profit_margin_pct
FROM sales_data
GROUP BY segment
ORDER BY total_revenue DESC;

CREATE OR REPLACE VIEW vw_discount_impact AS
SELECT 
    CASE 
        WHEN discount = 0 THEN 'No Discount'
        WHEN discount <= 0.10 THEN 'Low (1-10%)'
        WHEN discount <= 0.20 THEN 'Medium (11-20%)'
        WHEN discount <= 0.30 THEN 'High (21-30%)'
        ELSE 'Very High (30%+)'
    END AS discount_tier,
    COUNT(*) AS total_orders,
    ROUND(SUM(sales)::numeric, 2) AS total_revenue,
    ROUND(SUM(profit)::numeric, 2) AS total_profit,
    ROUND(AVG(profit_margin * 100)::numeric, 2) AS avg_profit_margin_pct
FROM sales_data
GROUP BY discount_tier
ORDER BY total_profit DESC;

CREATE OR REPLACE VIEW vw_shipping_analysis AS
SELECT 
    ship_mode,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(sales)::numeric, 2) AS total_revenue,
    ROUND(AVG(EXTRACT(DAY FROM (ship_date - order_date)))::numeric, 1) AS avg_ship_days
FROM sales_data
GROUP BY ship_mode
ORDER BY total_orders DESC;
