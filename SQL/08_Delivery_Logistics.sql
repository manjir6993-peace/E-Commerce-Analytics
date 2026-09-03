==========================================================
E-COMMERCE ANALYTICS PROJECT
08 - DELIVERY / LOGISTICS ANALYSIS
==========================================================

Business Questions:

1. What is the average delivery time for orders?
2. How many orders were delivered late?
3. What percentage of delivered orders were late?
4. When orders are delivered late, what is the average delay?


  
==========================================================

-- Q1: Average Delivery Time
-- Calculates the average number of days between
-- order purchase and customer delivery
==========================================================

SELECT
    ROUND(
        AVG(
            DATEDIFF(
                STR_TO_DATE(order_delivered_customer_date, '%m/%d/%Y %H:%i'),
                STR_TO_DATE(order_purchase_timestamp, '%m/%d/%Y %H:%i')
            )
        ),
        2
    ) AS avg_delivery_days
FROM orders
WHERE order_delivered_customer_date IS NOT NULL;



==========================================================

-- Q2: Late Deliveries
-- Counts orders delivered after the estimated
-- delivery date
==========================================================

SELECT COUNT(*) AS late_orders
FROM orders
WHERE order_delivered_customer_date IS NOT NULL
  AND STR_TO_DATE(order_delivered_customer_date, '%m/%d/%Y %H:%i')
      > STR_TO_DATE(order_estimated_delivery_date, '%m/%d/%Y %H:%i');



==========================================================

-- Q3: Late Delivery Percentage
-- Calculates the percentage of delivered orders
-- that were delivered after the estimated date
==========================================================

SELECT
    ROUND(
        SUM(
            CASE
                WHEN STR_TO_DATE(order_delivered_customer_date, '%m/%d/%Y %H:%i')
                   > STR_TO_DATE(order_estimated_delivery_date, '%m/%d/%Y %H:%i')
                THEN 1
                ELSE 0
            END
        )
        / COUNT(*) * 100,
        2
    ) AS late_delivery_percent
FROM orders
WHERE order_delivered_customer_date IS NOT NULL;



==========================================================

-- Q4: Average Delay for Late Deliveries
-- Calculates the average number of days orders
-- were delayed beyond the estimated delivery date
==========================================================

SELECT
    ROUND(
        AVG(
            DATEDIFF(
                STR_TO_DATE(order_delivered_customer_date, '%m/%d/%Y %H:%i'),
                STR_TO_DATE(order_estimated_delivery_date, '%m/%d/%Y %H:%i')
            )
        ),
        2
    ) AS avg_delay_days
FROM orders
WHERE order_delivered_customer_date IS NOT NULL
  AND STR_TO_DATE(order_delivered_customer_date, '%m/%d/%Y %H:%i')
      > STR_TO_DATE(order_estimated_delivery_date, '%m/%d/%Y %H:%i');
