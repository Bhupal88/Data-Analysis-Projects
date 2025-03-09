SELECT * FROM `e-commerce_project`.sales_data;

-- Top-Selling Products and Revenue Contribution
SELECT Product, SUM( `Quantity Ordered`) AS Total_Ordered, ROUND(SUM(`Quantity Ordered` * `Price Each`),2) AS Total_revenue
FROM `e-commerce_project`.sales_data
GROUP BY Product
ORDER BY Total_revenue DESC;

-- Peak Sales Hours & Date Trends
SELECT HOUR(STR_TO_DATE(`Time`, '%r')) AS Hour_of_day, ROUND(SUM(`Quantity Ordered` * `Price Each`),2) AS Total_revenue
FROM `e-commerce_project`.sales_data
GROUP BY Hour_of_Day
ORDER BY Total_revenue DESC;


--  City & State-Wise Sales Performance
SELECT City, State, ROUND(SUM(`Quantity Ordered` * `Price Each`),2) AS Total_revenue,
COUNT(DISTINCT `Order ID`) AS Total_Orders
FROM `e-commerce_project`.sales_data
GROUP BY City, State
ORDER BY Total_revenue DESC;

-- Customer Buying Patterns (Bundled Purchases)
SELECT a.Product AS Product_A, b.Product AS Product_B, COUNT(*) AS Pair_Count
FROM `e-commerce_project`.sales_data a
JOIN `e-commerce_project`.sales_data b
	ON a.`Order ID` = b.`Order ID`
    AND a.Product <> b.Product
GROUP BY Product_A, Product_B
ORDER BY Pair_Count;

-- Price Sensitivity & Revenue Impact
SELECT ROUND(AVG(`Price Each`),2) AS avg_price, SUM(`Quantity Ordered`) AS Total_ordered, ROUND(SUM(`Price Each` * `Quantity Ordered`),2) AS Total_revenue
FROM `e-commerce_project`.sales_data
GROUP BY Product
ORDER BY avg_price DESC;