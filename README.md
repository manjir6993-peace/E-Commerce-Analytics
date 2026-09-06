# E-Commerce Analytics

An end-to-end E-Commerce Analytics project using SQL and Power BI to analyze sales, customer behavior, product performance, payments, delivery performance, and customer satisfaction.

## Project Overview

This project analyzes the Olist Brazilian E-Commerce Public Dataset containing approximately 100K orders from 2016–2018.

The objective was to transform raw transactional data into actionable business insights using SQL for data analysis and Power BI for interactive reporting.

## Business Objectives

- Analyze overall sales and revenue performance
- Understand customer growth and repeat-purchase behavior
- Identify high-performing product categories
- Evaluate seller performance
- Analyze customer satisfaction and review patterns
- Understand payment-method usage
- Measure delivery performance and late-delivery risk
- Translate findings into business recommendations

## Tools & Technologies

- **SQL:** MySQL
- **BI & Visualization:** Microsoft Power BI
- **Data Source:** Olist Brazilian E-Commerce Public Dataset
- **Version Control:** GitHub

## Dataset

The project uses the Olist Brazilian E-Commerce Public Dataset.

Key tables used:

- Orders
- Order Items
- Customers
- Products
- Sellers
- Order Payments
- Order Reviews
- Product Category Translation

The geolocation dataset was excluded from the Power BI model because it was not required for the core business analysis.

## Analysis Areas

### 01. Sales & Revenue
- Total revenue
- Order volume
- Average Order Value
- Revenue trends

### 02. Business Growth
- Customer growth
- Revenue per customer
- Customer acquisition trends

### 03. Product Performance
- Revenue by product category
- Items sold by category
- Top-performing products

### 04. Customer Behavior
- Unique customers
- Repeat customers
- Repeat customer rate
- Order frequency
- Time between repeat purchases

### 05. Seller Performance
- Seller revenue
- Order volume
- Seller AOV
- High-volume and high-value sellers

### 06. Customer Satisfaction
- Average review score
- Negative reviews
- Negative-review percentage
- Review score distribution

### 07. Payments
- Payment-method usage
- Revenue by payment method
- Average payment value
- Payment installments

### 08. Delivery & Logistics
- Average delivery time
- Late deliveries
- Late-delivery percentage
- Average delay for late deliveries

## Key Business Insights

- Total revenue was approximately **13.59M** across **99,441 orders**.
- Revenue growth was concentrated across **2017–2018**.
- **Health & Beauty** was the highest-revenue product category at approximately **1.26M**.
- Only **3.12% of customers were repeat customers**, indicating a significant retention opportunity.
- Customer sentiment was predominantly positive, with **57.78% of reviews rated 5 stars**.
- **7.87% of delivered orders were late**, with late orders delayed by an average of **8.87 days**.
- Credit cards represented approximately **75% of payment orders**, indicating strong payment-method concentration.

## Power BI Dashboard

The Power BI dashboard contains four pages:

### 1. Executive Overview
Provides an overall view of revenue, orders, AOV, delivery performance, customer retention and product-category performance.

### 2. Customer Performance
Focuses on customer growth, retention, revenue per customer and customer review distribution.

### 3. Operations & Payments
Analyzes delivery performance, payment-method usage, payment revenue and average delivery time.

### 4. Business Insights & Recommendations
Summarizes key findings, business problems and recommended actions.

## Business Recommendations

### Improve Customer Retention
Use loyalty programs, personalized promotions and post-purchase engagement to increase repeat purchases.

### Improve Delivery Reliability
Identify delayed-delivery patterns by seller and category and work with logistics partners to reduce delivery delays.

### Improve Customer Experience
Analyze negative reviews by product category and seller to identify recurring quality, service or delivery issues.

### Diversify Payment Methods
Promote alternative payment methods to reduce dependency on credit-card transactions.

## Project Structure

```text
E-Commerce-Analytics/
│
├── SQL/
│   ├── 01_Sales_Revenue.sql
│   ├── 02_Business_Growth.sql
│   ├── 03_Product_Performance.sql
│   ├── 04_Customer_Behavior.sql
│   ├── 05_Seller_Performance.sql
│   ├── 06_Customer_Satisfaction.sql
│   ├── 07_Payments.sql
│   └── 08_Delivery_Logistics.sql
```text
└── README.md



## Project Outcome

- Analyzed 99K+ e-commerce orders using SQL and Power BI.
- Identified key revenue, customer retention, product, payment, and delivery trends.
- Found that only 3.12% of customers were repeat customers, highlighting a major retention opportunity.
- Identified 7.87% late deliveries with an average delay of 8.87 days.
- Built a 4-page Power BI dashboard covering Executive Overview, Customer Performance, Operations & Payments, and Business Insights.
- Translated analysis findings into actionable business recommendations.


## Power BI Dashboard

### Executive Overview
[View Dashboard](Screenshots/Executive_Overview.jpg)

### Customer Performance
[View Dashboard](Screenshots/Customer_Performance.jpg)

### Operations & Payments
[View Dashboard](Screenshots/Operations_and_Payments.jpg)

### Business Insights
[View Dashboard](Screenshots/Business_Insights.jpg)
