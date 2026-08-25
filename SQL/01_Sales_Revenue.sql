========================================================
E-COMMERCE ANALYTICS PROJECT
01 - SALES & REVENUE ANALYSIS
========================================================

Dataset:
Olist Brazilian E-Commerce Dataset

Database:
ecommerce_analytics

Business Questions:
1. How are orders distributed by status?
2. How many orders are placed each year?
3. How much revenue is generated each year?
4. What is the Average Order Value (AOV) by year?
5. What are the monthly sales trends?

Main Tables:
- orders
- order_items
========================================================




  
-- ========================================================
-- Q1: Order Volume by Order Status
-- ========================================================

SELECT
    order_status,
    COUNT(DISTINCT order_id) AS order_count
FROM orders
GROUP BY order_status
ORDER BY order_count DESC;


-- ========================================================
-- Q2: Number of Orders by Year
-- ========================================================

SELECT
    YEAR(STR_TO_DATE(order_purchase_timestamp, '%m/%d/%Y %H:%i')) AS order_year,
    COUNT(DISTINCT order_id) AS order_count
FROM orders
GROUP BY order_year
ORDER BY order_year;


-- ========================================================
-- Q3: Total Sales by Year
-- ========================================================

SELECT
    YEAR(STR_TO_DATE(o.order_purchase_timestamp, '%m/%d/%Y %H:%i')) AS order_year,
    SUM(ord.price) AS total_sales
FROM orders o
JOIN order_items ord
    ON o.order_id = ord.order_id
GROUP BY order_year
ORDER BY order_year;


-- ========================================================
-- Q4: Average Order Value (AOV) by Year
-- ========================================================

WITH cte AS
(
    SELECT
        YEAR(STR_TO_DATE(o.order_purchase_timestamp, '%m/%d/%Y %H:%i')) AS order_year,
        COUNT(DISTINCT o.order_id) AS order_count,
        SUM(ord.price) AS total_sales
    FROM orders o
    JOIN order_items ord
        ON o.order_id = ord.order_id
    GROUP BY order_year
)

SELECT
    order_year,
    order_count,
    total_sales,
    total_sales / order_count AS avg_order_value
FROM cte
ORDER BY order_year;


-- ========================================================
-- Q5: Monthly Sales Trend
-- ========================================================

SELECT
    YEAR(STR_TO_DATE(o.order_purchase_timestamp, '%m/%d/%Y %H:%i')) AS order_year,
    MONTH(STR_TO_DATE(o.order_purchase_timestamp, '%m/%d/%Y %H:%i')) AS month_number,
    MONTHNAME(STR_TO_DATE(o.order_purchase_timestamp, '%m/%d/%Y %H:%i')) AS order_month,
    SUM(ord.price) AS total_sales
FROM orders o
JOIN order_items ord
    ON o.order_id = ord.order_id
GROUP BY
    order_year,
    month_number,
    order_month
ORDER BY
    order_year,
    month_number;
