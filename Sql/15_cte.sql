/*============================================================
 Author  : Samshad Ansari
 Project : Amazon Sales Data Warehouse
 File    : 15_cte.sql
 Purpose : Learn Common Table Expressions (CTE) using Business Scenarios
============================================================*/

/*============================================================
 Query 1 : Customer Revenue using CTE
 Purpose : Calculate total revenue of each customer.
============================================================*/

with  CustomerRevenue  as 
(
	select customername , sum(totalamount) as total_revenue from customers 
    inner join orders using(customerkey) inner join orderdetails using(orderid)
    group by 1 
)
select * from CustomerRevenue order by total_revenue desc;

/*============================================================
 Query 2 : Top 10 Customers using CTE
============================================================*/

with  CustomerRevenue  as 
(
	select customername , sum(totalamount) as total_revenue from customers 
    inner join orders using(customerkey) inner join orderdetails using(orderid)
    group by 1 
)
select * from CustomerRevenue order by total_revenue desc limit 10;

/*============================================================
 Query 3 : Product Revenue using CTE
============================================================*/

with ProductRevenue as 
(
	select productname, sum(totalamount) as total_revenue from products 
    inner join orderdetails using(productkey)
    group by 1 
)
select * from ProductRevenue order by total_revenue desc ;

/*============================================================
 Query 4 : Category Revenue using CTE
============================================================*/

with CategoryRevenue as 
(
	select category , sum(totalamount) as total_revenue from products 
    inner join orderdetails using(productkey) 
    group by 1
)
select * from CategoryRevenue order by total_revenue desc;

/*============================================================
 Query 5 : Monthly Revenue using CTE
============================================================*/

with monthly_revenue as
(
	select monthname(orderdate) as month_name, sum(totalamount) as total_revenue  from orders 
    inner join orderdetails using(orderid) 
    group by 1
)
select * from monthly_revenue order by total_revenue desc;

/*============================================================
 Query 6 : Products Above Average Revenue
============================================================*/

with product_revenue as 
(
	select productname, sum(totalamount) as total_revenue from products 
    inner join orderdetails using(productkey) 
    group by 1
)
select * from product_revenue 
where total_revenue > (select avg(total_revenue) from product_revenue) 
order by total_revenue desc;

/*============================================================
 Query 7 : Repeat Customers
============================================================*/

with CustomerOrders as 
(
	select customername , count(orderid) as ordercount from customers 
    inner join orders using(customerkey) 
    group by 1
)
select * from CustomerOrders where ordercount > 1 
order by ordercount desc;

/*============================================================
 Query 8 : Top Revenue State
============================================================*/

with state_revenue as
(
	select state , sum(totalamount) as total_revenue from customers 
    inner join orders using(customerkey) 
    inner join orderdetails using(orderid) 
    group by 1
)
select * from state_revenue 
order by total_revenue desc limit 1 ;

/*============================================================
 Query 9 : Top Selling Brand
============================================================*/
with BrandRevenue as 
(
	select brand , sum(totalamount) as total_revenue from products 
    inner join orderdetails using(productkey) 
    group by 1 
) 
select * from BrandRevenue order by total_revenue desc limit 1;

/*============================================================
 Query 10 : Customer Revenue Summary
============================================================*/

with CustomerRevenue as
(
	select customername , count(orderid) as ordercount , sum(totalamount) as total_revenue 
    from customers inner join orders using(customerkey)
    inner join orderdetails using(orderid)
    group by 1
)
select * from CustomerRevenue order by total_revenue desc;







    
    