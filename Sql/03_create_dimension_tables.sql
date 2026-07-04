/*============================================================
 Author  : Samshad Ansari
 Project : Amazon Sales Data Warehouse
 File    : 03_create_dimension_tables.sql
 Purpose : Create Dimension Tables
============================================================*/

-- ==========================================================
-- Customers Dimension Table
-- ==========================================================

CREATE TABLE Customers (
    CustomerKey INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID VARCHAR(20),
    CustomerName VARCHAR(100),
    City VARCHAR(100),
    State VARCHAR(100),
    Country VARCHAR(100)
);

-- ==========================================================
-- Products Dimension Table
-- ==========================================================

CREATE TABLE Products (
    ProductKey INT AUTO_INCREMENT PRIMARY KEY,
    ProductID VARCHAR(20),
    ProductName VARCHAR(255),
    Category VARCHAR(100),
    Brand VARCHAR(100)
);

-- ==========================================================
-- Sellers Dimension Table
-- ==========================================================

CREATE TABLE Sellers (
    SellerKey INT AUTO_INCREMENT PRIMARY KEY,
    SellerID VARCHAR(20)
);