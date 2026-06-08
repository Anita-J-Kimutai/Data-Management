-- Question 2

DROP TABLE Students; 
CREATE TABLE Students (
    name TEXT,
    sid TEXT,
    age INTEGER
);

CREATE TABLE Courses (
    cid TEXT,
    title TEXT,
    credits INTEGER
);

INSERT INTO Students VALUES
('Rose', 'S1', 25),
('Ann', 'S2', 26),
('Mali', 'S3', 28);

INSERT INTO Courses VALUES
('C1', 'Mathematics', 30),
('C2', 'IT', 4),
('C3', 'Physics', 3);

--Question 3

CREATE TABLE R (
    A INTEGER,
    B INTEGER,
    C INTEGER,
    D INTEGER
);

INSERT INTO R (A, B, C, D) VALUES
(5, 1, 2, 3),
(15, 4, 5, 6),
(20, 7, 8, 9);

SELECT * FROM R WHERE A > 10;

SELECT B, C FROM R;

SELECT B, C FROM R WHERE A > 10;

--Question 4

CREATE TABLE R (
    A INTEGER,
    B INTEGER
);

DROP TABLE S;
CREATE TABLE S (
    A INTEGER,
    B INTEGER
);

INSERT INTO R (A, B) VALUES
(1, 10),
(2, 20),
(3, 30);

INSERT INTO S (A, B) VALUES
(2, 20),
(3, 30),
(4, 40);

SELECT A, B FROM R UNION SELECT A, B FROM S;

SELECT A, B FROM R INTERSECT SELECT A, B FROM S;

SELECT A, B FROM R EXCEPT SELECT A, B FROM S;

--Question 5

SELECT R.A, R.B, S.A, S.B FROM R CROSS JOIN S;

DROP TABLE Students; 
CREATE TABLE Students (
    name TEXT,
    sid INTEGER,
    cid INTEGER
);

DROP TABLE Colleges; 
CREATE TABLE Colleges (
    cid INTEGER,
    cname TEXT
);

INSERT INTO Students (name, sid, cid) VALUES
('Alice', 1, 101),
('Bob', 2, 102),
('Charlie', 3, 103);

INSERT INTO Colleges (cid, cname) VALUES
(101, 'Engineering'),
(102, 'Science');

--Inner JOIN
SELECT
    Students.name, 
    Students.sid, 
    Students.cid, 
    Colleges.cname
FROM Students
INNER JOIN Colleges
ON Students.cid = Colleges.cid;

--LEFT JOIN

SELECT
    Students.name, 
    Students.sid, 
    Students.cid, 
    Colleges.cname
FROM Students
LEFT JOIN Colleges
ON Students.cid = Colleges.cid;

---Question 6
DROP TABLE Customers; 
CREATE TABLE Customers (
    cid INTEGER PRIMARY KEY,
    cname TEXT,
    city TEXT
);

DROP TABLE Accounts; 
CREATE TABLE Accounts (
    acc_no INTEGER PRIMARY KEY,
    cid INTEGER,
    balance REAL,
    FOREIGN KEY (cid) REFERENCES Customers(cid)
);

INSERT INTO Customers (cid, cname, city) VALUES
(1, 'Allan', 'London'),
(2, 'Billy', 'Chester'),
(3, 'Caren', 'Leeds');

INSERT INTO Accounts (acc_no, cid, balance) VALUES
(100, 1, 5300.0),
(101, 2, 1800.0),
(103, 3, 200.0);

SELECT cid, cname, city FROM Customers;
SELECT acc_no, cid, balance FROM Accounts;

--Update
UPDATE Accounts SET balance = balance + 500 WHERE cid = 1;


UPDATE Customers SET city = 'Manchester' WHERE cid = 2;

--Delete

DELETE FROM Accounts WHERE balance < 500;

DELETE FROM Customers WHERE cid = 3;

--Questions 7

SELECT
    Customers.cname,
    Accounts.acc_no,
    Accounts.balance
FROM Customers
INNER JOIN Accounts
ON Customers.cid = Accounts.cid;

------------------------------------


CREATE TABLE Loan (
    lid INTEGER,
    amount REAL
);

CREATE TABLE Borrower (
    cid INTEGER,
    lid INTEGER
);

INSERT INTO Loan (lid, amount) VALUES
(1, 5000),
(2, 7000),
(3, 3000);

INSERT INTO Borrower (cid, lid) VALUES
(1, 1),
(2, 2),
(4, 4);

SELECT
    Borrower.cid,
    Loan.lid,
    Loan.amount
FROM Borrower
INNER JOIN Loan
ON Borrower.lid = Loan.lid;

--Left JOIN
SELECT
    Borrower.cid,
    Loan.lid,
    Loan.amount
FROM Borrower
LEFT JOIN Loan
ON Borrower.lid = Loan.lid;

--Full OUTER JOIN
SELECT
    Borrower.cid,
    Loan.lid,
    Loan.amount
FROM Borrower
LEFT JOIN Loan
ON Borrower.lid = Loan.lid

UNION

SELECT 
    Borrower.cid,
    Loan.lid,
    Loan.amount
FROM Loan
LEFT JOIN Borrower
ON Loan.lid = Borrower.lid;














