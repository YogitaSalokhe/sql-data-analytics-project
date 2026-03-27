-- DATA SEGMENTATION
-- Group the date based on a specific range.
-- Helps in understanding the correlation between two measures.

-- TASK : Segment products into cost ranges and count how many products fall into each segment
WITH product_segment AS
(SELECT
	product_key,
	product_name,
	cost,
	CASE WHEN cost < 100 THEN 'Below 100'
		 WHEN cost BETWEEN 100 AND 500 THEN '100-500'
		 WHEN cost BETWEEN 500 AND 1000 THEN '500-1000'	
		 ELSE 'Above 1000'
	END AS cost_range
FROM gold.dim_products
)
SELECT
	cost_range,
	COUNT(product_key) AS total_products
FROM product_segment
GROUP BY cost_range
ORDER BY total_products DESC
;


-- TASK: 
/* Group customers into 3 segments based on thier spending behavior.
  1.VIP Customers: at least 12 months of history and spending more than $5000.
  2.Regular Customers: at least 12 months of history but spending $5000 or less.
  3.New Customers: lifespan less than 12 months
  And find the total number of customers by each group.*/
-- customer_key for total number of customers, sales_amount for calculating total spending, order_date to calculate months or lifespan
WITH customer_segment AS
(
SELECT
	c.customer_key,
	SUM(f.sales_amount) AS total_spending,
	MIN(order_date) AS first_order,
	MAX(order_date) AS last_order,
	DATEDIFF(MONTH, MIN(order_date), MAX(order_date)) AS lifespan
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON f.customer_key = c.customer_key
GROUP BY c.customer_key
)
SELECT customer_type,
		COUNT(customer_key) as total_customer
FROM
(
SELECT
	customer_key,
	CASE WHEN lifespan >= 12 AND total_spending > 5000 THEN 'VIP'
		 WHEN lifespan >= 12 AND total_spending <= 5000 THEN 'REGULAR'
		 ELSE 'NEW'
	END AS customer_type
FROM customer_segment
)t
GROUP BY customer_type
ORDER BY total_customer DESC;
