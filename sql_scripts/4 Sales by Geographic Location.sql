/*
4 Sales by Geographic Location
Which German cities have 
the highest number of customers 
and generate the most sales?
*/

-- a. Cities with highest number of customers
SELECT
	city,
	COUNT(customer_id) AS num_customers
FROM
	customers
GROUP BY
	city
ORDER BY
	num_customers DESC
LIMIT 10;


-- b. Cities with Most Number of Orders Top 10
SELECT
	c.city,
	COUNT(o.order_id) AS num_orders
FROM
	orders as o
LEFT JOIN
	customers as c
ON
	o.customer_id = c.customer_id
GROUP BY
	c.city
ORDER BY
	num_orders DESC
LIMIT 10;

--c.  Cities with Most Revenue
SELECT
	c.city,
	SUM(o.total_amount) AS total_revenue
FROM
	orders as o
LEFT JOIN
	customers as c
ON
	o.customer_id = c.customer_id
GROUP BY
	c.city
ORDER BY
	total_revenue DESC
LIMIT 10;