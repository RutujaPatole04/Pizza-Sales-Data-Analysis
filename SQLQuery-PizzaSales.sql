select * from pizza_sales;
/*KPI's  Requirement*/
/*1-- Total Revenue*/
select sum(total_price) as Total_Revenue from pizza_sales;

/*2-- Average Order Value--- total revenue/ total number of orders*/
select sum(total_price)/count(distinct order_id) as Avg_Order_Value from pizza_sales;

/*3--Total Pizzas Sold --sum of all quantities */
select sum(quantity) as Total_Pizza_Sold from pizza_sales

/*4--Total Orders-- sum of orders */
select count(distinct order_id) as Total_Orders from pizza_sales;

/*5--Average Pizzas Per Order-- total/count---total pizzas sold / total number of orders ---it is rounding off and giving results */
select cast(cast(sum(quantity) as decimal(10,2))/cast(count(distinct order_id) as decimal(10,2)) as decimal(10,2)) from pizza_sales

/*Charts Requirement */
/*1--Daily trend -- on which particular dae order count was highest  */
Select DATENAME(DW,order_date) as order_day, count(distinct order_id) as Total_orders
from pizza_sales
group by DATENAME(DW,order_date) 
Select DATEPART(DW,order_date) as order_day, count(distinct order_id) as Total_orders
from pizza_sales
group by DATEPART(DW,order_date)
/*datepart--integers output, datename-- string output, dw--day of the week)*/

/*2--hourly trend-- on which particular dae order count was highest  wat is the peak time */
select DATEPART(HOUR, order_time) as Order_hours, count(distinct order_id) as Total_orders 
from pizza_sales
group by DATEPART(HOUR, order_time)
order by DATEPART(HOUR, order_time) asc

/*3--Percentage of sales by Pizza Category       total  pizza category sales/total sales----individual category sales/ total sales if you want percentage multiply by 100 and make a ratio */
select pizza_category, sum(total_price) * 100/(select sum(total_price)from pizza_sales where MONTH(order_date)=1) as PCT
from pizza_sales
where MONTH(order_date)=1
group by pizza_category


select pizza_category, sum(total_price)  from pizza_sales as Total_Sales
group by pizza_category

/*Percentage of Sales by Pizza size---*/
select pizza_size,cast(sum(total_price) as decimal(10,2)) as Total_Sales, cast(sum(total_price) * 100/(select sum(total_price)from pizza_sales where Datepart(quarter, order_date)=1) as decimal(10,2))as PCT
from pizza_sales
where Datepart(quarter, order_date)=1
group by pizza_size
order by PCT desc

/*total pizzas sold by pizza category*/
select * from pizza_sales
select pizza_category,sum(quantity) as Total_Pizzas_Sold from pizza_sales
group by pizza_category

/*Top 5 bestsellers by total Pizzas Sold*/
select top 5 pizza_name,sum(quantity) as Total_Pizzas_Sold from pizza_sales
group by pizza_name
order by sum(quantity) desc

/*Bottom 5 */
select top 5 pizza_name,sum(quantity) as Total_Pizzas_Sold from pizza_sales
group by pizza_name
order by sum(quantity) asc