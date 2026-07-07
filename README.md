# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis  
**Database**: ` sql_project_p1`


## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named ` sql_project_p1`.
- **Table Creation**: A table named `RETAIL_SALES` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
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
```

### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql
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
```

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **Write a SQL query to retrieve all columns for sales made on '2022-11-05**:
```sql
SELECT * 
FROM RETAIL_SALES
WHERE sale_date='2022-11-05';
```

2. **Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022**:
```sql
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
```

3. **Write a SQL query to calculate the total sales (total_sale) for each category**:
```sql
SELECT category,SUM(total_sale) AS TOTAL_SALE,COUNT(*) as TOTAL_ORDERS
FROM RETAIL_SALES
GROUP BY category;
```

4. **Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category**:
```sql
SELECT ROUND(AVG(age),2) as AVERAGE_AGE
FROM RETAIL_SALES
WHERE category ='Beauty';
```

5. **Write a SQL query to find all transactions where the total_sale is greater than 1000.**:
```sql
SELECT * 
FROM RETAIL_SALES
WHERE total_sale>1000;
```

6. **Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.**:
```sql
SELECT category,gender,COUNT(transactions_id) AS TOTAL_TRANSACTION
FROM RETAIL_SALES
GROUP BY category, gender
ORDER BY category;
```

7. **Write a SQL query to calculate the average sale for each month. Find out best selling month in each year**:
```sql
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
```

8. **Write a SQL query to find the top 5 customers based on the highest total sales **:
```sql
SELECT customer_id,
SUM(total_sale) AS total_sale
FROM RETAIL_SALES
GROUP BY customer_id
ORDER BY total_sale DESC
LIMIT 5;
```

9. **Write a SQL query to find the number of unique customers who purchased items from each category.**:
```sql
SELECT category,COUNT(DISTINCT customer_id) as unique_customers
FROM RETAIL_SALES
GROUP BY category;
```

10. **Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**:
```sql
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
GROUP BY shift
```

## Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

## Reports

- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category.

## Conclusion

This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.

## Author - Ayush Pratap Singh

This project is part of my portfolio, showcasing the SQL skills essential for data analyst roles. If you have any questions, feedback, or would like to collaborate, feel free to get in touch!

### Stay Updated 

For more content on SQL, data analysis, and other data-related topics, make sure to follow me on social media and join our community:


- **LinkedIn**: [Connect with me professionally](www.linkedin.com/in/ayushpratapsingh2612)
- - **Gmail**: [Connect with me professionally](ayushpratapsingh2612@gmail.com)


Thank you for your support, and I look forward to connecting with you!
