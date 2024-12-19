use SalesAnalysisDB


--1. Total Sales and Revenue Analysis

SELECT 
    SUM(total_sale) AS Total_Revenue, 
    COUNT(transactions_id) AS Total_Transactions
FROM Retail_Sales;
GO

--2. Sales by Category
SELECT 
    category, 
    SUM(total_sale) AS Total_Sales, 
    SUM(quantiy) AS Total_Quantity
FROM Retail_Sales
GROUP BY category
ORDER BY Total_Sales DESC;
GO

--3. Sales by Gender
SELECT 
    gender, 
    SUM(total_sale) AS Total_Sales, 
    COUNT(DISTINCT customer_id) AS Total_Customers
FROM Retail_Sales
GROUP BY gender;
GO

--4. Daily Sales Trend

SELECT 
    sale_date, 
    SUM(total_sale) AS Daily_Sales, 
    COUNT(transactions_id) AS Transactions_Count
FROM Retail_Sales
GROUP BY sale_date
ORDER BY sale_date ASC;
GO

--5. Peak Sales Time

SELECT 
    sale_time, 
    SUM(total_sale) AS Total_Sales, 
    COUNT(transactions_id) AS Transactions_Count
FROM Retail_Sales
GROUP BY sale_time
ORDER BY Total_Sales DESC;
GO

--6. Age Group Analysis
SELECT 
    CASE 
        WHEN age BETWEEN 18 AND 25 THEN '18-25'
        WHEN age BETWEEN 26 AND 35 THEN '26-35'
        WHEN age BETWEEN 36 AND 45 THEN '36-45'
        WHEN age > 45 THEN '45+'
        ELSE 'Unknown'
    END AS Age_Group, 
    COUNT(customer_id) AS Total_Customers, 
    SUM(total_sale) AS Total_Sales
FROM Retail_Sales
GROUP BY 
    CASE 
        WHEN age BETWEEN 18 AND 25 THEN '18-25'
        WHEN age BETWEEN 26 AND 35 THEN '26-35'
        WHEN age BETWEEN 36 AND 45 THEN '36-45'
        WHEN age > 45 THEN '45+'
        ELSE 'Unknown'
    END
ORDER BY Total_Sales DESC;
GO


--7. Profitability Analysis

SELECT 
    category, 
    SUM(total_sale - cogs) AS Profit,
    SUM(total_sale) AS Total_Sales, 
    SUM(cogs) AS Total_COGS
FROM Retail_Sales
GROUP BY category
ORDER BY Profit DESC;
GO


--8. Top Customers by Sales

SELECT 
    customer_id, 
    SUM(total_sale) AS Total_Sales, 
    COUNT(transactions_id) AS Transactions_Count
FROM Retail_Sales
GROUP BY customer_id
ORDER BY Total_Sales DESC;
GO


--9. Monthly Sales Analysis
SELECT 
    FORMAT(sale_date, 'yyyy-MM') AS Month, 
    SUM(total_sale) AS Monthly_Sales, 
    COUNT(transactions_id) AS Transactions_Count
FROM Retail_Sales
GROUP BY FORMAT(sale_date, 'yyyy-MM')
ORDER BY Month ASC;
GO



--10. Average Price per Category

SELECT 
    category, 
    AVG(price_per_unit) AS Avg_Price_Per_Unit
FROM Retail_Sales
GROUP BY category;
GO
