============================================================
E-COMMERCE ANALYTICS PROJECT
04 - CUSTOMER BEHAVIOR ANALYSIS
============================================================

Business Questions:

1. How frequently do customers place orders?
2. What is the repeat customer rate?
3. How much revenue does each customer generate?
4. How long is the average gap between repeat purchases?


  
============================================================
-- Q1: Customer Order Frequency
-- Shows how many customers placed 1, 2, 3, etc. orders
============================================================

WITH customer_orders AS
(
    SELECT
        c.customer_unique_id,
        COUNT(o.order_id) AS order_count
    FROM customers c
    JOIN orders o
        ON o.customer_id = c.customer_id
    GROUP BY c.customer_unique_id
)

SELECT
    order_count,
    COUNT(customer_unique_id) AS customer_count
FROM customer_orders
GROUP BY order_count
ORDER BY order_count;



============================================================
-- Q2: Repeat Customer Count
-- A repeat customer is one who placed more than 1 order
============================================================

WITH customer_orders AS
(
    SELECT
        c.customer_unique_id,
        COUNT(o.order_id) AS order_count
    FROM customers c
    JOIN orders o
        ON o.customer_id = c.customer_id
    GROUP BY c.customer_unique_id
)

SELECT
    COUNT(customer_unique_id) AS repeat_customers
FROM customer_orders
WHERE order_count > 1;



============================================================
-- Q3: Average Revenue per Customer
============================================================

WITH customer_revenue AS
(
    SELECT
        c.customer_unique_id,
        SUM(ord.price) AS revenue
    FROM customers c
    JOIN orders o
        ON o.customer_id = c.customer_id
    JOIN order_items ord
        ON o.order_id = ord.order_id
    GROUP BY c.customer_unique_id
)

SELECT
    AVG(revenue) AS average_revenue_per_customer
FROM customer_revenue;



============================================================
-- Q4: Average Gap Between Repeat Purchases
-- Measures calendar days between consecutive orders
============================================================

WITH cte AS
(
    SELECT
        c.customer_unique_id,
        o.order_purchase_timestamp,
        LAG(o.order_purchase_timestamp)
            OVER (
                PARTITION BY c.customer_unique_id
                ORDER BY o.order_purchase_timestamp
            ) AS previous_order_date
    FROM customers c
    JOIN orders o
        ON o.customer_id = c.customer_id
),

xyz AS
(
    SELECT
        customer_unique_id,
        order_purchase_timestamp,
        previous_order_date,
        DATEDIFF(
            STR_TO_DATE(
                order_purchase_timestamp,
                '%m/%d/%Y %H:%i'
            ),
            STR_TO_DATE(
                previous_order_date,
                '%m/%d/%Y %H:%i'
            )
        ) AS days_since_previous_order
    FROM cte
)

SELECT
    AVG(days_since_previous_order) AS avg_days_between_orders
FROM xyz
WHERE previous_order_date IS NOT NULL;
