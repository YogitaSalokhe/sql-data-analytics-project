-- Advanced Data Analytics
-- Change Over Time: Analyze how a measure evolved over time

-- Analyze sales performance over Time.
SELECT 
	YEAR(order_date) AS order_year,
	SUM(sales_amount) AS total_sales,
	COUNT(DISTINCT customer_key) As total_customer,
	COUNT(quantity) as total_quantity_sold
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY YEAR(order_date)
ORDER BY YEAR(order_date);

SELECT 
	YEAR(order_date) AS order_year,
	MONTH(order_date) AS order_month,
	SUM(sales_amount) AS total_sales,
	COUNT(DISTINCT customer_key) As total_customer,
	COUNT(quantity) as total_quantity_sold
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY YEAR(order_date), MONTH(order_date);

--USING DATETRUNC()
SELECT 
	DATETRUNC(MONTH,order_date) AS order_date,  -- truncate a date to the first day of its month.
	SUM(sales_amount) AS total_sales,
	COUNT(DISTINCT customer_key) As total_customer,
	COUNT(quantity) as total_quantity_sold
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(MONTH,order_date) 
ORDER BY DATETRUNC(MONTH,order_date);

SELECT 
	DATETRUNC(YEAR,order_date) AS order_date,  -- truncate a date to the first day of its month.
	SUM(sales_amount) AS total_sales,
	COUNT(DISTINCT customer_key) As total_customer,
	COUNT(quantity) as total_quantity_sold
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(YEAR,order_date)
ORDER BY DATETRUNC(YEAR,order_date);

-- USING FORMAT()
SELECT 
	FORMAT(order_date, 'yyyy-MMM') AS order_date,  
	SUM(sales_amount) AS total_sales,
	COUNT(DISTINCT customer_key) As total_customer,
	COUNT(quantity) as total_quantity_sold
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY FORMAT(order_date, 'yyyy-MMM')
ORDER BY FORMAT(order_date, 'yyyy-MMM');