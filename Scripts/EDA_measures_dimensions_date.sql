--Explore All The Objects in the Database
SELECT * FROM INFORMATION_SCHEMA.TABLES;

-- Explore All The Columns in the Database
SELECT * FROM INFORMATION_SCHEMA.COLUMNS; 

-- Explore perticular tables columns
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'dim_customers';

----------------------------------------------------------------------------------------------------------------------------------------
-- Exploring dimensions
-- Explore All the Countries or customers come from
SELECT DISTINCT country FROM gold.dim_customers;

-- Explore All the Categories and subcategories of the products "The major divisions"
-- 4 category, 36 subcategory and 295 products
SELECT DISTINCT category, subcategory, product_name  FROM gold.dim_products
ORDER BY 1,2,3;

---------------------------------------------------------------------------------------------------------------------------
-- Date Exploration
-- Explore the boundaies of the dates that we have in Datasets (Earliest and latest date)
-- understand the scope of data and the timespan
-- MIN/MAX [date_dimension]

--Find the date of the 1st and last order date
SELECT 
	MIN(order_date) AS first_order_date,
	MAX(order_date) AS last_order_date,
	DATEDIFF(YEAR, MIN(order_date),  MAX(order_date)) AS order_range_years  --How many years of sales data is available
FROM gold.fact_sales;

-- Find the youngest and oldest customer
SELECT
	MIN(birthdate) AS Oldest_birthdate,
	DATEDIFF(year,MIN(birthdate), GETDATE()) AS oldest_age,
	MAX(birthdate) AS youngest_birthdate,
	DATEDIFF(year,MAX(birthdate), GETDATE()) AS youngest_age
FROM gold.dim_customers;

--------------------------------------------------------------------------------------------------------------------------------
-- Exploring Measures
-- Find the Total sales
SELECT SUM(sales_amount) AS total_sales FROM gold.fact_sales;

-- Find How many items are sold
SELECT
	SUM(quantity) total_quantity
FROM gold.fact_sales;

-- Find the average	selling price
SELECT AVG(price) AS average_price FROM gold.fact_sales;

-- Find the total number of orders
SELECT COUNT(order_number) AS total_orders
FROM gold.fact_sales;  -- 60398

SELECT COUNT(DISTINCT order_number) AS total_orders
FROM gold.fact_sales;  -- 27659


-- Find the total number of products
SELECT COUNT(product_number) as total_no_of_products
FROM gold.dim_products;

SELECT COUNT(DISTINCT product_number) as total_no_of_products
FROM gold.dim_products;

-- Find the total number of customers
SELECT COUNT(customer_key) as total_no_of_customers
FROM gold.dim_customers;

-- Find the total  number of customers that has placed an order
SELECT	COUNT(DISTINCT customer_key) as total_customers
FROM gold.fact_sales;

-- Generate a Report that shows all the key metrics of the business
SELECT 'Total Sales' AS measure_name, SUM(sales_amount) AS measure_value FROM gold.fact_sales
UNION ALL
SELECT 'Total Quantity', SUM(quantity) FROM gold.fact_sales
UNION ALL
SELECT 'Average Price', AVG(price) FROM gold.fact_sales
UNION ALL
SELECT 'Total Orders', COUNT(DISTINCT order_number) FROM gold.fact_sales
UNION ALL
SELECT 'Total Products', COUNT(DISTINCT product_name) FROM gold.dim_products
UNION ALL
SELECT 'Total Customers', COUNT(customer_key) FROM gold.dim_customers;