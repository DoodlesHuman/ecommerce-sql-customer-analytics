-- 9. Impact of Marketing Campaigns
/*
How many orders were placed 
during each marketing campaign period?
*/

SELECT 
	m.campaign_name,
	COUNT(o.order_id) AS num_orders
FROM
	orders AS o
JOIN 
	marketing AS m
ON
	o.order_date BETWEEN m.start_date AND m.end_date
GROUP BY
	m.campaign_name