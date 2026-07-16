/*============================================================
 Author  : Samshad Ansari
 Project : Amazon Sales Data Warehouse
 File    : 14_subqueries.sql
 Purpose : Learn Subqueries using Real Business Scenarios
============================================================*/

/*============================================================
 Query 1 : Orders Above Average Order Value
 Purpose : Find orders above the average order value.
============================================================*/

select orderid , totalamount  from orderdetails 
where totalamount > (select avg(totalamount) from orderdetails ) 
order by totalamount desc;

/*============================================================
 Query 1 : Orders Above Average Order Value
 Purpose : Find orders above the average order value.
============================================================*/

select productname, unitprice  from products inner join orderdetails using(productkey) 
where unitprice > (select avg(unitprice) from orderdetails ) 
order by unitprice desc;

/*============================================================
 Query 3 : Customers With High Value Orders
============================================================*/

select customername from customers 
where customerkey in (select customerkey 
						from orders where orderid in (select orderid from orderdetails 
                        where totalamount > 2000
                        ));
                        

/*============================================================
 Query 4 : Customers Who Have Orders
============================================================*/

select customername from customers 
	where exists(select 1 from orders where customerkey = customerkey);
    
/*============================================================
 Query 5 : Customers Without Orders
============================================================*/

select customername from customers 
where not exists (select 1  from orders  where customerkey = customerkey);

/*============================================================
 Query 6 : Products Above Category Average Price
============================================================*/

select productname , category , unitprice from products inner join orderdetails 
using(productkey) where unitprice > (select avg(unitprice) from products 
join orderdetails using(productkey) where category = category);

/*============================================================
 Query 7 : ANY Operator
============================================================*/

select orderid , totalamount from orderdetails 
where totalamount > any(select totalamount from orderdetails 
						where totalamount > 2000)
                        order by totalamount desc;

/*============================================================
 Query 8 : ALL Operator
============================================================*/
select orderid , totalamount  from orderdetails 
where totalamount >= all (select totalamount from orderdetails 
							where totalamount > 2000);
						
                        
/*============================================================
 Query 9 : Top Revenue Customer
============================================================*/
select customername from customers 
where customerkey = (select customerkey from orders 
where orderid = (select orderid from orderdetails 
order by totalamount desc limit 1));

/*============================================================
 Query 10 : Products Generating Above Average Revenue
============================================================*/


SELECT
    ProductName,
    Total_Revenue
FROM
(
    SELECT
        p.ProductName,
        SUM(od.TotalAmount) AS Total_Revenue
    FROM Products p
    JOIN OrderDetails od
    ON p.ProductKey = od.ProductKey
    GROUP BY p.ProductName
) AS ProductRevenue
WHERE Total_Revenue >
(
    SELECT AVG(Total_Revenue)
    FROM
    (
        SELECT
            SUM(od.TotalAmount) AS Total_Revenue
        FROM Products p
        JOIN OrderDetails od
        ON p.ProductKey = od.ProductKey
        GROUP BY p.ProductName
    ) AS AvgRevenue
)
ORDER BY Total_Revenue DESC;
                        
                        










