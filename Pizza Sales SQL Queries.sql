-- KPI's REQUIREMENT 
-- 1. Total Revenue
SELECT 
		SUM([total_price]) as Total_Revenue
FROM
		[dbo].[pizza_sales]

-- 2. Average Order Value
SELECT
		SUM([total_price])/COUNT(DISTINCT([order_id])) as Average_Order_Value
FROM
		[dbo].[pizza_sales]

-- 3. Total Pizzas Sold
SELECT 
		SUM([quantity]) as Total_Pizzas_Sold
FROM 
		[dbo].[pizza_sales]

-- 4. Total Orders
SELECT
		COUNT(DISTINCT([order_id])) as Total_Orders
FROM 
		[dbo].[pizza_sales]

-- 5. Average Pizzas Per Order
SELECT 
		(CAST(SUM([quantity]) AS DECIMAL(10,2))/ CAST(COUNT(DISTINCT([order_id])) AS DECIMAL(10,2))) as Average_Pizzas_Per_Order
FROM 
		[dbo].[pizza_sales]


-- CHARTS REQUIREMENT 
-- 1. Daily Trend for Total Orders
WITH TB 
AS (
	SELECT
			[order_id]
			,DATENAME(WEEKDAY,[order_date]) AS Weekday
			,[order_time]
			,CASE WHEN DATENAME(HOUR,[order_time])< 12 THEN 'AM' ELSE 'PM' END AS AM_PM
	FROM
			[dbo].[pizza_sales]
)
SELECT 
		[Weekday]
		,[AM_PM]
		,COUNT(DISTINCT([order_id])) AS Total_Orders
FROM 
		TB
GROUP BY
		[Weekday]
		,[AM_PM]
ORDER BY 
		Total_Orders DESC
-- 2. Monthly Trend for Total Orders
SELECT
		[Month]
		,COUNT(DISTINCT([order_id])) AS Total_Orders
FROM
		(SELECT
				DATENAME(MONTH,[order_date]) AS Month
				,[order_id]
		FROM
				[dbo].[pizza_sales]) AS TB
GROUP BY 
		[Month]
ORDER BY
		Total_Orders DESC

-- 3. Percentage of Sales by Pizza Category
SELECT
		[pizza_category]
		,SUM([total_price]) AS Sales
		,CAST(SUM([total_price])*100/(SELECT SUM([total_price]) FROM [dbo].[pizza_sales]) AS DECIMAL(10,2)) AS Percentage_of_Sales
FROM
		[dbo].[pizza_sales]
GROUP BY
		[pizza_category]
ORDER BY
		Percentage_of_Sales DESC

-- 4. Percentage of Sales by Pizza Size
SELECT
		[pizza_size]
		,SUM([total_price]) AS Sales
		,CAST(SUM([total_price])*100/(SELECT SUM([total_price]) FROM [dbo].[pizza_sales]) AS DECIMAL(10,2)) AS Percentage_of_Sales
FROM
		[dbo].[pizza_sales]
GROUP BY
		[pizza_size]
ORDER BY
		Percentage_of_Sales DESC

-- 5. Total Pizzas Sold by Pizza Category
SELECT
		[pizza_category]
		,SUM([quantity]) AS Total_Pizzas_Sold
FROM
		[dbo].[pizza_sales]
GROUP BY
		[pizza_category]
ORDER BY
		Total_Pizzas_Sold DESC

-- 6. Top 5 Best Sellers by Revenue, Total Quantity and Total Orders
SELECT TOP 5
		[pizza_name]
		,SUM([total_price]) AS Revenue
FROM
		[dbo].[pizza_sales]
GROUP BY
		[pizza_name]
ORDER BY
		Revenue DESC

SELECT TOP 5
		[pizza_name]
		,COUNT(DISTINCT([order_id])) AS Total_Orders
FROM
		[dbo].[pizza_sales]
GROUP BY
		[pizza_name]
ORDER BY
		Total_Orders DESC

SELECT TOP 5
		[pizza_name]
		,SUM([quantity]) AS Total_Quantity
FROM
		[dbo].[pizza_sales]
GROUP BY
		[pizza_name]
ORDER BY
		Total_Quantity DESC

-- 7. Bottom 5 Best Sellers by Revenue, Total Quantity and Total Orders
SELECT TOP 5
		[pizza_name]
		,SUM([total_price]) AS Revenue
FROM
		[dbo].[pizza_sales]
GROUP BY
		[pizza_name]
ORDER BY
		Revenue

SELECT TOP 5
		[pizza_name]
		,COUNT(DISTINCT([order_id])) AS Total_Orders
FROM
		[dbo].[pizza_sales]
GROUP BY
		[pizza_name]
ORDER BY
		Total_Orders

SELECT TOP 5
		[pizza_name]
		,SUM([quantity]) AS Total_Quantity
FROM
		[dbo].[pizza_sales]
GROUP BY
		[pizza_name]
ORDER BY
		Total_Quantity