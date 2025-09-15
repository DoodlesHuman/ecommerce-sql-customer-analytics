/*
5. Customer Segmentation with RFM Analysis
Can we segment customers into groups like 
'Champions', 'Loyal', 'At-Risk', and 'Lost' 
based on their buying behavior?
*/

-- A. Recency: Days since last purchase for each customer
SELECT
	DISTINCT customer_id,
	MAX(order_date) AS last_order_date,
	CURRENT_DATE - MAX(order_date) AS days_since_last_purchase
FROM
	orders
GROUP BY
	customer_id
ORDER BY
	days_since_last_purchase DESC;
----------------

-- B. Frequency: Total orders for each customer

SELECT
	customer_id,
	COUNT(order_id) AS num_orders
FROM
	orders
GROUP BY
	customer_id
ORDER BY
	num_orders DESC;
----------------------------------------------------
-- C. Monetary: Sum total spending for each customer 

SELECT
	customer_id,
	SUM(total_amount) AS total_value
FROM
	orders
GROUP BY
	customer_id
ORDER BY
	total_value DESC;

----------------------------------------------------
-- A.2 Recency Quartiles
/*
Here, we assign the most recent purchase having customer
a score of 4 and the least one a score of 1.
*/

WITH latest AS(
	SELECT
		DISTINCT customer_id,
		MAX(order_date) AS last_order_date,
		CURRENT_DATE - MAX(order_date) AS days_since_last_purchase
	FROM
		orders
	GROUP BY
		customer_id
)
SELECT
	*,
	NTILE(4) OVER (
		ORDER BY days_since_last_purchase DESC
	) AS recency_score
FROM
	latest
ORDER BY
	recency_score DESC;
----------------------------------------------------

-- B.2 Most Frequent Purchasing Customers
/* Most frequent buyers are awarded a score of 4.
The least frequent with a score of 1.
*/

WITH freq AS(
	SELECT
		customer_id,
		COUNT(order_id) AS num_orders
	FROM
		orders
	GROUP BY
		customer_id
)
SELECT
	*,
	NTILE(4) OVER(
		ORDER BY num_orders
	) AS frequency_score
FROM
	freq
ORDER BY
	frequency_score DESC;

----------------------------------------------------
-- C.2 Monetary Score
/* Highest value customers are awarded a score 4.
Least value customers are awarded 1.
*/

WITH money AS(
	SELECT
		customer_id,
		SUM(total_amount) AS total_value
	FROM
		orders
	GROUP BY
		customer_id
)
SELECT
	*,
	NTILE(4) OVER(
		ORDER BY total_value
	) AS monetary_score
FROM
	money
ORDER BY
	monetary_score DESC;
---------------------------------------------------------
-- D. RFM Scoring and Customer Segmentation

WITH r AS(
	SELECT
		customer_id,
		NTILE(4) OVER (
			ORDER BY (CURRENT_DATE - MAX(order_date)) DESC
		) AS recency_score
	FROM
		orders
	GROUP BY
		customer_id
),
f AS(
	SELECT
		customer_id,
		NTILE(4) OVER(
			ORDER BY COUNT(order_id)
		) AS frequency_score
	FROM
		orders
	GROUP BY
		customer_id
),
m AS(
	SELECT
		customer_id,
		SUM(total_amount) AS total_value,
		NTILE(4) OVER(
			ORDER BY SUM(total_amount)
		) AS monetary_score
	FROM
		orders
	GROUP BY
		customer_id
)
SELECT
	r.customer_id,
	r.recency_score,
	f.frequency_score,
	m.monetary_score,
    CASE
        WHEN r.recency_score = 4 AND f.frequency_score >= 3 AND m.monetary_score >= 3 THEN 'Champions'
        WHEN r.recency_score >= 3 AND f.frequency_score >= 3 THEN 'Loyal Customers'
        WHEN r.recency_score >= 3 AND f.frequency_score >= 2 AND m.monetary_score >= 2 THEN 'Potential Loyalists'
        WHEN r.recency_score = 4 AND f.frequency_score = 1 THEN 'New Customers'
        WHEN r.recency_score = 3 AND f.frequency_score <= 2 THEN 'Promising'
        WHEN r.recency_score <= 3 AND f.frequency_score >= 3 AND m.monetary_score >= 3 THEN 'Needs Attention'
        WHEN r.recency_score <= 2 AND f.frequency_score >= 2 AND m.monetary_score >= 2 THEN 'At Risk'
        WHEN r.recency_score = 1 THEN 'Lost Customers'
        ELSE 'Other' -- any other combinations
    END AS customer_segment
FROM
	r
JOIN f ON r.customer_id = f.customer_id
JOIN m ON r.customer_id = m.customer_id
ORDER BY r.customer_id;

----------------------

-- E. Segments Aggregate Data

WITH r AS(
	SELECT
		customer_id,
		NTILE(4) OVER (
			ORDER BY (CURRENT_DATE - MAX(order_date)) DESC
		) AS recency_score
	FROM
		orders
	GROUP BY
		customer_id
),
f AS(
	SELECT
		customer_id,
		NTILE(4) OVER(
			ORDER BY COUNT(order_id)
		) AS frequency_score
	FROM
		orders
	GROUP BY
		customer_id
),
m AS(
	SELECT
		customer_id,
		SUM(total_amount) AS total_value,
		NTILE(4) OVER(
			ORDER BY SUM(total_amount)
		) AS monetary_score
	FROM
		orders
	GROUP BY
		customer_id
),
segments AS (
	SELECT
		r.customer_id,
		r.recency_score,
		f.frequency_score,
		m.monetary_score,
	    CASE
	        WHEN r.recency_score = 4 AND f.frequency_score >= 3 AND m.monetary_score >= 3 THEN 'Champions'
	        WHEN r.recency_score >= 3 AND f.frequency_score >= 3 THEN 'Loyal Customers'
	        WHEN r.recency_score >= 3 AND f.frequency_score >= 2 AND m.monetary_score >= 2 THEN 'Potential Loyalists'
	        WHEN r.recency_score = 4 AND f.frequency_score = 1 THEN 'New Customers'
	        WHEN r.recency_score = 3 AND f.frequency_score <= 2 THEN 'Promising'
	        WHEN r.recency_score <= 3 AND f.frequency_score >= 3 AND m.monetary_score >= 3 THEN 'Needs Attention'
	        WHEN r.recency_score <= 2 AND f.frequency_score >= 2 AND m.monetary_score >= 2 THEN 'At Risk'
	        WHEN r.recency_score = 1 THEN 'Lost Customers'
	        ELSE 'Other' -- any other combinations
	    END AS customer_segment
	FROM
		r
	JOIN f ON r.customer_id = f.customer_id
	JOIN m ON r.customer_id = m.customer_id
	ORDER BY r.customer_id
)
SELECT
	customer_segment,
	COUNT(customer_segment) AS num_of_customers
FROM
	segments
GROUP BY
	customer_segment
ORDER BY
	num_of_customers;