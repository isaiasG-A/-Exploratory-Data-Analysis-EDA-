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
 -- Identify the earlier and latest dates (boundaries)
 -- Understand the scope of data and the timespan.

 --Task: Find the date of the first and last order
      -- How many years of sales are available

 SELECT 
	 MIN(order_date) AS first_order_date, 
	 MAX(order_date) AS last_order_date,
	 DATEDIFF(year, MIN(order_date), MAX(order_date)) AS order_range_months
 FROM gold.fact_sales

 -- Find the youngest and the oldest customer
 SELECT 
	 MIN(birthdate) AS oldest_birthdate,
	 DATEDIFF(year, MIN(birthdate), GETDATE()) AS oldest_age,
	 MAX(birthdate) AS youngest_birthdate,
	 DATEDIFF(year, MAX(birthdate), GETDATE()) AS youngest_age
 FROM gold.dim_customers

 ---------------------------------------------------------------------------------------------------------------------------------------

 --Measure Exploration
   -- Calculate the key metric of the business (Big Numbers)
   -- Highest Level of Aggregation |  Lowest Level of Details

   https://youtu.be/SSKVgrwhzus?t=101098
