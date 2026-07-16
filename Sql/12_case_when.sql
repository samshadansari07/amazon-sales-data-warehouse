/*============================================================
 Author  : Samshad Ansari
 Project : Amazon Sales Data Warehouse
 File    : 12_case_when.sql
 Purpose : Use CASE WHEN for Business Classification and Reporting
 
============================================================*/
-- ============================================================
-- MODULE 1 : CUSTOMER CLASSIFICATION
-- ==============================================

/*============================================================
 Query 1 : Customer Revenue Category
 Purpose : Classify customers as Premium, Regular, or New.
============================================================*/

select customername , round(sum(totalamount),2) as total_revenue ,
case 
	when sum(totalamount) >= 500000 then "premimum customer"
    when sum(totalamount) >= 400000 then "regular customer"
    else "new customer"
    end as customer_category 

from customers inner join orders using(customerkey) 
inner join orderdetails using(orderid) 
group by 1 order by total_revenue desc;

/*============================================================
 Query 2 : Order Value Category
 Purpose : Categorize orders into High, Medium, and Low value.
============================================================*/

select orderid , totalamount ,
case 
	when totalamount >= 3000 then "high value order "
    when totalamount >= 2000 then "medium value order " 
    else "low value order "
    end as order_category 
    
from orderdetails order by totalamount desc;

-- ============================================================
-- MODULE 3 : PRODUCT DEMAND ANALYSIS
-- ============================================================

/*============================================================
 Query 3 : Product Demand Level
 Purpose : Categorize products by demand.
============================================================*/

select productname , sum(quantity) as total_quantity,
case 
	when sum(quantity) >= 6000 then "high demand "
    when sum(quantity) >= 5000 then "medium demand"
    else "low demand"
    end as demand_level
    
from products inner join orderdetails using(productkey)  group by 1
order by total_quantity desc;


-- ============================================================
-- MODULE 4 : DISCOUNT ANALYSIS
-- ============================================================

/*============================================================
 Query 4 : Discount Category
 Purpose : Analyze discount levels.
============================================================*/

select orderid , discount ,
case 
	when discount >= 20 then "havy discount "
    when discount >= 10 then "medium discount "
    else "low discount"
    end as discount_level
from orderdetails order by discount ;

-- ============================================================
-- MODULE 5 : REVENUE GRADING
-- ============================================================

/*============================================================
 Query 5 : Revenue Grade
 Purpose : Assign grades based on order revenue.
============================================================*/

select orderid , totalamount , 
case 
	when totalamount >= 2500 then "grade a"
    when totalamount >= 1500 then "grade b"
    when totalamount >= 800 then "grade c"
    else "grade d"
    end as revenue_grade
from orders inner join  orderdetails using(orderid)
order by totalamount desc;

-- ============================================================
-- MODULE 6 : SHIPPING COST ANALYSIS
-- ============================================================

/*============================================================
 Query 6 : Shipping Cost Category
 Purpose : Classify shipping costs.
============================================================*/

select orderid , shippingcost,
case 
	when shippingcost >= 15 then "high shipping cost"
    when shippingcost >= 10 then "medium shipping cost"
    else "low shipping cost"
    end as shipping_cateory 
from orderdetails order by shippingcost desc; 


