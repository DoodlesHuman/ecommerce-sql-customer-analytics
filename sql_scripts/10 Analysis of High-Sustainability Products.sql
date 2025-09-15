-- 10. Analysis of High-Sustainability Products
/*
 Do customers who buy products 
 with a high sustainability 
 rating (4 or 5) spend more 
 on average per order?
 */

WITH order_totals AS (
    SELECT
        o.order_id,
        o.customer_id,
        o.total_amount 
    FROM 
		orders AS o
    JOIN order_items AS oi 
		ON o.order_id = oi.order_id
    GROUP BY 
		o.order_id, o.customer_id
),
sustainable_customers AS (
    SELECT DISTINCT
        o.customer_id
    FROM 
		order_items oi
    JOIN products AS p 
		ON oi.product_id = p.product_id
    JOIN orders AS o 
		ON oi.order_id = o.order_id
    WHERE p.sustainability_rating > 3 
),
avg_values AS (    
    SELECT
        CASE 
            WHEN ot.customer_id IN (SELECT customer_id FROM sustainable_customers) 
            THEN 'Sustainable Buyers'
            ELSE 'Other Buyers'
        END AS customer_group,
        ROUND(AVG(ot.total_amount), 2) AS avg_order_value
    FROM 
		order_totals ot
    GROUP BY 
		customer_group
)
SELECT *
FROM avg_values;
