SELECT TOP (1000) [pizza_id]
      ,[order_id]
      ,[pizza_name_id]
      ,[quantity]
      ,[order_date]
      ,[order_time]
      ,[unit_price]
      ,[total_price]
      ,[pizza_size]
      ,[pizza_category]
      ,[pizza_ingredients]
      ,[pizza_name]
  FROM [pizza_sales].[dbo].[pizza_sales]

  use pizza_sales;

  --to get total revenue of the pizza sales
 select sum(total_price) as Total_Revenue from pizza_sales

-- average order values
select sum(total_price) / count(distinct order_id) as Avg_order_value from pizza_sales

--total pizzas sold
select sum(quantity) as Total_Pizzas_Sold from pizza_sales

-- total orders
select count(distinct order_id) as Total_Orders from pizza_sales

-- Averge Pizzas Per Order
select cast(cast(sum(quantity) as decimal(10,2)) / cast(count(distinct order_id) as decimal(10,2)) as decimal(10,2)) as avg_pizzas_per_order
from pizza_sales

-- Daily trend of total order
select DATENAME(DW,order_date) as order_day , count(Distinct order_id) as total_orders 
from pizza_sales
group by DATENAME(DW,order_date)
order by order_day  desc

-- Monthly trend of total order
select DATENAME(MONTH,order_date) as order_day , count(Distinct order_id) as total_orders 
from pizza_sales
group by DATENAME(MONTH,order_date)
order by order_day  desc

-- %sale by pizza category
select pizza_category, cast(sum(total_price) as decimal(10,2)) as Total_revenue,
cast(sum(total_price) * 100 / (select sum(total_price) from pizza_sales) as decimal(10,2)) as PCT
from pizza_sales
group by pizza_category

--% sale by pizza size
select pizza_size, cast(sum(total_price) as decimal(10,2)) as Total_revenue,
cast(sum(total_price) * 100 / (select sum(total_price) from pizza_sales) as decimal(10,2)) as PCT
from pizza_sales
group by pizza_size
order by pizza_size

--- total pizzas sold by category
Select pizza_category, sum(quantity) as pizzas_sold from pizza_sales
--where MONTH(order_date) = 2
group by pizza_category
order by pizza_category

-- top 5 pizzas by revenue
select top 5 pizza_name, sum(total_price) as revenue from pizza_sales
group by pizza_name
order by revenue desc

-- bottom 5 pizza by revenue
select top 5 pizza_name, sum(total_price) as revenue from pizza_sales
group by pizza_name
order by revenue 

-- top 5 pizzas of by quantity
select top 5 pizza_name , sum(quantity) as total from pizza_sales
group by pizza_name
order by total desc

-- bottom 5 pizzas of by quantity
select top 5 pizza_name , sum(quantity) as total from pizza_sales
group by pizza_name
order by total 


-- top 5 pizzas of by total_orders
select top 5 pizza_name , count(distinct order_id) as total_order from pizza_sales
group by pizza_name
order by total_order desc

-- bottom 5 pizzas of by total_orders
select top 5 pizza_name , count(distinct order_id) as total_order from pizza_sales
group by pizza_name
order by total_order 