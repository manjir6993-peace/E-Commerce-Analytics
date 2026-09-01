============================================================
E-COMMERCE ANALYTICS PROJECT
02 - BUSINESS GROWTH ANALYSIS
============================================================

Dataset:
Olist Brazilian E-Commerce Dataset

Database:
ecommerce_analytics

Business Questions:

1. How many unique customers purchased each year?
2. How many new customers were acquired each year?
3. How many returning customers were there each year?
4. What is the revenue generated per customer each year?

Main Tables:

- customers
- orders
- order_items


  
============================================================
-- Q1: Customer Growth by Year
============================================================

SELECT
    YEAR(
        STR_TO_DATE(
            o.order_purchase_timestamp,
            '%m/%d/%Y %H:%i'
        )
    ) AS order_year,
    COUNT(DISTINCT c.customer_unique_id) AS customer_count
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id
GROUP BY order_year
ORDER BY order_year;



============================================================
-- Q2: New Customer Acquisition by Year
============================================================

WITH first_purchase AS
(
    SELECT
        c.customer_unique_id,
        MIN(
            STR_TO_DATE(
                o.order_purchase_timestamp,
                '%m/%d/%Y %H:%i'
            )
        ) AS first_purchase_date
    FROM orders o
    JOIN customers c
        ON o.customer_id = c.customer_id
    GROUP BY c.customer_unique_id
)

SELECT
    YEAR(first_purchase_date) AS acquisition_year,
    COUNT(*) AS new_customers
FROM first_purchase
GROUP BY acquisition_year
ORDER BY acquisition_year;



============================================================
-- Q3: Returning Customers by Year
============================================================

WITH first_purchase AS
(
    SELECT
        c.customer_unique_id,
        MIN(
            STR_TO_DATE(
                o.order_purchase_timestamp,
                '%m/%d/%Y %H:%i'
            )
        ) AS first_purchase_date
    FROM orders o
    JOIN customers c
        ON o.customer_id = c.customer_id
    GROUP BY c.customer_unique_id
),

customer_orders AS
(
    SELECT
        c.customer_unique_id,
        YEAR(
            STR_TO_DATE(
                o.order_purchase_timestamp,
                '%m/%d/%Y %H:%i'
            )
        ) AS order_year,
        YEAR(fp.first_purchase_date) AS first_purchase_year
    FROM orders o
    JOIN customers c
        ON o.customer_id = c.customer_id
    JOIN first_purchase fp
        ON c.customer_unique_id = fp.customer_unique_id
)

SELECT
    order_year,
    COUNT(DISTINCT customer_unique_id) AS returning_customers
FROM customer_orders
WHERE order_year > first_purchase_year
GROUP BY order_year
ORDER BY order_year;



============================================================
-- Q4: Revenue per Customer by Year
============================================================

WITH cte AS
(
    SELECT
        YEAR(
            STR_TO_DATE(
                o.order_purchase_timestamp,
                '%m/%d/%Y %H:%i'
            )
        ) AS order_year,
        SUM(ord.price) AS total_sales,
        COUNT(DISTINCT c.customer_unique_id) AS customer_count
    FROM orders o
    JOIN customers c
        ON o.customer_id = c.customer_id
    JOIN order_items ord
        ON o.order_id = ord.order_id
    GROUP BY order_year
)

SELECT
    order_year,
    total_sales,
    customer_count,
    total_sales / customer_count AS revenue_per_customer
FROM cte
ORDER BY order_year;
