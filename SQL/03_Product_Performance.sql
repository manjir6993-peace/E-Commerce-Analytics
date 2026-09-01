============================================================
E-COMMERCE ANALYTICS PROJECT
03 - PRODUCT PERFORMANCE ANALYSIS
============================================================

Dataset:
Olist Brazilian E-Commerce Dataset

Database:
ecommerce_analytics

Business Questions:

1. Which product categories generate the most revenue?
2. Which product categories sell the most items?
3. Which individual products generate the most revenue?

Main Tables:

- products
- order_items
- product_category_translation

============================================================
-- Q1: Revenue by Product Category
============================================================

SELECT
    p.product_category_name,
    SUM(ord.price) AS total_revenue
FROM products p
JOIN order_items ord
    ON p.product_id = ord.product_id
GROUP BY p.product_category_name
ORDER BY total_revenue DESC;



============================================================
-- Q2: Items Sold by Product Category
============================================================

SELECT
    p.product_category_name,
    COUNT(*) AS items_sold
FROM products p
JOIN order_items ord
    ON p.product_id = ord.product_id
GROUP BY p.product_category_name
ORDER BY items_sold DESC;



============================================================
-- Q3: Top 10 Individual Products by Revenue
--     with English Product Category
============================================================

SELECT
    p.product_id AS individual_product,
    pro.product_category_name_english AS category,
    SUM(ord.price) AS revenue
FROM products p
JOIN order_items ord
    ON p.product_id = ord.product_id
JOIN product_category_translation pro
    ON p.product_category_name = pro.product_category_name
GROUP BY
    individual_product,
    category
ORDER BY revenue DESC
LIMIT 10;
