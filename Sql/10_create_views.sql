/*============================================================
 Author  : Samshad Ansari
 Project : Amazon Sales Data Warehouse
 Purpose : Create SQL Views for Business Reporting
============================================================*/


/*============================================================
 View 2 : Product Sales Summary
============================================================*/
create view vw_product_sales_summary as
select productkey , productname ,category , brand, 
sum(quantity) as total_quantity_sold, 
round(sum(totalamount),2) as total_revenue 
from products inner join orderdetails using(productkey) 
group by 1,2,3,4;

select * from vw_product_sales_summary;

/*============================================================
 View 1 : Customer Sales Summary
============================================================*/

create view vw_customers_sales_summary as
select customerkey , customername , city , state , country , 
count(orderid) as total_orders , sum(quantity) as total_quantity,
round(sum(totalamount),2) as total_revenue
from customers inner join orders using(customerkey) 
inner join orderdetails using(orderid) 
group by 1,2,3,4,5;

select * from vw_customers_sales_summary;

/*============================================================
 View 3 : Monthly Sales Summary
============================================================*/

create view vw_monthly_sales_summary as
select 
year(orderdate) as sales_year,
month(orderdate) as sales_month,
monthname(orderdate) as monthname,
count(orderid) as total_orders,
sum(quantity) as total_quantity,
round(sum(totalamount),2) as total_revenue
from orders inner join orderdetails using(orderid) group by 1,2,3;

select * from vw_monthly_sales_summary;

/*============================================================
 View 4 : Category Revenue Summary
============================================================*/

create view vw_category_revenue_summary as
select category , round(sum(totalamount),2) as total_revenue 
from products inner join orderdetails using(productkey) 
group by 1;

select * from vw_category_revenue_summary;

/*============================================================
 View 5 : Brand Revenue Summary
============================================================*/

create view vw_brand_revenue_summary as 
select brand , round(sum(totalamount),2) as total_revenue
from products inner join orderdetails using(productkey) 
group by 1;

select * from vw_brand_revenue_summary;










