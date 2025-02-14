SELECT * FROM nike_sales.nike_sales_2024;

-- Calculating total units sold, revenue, and average price for each region & category.
SELECT Region, Main_Category ,SUM(Units_Sold), SUM(Revenue_USD), AVG(Retail_Price)
FROM nike_sales.nike_sales_2024
GROUP BY Region, Main_Category
ORDER BY Region, SUM(Revenue_USD) DESC;

-- Analyzing relationship between price tier and sales performance, identifying trends in units sold & revenue for each price tier
SELECT Region, Price_Tier, SUM(Units_Sold), SUM(Revenue_USD), AVG(Retail_Price)
FROM nike_sales.nike_sales_2024
GROUP BY Region, Price_Tier
ORDER BY Region, SUM(Revenue_USD) DESC;

-- Analyzing monthly sales trends to identify peak sales months, seasonality, and sales growth over the year.
SELECT Month, SUM(Revenue_USD), SUM(Units_Sold), FIELD(Month,'January','February', 'March', 'April',
'May','June','July','August', 'September','October',
'November', 'December') AS month_order 
FROM 
nike_sales.nike_sales_2024
GROUP BY Month
Order by month_order;

SELECT Month, SUM(Revenue_USD), SUM(Units_Sold), FIELD(Month,'January','February', 'March', 'April',
'May','June','July','August', 'September','October',
'November', 'December') AS month_order 
FROM 
nike_sales.nike_sales_2024
GROUP BY Month
ORDER BY month_order;

-- Comparing the performance of online sales versus retail sales on total revenue using CTE
WITH CTE AS (SELECT Region, SUM(Revenue_USD) AS Total, ROUND(SUM((Online_Sales_Percentage/100)*Revenue_USD),2) AS Online_Sales_Revenue
FROM nike_sales.nike_sales_2024
GROUP BY Region)
SELECT *, (CTE.Total-CTE.Online_Sales_Revenue) AS Retail_Sales_Revenue
FROM CTE
;

-- Calculating the profitability of products by looking at revenue per unit and the correlation with units sold
-- Displaying Top 10 Highest Revenue_Per_Unit
SELECT Main_Category, Product_Line, SUM(Revenue_USD)/SUM(Units_Sold) as Revenue_Per_Unit
FROM nike_sales.nike_sales_2024
GROUP BY Main_Category, Product_Line
ORDER BY Revenue_Per_Unit DESC
LIMIT 10;