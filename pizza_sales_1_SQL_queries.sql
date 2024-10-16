
--To create a database:


CRATE DATABSE  Pizza_sales_2023_DB;


-- Creating Tables 

Create Table Pizza_sales_2023 (
pizza_id INT, 
order_id INT,
 pizza_name_id VARCHAR(20), 
quantity INT, 
order_date DATE, 
order_time TIME, 
unit_price FLOAT, 
total_price FLOAT, 
pizza_size VARCHAR(5), 
pizza_category VARCHAR(20), 
pizza_ingredients VARCHAR(150), 
pizza_name VARCHAR(50)
);


	SELECT * FROM Pizza_sales_2023;


-- 1. Find the total revenue of pizza orders

	SELECT ROUND(SUM(total_price),2) AS Total_Revenue 
	FROM Pizza_sales_2023;


-- 2 -	Find the Average order value (per order) calculate by diciding the total revenue by the total number of orders


	SELECT ROUND(SUM(total_price)/ COUNT(DISTINCT(order_id)),2) AS Average_order_value_per_order
	FROM Pizza_sales_2023;


-- 3. Find the total number of pizzas sold 

	SELECT SUM(quantity) AS Total_pizzas_sold

	FROM Pizza_sales_2023;


-- 4. Find the total number of orders ordered ? 

	SELECT COUNT(DISTINCT(order_id)) AS Total_orders
	FROM Pizza_sales_2023;


-- 5. Find the Average number of pizzas ordered/sold per order ? 
     --calulated by diving the total number of pizzas sold by the total number of orders?

	SELECT SUM(quantity) /COUNT(DISTINCT(order_id)) AS pizzas_sold_per_order
	FROM Pizza_sales_2023;

								---- CAST function is used to convert a value from one data type to another

	SELECT CAST(SUM(quantity) AS DECIMAL(10,2)) /
	CAST(COUNT(DISTINCT(order_id)) AS DECIMAL(10,2)) 
	FROM Pizza_sales_2023;
									--- USE CAST() especially if you expect fractional averages

	SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) /
	CAST(COUNT(DISTINCT(order_id)) AS DECIMAL(10,2)) AS DECIMAL(10,2)) 
	FROM Pizza_sales_2023;



-- 6 Find the What are the busiest Days & MONTHS & QUARTER and Times

	SELECT * FROM Pizza_sales_2023;


							--DW for Day of the Week (e.g., 'Monday', 'Tuesday')
							--MONTH for the Month Name (e.g., 'January', 'February')
							--YEAR for the Year (e.g., '2023')
							--DAY for the Day of the Month (e.g., '1', '15', '31')
							--QUARTER for the Quarter (e.g., '1', '2', '3', '4')

			-- DAILY TREND IN A WEEK 
			SELECT 
				DATENAME(DW, order_date) AS Order_Day, COUNT(DISTINCT order_id) AS total_orders
			FROM Pizza_sales_2023
			GROUP BY DATENAME(DW, order_date)
			ORDER BY COUNT(DISTINCT order_id) DESC;

			-- MONTHLY TREND IN A WEEK 
			SELECT 
				DATENAME(MONTH, order_date) AS Order_Month, COUNT(DISTINCT order_id) AS total_orders
			FROM Pizza_sales_2023
			GROUP BY DATENAME(MONTH, order_date)
			ORDER BY COUNT(DISTINCT order_id) DESC;

			-- Quartley TREND 
			SELECT 
				DATENAME(QUARTER, order_date) AS Order_QUARTER, COUNT(DISTINCT order_id) AS total_orders
			FROM Pizza_sales_2023
			GROUP BY DATENAME(QUARTER, order_date)
			ORDER BY COUNT(DISTINCT order_id) DESC;



			-- HOURLY TREND OF PIZZA SALES 

			SELECT 
				DATEPART(HOUR, order_time) AS Time_of_order_placed, 
				COUNT(DISTINCT(order_id)) AS total_orders
			FROM Pizza_sales_2023
			GROUP BY DATEPART(HOUR, order_time)
			ORDER BY COUNT(DISTINCT(order_id)) DESC;


-- 7. Find the Percentage of Sales by each Pizza Category 

	SELECT * FROM Pizza_sales_2023;


	----- Query 1 produces values in terms of the 'percentage of total sales' that each pizza category contributes.
	
	SELECT 
		pizza_category,
		ROUND(SUM(total_price),2) AS total_sales,
		ROUND(SUM(total_price)*100/ (SELECT SUM(total_price) FROM Pizza_sales_2023),2) AS sales_percentage_each_category
	FROM Pizza_sales_2023
	GROUP BY pizza_category
	ORDER BY pizza_category ;

	------- Query 2 produces values in terms of 'average revenue per order' for each pizza category.
	SELECT 
		pizza_category,
		ROUND(SUM(total_price)/COUNT(DISTINCT order_id),2) AS sales_percentage_each_category
	FROM Pizza_sales_2023
	GROUP BY pizza_category
	ORDER BY pizza_category ;



-- 8. Find the Percentage of Sales by each Pizza Size 


	SELECT * FROM Pizza_sales_2023;


	SELECT 
		pizza_size,
		ROUND(SUM(total_price),2) AS total_sales,
		ROUND(SUM(total_price)*100/ (SELECT SUM(total_price) FROM Pizza_sales_2023),2) AS sales_percentage_by_size
	FROM Pizza_sales_2023
	GROUP BY pizza_size
	ORDER BY  sales_percentage_by_size DESC;


				-- Finding the values for 1st quarter


	SELECT 
		pizza_size,
		ROUND(SUM(total_price),2) AS total_sales,
		ROUND(SUM(total_price)*100/ (SELECT SUM(total_price) FROM Pizza_sales_2023 	WHERE DATEPART(quarter, order_date) = 1),2) AS sales_percentage_by_size
	FROM Pizza_sales_2023
	WHERE DATEPART(quarter, order_date) = 1
	GROUP BY pizza_size
	ORDER BY  sales_percentage_by_size DESC;




-- 9. Find the Total number of Pizzas sold by Pizza Category

	SELECT * FROM Pizza_sales_2023;

	SELECT 
		pizza_category,
		SUM(quantity) AS total_pizzas_sold
	FROM Pizza_sales_2023
	GROUP BY pizza_category
	ORDER BY total_pizzas_sold DESC;





-- 9. Find the Top 5 Best Sellers (pizza name)

	SELECT * FROM Pizza_sales_2023;


	SELECT TOP 5
		pizza_name AS Best_sellers,
		SUM(quantity) AS total_pizzas_sold
	FROM Pizza_sales_2023
	GROUP BY pizza_name
	ORDER BY total_pizzas_sold DESC;
	


-- 10. Find the Lowest 5 Worst Sellers (pizza name)

	SELECT * FROM Pizza_sales_2023;


	SELECT TOP 5
		pizza_name AS Worst_sellers,
		SUM(quantity) AS total_pizzas_sold
	FROM Pizza_sales_2023
	GROUP BY pizza_name
	ORDER BY total_pizzas_sold;
	