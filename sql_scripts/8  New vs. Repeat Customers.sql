-- 8.  New vs. Repeat Customers
/*
What is the monthly breakdown 
of orders from new customers 
versus repeat customers?
*/

WITH orders_with_type AS (
    SELECT
        o.order_id,
        o.customer_id,
		EXTRACT(MONTH FROM order_date) AS order_month,
		EXTRACT(YEAR FROM order_date) AS order_year,
        CASE
            WHEN 
				o.order_date = FIRST_VALUE(o.order_date) OVER (
                    PARTITION BY o.customer_id
                    ORDER BY o.order_date
                )
            THEN 'New'
            ELSE 'Repeat'
        END AS customer_type
    FROM orders o
)
SELECT
	order_year,
    order_month,
    customer_type,
    COUNT(order_id) AS order_count
FROM 
	orders_with_type
GROUP BY 
	order_year, order_month, customer_type
ORDER BY 
	order_year, order_month, customer_type;

