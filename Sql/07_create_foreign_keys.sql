/*============================================================
 Author  : Samshad Ansari
 Project : Amazon Sales Data Warehouse
 File    : 07_create_foreign_keys.sql
 Purpose : Create Foreign Key Relationships
============================================================*/

-- ==========================================================
-- Foreign Keys for Orders Table
-- ==========================================================

ALTER TABLE Orders
ADD CONSTRAINT fk_orders_customer
FOREIGN KEY (CustomerKey)
REFERENCES Customers(CustomerKey);

ALTER TABLE Orders
ADD CONSTRAINT fk_orders_seller
FOREIGN KEY (SellerKey)
REFERENCES Sellers(SellerKey);


-- ==========================================================
-- Foreign Keys for OrderDetails Table
-- ==========================================================

ALTER TABLE OrderDetails
ADD CONSTRAINT fk_orderdetails_order
FOREIGN KEY (OrderID)
REFERENCES Orders(OrderID);

ALTER TABLE OrderDetails
ADD CONSTRAINT fk_orderdetails_product
FOREIGN KEY (ProductKey)
REFERENCES Products(ProductKey);