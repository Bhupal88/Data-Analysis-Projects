SELECT * FROM australia_real_estate_project.aus_real_estate;


-- CALCULATING THE AVERAGE PROPERTY PRICES PER CITY/STATE 
SELECT City, State, AVG(Price)
FROM australia_real_estate_project.aus_real_estate
GROUP BY City, State
ORDER BY AVG(Price) DESC;

-- ANALYZING PRICE VARIATIONS ON DIFFERENT PROPERTY SIZES
SELECT
CASE
	WHEN SqFt < 1000 THEN 'Small'
    WHEN SqFt BETWEEN 1000 AND 2500 THEN 'Medium'
    WHEN SqFt BETWEEN 2500 AND 4000 THEN 'Large'
    ELSE 'Very Large' END AS 'Property Size Group', 
COUNT(*) AS property_count,
ROUND(AVG(Price), 2) AS avg_price,
ROUND(MAX(Price), 2) AS max_price,
ROUND(MIN(Price), 2) AS min_price, State
FROM australia_real_estate_project.aus_real_estate
GROUP BY `Property Size Group`, State
ORDER BY avg_price DESC;

-- Effect of Bedrooms & Bathrooms on Pricing
SELECT ROUND(AVG(Price),2) AS Avg_Price, Bedrooms, Bathrooms, COUNT(*) AS property_count
FROM australia_real_estate_project.aus_real_estate
GROUP BY Bedrooms, Bathrooms
ORDER BY Bedrooms, Bathrooms;

-- Older vs Newer Homes (Price comparison)
SELECT
CASE 
	WHEN Year_Built < 1980 THEN 'Before 1980'
    WHEN Year_Built BETWEEN 1980 and 2000 THEN '1980-2000'
    WHEN Year_Built > 2000 THEN 'After 2000'
    END AS Property_age_group, COUNT(*) AS property_count,
ROUND(AVG(Price),2) AS Avg_price,
ROUND(MAX(Price),2) AS Max_price, 
ROUND(MIN(Price),2) AS Min_price
FROM australia_real_estate_project.aus_real_estate
GROUP BY Property_age_group
ORDER BY Avg_price DESC;

-- Lot size vs Property Price
SELECT 
CASE
WHEN Lot_Area < 2000 THEN 'Small (< 2000)'
WHEN Lot_Area BETWEEN 2000 AND 5000 THEN 'Medium (2000 - 50000)'
WHEN Lot_Area > 4000 THEN 'Large (> 4000)'
END AS Lot_Size_Group,
COUNT(*) AS property_count,
ROUND(AVG(Price),2) AS Avg_price,
ROUND(MAX(Price),2) AS Max_price, 
ROUND(MIN(Price),2) AS Min_price
FROM australia_real_estate_project.aus_real_estate
GROUP BY Lot_Size_Group
ORDER BY Avg_price DESC;

-- Garage vs Non-Garage Properties (Price Differences)
SELECT CASE
WHEN Garage=0 THEN 'Yes'
WHEN Garage=1 THEN 'No'
END AS Garage_Status,
COUNT(*) AS property_count,
ROUND(AVG(Price),2) AS Avg_price,
ROUND(MAX(Price),2) AS Max_price, 
ROUND(MIN(Price),2) AS Min_price
FROM australia_real_estate_project.aus_real_estate
GROUP BY Garage_Status
ORDER BY Avg_price DESC;

-- Finding the TOP 3 most affordable cities for first_time buyers
SELECT City, State, COUNT(*) AS property_count,
ROUND(AVG(Price),2) AS Avg_price,
ROUND(MAX(Price),2) AS Max_price, 
ROUND(MIN(Price),2) AS Min_price
FROM australia_real_estate_project.aus_real_estate
GROUP BY City, State
ORDER BY Avg_price LIMIT 3;
