-- Total Revenue --
SELECT SUM(total_price) as total_revenue from pizza_sales

-- Average Order Value --

SELECT * FROM pizza_sales

select SUM(total_price) / COUNT(DISTINCT order_id) as avg_order_value from pizza_sales

-- Total Pizza Sold

Select sum(quantity) as totai_pizza_sold from pizza_sales

-- Total Order ---

select count(distinct order_id) as total_order from pizza_sales

-- Average pizza per orders

select cast(cast(sum(quantity) as decimal (10,2)) /  
cast(count(distinct order_id) as decimal (10,2)) as decimal (10,2)) as avg_pizza_per_oder from pizza_sales

-- Daily trend
select datename(dw, order_date) as order_day, count(distinct order_id) as total_orders
from pizza_sales
group by datename(dw, order_date)

--Hourly trend
select datepart(hour, order_time) as order_hours, count(distinct order_id) as total_orders
from pizza_sales
group by datepart(hour, order_time)
order by datepart(hour, order_time)

-- Percentage of Sales by Pizza Category

select pizza_category, sum(total_price) as total_price, sum(total_price) * 100 / (select sum(total_price) from pizza_sales) as PCT
from pizza_sales
group by pizza_category
order by pizza_category

-- Percentage of Sales by Pizza Category (month) 1 means January

select pizza_category, sum(total_price) as total_price, sum(total_price) * 100 / 
(select sum(total_price) from pizza_sales where month(order_date) = 1) as PCT
from pizza_sales
where month(order_date) = 1
group by pizza_category
order by pizza_category

-- Percentage of Sales by Pizza Category (quarter) 1 means first  quarter

SELECT 
    pizza_category, 
    SUM(total_price) AS total_price, 
    SUM(total_price) * 100 / 
        (SELECT SUM(total_price) 
         FROM pizza_sales 
         WHERE DATEPART(QUARTER, order_date) = 1) AS PCT
FROM pizza_sales
WHERE DATEPART(QUARTER, order_date) = 1
GROUP BY pizza_category
ORDER BY pizza_category;

-- Percentage of Sales by Pizza size

select pizza_size, cast(sum(total_price) as decimal (10,2)) as total_price, cast(sum(total_price) * 100 / 
(select sum(total_price) from pizza_sales where datepart(quarter, order_date)=1) as decimal(10,2)) as PCT
from pizza_sales
where datepart(quarter, order_date)=1
group by pizza_size
order by pizza_size

--Total pizza sold by pizza category

select pizza_category, sum(quantity) as total_pizzas_sold
from pizza_sales
group by pizza_category
order by pizza_category

-- Top 5 sellers by total pizza sold

select top 5 pizza_name, sum(quantity) as total_pizzas_sold
from pizza_sales
group by pizza_name 
order by sum(quantity) desc

-- Worst 5 sellers by total pizza sold

select top 5 pizza_name, sum(quantity) as total_pizzas_sold
from pizza_sales
group by pizza_name 
order by sum(quantity) asc