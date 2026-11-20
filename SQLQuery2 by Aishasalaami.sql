USE TWDP
SELECT * FROM Orders_table;
SELECT [CustomerName], [Product], [Country]
FROM Orders_table SELECT * FROM [dbo].[Orders_table] WHERE [Country] = 'Canada'
SELECT * FROM [dbo].[Orders_table] WHERE [Product] ='Phone'
SELECT * FROM [dbo].[Orders_table] WHERE [Quantity] >=4
SELECT * FROM [dbo].[Orders_table] WHERE [Country] <> 'USA'

SELECT * FROM Orders_table WHERE Quantity BETWEEN 2 AND 4
SELECT * FROM Orders_table WHERE Product ='laptop' AND Country = 'Nigeria'
SELECT * FROM Orders_table WHERE ( Product = 'Tablet' OR Product = 'Smartwatch') AND Quantity >=3 
SELECT * FROM Orders_table WHERE NOT [Country] = 'UK' 
SELECT * FROM Orders_table WHERE [Country] IN ('Nigeria', 'Ghana', 'UAE')
SELECT * FROM Orders_table WHERE NOT [Product] IN ( 'Laptop', 'Phone')
SELECT * FROM Orders_table WHERE [CustomerName] LIKE ('S%')
SELECT * FROM Orders_table WHERE [CustomerName] LIKE ('% Brown')
SELECT * FROM Orders_table WHERE (product = 'Laptop' or Product = 'Tablet') AND Quantity >2 AND ([CustomerName] NOT LIKE 'J%') 

SELECT TOP 3 * FROM [dbo].[Orders_table] ORDER BY Quantity DESC
SELECT DISTINCT Country FROM [dbo].[Orders_table] 
SELECT COUNT(*) AS Total_Orders FROM [dbo].[Orders_table] 
SELECT AVG(Quantity) AS Average_Quantity FROM [dbo].[Orders_table]
SELECT [Product], COUNT(*) AS Products_Ordered FROM [dbo].[Orders_table] GROUP BY [Product] HAVING COUNT(*) >3

SELECT * FROM [dbo].[Orders_table] ORDER BY [OrderDate] DESC
SELECT * FROM [dbo].[Orders_table] ORDER BY [Country] ASC, [Quantity] DESC

--List all country and product combinations
SELECT DISTINCT [Country], [Product] FROM [dbo].[Orders_table]

--Show the 5 orders with the highest quantity
SELECT TOP 5 * FROM [dbo].[Orders_table] ORDER BY [Quantity] DESC

--Select the 3 most recent orders placed by customers in Nigeria
SELECT TOP 3 * FROM [dbo].[Orders_table] WHERE [Country]= 'Nigeria' ORDER BY [OrderDate] DESC


--WORKING WITH DATES
SELECT YEAR([OrderDate]) FROM [dbo].[Orders_table] AS YEAR
SELECT [OrderDate], MONTH([OrderDate]) AS Month_Num FROM[dbo].[Orders_table]
SELECT [OrderDate], YEAR([OrderDate]) AS YEAR FROM[dbo].[Orders_table]

SELECT [OrderDate],
MONTH([OrderDate]) AS Month_Num, 
DATENAME(MONTH,[OrderDate]) AS Months_Names, 
DATEPART(QUARTER, [OrderDate]) AS QUARTER,
YEAR([OrderDate]) AS YEAR 
FROM[dbo].[Orders_table]

--SHOW EACH ORDER'S ORDERID, 
USE TWDP
SELECT * FROM [dbo].[Orders]
SELECT * FROM [dbo].[Customers]

SELECT
 o.[OrderID],
 c.[CustomerName],
 o.[OrderDate]
FROM [dbo].[Orders] o
INNER JOIN [dbo].[Customers] c
ON o.CustomerID = c.CustomerID

--Joining Orders to Products and grouping by ProductName.
SELECT
    p.ProductName,
    SUM(o.Quantity) AS TotalQuantity
FROM Orders o
INNER JOIN Products p
    ON o.ProductID = p.ProductID
GROUP BY p.ProductName;

--List all orders placed by customers in the UK or Canada,
--Including the product name. 
SELECT
    o.OrderID,
    o.OrderDate,
    c.[CustomerName],
    c.Country,
    p.ProductName
FROM [dbo].[Orders] o
INNER JOIN [dbo].[Customers] c
ON o.[CustomerID] = c.[CustomerID]
INNER JOIN [dbo].[Products] p
ON o.[ProductID] = p.[ProductID]
WHERE c.[Country] IN ('UK', 'Canada')

--Use a LEFT JOIN to list every customer and their orders
--including customers who have never ordered. 
SELECT 
o.OrderDate,
c.CustomerID,
c.CustomerName
From [dbo].[Customers] c
LEFT JOIN [dbo].[Orders] o
ON c.CustomerID = o.CustomerID

--Show total revenue (Quatity x Price) per product,
--using a JOIN and GROUP BY, sorted highest to lowest. Round the answer up to 2 decimal places.
SELECT
p.[ProductName],
ROUND (SUM(o.[Quantity] * p.[Price]),2) AS Total_Revenue
FROM [dbo].[Orders] o
INNER JOIN [dbo].[Products] p
ON o.[ProductID] = p.[ProductID]
GROUP BY p.[ProductName]
ORDER BY Total_Revenue DESC;