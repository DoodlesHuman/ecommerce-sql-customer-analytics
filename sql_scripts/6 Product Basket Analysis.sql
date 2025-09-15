-- 6. Product Basket Analysis
/* 
What products are frequently purchased 
together in the same order?
*/
SELECT
    p1.product_name,
    p2.product_name,
    COUNT(*) AS frequency
FROM order_items oi1
JOIN 
	order_items oi2 ON oi1.order_id = oi2.order_id 
	AND oi1.product_id < oi2.product_id
JOIN 
	products p1 ON oi1.product_id = p1.product_id
JOIN 
	products p2 ON oi2.product_id = p2.product_id
GROUP BY 
	p1.product_name, p2.product_name
ORDER BY 
	frequency DESC;