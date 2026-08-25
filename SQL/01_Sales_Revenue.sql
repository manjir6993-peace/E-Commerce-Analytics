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
