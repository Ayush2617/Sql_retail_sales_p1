-- SQL  RETAIL SALES ANALYSIS - PROJECT 1
CREATE DATABASE sql_project_p1;
USE sql_project_p1;

CREATE TABLE RETAIL_SALES(
    transactions_id INT PRIMARY KEY,
	sale_date DATE,
	sale_time TIME,
	customer_id	 INT ,
    gender VARCHAR(15),
	age	INT,
    category VARCHAR(15),
	quantiy INT,
	price_per_unit	FLOAT,
    cogs	FLOAT,
    total_sale INT
);
SELECT * FROM RETAIL_SALES;
SELECT COUNT(*) FROM RETAIL_SALES;
SELECT COUNT(*) FROM RETAIL_SALES WHERE transactions_id is NULL;
-- SELECT MIN(transactions_id), MAX(transactions_id)
-- FROM RETAIL_SALES;

SELECT * FROM RETAIL_SALES WHERE
		sale_date is NULL
        OR
		sale_time is NULL
        OR
        customer_id is NULL
		OR
        transactions_id is NULL
        OR
        gender is NULL
        OR
        category is NULL
        OR
        quantiy is NULL
        or
        price_per_unit is NULL
        OR 
        cogs is NULL
        OR 
        total_sale is NULL;

-- DATA EXPLORATION
-- TOTAL NUMBER OF RECORDS
SELECT COUNT(*) AS total_sale FROM  RETAIL_SALES;

-- NUMNER OF UNIQUE  CUSTOMERS
SELECT COUNT(DISTINCT customer_id) as total_customer FROM RETAIL_SALES;

-- UNIQUE CATEGORY
SELECT COUNT(DISTINCT category ) AS no_of_categories FROM RETAIL_SALES;
SELECT DISTINCT category  AS categories FROM RETAIL_SALES;

-- DATA ANALYSIS & BUSINESS PROBLEMS
-- 1.Write a SQL query to retrieve all columns for sales made on '2022-11-05:
SELECT * 
FROM RETAIL_SALES
WHERE sale_date='2022-11-05';

-- 2.Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:
SELECT *
FROM RETAIL_SALES
WHERE
     category= 'Clothing'
     AND 
     quantiy>=4
     AND
     sale_date>='2022-11-01'
     AND
     sale_date<='2022-11-30';

-- 3.Write a SQL query to calculate the total sales (total_sale) for each category.
SELECT category,SUM(total_sale) AS TOTAL_SALE,COUNT(*) as TOTAL_ORDERS
FROM RETAIL_SALES
GROUP BY category;

-- 4.Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category. 
SELECT ROUND(AVG(age),2) as AVERAGE_AGE
FROM RETAIL_SALES
WHERE category ='Beauty';

-- 5.Write a SQL query to find all transactions where the total_sale is greater than 1000.
SELECT * 
FROM RETAIL_SALES
WHERE total_sale>1000;

-- 6.Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
SELECT category,gender,COUNT(transactions_id) AS TOTAL_TRANSACTION
FROM RETAIL_SALES
GROUP BY category, gender
ORDER BY category;

-- 7.Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:
SELECT * 
FROM(
     SELECT 
     EXTRACT(YEAR FROM sale_date) AS YEAR,
     EXTRACT(MONTH FROM sale_date) AS MONTH,
	 AVG(total_sale) AS AVG_SALE,
     RANK() OVER(
     PARTITION BY EXTRACT(YEAR FROM sale_date)
     ORDER BY AVG(total_sale)DESC) AS rankk
     FROM RETAIL_SALES
     GROUP BY YEAR,MONTH
   --  ORDER BY YEAR ,AVG_SALE DESC;
) AS t1
WHERE rankk=1;

-- 8.Write a SQL query to find the top 5 customers based on the highest total sales.
SELECT customer_id,
SUM(total_sale) AS total_sale
FROM RETAIL_SALES
GROUP BY customer_id
ORDER BY total_sale DESC
LIMIT 5;

-- 9.Write a SQL query to find the number of unique customers who purchased items from each category. 
SELECT category,COUNT(DISTINCT customer_id) as unique_customers
FROM RETAIL_SALES
GROUP BY category;

-- 10.Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17).
WITH hourly_sale
AS
(
SELECT *,
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END as shift
FROM retail_sales
)
SELECT 
    shift,
    COUNT(*) as total_orders    
FROM hourly_sale
GROUP BY shift;

-- END OF PROJECT
