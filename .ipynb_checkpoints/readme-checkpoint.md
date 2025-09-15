# SQL Customer Analytics for Einfach Online GmbH
An End-to-End E-commerce Data Analysis Project

## Project Overview
This project is a comprehensive, end-to-end analysis of customer purchasing behavior for **Einfach Online GmbH**, a fictional German e-commerce platform specializing in sustainable products. The goal was to move beyond intuition-based decisions and leverage customer data to answer critical business questions, ultimately providing actionable recommendations to drive growth and improve customer retention.

The entire analysis, from data cleaning and aggregation to complex customer segmentation, was conducted using SQL.

## Key Business Questions
This analysis was guided by a desire to understand our customers and product performance on a deeper level:

1. **Customer Value**: Who are our most valuable customers based on their purchase history?

2. **Product Performance**: What are our best-selling products and categories? Are there opportunities for product bundling?

3. **Geographic Trends**: How does customer behavior vary across different cities in Germany?

4. **Customer Lifecycle**: What is the typical purchasing cycle, and can we identify customers who are at risk of churning?

5. **Marketing Impact**: How effective have our past marketing campaigns been?

## Data Source & Schema
The dataset was *synthetically generated* to model a realistic e-commerce business. It consists of five interconnected tables, which were loaded into a **PostgreSQL** database.

- `customers`: Contains information on 5,000 customers.

- `products`: Details on 100 unique, sustainable products.

- `orders`: Records of 20,000 unique orders.

- `order_items`: The bridge table detailing the contents of each order.

- `marketing`: Information on promotional campaigns.

## Tools & Technologies

- **Data Generation**: Python (Pandas, Faker)

- **Database**: PostgreSQL

- **Analysis**: SQL (using advanced techniques like CTEs, Window Functions, Joins, and Subqueries)

- **Version Control**: Git & GitHub

## Key Findings & Visualizations

### Finding 1: Key Customer Segments Require Strategic Focus

The RFM (Recency, Frequency, Monetary) analysis successfully segmented customers into distinct groups. While "Loyal Customers" form the largest group (18.01%), our most valuable "Champions" make up a significant 13.62% of the customer base.
Here are some of the core insights derived from the SQL analysis.

Critically, the "Needs Attention," "At Risk," and "Lost Customers" segments combined represent over 43% of all customers. This highlights a major opportunity for targeted re-engagement campaigns to prevent churn and recover lost revenue.

![Customer Segments Bar Chart](results/5 segmentation.jpeg)
