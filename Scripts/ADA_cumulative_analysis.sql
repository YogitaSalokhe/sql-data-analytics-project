-- CUMULATIVE ANALYSIS
-- calculate the total sales per month
-- and the running total of sales over time

SELECT
	order_date,
	total_sales,
	SUM(total_sales) OVER(ORDER BY order_date) AS running_total_sales
FROM
(
	SELECT 
		DATETRUNC(MONTH,order_date) AS order_date,  -- truncate a date to the first day of its month.
		SUM(sales_amount) AS total_sales
	FROM gold.fact_sales
	WHERE order_date IS NOT NULL
	GROUP BY DATETRUNC(MONTH,order_date) 
)t;

SELECT
	order_date,
	total_sales,
	SUM(total_sales) OVER(ORDER BY order_date) AS running_total_sales
FROM
(
	SELECT 
		DATETRUNC(YEAR,order_date) AS order_date,  -- truncate a date to the first day of its month.
		SUM(sales_amount) AS total_sales
	FROM gold.fact_sales
	WHERE order_date IS NOT NULL
	GROUP BY DATETRUNC(YEAR,order_date) 
)t;

-- calculate the moving average of the price
SELECT
	order_date,
	total_sales,
	SUM(total_sales) OVER(ORDER BY order_date) AS running_total_sales,
	AVG(avg_price) OVER(ORDER BY order_date) AS moving_avg_price
FROM
(
	SELECT 
		DATETRUNC(YEAR,order_date) AS order_date,  -- truncate a date to the first day of its month.
		SUM(sales_amount) AS total_sales,
		AVG(price) as avg_price
	FROM gold.fact_sales
	WHERE order_date IS NOT NULL
	GROUP BY DATETRUNC(YEAR,order_date) 
)t;
