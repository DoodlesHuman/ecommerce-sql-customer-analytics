/*
3. Top-Selling Products and Categories
Which products and product categories
generate the most revenue?
*/

-- a. Products with most revenue Top 10
WITH temp AS(
	SELECT
		o.order_id, i.product_id, i.quantity
	FROM
		orders AS o
	LEFT JOIN
		order_items AS i
	ON
		i.order_id = o.order_id
)
SELECT
	p.product_name,
	SUM(temp.quantity * p.price) AS total_rev
FROM
	temp
LEFT JOIN
	products AS p
ON
	p.product_id = temp.product_id
GROUP BY
	p.product_name
ORDER BY
	total_rev DESC
LIMIT 10;

-- b. Categories with most reveneue
WITH temp AS(
	SELECT
		o.order_id, i.product_id, i.quantity
	FROM
		orders AS o
	LEFT JOIN
		order_items AS i
	ON
		i.order_id = o.order_id
)
SELECT
	p.category,
	SUM(temp.quantity * p.price) AS total_rev
FROM
	temp
LEFT JOIN
	products AS p
ON
	p.product_id = temp.product_id
GROUP BY
	p.category
ORDER BY
	total_rev DESC;