CREATE DATABASE IF NOT EXISTS inventory_project;
USE inventory_project;

#Changing the Column names
ALTER TABLE retail_store_inventory_dataset
RENAME COLUMN `Store ID` TO store_id;

ALTER TABLE retail_store_inventory_dataset
RENAME COLUMN `Product ID` TO product_id;

ALTER TABLE retail_store_inventory_dataset
RENAME COLUMN `Inventory Level` TO inventory_level;

ALTER TABLE retail_store_inventory_dataset
RENAME COLUMN `Units Sold` TO units_sold;

ALTER TABLE retail_store_inventory_dataset
RENAME COLUMN `Units Ordered` TO units_ordered;

ALTER TABLE retail_store_inventory_dataset
RENAME COLUMN `Demand Forecast` TO demand_forecast;

ALTER TABLE retail_store_inventory_dataset
RENAME COLUMN `Weather Condition` TO weather_condition;

ALTER TABLE retail_store_inventory_dataset
RENAME COLUMN `Holiday/Promotion` TO holiday_promotion;

ALTER TABLE retail_store_inventory_dataset
RENAME COLUMN `Competitor Pricing` TO competitor_pricing;

ALTER TABLE retail_store_inventory_dataset
RENAME COLUMN `Discounted Revenue` TO discounted_revenue;

ALTER TABLE retail_store_inventory_dataset
RENAME COLUMN `ï»¿Date` TO date;

#Describing the Data
DESCRIBE retail_store_inventory_dataset;

#Categories with the highest sales volume
SELECT category,
	   sum(units_sold) as Total_sales
FROM retail_store_inventory_dataset
GROUP BY category
ORDER BY Total_sales DESC; 

#Products with the most units
SELECT product_id,
	   sum(units_sold) as Total_units
FROM retail_store_inventory_dataset
GROUP BY product_id
ORDER BY Total_units DESC;

#Regions with the highest revenue
SELECT region,
round(sum(Revenue),2) as Total_revenue
FROM retail_store_inventory_dataset
GROUP BY region
ORDER BY Total_revenue DESC;

#Which stores achieve the highest sales?
SELECT store_id,
	   sum(units_sold) as Total_sales
FROM retail_store_inventory_dataset
GROUP BY store_id
ORDER BY Total_sales DESC;

#Products with the lowest inventory levels
SELECT product_id,
avg(inventory_level) as avg_inventory_level
FROM retail_store_inventory_dataset
GROUP BY product_id
ORDER BY avg_inventory_level ASC;

#Products that are overstocked
SELECT product_id,
	   avg(inventory_level) as avg_inventory_level,
       sum(units_sold) as Total_sales
FROM retail_store_inventory_dataset
GROUP BY product_id
ORDER BY avg_inventory_level DESC,Total_sales ASC;

#Products that are understocked
SELECT product_id,
	   avg(inventory_level) as avg_inventory_level,
       sum(units_sold) as Total_sales
FROM retail_store_inventory_dataset
GROUP BY product_id
ORDER BY avg_inventory_level ASC,Total_sales DESC;

#Categories with most accurate demand forecasts
SELECT category,
	   sum(units_sold) as Total_sales,
       round(sum(demand_forecast),2) as forecast_demand,
       round(ABS(SUM(units_sold) - SUM(demand_forecast)),2) as forecast_error
FROM retail_store_inventory_dataset
GROUP BY category
ORDER BY forecast_error ASC;

#How do promotions affect sales
SELECT holiday_promotion,
       SUM(units_sold) AS total_sales
FROM retail_store_inventory_dataset
GROUP BY holiday_promotion
ORDER BY total_sales DESC;

#Top 10 Products by Revenue
SELECT product_id,
	   round(sum(Revenue),2) as Total_revenue
FROM retail_store_inventory_dataset
GROUP BY product_id
ORDER BY Total_revenue DESC
LIMIT 10;

SELECT 1;