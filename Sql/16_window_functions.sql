/*============================================================
 Author  : Samshad Ansari
 Project : Amazon Sales Data Warehouse
 File    : 16_window_functions.sql
 Purpose : Learn Window Functions using Business Scenarios
============================================================*/

/*============================================================
 Author  : Samshad Ansari
 Project : Amazon Sales Data Warehouse
 File    : 16_window_functions.sql
 Purpose : Learn Window Functions using Business Scenarios
============================================================*/

select customername , total_revenue , 
row_number() over(order by total_revenue desc) as row_numbers 
from (
	  select customername, sum(totalamount) as total_revenue from customers 
      inner join orders using(customerkey) 
      inner join orderdetails using(orderid)
      group by 1
) customerrevenue ;

/*============================================================
 Query 2 : Customer Revenue using RANK()
============================================================*/
with cte as 
(
	select customername , sum(totalamount) as total_revenue, 
    rank() over(order by sum(totalamount)  desc) as customer_rank from customers 
    inner join orders using(customerkey) inner join orderdetails using(orderid) 
    group by 1 
) select * from cte;

/*============================================================
 Query 3 : Customer Revenue using DENSE_RANK()
============================================================*/
with cte as 
(
	select customername , sum(totalamount) as total_revenue, 
    dense_rank() over(order by sum(totalamount)  desc) as customer_rank from customers 
    inner join orders using(customerkey) inner join orderdetails using(orderid) 
    group by 1 
) select * from cte;

/*============================================================
 Query 4 : Product Rank within Category
============================================================*/

with cte as 
(
	select category , productname ,	sum(totalamount) as total_revenue ,
    rank() over(partition by category order by sum(totalamount) desc ) as category_rank
    from products inner join orderdetails using(productkey) 
    group by 1,2 
) 
select * from cte ;

/*============================================================
 Query 5 : Previous Month Revenue
============================================================*/

with cte as 
(
	 select monthname(orderdate) as month_name , sum(totalamount) as total_revenue ,
     lag(sum(totalamount)) over(order by monthname(orderdate)  desc) as prev_month_revenue 
     from orders inner join orderdetails using(orderid) 
     group by 1
)
select * from cte;

/*============================================================
 Query 6 : Next Month Revenue
============================================================*/

with cte as 
(
	 select monthname(orderdate) as month_name , sum(totalamount) as total_revenue ,
     lead(sum(totalamount)) over(order by monthname(orderdate)  desc) as prev_month_revenue 
     from orders inner join orderdetails using(orderid) 
     group by 1
)
select * from cte;

/*============================================================
 Query 7 : Running Total
============================================================*/

with cte as 
(
	select month(orderdate) as monthnumber , 
    monthname(orderdate) as month_name, sum(totalamount) as total_revenue
    from orders inner join orderdetails using(orderid) 
    group by 1,2
)
select month_name, total_revenue ,sum(total_revenue) over(order by monthnumber) as running_total
from cte;

/*============================================================
 Query 8 : Month-over-Month (MoM) Growth %
============================================================*/

WITH cte AS
(
    SELECT
        MONTH(OrderDate) AS month_number,
        MONTHNAME(OrderDate) AS month_name,
        SUM(TotalAmount) AS total_revenue,
        LAG(SUM(TotalAmount)) OVER(ORDER BY MONTH(OrderDate)) AS previous_month_revenue
    FROM Orders
    INNER JOIN OrderDetails USING(OrderID)
    GROUP BY
        MONTH(OrderDate),
        MONTHNAME(OrderDate)
)

SELECT
    month_name,
    total_revenue,
    previous_month_revenue,
    ROUND(
        ((total_revenue - previous_month_revenue)
        / previous_month_revenue) * 100, 2
    ) AS mom_growth_percentage
FROM cte;

/*============================================================
 Query 8 : Moving Average
============================================================*/
with cte as (
	select month(orderdate) as months ,
    monthname(orderdate) as month_name, sum(totalamount) as total_revenue
    from orders inner join orderdetails using(orderid) 
    group by 1,2
)
select month_name,total_revenue , round(AVG(total_revenue) over(order by months rows between 2 
										preceding and current row ),2) AS moving_avg
from cte;

/*============================================================
 Query 9 : FIRST_VALUE()
============================================================*/

with cte as (
	select category , productname, sum(totalamount) as total_revenue 
    from products inner join orderdetails using(productkey) 
    group by 1 ,2 
)
select category, productname, total_revenue , first_value(productname) 
over(partition by category  order by total_revenue desc ) as top_products 
from cte;

/*============================================================
 Query 10 : NTILE()
============================================================*/

SELECT
    CustomerName,
    Total_Revenue,
    NTILE(4)
    OVER(ORDER BY Total_Revenue DESC) AS Revenue_Group
FROM
(
    SELECT
        c.CustomerName,
        SUM(od.TotalAmount) AS Total_Revenue
    FROM Customers c
    JOIN Orders o
        ON c.CustomerKey = o.CustomerKey
    JOIN OrderDetails od
        ON o.OrderID = od.OrderID
    GROUP BY c.CustomerName
) CustomerRevenue;
    

    


    










