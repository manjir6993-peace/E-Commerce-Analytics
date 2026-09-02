==========================================================
E-COMMERCE ANALYTICS PROJECT
05 - SELLER PERFORMANCE ANALYSIS
==========================================================

Business Questions:

1. Which sellers generate the most revenue?
2. Which sellers have the most orders?
3. Which sellers have the highest AOV?
4. Which sellers are both high-volume and high-value?


  
==========================================================

-- Q1: Seller Revenue
-- Identifies sellers generating the highest revenue
==========================================================

SELECT s.seller_id,
       SUM(ord.price) AS revenue
FROM sellers s
JOIN order_items ord
    ON s.seller_id = ord.seller_id
GROUP BY s.seller_id
ORDER BY revenue DESC
LIMIT 10;



==========================================================

-- Q2: Seller Order Volume
-- Identifies sellers handling the highest number of orders
==========================================================

SELECT s.seller_id,
       COUNT(DISTINCT ord.order_id) AS order_count
FROM sellers s
JOIN order_items ord
    ON s.seller_id = ord.seller_id
GROUP BY s.seller_id
ORDER BY order_count DESC
LIMIT 10;



==========================================================

-- Q3: Seller Average Order Value
-- Ranks sellers by AOV, considering sellers with at least 10 orders
==========================================================

WITH revenue AS
(
    SELECT s.seller_id,
           SUM(ord.price) AS revenue
    FROM sellers s
    JOIN order_items ord
        ON s.seller_id = ord.seller_id
    GROUP BY s.seller_id
),

count_of_orders AS
(
    SELECT s.seller_id,
           COUNT(DISTINCT ord.order_id) AS order_count
    FROM sellers s
    JOIN order_items ord
        ON s.seller_id = ord.seller_id
    GROUP BY s.seller_id
)

SELECT co.seller_id,
       r.revenue,
       co.order_count,
       r.revenue / co.order_count AS AOV
FROM count_of_orders co
JOIN revenue r
    ON r.seller_id = co.seller_id
WHERE co.order_count >= 10
ORDER BY AOV DESC
LIMIT 10;



==========================================================

-- Q4: High-Volume and High-Value Sellers
-- Identifies sellers with at least 500 orders and 100,000+ revenue
==========================================================

WITH revenue AS
(
    SELECT s.seller_id,
           SUM(ord.price) AS revenue
    FROM sellers s
    JOIN order_items ord
        ON s.seller_id = ord.seller_id
    GROUP BY s.seller_id
),

count_of_orders AS
(
    SELECT s.seller_id,
           COUNT(DISTINCT ord.order_id) AS order_count
    FROM sellers s
    JOIN order_items ord
        ON s.seller_id = ord.seller_id
    GROUP BY s.seller_id
)

SELECT co.seller_id,
       r.revenue,
       co.order_count
FROM count_of_orders co
JOIN revenue r
    ON r.seller_id = co.seller_id
WHERE r.revenue >= 100000
  AND co.order_count >= 500
ORDER BY r.revenue DESC
LIMIT 10;
