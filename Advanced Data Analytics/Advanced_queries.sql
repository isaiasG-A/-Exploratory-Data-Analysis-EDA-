-- Change Over Time
  -- A technique on how to Analyze a measure that evolves over time.
    -- Helps track trends and identify seasonality in your data.

    -- Analyze sales performance overtime
       -- Changes over years
          -- A high-level overview insights that helps with strategic decision-making.

    SELECT --DATETRUNC(month/year, date_value): Rounds a date or timestamp to a specific date
                -- Data will be sorted by the month.
        DATETRUNC(month, order_date) as order_date,
        SUM(sales_amount) as total_sales,
        COUNT(DISTINCT customer_key) as total_customers,
        SUM(quantity) as total_quantity
    FROM gold.fact_sales
    WHERE order_date IS NOT NULL
    GROUP BY DATETRUNC(month, order_date)
    ORDER BY DATETRUNC(month, order_date) 

    --FORMAT(): For a specific date format
      -- Output is a string and cant be sorted correctly, only by year and not month.
    SELECT --MMM: Abvreviation of month name.
        FORMAT(order_date, 'yyy--MMM') as order_date,
        SUM(sales_amount) as total_sales,
        COUNT(DISTINCT customer_key) as total_customers,
        SUM(quantity) as total_quantity
    FROM gold.fact_sales
    WHERE order_date IS NOT NULL
    GROUP BY FORMAT(order_date, 'yyy--MMM')
    ORDER BY FORMAT(order_date, 'yyy--MMM') 

------------------------------------------------------------------------------------------

-- Cumulative Analysis
    -- Aggregate the data progressively over time.
    -- Helps to understand whether the bussiness is growing or declining.

    --Calculate the total sales per month
    -- and the running total of sales over time.
    SELECT 
        order_date,
        total_sales,
        --WINDOW FUNCTION
        --Adding each row's value to the sum of all the previous row's values
        SUM(total_sales) OVER (ORDER BY order_date) AS running_total_sales,
        AVG(avg_price) OVER (ORDER BY order_date)AS moving_average_price
    FROM 
    (
        SELECT
            DATETRUNC(year, order_date) AS order_date,
            SUM(sales_amount) AS total_sales,
            AVG(price) AS avg_price
        FROM gold.fact_sales
        WHERE order_date IS NOT NULL
        GROUP BY DATETRUNC(year, order_date)
        )t

-----------------------------------------------------------------------------------------------

-- Performance Analysis
  -- Comparing the current value to a target value.
  -- Help measure success and compare performance.

    -- Analyze the yearly performance of products
     -- by comparing each product's sales to both its average sales performance and the previous year's sales
     --AVG needed and previouus sales 
     -- CTE or SUBQUERY can be used

 WITH yearly_product_sales AS(
 SELECT 
    YEAR(f.order_date) AS order_year, --Change YEAR to MONTH to analyses month to month
    p.product_name,
    SUM(f.sales_amount) AS current_sales
 FROM gold.fact_sales f
 LEFT JOIN gold.dim_products p
 ON f.product_key = p.product_key
 WHERE f.order_date IS NOT NULL
 GROUP BY
 YEAR(f.order_date),
 p.product_name
 )
 SELECT
 order_year,
 product_name,
 current_sales,
 --Comparing performance of Sales of each product with the Average.
 AVG(current_sales) OVER (PARTITION BY product_name) avg_sales,
 current_sales - AVG(current_sales) OVER (PARTITION BY product_name) AS diff_avg,
 CASE WHEN current_sales - AVG(current_sales) OVER (PARTITION BY product_name) > 0 THEN 'Above Avg'
      WHEN  current_sales - AVG(current_sales) OVER (PARTITION BY product_name) < 0 THEN 'Below Avg'
      ELSE 'Avg'
END avg_change,
-- Year-over-year Analysis--
LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) py_sales,

current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) AS diff_py,
CASE WHEN current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) > 0 THEN 'Increase'
      WHEN  current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) < 0 THEN 'Decrease'
      ELSE 'No Change'
END avg_change
 FROM yearly_product_sales
 ORDER BY product_name, order_year

      

 --Part-To-Whole Analysis
   -- Analyze how an individual part is performing compared to the overall, allowing us to understand which category
      -- has the greatest impact on the business. 

      https://youtu.be/SSKVgrwhzus?t=104401

-----------------------------------------------------

-------------------------------------------------------------------------------------------
SELECT * FROM gold.dim_products
SELECT * FROM gold.dim_customers
SELECT * FROM gold.fact_sales
