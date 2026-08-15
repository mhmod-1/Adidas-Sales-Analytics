CREATE DATABASE Adidas_Project;
GO

USE Adidas_Project;
GO

-- =========================================================
-- DASHBOARD 1 : Executive Overview
-- Objective: Monitor the overall business performance.
-- =========================================================


-- Question 1
-- What is the total sales?

SELECT SUM(Total_Sales) AS Total_Sales
FROM fact_sales;


-- =========================================================


-- Question 2
-- What is the total operating profit?

SELECT SUM(Operating_Profit) AS Total_Operating_Profit
FROM fact_sales;


-- =========================================================


-- Question 3
-- What is the average operating margin?

SELECT AVG(Operating_Margin) AS Average_Operating_Margin
FROM fact_sales;


-- =========================================================


-- Question 4
-- How many units were sold?

SELECT SUM(Units_Sold) AS Total_Units_Sold
FROM fact_sales;

-- =========================================================


-- Question 5
-- How many retailers are there?

SELECT COUNT(*) AS Total_Retailers
FROM dim_retailer;


-- =========================================================


-- Question 6
-- What is the average price per unit?

SELECT AVG(Price_per_Unit) AS Average_Price_Per_Unit
FROM fact_sales;


-- =========================================================


-- Question 7
-- Which year generated the highest total sales?

SELECT TOP 1
       d.Year,
       SUM(f.Total_Sales) AS Total_Sales
FROM fact_sales AS f
JOIN dim_date AS d
ON f.Date_Key = d.Date_Key
GROUP BY d.Year
ORDER BY Total_Sales DESC;


-- =========================================================


-- Question 8
-- What is the monthly sales trend?

SELECT
       d.Year,
       d.Month,
       d.Month_Name,
       SUM(f.Total_Sales) AS Total_Sales
FROM fact_sales AS f
JOIN dim_date AS d
ON f.Date_Key = d.Date_Key
GROUP BY d.Year, d.Month, d.Month_Name
ORDER BY d.Year, d.Month;


-- =========================================================


-- Question 9
-- Which sales method generated the highest total sales?

SELECT
       Sales_Method,
       SUM(Total_Sales) AS Total_Sales
FROM fact_sales
GROUP BY Sales_Method
ORDER BY Total_Sales DESC;


-- =========================================================


-- Question 10
-- Which sales method generated the highest operating profit?

SELECT
       Sales_Method,
       SUM(Operating_Profit) AS Total_Operating_Profit
FROM fact_sales
GROUP BY Sales_Method
ORDER BY Total_Operating_Profit DESC;



-- =========================================================
-- DASHBOARD 2 : Product & Sales Analysis
-- Objective: Analyze product performance and sales.
-- =========================================================


-- Question 1
-- Which products generated the highest total sales?

SELECT
    p.Product,
    SUM(f.Total_Sales) AS Total_Sales
FROM fact_sales AS f
JOIN dim_product AS p
ON f.Product_Key = p.Product_Key
GROUP BY p.Product
ORDER BY Total_Sales DESC;


-- =========================================================


-- Question 2
-- Which products generated the highest operating profit?

SELECT
    p.Product,
    SUM(f.Operating_Profit) AS Total_Operating_Profit
FROM fact_sales AS f
JOIN dim_product AS p
ON f.Product_Key = p.Product_Key
GROUP BY p.Product
ORDER BY Total_Operating_Profit DESC;


-- =========================================================


-- Question 3
-- Which products generated the lowest total sales?

SELECT
    p.Product,
    SUM(f.Total_Sales) AS Total_Sales
FROM fact_sales AS f
JOIN dim_product AS p
ON f.Product_Key = p.Product_Key
GROUP BY p.Product
ORDER BY Total_Sales ASC;


-- =========================================================


-- Question 4
-- How many units were sold for each product?

SELECT
    p.Product,
    SUM(f.Units_Sold) AS Total_Units_Sold
