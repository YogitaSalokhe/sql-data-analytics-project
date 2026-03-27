-- Ranking Analysis
-- Ranking dimensions by measures

-- Which 5 products generates the higest revenue
SELECT TOP 5 p.product_name,
	   SUM(f.sales_amount) AS total_revenue
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON p.product_key = f.product_key
GROUP BY p.product_name
ORDER BY total_revenue DESC;

-- Which 5 product are worst performing in terms of sales
SELECT TOP 5 p.product_name,
	   SUM(f.sales_amount) AS total_revenue
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON p.product_key = f.product_key
GROUP BY p.product_name
ORDER BY total_revenue ASC;

-- Which 5 subcategories generates the higest revenue
SELECT TOP 5 p.subcategory,
	   SUM(f.sales_amount) AS total_revenue
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON p.product_key = f.product_key
GROUP BY p.subcategory
ORDER BY total_revenue DESC;

-- USING WINDOWS FUNCTION
SELECT * 
FROM
	(SELECT p.product_name,
		   SUM(f.sales_amount) AS total_revenue,
		   ROW_NUMBER() OVER(ORDER BY SUM(f.sales_amount) DESC) as rank_products
	FROM gold.fact_sales f
	LEFT JOIN gold.dim_products p
	ON p.product_key = f.product_key
	GROUP BY p.product_name
	) a
WHERE rank_products <=5;

-- FIND the TOP 10 customers who have generated highest revenue 
SELECT TOP 10
	   c.customer_key,
	   c.first_name,
	   c.last_name,
	   SUM(f.sales_amount) AS total_revenue
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON c.customer_key = f.customer_key
GROUP BY  c.customer_key,c.first_name, c.last_name
ORDER BY total_revenue DESC;


-- 3 customers with fewest orders placed

SELECT TOP 3
	   c.customer_key,
	   c.first_name,
	   c.last_name,
	   COUNT(DISTINCT order_number) AS total_orders
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON c.customer_key = f.customer_key
GROUP BY  c.customer_key,c.first_name, c.last_name
ORDER BY total_orders ASC;
