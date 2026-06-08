DROP TABLE Books;

CREATE TABLE Books (

   BookID INT PRIMARY KEY,

   Title VARCHAR(100) NOT NULL,

   Author VARCHAR(50),

   Genre VARCHAR(30),

   Price FLOAT

);

iNSERT INTO Books VALUES (1, '1984', 'George Orwell', 'Dystopian', 19.99);

INSERT INTO Books VALUES (2, 'To Kill a Mockingbird', 'Harper Lee', 'Fiction', 14.99);

INSERT INTO Books VALUES (3, 'The greatest Salesman in the world', 'OG Mandino', 'Personal Development', 19.99);

INSERT INTO Books VALUES (4, 'Project Hail mary', 'Andy Weir', 'Science Fiction', 9.99);

INSERT INTO Books VALUES (5, 'Dune', 'Frank Herbert', 'Fantacy', 9.99);

INSERT INTO Books VALUES (6, 'The Thursday Murder', 'Richard Osman', 'Crime', 7.99);

INSERT INTO Books VALUES (7, 'A court of thorns and roses', 'Sarah J Maas', 'Romance', 9.99);

INSERT INTO Books VALUES (8, 'The midnight Library', 'Matt Haig', 'Fiction', 9.99);

INSERT INTO Books VALUES (9, 'Normal People', 'Sally Rooney', 'Fiction', 9.99);

INSERT INTO Books VALUES (10, 'It starts with us', 'Colleen Hoover', 'Romance', 8.99);

INSERT INTO Books VALUES (11, 'Atomic Habits', 'James Clear', 'Personal development', 10.99);

INSERT INTO Books VALUES (12, 'It ends with us', 'Colleen Hoover', 'Romance', 7.99);

INSERT INTO Books VALUES (13, 'The hobbit', 'J.R.R.Tolkein', 'Fantasy', 9.99);

INSERT INTO Books VALUES (14, 'Lessons in chemistry', 'Bonnie Garmus', 'Fiction', 14.99);

INSERT INTO Books VALUES (15, 'Iron Flame', 'Rebecca Yarros', 'Romanes', 6.99);

INSERT INTO Books VALUES (16, 'Sapiens', 'Yuval Noah Harara', 'History ', 16.99);

SELECT BookID, Title, Author, Genre, Price FROM Books;

SELECT Title, Author FROM Books;

-- Books with price greater than 15
SELECT BookID, Title, Author, Genre, Price FROM Books WHERE Price > 15;

-- Books in Fiction genre
SELECT BookID, Title, Author, Genre, Price FROM Books WHERE Genre = 'Fiction';

-- Order by price in escending
SELECT BookID, Title, Author, Genre, Price FROM Books ORDER BY Price DESC;

UPDATE Books SET Price = 21.99 WHERE BookID = 1;

DELETE FROM Books WHERE Genre = 'Dystopian';

SELECT BookID, Title, Author, Genre, Price FROM Books WHERE Title LIKE '%Kill%';

-- Average price
SELECT AVG(Price) AS AveragePrice FROM Books;

-- Count Fiction books
SELECT COUNT(BookID) AS FictionCount FROM Books WHERE Genre = 'Fiction';

DROP TABLE Customers;

CREATE TABLE Customers (

    CustomerID INT PRIMARY KEY,

Name VARCHAR(50),

   Email VARCHAR(50),

   Phone VARCHAR(15)

);

DROP TABLE Sales;

CREATE TABLE Sales (

   SaleID INT PRIMARY KEY,

   BookID INT,

   CustomerID INT,

   Quantity INT,

   FOREIGN KEY (BookID) REFERENCES Books(BookID),

   FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)

);

INSERT INTO Customers (CustomerID, Name, Email, Phone) VALUES
(1, 'Alice Green', 'alice@email.com', '07123456789'),
(2, 'Bob White', 'bob@email.com', '07234567890');


INSERT INTO Sales (SaleID, BookID, CustomerID, Quantity) VALUES
(1, 1, 1, 2),
(2, 2, 2, 1);



SELECT Books.Title, SUM(Sales.Quantity * Books.Price) AS TotalRevenue
FROM Sales
JOIN Books ON Sales.BookID = Books.BookID
GROUP BY Books.Title;

ALTER TABLE Sales ADD COLUMN Quantity INTEGER;

UPDATE Sales SET Quantity = 2 WHERE SaleID = 1;
UPDATE Sales SET Quantity = 1 WHERE SaleID = 2;

SELECT Books.Title, Customers.Name, Sales.Quantity
FROM Sales
JOIN Books ON Sales.BookID = Books.BookID
JOIN Customers ON Sales.CustomerID = Customers.CustomerID
WHERE Customers.CustomerID = 1;









