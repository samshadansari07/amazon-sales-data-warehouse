/*============================================================
 Author  : Samshad Ansari
 Project : Amazon Sales Data Warehouse
 File    : 13_conditional_functions.sql
 Purpose : Demonstrate Conditional Functions in MySQL
============================================================*/

-- ============================================================
-- MODULE 1 : IF()
-- ============================================================

/*============================================================
 Query 2 : Product Demand
 Purpose : Identify demand level using IF().
============================================================*/

select orderid , totalamount , 
	if(totalamount >= 1000, 
    "high value order ", "normal ordervalue ") as order_status
from orderdetails order by totalamount desc;

/*============================================================
 Query 2 : Product Demand
 Purpose : Identify demand level using IF().
============================================================*/

select productname , sum(quantity) as total_quantity, 
	if(sum(quantity) >= 6000 ,
    "high demand" ,"low demand") as demand_status 
from products inner join orderdetails using(productkey) 
group by 1 order by total_quantity desc;

-- ============================================================
-- MODULE 2 : IFNULL()
-- ============================================================

/*============================================================
 Query 3 : IFNULL()
 Purpose : Replace NULL discount values.
============================================================*/

select orderid , ifnull(discount , 0 ) as shipping_cost
from orderdetails ;

/*============================================================
 Query 4 : IFNULL()
 Purpose : Replace NULL shipping cost.
============================================================*/

select orderid , ifnull(shippingcost, 0) as shippingcost from orderdetails ;

/*============================================================
 Query 5 : COALESCE()
 Purpose : Return first non-null value.
============================================================*/

select  orderid , coalesce(discount,tax, shippingcost,0) as first_available_value
from orderdetails;

/*============================================================
 Query 6 : COALESCE()
 Purpose : Display first available location.
============================================================*/

select customername, coalesce(city , state , country, "unknown") as customer_location 
from customers;

/*============================================================
 Query 7 : NULLIF()
 Purpose : Convert zero discount to NULL.
============================================================*/

select orderid, ifnull(discount,0) as discount from orderdetails;

/*============================================================
 Query 8 : NULLIF()
 Purpose : Convert zero shipping cost to NULL.
============================================================*/

select orderid , ifnull(shippingcost,0) as shippingcost from orderdetails;









