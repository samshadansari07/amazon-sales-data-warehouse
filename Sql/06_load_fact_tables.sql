/*============================================================
 Author  : Samshad Ansari
 Project : Amazon Sales Data Warehouse
 File    : 06_load_fact_tables.sql
 Purpose : Load Data into Fact Tables
============================================================*/

-- ==========================================================
-- Load Orders Fact Table
-- ==========================================================

INSERT INTO Orders (
    OrderID,
    OrderDate,
    CustomerKey,
    SellerKey,
    PaymentMethod,
    OrderStatus
)
SELECT
    r.OrderID,
    r.OrderDate,
    c.CustomerKey,
    s.SellerKey,
    r.PaymentMethod,
    r.OrderStatus
FROM amazon_sales_raw AS r
JOIN Customers AS c
      ON r.CustomerID = c.CustomerID
     AND r.CustomerName = c.CustomerName
     AND r.City = c.City
     AND r.State = c.State
     AND r.Country = c.Country
JOIN Sellers AS s
      ON r.SellerID = s.SellerID;


-- ==========================================================
-- Load OrderDetails Fact Table
-- ==========================================================

INSERT INTO OrderDetails (
    OrderID,
    ProductKey,
    Quantity,
    UnitPrice,
    Discount,
    Tax,
    ShippingCost,
    TotalAmount
)
SELECT
    r.OrderID,
    p.ProductKey,
    r.Quantity,
    r.UnitPrice,
    r.Discount,
    r.Tax,
    r.ShippingCost,
    r.TotalAmount
FROM amazon_sales_raw AS r
JOIN Products AS p
      ON r.ProductID = p.ProductID
     AND r.ProductName = p.ProductName
     AND r.Brand = p.Brand
     AND r.Category = p.Category;