
-------------Create Customer table
DROP table Customer;
CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    Address VARCHAR(255)
);


------Create product table
DROP table Product;
CREATE TABLE Product (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    Stock INT NOT NULL CHECK (Stock >= 0)
);

-----Create Orders table
DROP TABLE Orders;
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    OrderDate DATE NOT NULL,
    CustomerID INT NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

-----Create OrderItems table
DROP TABLE OrderItems;
  CREATE TABLE OrderItems (
    OrderItemID INT PRIMARY KEY,
    OrderID INT NOT NULL,
	ProductID INT NOT NULL,
	Quantity INT NOT NULL CHECK (Quantity > 0),
    UnitPrice DECIMAL(10,2) NOT NULL,
    
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);


----------Inserting data to customers table
INSERT INTO Customer (CustomerID, Name, Email, Address) VALUES
(1, 'John Robin', 'jr@gmail.com', 'London'),
(2, 'Alan Smith', 'as@gmail.com', 'Chester'),
(3, 'Charles Robert', 'cr@gmail.com', 'Bradford'),
(4, 'Della Iman', 'di@gmail.com', 'Leeds'),
(5, 'Eric Mavin', 'em@gmail.com', 'Barnsley'),
(6, 'Mary Jane', 'mj@gmail.com', 'Gloucester'),
(7, 'Allan White', 'aw@gmail.com', 'Selby'),
(8, 'Samuel Kerry', 'sk@gmail.com', 'Leicester'),
(9, 'Black Mamba', 'bm@gmail.com', 'Cambridge'),
(10, 'Simon Kabu', 'sik@gmail.com', 'Swindon');


----------Inserting data into product
INSERT INTO Product (ProductID, ProductName, Price, Stock) VALUES
(101, 'Laptop', 1550.00, 25),
(102, 'Smartphone', 400.00, 35),
(103, 'Headphones', 50.00, 90),
(104, 'Keyboard', 30.00, 20),
(105, 'Mouse', 35.00, 50),
(106, 'Monitor', 300.00, 10),
(107, 'Tablet', 250.00, 38),
(108, 'Printer', 250.00, 10),
(109, 'Webcam', 70.00, 32),
(110, 'Speaker', 100.00, 25);



-----------Inserting data into orders table

INSERT INTO Orders (OrderID, OrderDate, CustomerID) VALUES
(1001, '2026-03-10', 1),
(1002, '2026-04-12', 2),
(1003, '2026-06-15', 3),
(1004, '2026-01-18', 4),
(1005, '2026-05-20', 5),
(1006, '2026-06-22', 6),
(1007, '2026-03-25', 7),
(1008, '2026-04-28', 8),
(1009, '2026-02-01', 9),
(1010, '2026-06-03', 10);


------------Inserting money into OrderItems
INSERT INTO OrderItems (OrderItemID, OrderID, ProductID, Quantity, UnitPrice) VALUES
(1, 1001, 101, 1, 1550.00),
(2, 1001, 103, 2, 50.00),

(3, 1002, 102, 1, 400.00),
(4, 1002, 105, 1, 35.00),

(5, 1003, 104, 2, 30.00),
(6, 1003, 106, 1, 300.00),

(7, 1004, 101, 1, 1550.00),

(8, 1005, 107, 1, 250.00),
(9, 1005, 103, 1, 50.00),

(10, 1006, 108, 1, 250.00),

(11, 1007, 109, 2, 70.00),

(12, 1008, 110, 1, 100.00),
(13, 1008, 105, 2, 35.00),

(14, 1009, 102, 1, 400.00),

(15, 1010, 106, 1, 300.00),
(16, 1010, 104, 1, 30.00);


----Dispaly a list of all customers
SELECT CustomerID, Name, Email, Address FROM Customer;

--------Display orders by specific customer 
SELECT OrderID, OrderDate FROM Orders WHERE CustomerID = 3;


---------INNER JOIN
SELECT c.CustomerID, c.Name, o.OrderID, o.OrderDate
FROM Customer c
INNER JOIN Orders o ON c.CustomerID = o.CustomerID;


-----Products in each order
SELECT o.OrderID, p.ProductID, p.ProductName, oi.Quantity
FROM Orders o
INNER JOIN OrderItems oi ON o.OrderID = oi.OrderID
INNER JOIN Product p ON oi.ProductID = p.ProductID;



---------Value of each order
SELECT o.OrderID, SUM(oi.Quantity * oi.UnitPrice) AS TotalOrderValue
FROM Orders o
INNER JOIN OrderItems oi ON o.OrderID = oi.OrderID
GROUP BY o.OrderID;


--------Quantity sold for every product
SELECT p.ProductID, p.ProductName, SUM(oi.Quantity) AS TotalSold
FROM Product p
INNER JOIN OrderItems oi ON p.ProductID = oi.ProductID
GROUP BY p.ProductID, p.ProductName;


-----------Spending per customer
SELECT c.CustomerID, c.Name, SUM(oi.Quantity * oi.UnitPrice) AS TotalSpent
FROM Customer c
INNER JOIN Orders o ON c.CustomerID = o.CustomerID
INNER JOIN OrderItems oi ON o.OrderID = oi.OrderID
GROUP BY c.CustomerID, c.Name
ORDER BY TotalSpent DESC;


-----------Products with stock levels less than 20
SELECT ProductID, ProductName, Stock
FROM Product
WHERE Stock < 20;

--------------average value of each order
SELECT AVG(OrderTotal) AS AverageOrderValue
FROM (
    SELECT OrderID, SUM(Quantity * UnitPrice) AS OrderTotal
    FROM OrderItems
    GROUP BY OrderID
) AS OrderTotals;


--------Updating customer email
UPDATE Customer SET Email = 'john.robin@gmail.com' WHERE CustomerID = 1;

------Updating product price
UPDATE Product SET Price = 1450.00 WHERE ProductID = 101;
SELECT ProductID, ProductName, Price, Stock FROM Product;

--------deletion of cancelled order
DELETE FROM Orders WHERE OrderID = 1009;
SELECT OrderID, OrderDate, CustomerID FROM Orders;





