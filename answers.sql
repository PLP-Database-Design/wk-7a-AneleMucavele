-- QUESTION 1 Creating Normalizeddb 
CREATE DATABASE Normalizeddb;
USE Normalizeddb;

-- Creating the original ProductDetail_1NF table
CREATE TABLE  ProductDetail_1NF (
    OrderID INT,
    CustomerName VARCHAR(100),
    Products VARCHAR(255),
    PRIMARY KEY (OrderID, Product)
);

-- Inserting sample data into ProductDetail_1NF
INSERT INTO ProductDetail_1NF (OrderID, CustomerName, Products) VALUES
    (101, 'John Doe', 'Laptop'),
    (101, 'John Doe', 'Mouse'),
    (102, 'Jane Smith', 'Tablet'),
    (102, 'Jane Smith', 'Keyboard'),
    (102, 'Jane Smith', 'Mouse'),
    (103, 'Emily Clark', 'Phone');

INSERT INTO ProductDetail_1NF (OrderID, CustomerName, Product)
SELECT 
    OrderID,
    CustomerName,
    TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(Products, ',', n), ',', -1)) AS Product
FROM 
    ProductDetail_1NF
JOIN 
    (SELECT 1 AS n UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4) AS numbers
WHERE 
    n <= LENGTH(Products) - LENGTH(REPLACE(Products, ',', '')) + 1;

-- QUESTION 2

-- Create Orders table 
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

-- Create OrderItems table 
CREATE TABLE OrderItems (
    OrderID INT,
    Product VARCHAR(100),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Insert data into Orders 
INSERT INTO Orders (OrderID, CustomerName)
SELECT DISTINCT OrderID, CustomerName
FROM OrderDetails;

-- Insert data into OrderItems 
INSERT INTO OrderItems (OrderID, Product, Quantity)
SELECT OrderID, Product, Quantity
FROM OrderDetails;