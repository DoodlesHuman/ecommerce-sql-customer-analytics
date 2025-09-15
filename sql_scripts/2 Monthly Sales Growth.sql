/*
2. Monthly Sales Growth
How have our sales grown month-over-month?
*/
WITH sums AS(
	SELECT
		EXTRACT(MONTH FROM order_date) AS month,
		EXTRACT(YEAR FROM order_date) AS year,
		SUM(total_amount) AS revenue
	FROM
		orders
	GROUP BY
		month,
		year
	ORDER BY
		year,
		month
),
lags AS(
	SELECT
		month, year,
		revenue,
		LAG(revenue, 1, 0) OVER () AS prev_rev 
	FROM
		sums
)
SELECT
	month, year, revenue, prev_rev,
	CASE
		WHEN prev_rev = 0 THEN 0
		ELSE ROUND(100 * (revenue - prev_rev)/ prev_rev, 2)
	END AS monthly_growth_percentage
FROM
	lags