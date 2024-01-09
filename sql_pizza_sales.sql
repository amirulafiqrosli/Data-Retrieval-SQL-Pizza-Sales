/* 
1. Retrieve Basic Order Information:
   Question: Write a SQL query to retrieve number of orders.
*/
Select Count(*) as unique_orders
From orders;

/* 
2. Calculate Total Sales:
   Question: Can you create a query to calculate the total sales for each day, including the date 
   and the corresponding total sales amount?
*/
Select Distinct(DATE_FORMAT(o.date, '%Y-%m-%d')) as date, round(sum(p.price*od.quantity),2) as total_sales
From orders as o 
      Join order_details as od on o.order_id = od.order_details_id
      Join pizzas as p on od.pizza_id = p.pizza_id
Group by o.date;

/*
3. Popular Pizza Types:
   Question: Identify the top 5 most popular pizza types (based on the quantity ordered) and 
   display their names along with the total quantity ordered.
*/
Select distinct(pt.name), sum(od.quantity) as total_quantity
From order_details as od
      Join pizzas as p on od.pizza_id = p.pizza_id
      Join pizza_types as pt on p.pizza_type_id = pt.pizza_type_id 
Group by pt.name
Order by total_quantity Desc
Limit 5;

/*
4. Revenue by Pizza Category:
   Question: Write a query to calculate the total revenue generated for each pizza category 
   (Classic, Chicken, Supreme, Veggie) and display the results.
*/
Select pt.category, Round(Sum(od.quantity*p.price),2) as total_revenue
From order_details as od 
      Join pizzas as p on od.pizza_id = p.pizza_id
      Join pizza_types as pt on p.pizza_type_id = pt.pizza_type_id
Group by pt.category;
      
/*
5. Average Pizza Price:
   Question: Calculate the average price of pizzas for each size (Small, Medium, Large, X Large, XX Large) 
   and display the results.
*/
Select  Distinct(size), Round(Avg(price),2) as avg_price
From pizzas 
Group by size;

/*
6. Busiest Hours:
   Question: Determine the top 3 busiest hours of the day in terms of the number of orders placed.
*/
Select Hour(time) as hour, sum(num_orders) as total_orders
From (Select time, Count(order_id) as num_orders From orders Group by time) as temp
Group by hour
Order by total_orders Desc
Limit 3;

/*

7. Dynamic Pricing Analysis:
   Question: Investigate the impact of dynamic pricing by comparing the average prices of pizzas 
   on weekdays versus weekends. Provide insights into pricing strategies.
*/

Select Avg(p.price) as avg_price,
  CASE
    WHEN DAYOFWEEK(o.date) = 1 OR DAYOFWEEK(o.date) = 7 THEN 'Weekend'
    WHEN DAYOFWEEK(o.date) BETWEEN 2 AND 6 THEN 'Weekday'
  END as day
From orders as o
  Join order_details as od on o.order_id = od.order_details_id
  Join pizzas as p on od.pizza_id = p.pizza_id
Group by day;



