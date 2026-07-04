/*============================================================
 Author  : Samshad Ansari
 Project : Amazon Sales Data Warehouse
 File    : 08_data_validation.sql
 Purpose : Validate Data After ETL Process
============================================================*/

-- ==========================================================
-- Validate Record Count in All Tables
-- ==========================================================

SELECT
    (SELECT COUNT(*) FROM Customers)    AS Total_Customers,
    (SELECT COUNT(*) FROM Products)     AS Total_Products,
    (SELECT COUNT(*) FROM Sellers)      AS Total_Sellers,
    (SELECT COUNT(*) FROM Orders)       AS Total_Orders,
    (SELECT COUNT(*) FROM OrderDetails) AS Total_OrderDetails;


-- ==========================================================
-- Check for NULL CustomerKey in Orders
-- ==========================================================

SELECT COUNT(*) AS Missing_CustomerKey
FROM Orders
WHERE CustomerKey IS NULL;


-- ==========================================================
-- Check for NULL SellerKey in Orders
-- ==========================================================

SELECT COUNT(*) AS Missing_SellerKey
FROM Orders
WHERE SellerKey IS NULL;


-- ==========================================================
-- Check for NULL ProductKey in OrderDetails
-- ==========================================================

SELECT COUNT(*) AS Missing_ProductKey
FROM OrderDetails
WHERE ProductKey IS NULL;


-- ==========================================================
-- Check for Orders without OrderDetails
-- ==========================================================

SELECT o.OrderID
FROM Orders o
LEFT JOIN OrderDetails od
       ON o.OrderID = od.OrderID
WHERE od.OrderID IS NULL;


-- ==========================================================
-- Check for Duplicate Order IDs
-- ==========================================================

SELECT
    OrderID,
    COUNT(*) AS Total
FROM Orders
GROUP BY OrderID
HAVING COUNT(*) > 1;


-- ==========================================================
-- Check for Duplicate Product Keys in Products
-- ==========================================================

SELECT
    ProductKey,
    COUNT(*) AS Total
FROM Products
GROUP BY ProductKey
HAVING COUNT(*) > 1;