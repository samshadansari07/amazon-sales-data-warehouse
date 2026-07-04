/*============================================================
 Author  : Samshad Ansari
 Project : Amazon Sales Data Warehouse
 File    : 04_create_fact_tables.sql
 Purpose : Create Fact Tables
============================================================*/

-- ==========================================================
-- Orders Fact Table
-- ==========================================================

CREATE TABLE Orders (
    OrderID VARCHAR(20) PRIMARY KEY,
    OrderDate DATE,
    CustomerKey INT,
    SellerKey INT,
    PaymentMethod VARCHAR(50),
    OrderStatus VARCHAR(50)
);

-- ==========================================================
-- OrderDetails Fact Table
-- ==========================================================

CREATE TABLE OrderDetails (
    OrderDetailID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID VARCHAR(20),
    ProductKey INT,
    Quantity INT,
    UnitPrice DECIMAL(10,2),
    Discount DECIMAL(10,2),
    Tax DECIMAL(10,2),
    ShippingCost DECIMAL(10,2),
    TotalAmount DECIMAL(10,2)
);