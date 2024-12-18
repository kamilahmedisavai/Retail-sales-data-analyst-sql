USE SalesAnalysisDB;
GO


SELECT * 
FROM Retail_Sales;
GO


SELECT COUNT(*) AS Total_Rows
FROM Retail_Sales;
GO

SELECT COUNT(DISTINCT customer_id) AS Total_Customers
FROM Retail_Sales;
GO

--Data Cleaning

SELECT 
    COUNT(CASE WHEN transactions_id IS NULL THEN 1 END) AS Null_Transactions_ID,
    COUNT(CASE WHEN sale_date IS NULL THEN 1 END) AS Null_Sale_Date,
    COUNT(CASE WHEN sale_time IS NULL THEN 1 END) AS Null_Sale_Time,
    COUNT(CASE WHEN customer_id IS NULL THEN 1 END) AS Null_Customer_ID,
    COUNT(CASE WHEN gender IS NULL THEN 1 END) AS Null_Gender,
    COUNT(CASE WHEN age IS NULL THEN 1 END) AS Null_Age,
    COUNT(CASE WHEN category IS NULL THEN 1 END) AS Null_Category,
    COUNT(CASE WHEN quantiy IS NULL THEN 1 END) AS Null_Quantity,
    COUNT(CASE WHEN price_per_unit IS NULL THEN 1 END) AS Null_Price_Per_Unit,
    COUNT(CASE WHEN cogs IS NULL THEN 1 END) AS Null_COGS,
    COUNT(CASE WHEN total_sale IS NULL THEN 1 END) AS Null_Total_Sale
FROM Retail_Sales;
GO

UPDATE Retail_Sales
SET age = 30
WHERE age IS NULL;
GO

SELECT *
FROM Retail_Sales
WHERE 
    transactions_id IS NULL OR
    sale_date IS NULL OR
    sale_time IS NULL OR
    customer_id IS NULL OR
    gender IS NULL OR
    age IS NULL OR
    category IS NULL OR
    quantiy IS NULL OR
    price_per_unit IS NULL OR
    cogs IS NULL OR
    total_sale IS NULL;
GO

DELETE FROM Retail_Sales
WHERE 
    transactions_id IS NULL OR
    sale_date IS NULL OR
    age IS NULL;
GO

DELETE FROM Retail_Sales
WHERE 
    transactions_id IS NULL OR
    sale_date IS NULL OR
    sale_time IS NULL OR
    customer_id IS NULL OR
    gender IS NULL OR
    age IS NULL OR
    category IS NULL OR
    quantiy IS NULL OR
    price_per_unit IS NULL OR
    cogs IS NULL OR
    total_sale IS NULL;
GO

SELECT *
FROM Retail_Sales
WHERE 
    transactions_id IS NULL OR
    sale_date IS NULL OR
    sale_time IS NULL OR
    customer_id IS NULL OR
    gender IS NULL OR
    age IS NULL OR
    category IS NULL OR
    quantiy IS NULL OR
    price_per_unit IS NULL OR
    cogs IS NULL OR
    total_sale IS NULL;
GO


SELECT COUNT(*) AS Total_Rows
FROM Retail_Sales;
GO

--Data exploration 
--How many unique customer we have 

SELECT COUNT(DISTINCT customer_id) AS Total_Customers
FROM Retail_Sales;
GO

--How many Categories

SELECT COUNT(DISTINCT category) AS Total_Categories
FROM Retail_Sales;
GO

SELECT DISTINCT category
FROM Retail_Sales;
GO
-- what are the categories

SELECT DISTINCT category
FROM Retail_Sales;
GO


---data and business analyst

--Q.1 Retrieve all columns for sales made on '2022-11-05':


SELECT *
FROM Retail_Sales
WHERE sale_date = '2022-11-05';
GO

--Q.2 Retrieve all transactions where the category is 'Clothing' and the quantity sold is equal and more than 4 in the month of Nov-2022:
SELECT *
FROM Retail_Sales
WHERE category = 'Clothing'
  AND quantiy >= 4
  AND sale_date BETWEEN '2022-11-01' AND '2022-11-30';
GO

--Q.3 Calculate the total sales (total_sale) for each category:

SELECT category, 
       SUM(total_sale) AS Total_Sales,
       COUNT(transactions_id) AS Total_Orders
FROM Retail_Sales
GROUP BY category;
GO

--Q.4 Find the average age of customers who purchased items from the 'Beauty' category:

SELECT AVG(age) AS Average_Age
FROM Retail_Sales
WHERE category = 'Beauty';
GO


--Q.5 Find all transactions where the total sale is greater than 1000:

SELECT *
FROM Retail_Sales
WHERE total_sale > 1000;
GO


--Q.6 Find the total number of transactions (transaction_id) made by each gender in each category:

SELECT gender, category, COUNT(transactions_id) AS Total_Transactions
FROM Retail_Sales
GROUP BY gender, category;
GO

--Q.7 Calculate the average sale for each month. Find out the best-selling month in each year:

-- Average sale for each month
SELECT YEAR(sale_date) AS Year, MONTH(sale_date) AS Month, AVG(total_sale) AS Average_Sale
FROM Retail_Sales
GROUP BY YEAR(sale_date), MONTH(sale_date)
ORDER BY Year, Month;

--best selling month in each year

WITH Monthly_Sales AS (
    SELECT 
        YEAR(sale_date) AS Year, 
        MONTH(sale_date) AS Month, 
        SUM(total_sale) AS Total_Sales
    FROM Retail_Sales
    GROUP BY YEAR(sale_date), MONTH(sale_date)
),
Ranked_Months AS (
    SELECT 
        Year, 
        Month, 
        Total_Sales,
        ROW_NUMBER() OVER (PARTITION BY Year ORDER BY Total_Sales DESC) AS Rank
    FROM Monthly_Sales
)
SELECT Year, Month, Total_Sales
FROM Ranked_Months
WHERE Rank = 1
ORDER BY Year;
GO


--Q.8 Find the top 5 customers based on the highest total sales:

SELECT TOP 5 customer_id, SUM(total_sale) AS Total_Sales
FROM Retail_Sales
GROUP BY customer_id
ORDER BY Total_Sales DESC;
GO

--Q.9 Find the number of unique customers who purchased items from each category:

SELECT category, COUNT(DISTINCT customer_id) AS Unique_Customers
FROM Retail_Sales
GROUP BY category;
GO

--Q.10 Create shifts and number of orders:

SELECT 
    CASE
        WHEN DATEPART(HOUR, sale_time) < 12 THEN 'Morning'
        WHEN DATEPART(HOUR, sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS Shift,
    COUNT(transactions_id) AS Number_of_Orders
FROM Retail_Sales
GROUP BY 
    CASE
        WHEN DATEPART(HOUR, sale_time) < 12 THEN 'Morning'
        WHEN DATEPART(HOUR, sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END;
GO

--end of the project 


