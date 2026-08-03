USE retail_sales_db;
-- total unique orders
SELECT count(DISTINCT order_id) AS total_orders
FROM retail_sales; 
-- Result: 5009 

-- total unique customers
SELECT COUNT(DISTINCT customer_id) AS total_customers
FROM retail_sales;
-- Result:793


SELECT 
ROUND(SUM(sales),2) AS total_sales , 
ROUND(SUM(profit),2) AS total_profit , 
ROUND(AVG(sales),2) AS avg_sales , 
ROUND(AVG(profit),2) AS avg_profit
FROM retail_sales;
-- Result: total_sales= 2297200.86  total_profit =286397.02  avg_sales=229.86 avg_profit= 28.66

SELECT region , ROUND(SUM(sales),2) AS total_sales
FROM retail_sales
GROUP BY region
ORDER BY total_sales DESC;
-- West	725457.82
-- East	678781.24
-- Central	501239.89
-- South	391721.91
-- West region generated the highest total sales

SELECT region, ROUND(SUM(sales),2) AS total_sales , ROUND(SUM(profit),2) AS total_profit
FROM retail_sales
GROUP BY region
ORDER BY total_profit DESC;

-- West	725457.82	108418.45
-- East	678781.24	91522.78
-- South	391721.91	46749.43
-- Central	501239.89	39706.36

-- West region has highest total sales and highest total profit
--  Central region has lowest total profit whereas South region has the lowest total sales


SELECT region, ROUND(SUM(sales),2) AS total_sales, ROUND(SUM(profit),2) AS total_profit
FROM retail_sales
WHERE region = "West"  -- total_sales and total_profit of only west region 
GROUP BY region;


SELECT region, ROUND(SUM(sales),2) AS total_sales, ROUND(SUM(profit),2) AS total_profit
FROM retail_sales
GROUP BY region
HAVING total_profit>50000;

-- Result 
-- West	725457.82	108418.45
-- East	678781.24	91522.78 
SELECT sub_category , ROUND(SUM(sales),2) AS total_sales, ROUND(SUM(profit),2) AS total_profit
FROM retail_sales
WHERE category="Furniture"
GROUP BY sub_category
HAVING total_sales>100000
ORDER BY total_sales DESC;

-- Results
-- Chairs	328449.1	26590.17
-- Tables	206965.53	-17725.48
-- Bookcases	114880	-3472.56


SELECT product_name, 
ROUND(SUM(sales),2) AS total_sales
FROM retail_sales
GROUP BY product_name
ORDER BY total_sales DESC
LIMIT 5;

-- Result: top 5 products with highest total sales

SELECT customer_id,
ROUND(SUM(profit),2) AS total_profit,
ROUND(SUM(sales),2) AS total_sales
FROM retail_sales
GROUP BY customer_id
ORDER BY total_profit DESC, total_sales DESC
LIMIT 10;

-- Result: sorting customer based on highest total profit and it tied based on highest total_sales

SELECT 
YEAR(order_date) AS order_year,
MONTH(order_date) AS order_month,
ROUND(SUM(sales),2) AS total_sales
FROM retail_sales
GROUP BY order_year,order_month
ORDER BY total_sales DESC
LIMIT 1;

-- Result: year with highest total_sales: 2017 and month 11.

SELECT segment,
ROUND(SUM(profit),2) AS total_profit
FROM retail_sales
GROUP BY segment
ORDER BY total_profit DESC;

-- Result:
-- Consumer	134119.21
-- Corporate	91979.13
-- Home Office	60298.68


SELECT 
	CASE
        WHEN profit>100 THEN 'High Profit'
		WHEN profit>0 AND profit<=100 THEN 'Medium Profit'
        ELSE 'Loss'
    END AS profit_category,
    COUNT(*) AS total_orders   --Each order based on its profit.
FROM retail_sales
GROUP BY profit_category;

-- Result:
-- Medium Profit	7168
-- High Profit	890
-- Loss	1936


SELECT MAX(sales) AS highest_sale, MIN(sales) AS Lowest_sale
FROM retail_sales;
-- Result:highes: 22638.5 and lowest: 0.444

WITH customer_sales AS(
        SELECT customer_id, 
        ROUND(SUM(sales),2) AS total_sales
        FROM retail_sales
        GROUP BY customer_id)
SELECT *
FROM customer_sales
WHERE total_sales>5000
LIMIT 10;

-- cte(common table expression) from temp table customer_sales created using WITH we got cutomer_id with total_sales >5000

SELECT
    customer_id,
    ROUND(SUM(sales),2) AS total_sales,
    RANK() OVER (
        ORDER BY SUM(sales) DESC
    ) AS sales_rank
FROM retail_sales
GROUP BY customer_id;

-- window function ranking based on total_sales 
-- if two customer id have same total_sales in 2nd and 3rd:
-- RANK(): It gives same rank 2 to both and skip 3 and give 4 to next id
-- DENSE_RANK(): it doesnot skip 3
-- ROW_NUMBER(): it forces rank doesn't repeat any rank despite having same sales.




