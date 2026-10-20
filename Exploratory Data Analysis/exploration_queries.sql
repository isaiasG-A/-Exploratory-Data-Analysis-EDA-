-- Explore All Objects in the Database
SELECT * FROM INFORMATION_SCHEMA.TABLES




-- Explore All Columns in the Database
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'dim_customers' 

-------------------------------------------------------------------------------------------------------------------------------------

--Dimension Exploration

SELECT DISTINCT country FROM gold.dim_customers
SELECT DISTINCT category, subcategory, product_name FROM gold.dim_products

---------------------------------------------------------------------------------------------------------------------------------------

-- Date Exploration
 -- Identify the earliest and latest dates (boundaries)
 -- Understand the scope of data and the time span.

 --Task: Find the date of the first and last order

 SELECT 
	 MIN(order_date) AS first_order_date, 
	 MAX(order_date) AS last_order_date
 FROM gold.fact_sales

