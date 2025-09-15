-- 7. Average Time Between Orders
/*
On average, 
how long does it take for a customer 
to place their next order? 
This helps define a churn threshold
*/
WITH dates AS(
	SELECT
		customer_id,
		order_date,
		LEAD(order_date, 1) OVER (
			PARTITION BY customer_id
			ORDER BY order_date
		) AS next_order_date
	FROM
		orders
	GROUP BY
		customer_id, order_date
)
SELECT
	customer_id,
	ROUND(AVG(next_order_date - order_date),2) AS avg_days
FROM
	dates
WHERE 
	next_order_date IS NOT NULL
GROUP BY
	customer_id
ORDER BY
	avg_days DESC;

-- B. Overall churn benchmark
WITH dates AS (
    SELECT
        customer_id,
        order_date,
        LEAD(order_date, 1) OVER (
            PARTITION BY customer_id
            ORDER BY order_date
        ) AS next_order_date
    FROM orders
    GROUP BY customer_id, order_date
)
SELECT
    ROUND(AVG(next_order_date - order_date), 2) AS overall_avg_days_between_orders
FROM dates
WHERE next_order_date IS NOT NULL;
