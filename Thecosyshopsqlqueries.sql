 -- Checking for diuplicates
-- No duplicates present

/*
SELECT Sale_ID, COUNT(sale_ID) 
FROM sales
GROUP BY sale_ID
HAVING COUNT(sale_ID) > 1;

SELECT Product_ID, COUNT(Product_ID) 
FROM products
GROUP BY Product_ID
HAVING COUNT(Product_ID) > 1;
*/



-- Products soLd didtribution
SELECT s.product_ID, p.product_Name, COUNT(*) AS total_sold
FROM sales s
JOIN products p ON s.product_ID = p.product_ID
GROUP BY s.product_ID, p.product_Name
ORDER BY total_sold DESC;

-- Top 10 customer locations

SELECT customer_location, COUNT(*) AS total_sold
FROM sales
GROUP BY customer_location
ORDER BY total_sold DESC
LIMIT 10;

-- Average amout spent per location rounded off

SELECT customer_location, ROUND(AVG(total_price)) AS avg_spent
FROM sales
GROUP BY customer_location
ORDER BY avg_spent DESC;

-- Top selling product per customer location

 SELECT customer_location, product_Name, total_sold
 FROM ( SELECT s.customer_location,
         p.product_Name,
         COUNT(*) AS total_sold,
         ROW_NUMBER() OVER (PARTITION BY s.customer_location ORDER BY COUNT(*) DESC) AS rank_row
         FROM sales s
		 JOIN products p ON s.Product_ID = p.product_ID
         GROUP BY s.customer_location, p.product_Name) AS ranked_sales
         WHERE rank_row = 1;

-- Monthly bestseller 

SELECT selling_month, product_name, total_sold
FROM(SELECT MONTHNAME(STR_TO_DATE(s.date_of_purchase, '%e-%b-%Y')) AS selling_month,
        p.product_name,
        COUNT(*) AS total_sold,
        ROW_NUMBER() OVER (PARTITION BY MONTHNAME(STR_TO_DATE(s.date_of_purchase, '%e-%b-%Y')) ORDER BY COUNT(*) DESC)  AS row_rank
        From sales s
        JOIN products p ON s.product_ID = p.product_ID
        GROUP BY MONTHNAME(STR_TO_DATE(s.date_of_purchase, '%e-%b-%Y')), p.product_name
        ) AS monthly_sales
        WHERE row_rank = 1;
        
-- Category Type distribution

SELECT p.product_type, COUNT(*) AS total_sold
FROM products p
JOIN sales s ON p.product_ID = s.product_ID
GROUP BY p.product_type
ORDER BY total_sold DESC;