FROM fact_sales AS f
JOIN dim_product AS p
ON f.Product_Key = p.Product_Key
GROUP BY p.Product
ORDER BY Total_Units_Sold DESC;


-- =========================================================


-- Question 5
-- What is the average price per unit for each product?

SELECT
    p.Product,
    AVG(f.Price_per_Unit) AS Average_Price_Per_Unit
FROM fact_sales AS f
JOIN dim_product AS p
ON f.Product_Key = p.Product_Key
GROUP BY p.Product
ORDER BY Average_Price_Per_Unit DESC;


-- =========================================================


-- Question 6
-- What is the average operating margin for each product?

SELECT
    p.Product,
    AVG(f.Operating_Margin) AS Average_Operating_Margin
FROM fact_sales AS f
JOIN dim_product AS p
ON f.Product_Key = p.Product_Key
GROUP BY p.Product
ORDER BY Average_Operating_Margin DESC;


-- =========================================================


-- Question 7
-- What percentage of total sales does each product contribute?

SELECT
    p.Product,
    SUM(f.Total_Sales) AS Total_Sales,
    ROUND(
        SUM(f.Total_Sales) * 100.0 /
        (SELECT SUM(Total_Sales) FROM fact_sales),
        2
    ) AS Sales_Percentage
FROM fact_sales AS f
JOIN dim_product AS p
ON f.Product_Key = p.Product_Key
GROUP BY p.Product
ORDER BY Sales_Percentage DESC;


-- =========================================================


-- Question 8
-- Rank products based on total sales.

SELECT
    p.Product,
    SUM(f.Total_Sales) AS Total_Sales,
    RANK() OVER (
        ORDER BY SUM(f.Total_Sales) DESC
    ) AS Product_Rank
FROM fact_sales AS f
JOIN dim_product AS p
ON f.Product_Key = p.Product_Key
GROUP BY p.Product
ORDER BY Product_Rank;


-- =========================================================
-- DASHBOARD 3 : Regional Performance
-- Objective: Analyze geographical sales performance.
-- =========================================================


-- Question 1
-- Which region generated the highest total sales?

SELECT
    l.Region,
    SUM(f.Total_Sales) AS Total_Sales
FROM fact_sales AS f
JOIN dim_location AS l
ON f.Location_Key = l.Location_Key
GROUP BY l.Region
ORDER BY Total_Sales DESC;


-- =========================================================


-- Question 2
-- Which state generated the highest total sales?

SELECT
    l.State,
    SUM(f.Total_Sales) AS Total_Sales
FROM fact_sales AS f
JOIN dim_location AS l
ON f.Location_Key = l.Location_Key
GROUP BY l.State
ORDER BY Total_Sales DESC;


-- =========================================================


-- Question 3
-- Which city generated the highest total sales?

SELECT
    l.City,
    SUM(f.Total_Sales) AS Total_Sales
FROM fact_sales AS f
JOIN dim_location AS l
ON f.Location_Key = l.Location_Key
GROUP BY l.City
ORDER BY Total_Sales DESC;


-- =========================================================


-- Question 4
-- Which retailer generated the highest total sales?

SELECT
    r.Retailer,
    SUM(f.Total_Sales) AS Total_Sales
FROM fact_sales AS f
JOIN dim_retailer AS r
ON f.Retailer_Key = r.Retailer_Key
GROUP BY r.Retailer
ORDER BY Total_Sales DESC;


-- =========================================================


-- Question 5
-- What is the average operating margin by region?

SELECT
    l.Region,
    AVG(f.Operating_Margin) AS Average_Operating_Margin
FROM fact_sales AS f
JOIN dim_location AS l
ON f.Location_Key = l.Location_Key
GROUP BY l.Region
ORDER BY Average_Operating_Margin DESC;


-- =========================================================


-- Question 6
-- How many units were sold in each region?

