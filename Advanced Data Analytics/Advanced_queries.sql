
-- Change Over Time
  -- A technique for analyzing a measure that evolves.
    -- Helps track trends and identify seasonality in your data.

    -- Analyze sales performance over time
       -- Changes over years
          -- A high-level overview of insights that helps with strategic decision-making.

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
      -- Output is a string and can't be sorted correctly, only by year and not month.
    SELECT --MMM: Abbreviation of month name.
        FORMAT(order_date, 'yyy--MMM') as order_date,
        SUM(sales_amount) as total_sales,
        COUNT(DISTINCT customer_key) as total_customers,
        SUM(quantity) as total_quantity
    FROM gold.fact_sales
    WHERE order_date IS NOT NULL
    GROUP BY FORMAT(order_date, 'yyy--MMM')
    ORDER BY FORMAT(order_date, 'yyy--MMM') 
-------------------------------------------------------------------------------------------
SELECT * FROM gold.dim_products
SELECT * FROM gold.dim_customers
SELECT * FROM gold.fact_sales
