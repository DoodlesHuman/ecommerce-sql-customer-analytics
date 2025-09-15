/*
1. Basic Business Metrics
Total revenue, number of customers, 
number of orders, customer cities, 
number of products
*/

-- Total Revenue
SELECT
	SUM(total_amount) AS total_revenue
FROM
	orders;

-- Total Number of Orders
SELECT
	COUNT(DISTINCT(order_id)) AS total_orders
FROM
	orders;

-- Total Number of Customers
SELECT
	COUNT(DISTINCT(customer_id)) AS total_number_of_customers
FROM
	customers;

-- Number of Cities of Customers
SELECT
	COUNT(DISTINCT(city)) AS number_of_cities
FROM
	customers;

-- Total Number of Products
SELECT
	COUNT(DISTINCT(product_id)) AS total_number_of_products
FROM
	products;