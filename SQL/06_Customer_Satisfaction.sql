==========================================================
E-COMMERCE ANALYTICS PROJECT
06 - CUSTOMER SATISFACTION ANALYSIS
==========================================================

Business Questions:

1. Which product categories have the highest average review scores?
2. Which product categories receive the most negative reviews?
3. Which product categories have the highest percentage of negative reviews?
4. What is the overall distribution of customer review scores?


  
==========================================================

-- Q1: Average Review Score by Category
-- Identifies product categories with the highest average review scores,
-- considering categories with at least 50 reviews
==========================================================

SELECT prod.product_category_name_english,
       ROUND(AVG(review_score), 2) AS Avg_review_score,
       COUNT(*) AS review_count
FROM order_reviews ordr
JOIN order_items ord
    ON ord.order_id = ordr.order_id
JOIN products p
    ON p.product_id = ord.product_id
JOIN product_category_translation prod
    ON p.product_category_name = prod.product_category_name
GROUP BY prod.product_category_name_english
HAVING review_count >= 50
ORDER BY Avg_review_score DESC;



==========================================================

-- Q2: Negative Reviews by Category
-- Identifies product categories receiving the highest number
-- of negative reviews (1-2 star reviews)
==========================================================

SELECT prod.product_category_name_english,
       COUNT(review_score) AS review_count
FROM order_reviews ordr
JOIN order_items ord
    ON ord.order_id = ordr.order_id
JOIN products p
    ON p.product_id = ord.product_id
JOIN product_category_translation prod
    ON p.product_category_name = prod.product_category_name
WHERE review_score <= 2
GROUP BY prod.product_category_name_english
ORDER BY review_count DESC;



==========================================================

-- Q3: Negative Review Percentage by Category
-- Calculates the percentage of reviews that are negative
-- for each product category
==========================================================

WITH total AS
(
    SELECT prod.product_category_name_english,
           COUNT(*) AS total_review_count
    FROM order_reviews ordr
    JOIN order_items ord
        ON ord.order_id = ordr.order_id
    JOIN products p
        ON p.product_id = ord.product_id
    JOIN product_category_translation prod
        ON p.product_category_name = prod.product_category_name
    GROUP BY prod.product_category_name_english
),

negative AS
(
    SELECT prod.product_category_name_english,
           COUNT(*) AS negative_review_count
    FROM order_reviews ordr
    JOIN order_items ord
        ON ord.order_id = ordr.order_id
    JOIN products p
        ON p.product_id = ord.product_id
    JOIN product_category_translation prod
        ON p.product_category_name = prod.product_category_name
    WHERE review_score <= 2
    GROUP BY prod.product_category_name_english
)

SELECT t.product_category_name_english,
       t.total_review_count,
       n.negative_review_count,
       ROUND(
           n.negative_review_count / t.total_review_count * 100,
           2
       ) AS negative_percent
FROM total t
JOIN negative n
    ON t.product_category_name_english = n.product_category_name_english
ORDER BY negative_percent DESC;



==========================================================

-- Q4: Overall Review Score Distribution
-- Shows the number and percentage of reviews for each
-- review score from 1 to 5
==========================================================

WITH total AS
(
    SELECT review_score,
           COUNT(*) AS total_review_count
    FROM order_reviews
    GROUP BY review_score
)

SELECT *,
       ROUND(
           (total_review_count / SUM(total_review_count) OVER ()) * 100,
           2
       ) AS review_percent
FROM total
ORDER BY review_score;
