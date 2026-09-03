==========================================================
E-COMMERCE ANALYTICS PROJECT
07 - PAYMENT ANALYSIS
==========================================================

Business Questions:

1. Which payment methods are most frequently used by customers?
2. Which payment methods generate the most revenue?
3. What is the average payment value for each payment method?
4. How does payment value vary by the number of installments?


  
==========================================================

-- Q1: Payment Method Usage
-- Identifies the most frequently used payment methods
==========================================================

SELECT payment_type,
       COUNT(DISTINCT order_id) AS order_count
FROM order_payments
GROUP BY payment_type
ORDER BY order_count DESC;



==========================================================

-- Q2: Revenue by Payment Method
-- Identifies payment methods generating the highest revenue
==========================================================

SELECT payment_type,
       SUM(payment_value) AS revenue
FROM order_payments
GROUP BY payment_type
ORDER BY revenue DESC;



==========================================================

-- Q3: Average Payment Value
-- Calculates the average payment value for each payment method
==========================================================

SELECT payment_type,
       AVG(payment_value) AS avg_payment_value
FROM order_payments
GROUP BY payment_type
ORDER BY avg_payment_value DESC;



==========================================================

-- Q4: Payment Value by Installments
-- Analyzes how average payment value varies with the
-- number of installments
==========================================================

SELECT payment_installments,
       AVG(payment_value) AS avg_payment_value
FROM order_payments
GROUP BY payment_installments
ORDER BY payment_installments;