SELECT
    l.Region,
    SUM(f.Units_Sold) AS Total_Units_Sold
FROM fact_sales AS f
JOIN dim_location AS l
ON f.Location_Key = l.Location_Key
GROUP BY l.Region
ORDER BY Total_Units_Sold DESC;


-- =========================================================


-- Question 7
-- What is the monthly sales trend by region?

SELECT
    d.Year,
    d.Month,
    d.Month_Name,
    l.Region,
    SUM(f.Total_Sales) AS Total_Sales
FROM fact_sales AS f
JOIN dim_date AS d
ON f.Date_Key = d.Date_Key
JOIN dim_location AS l
ON f.Location_Key = l.Location_Key
GROUP BY
    d.Year,
    d.Month,
    d.Month_Name,
    l.Region
ORDER BY
    d.Year,
    d.Month,
    l.Region;


-- =========================================================


-- Question 8
-- What percentage of total sales does each region contribute?

SELECT
    l.Region,
    SUM(f.Total_Sales) AS Total_Sales,
    ROUND(
        SUM(f.Total_Sales) * 100.0 /
        (SELECT SUM(Total_Sales) FROM fact_sales),
        2
    ) AS Sales_Percentage
FROM fact_sales AS f
JOIN dim_location AS l
ON f.Location_Key = l.Location_Key
GROUP BY l.Region
ORDER BY Sales_Percentage DESC;


-- =========================================================
-- DASHBOARD 4 : Retailer & Sales Method Performance
-- Objective: Analyze retailer and sales method performance.
-- =========================================================



-- Question 1
-- Which retailers have the highest total number of units sold?


SELECT 
    r.Retailer, 
    SUM(f.Units_Sold) AS Total_Units_Sold
FROM fact_sales AS f
JOIN dim_retailer AS r 
ON f.Retailer_Key = r.Retailer_Key
GROUP BY r.Retailer
ORDER BY Total_Units_Sold DESC;



-- =========================================================



-- Question 2
-- Which retailers generate the highest total sales?


SELECT 
    r.Retailer, 
    SUM(f.Total_Sales) AS Total_Sales
FROM fact_sales AS f
JOIN dim_retailer AS r 
ON f.Retailer_Key = r.Retailer_Key
GROUP BY r.Retailer
ORDER BY Total_Sales DESC;



-- =========================================================



-- Question 3
-- Which sales method generates the highest total sales and operating profit?


SELECT 
    f.Sales_Method, 
    SUM(f.Total_Sales) AS Total_Sales,
    SUM(f.Operating_Profit) AS Total_Profit
FROM fact_sales AS f
GROUP BY f.Sales_Method
ORDER BY Total_Profit DESC;



-- =========================================================



-- Question 4
-- Which retailers have the highest average operating margin?


SELECT 
    r.Retailer, 
    AVG(f.Operating_Margin) AS Avg_Margin
FROM fact_sales AS f
JOIN dim_retailer AS r 
ON f.Retailer_Key = r.Retailer_Key
GROUP BY r.Retailer
ORDER BY Avg_Margin DESC;



-- =========================================================



-- Question 5
-- How do sales methods perform across different regions?


SELECT 
    l.Region,
    f.Sales_Method, 
    SUM(f.Total_Sales) AS Total_Sales
FROM fact_sales AS f
JOIN dim_location AS l 
ON f.Location_Key = l.Location_Key
GROUP BY l.Region, f.Sales_Method
ORDER BY l.Region, Total_Sales DESC;



-- =========================================================



-- Question 6
-- Which retailers generate the highest total operating profit?


SELECT 
    r.Retailer, 
    SUM(f.Operating_Profit) AS Total_Profit
FROM fact_sales AS f
JOIN dim_retailer AS r 
ON f.Retailer_Key = r.Retailer_Key
GROUP BY r.Retailer
ORDER BY Total_Profit DESC;



-- =========================================================
