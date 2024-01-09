<h1>Data Retrieval by SQL: Pizza Sales</h1>

## Solution

### 1. Retrieve Basic Order Information: Write a SQL query to retrieve number of orders.

````sql
Select Count(*) as unique_orders
From orders;
````
**Answer:**

<img width="201" alt="image" src="https://raw.githubusercontent.com/amirulafiqrosli/Data-Retrieval-SQL-Pizza-Sales/main/1.png">

### 2. Calculate Total Sales: Can you create a query to calculate the total sales for each day, including the date and the corresponding total sales amount?

````sql
Select Distinct(DATE_FORMAT(o.date, '%Y-%m-%d')) as date, round(sum(p.price*od.quantity),2) as total_sales
From orders as o 
      Join order_details as od on o.order_id = od.order_details_id
      Join pizzas as p on od.pizza_id = p.pizza_id
Group by o.date;
````
**Answer:**

<img width="301" alt="image" src="https://raw.githubusercontent.com/amirulafiqrosli/Data-Retrieval-SQL-Pizza-Sales/main/2.png">

### 3. Popular Pizza Types: Identify the top 5 most popular pizza types (based on the quantity ordered) and display their names along with the total quantity ordered.

````sql
Select distinct(pt.name), sum(od.quantity) as total_quantity
From order_details as od
      Join pizzas as p on od.pizza_id = p.pizza_id
      Join pizza_types as pt on p.pizza_type_id = pt.pizza_type_id 
Group by pt.name
Order by total_quantity Desc
Limit 5;
````
**Answer:**

<img width="501" alt="image" src="https://raw.githubusercontent.com/amirulafiqrosli/Data-Retrieval-SQL-Pizza-Sales/main/3.png">

### 4. Revenue by Pizza Category: Write a query to calculate the total revenue generated for each pizza category (Classic, Chicken, Supreme, Veggie) and display the results.
````sql
Select pt.category, Round(Sum(od.quantity*p.price),2) as total_revenue
From order_details as od 
      Join pizzas as p on od.pizza_id = p.pizza_id
      Join pizza_types as pt on p.pizza_type_id = pt.pizza_type_id
Group by pt.category;
````
**Answer:**

<img width="401" alt="image" src="https://raw.githubusercontent.com/amirulafiqrosli/Data-Retrieval-SQL-Pizza-Sales/main/4.png">

### 5. Average Pizza Price: Calculate the average price of pizzas for each size (Small, Medium, Large, X Large, XX Large) and display the results.
````sql
Select  Distinct(size), Round(Avg(price),2) as avg_price
From pizzas 
Group by size;
````
**Answer:**

<img width="301" alt="image" src="https://raw.githubusercontent.com/amirulafiqrosli/Data-Retrieval-SQL-Pizza-Sales/main/5.png">

### 6. Busiest Hours: Determine the top 3 busiest hours of the day in terms of the number of orders placed.
````sql
Select Hour(time) as hour, sum(num_orders) as total_orders
From (Select time, Count(order_id) as num_orders From orders Group by time) as temp
Group by hour
Order by total_orders Desc
Limit 3;
````
**Answer:**

<img width="301" alt="image" src="https://raw.githubusercontent.com/amirulafiqrosli/Data-Retrieval-SQL-Pizza-Sales/main/6.png">

### 7. Dynamic Pricing Analysis: Investigate the impact of dynamic pricing by comparing the average prices of pizzas on weekdays versus weekends. Provide insights into pricing strategies.
````sql
Select Avg(p.price) as avg_price,
  CASE
    WHEN DAYOFWEEK(o.date) = 1 OR DAYOFWEEK(o.date) = 7 THEN 'Weekend'
    WHEN DAYOFWEEK(o.date) BETWEEN 2 AND 6 THEN 'Weekday'
  END as day
From orders as o
  Join order_details as od on o.order_id = od.order_details_id
  Join pizzas as p on od.pizza_id = p.pizza_id
Group by day;
````
**Answer:**

<img width="401" alt="image" src="https://raw.githubusercontent.com/amirulafiqrosli/Data-Retrieval-SQL-Pizza-Sales/main/7.png">


## Data Source
[Pizza Place Sales](https://www.kaggle.com/datasets/mysarahmadbhat/pizza-place-sales/code)
