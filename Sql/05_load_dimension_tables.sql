/*============================================================
 Author  : Samshad Ansari
 Project : Amazon Sales Data Warehouse
 File    : 05_load_dimension_tables.sql
 Purpose : Load Data into Dimension Tables
============================================================*/

-- ==========================================================
-- Load Customers Dimension
-- ==========================================================

INSERT INTO Customers (
    CustomerID,
    CustomerName,
    City,
    State,
    Country
)
SELECT DISTINCT
    CustomerID,
    CustomerName,
    City,
    State,
    Country
FROM amazon_sales_raw;


-- ==========================================================
-- Load Products Dimension
-- ==========================================================

INSERT INTO Products (
    ProductID,
    ProductName,
    Category,
    Brand
)
SELECT DISTINCT
    ProductID,
    ProductName,
    Category,
    Brand
FROM amazon_sales_raw;


-- ==========================================================
-- Load Sellers Dimension
-- ==========================================================

INSERT INTO Sellers (
    SellerID
)
SELECT DISTINCT
    SellerID
FROM amazon_sales_raw;