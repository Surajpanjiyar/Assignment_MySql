CREATE DATABASE Shop;

SHOW DATABASES;

USE Shop; 

-- CREATED A SALES TABLE WITH DATA INPUT. 
 
CREATE TABLE SalesPeople (
    Snum INT PRIMARY KEY,
    Sname VARCHAR(255) UNIQUE,
    City VARCHAR(255),
    Comm DECIMAL(5, 2)
);

INSERT INTO SalesPeople (Snum, Sname, City, Comm) VALUES
(1001, 'Peel', 'London', 0.12),
(1002, 'Serres', 'San Jose', 0.13),
(1004, 'Motika', 'London', 0.11),
(1007, 'Rifkin', 'Barcelona', 0.15),
(1003, 'Axelrod', 'New York', 0.10);

-- CREATED A CUSTOMERS TABLE WITH DATA INPUT. 

CREATE TABLE Customers (
    Cnum INT PRIMARY KEY,
    Cname VARCHAR(255),
    City VARCHAR(255) NOT NULL,
    Snum INT,
    FOREIGN KEY (Snum) REFERENCES SalesPeople(Snum)
);

INSERT INTO Customers (Cnum, Cname, City, Snum) VALUES
(2001, 'Hoffman', 'London', 1001),
(2002, 'Giovanni', 'Rome', 1003),
(2003, 'Liu', 'San Jose', 1002),
(2004, 'Grass', 'Berlin', 1002),
(2006, 'Clemens', 'London', 1001),
(2008, 'Cisneros', 'San Jose', 1007),
(2007, 'Pereira', 'Rome', 1004);

-- CREATED A ORDERS TABLE WITH DATA INPUT. 

CREATE TABLE Orders (
    Onum INT PRIMARY KEY,
    Amt DECIMAL(8, 2),
    Odate DATE,
    Cnum INT,
    Snum INT,
    FOREIGN KEY (Cnum) REFERENCES Customers(Cnum),
    FOREIGN KEY (Snum) REFERENCES SalesPeople(Snum)
);

INSERT INTO Orders (Onum, Amt, Odate, Cnum, Snum) VALUES
(3001, 18.69, '1990-03-10', 2008, 1007),
(3003, 767.19, '1990-03-10', 2001, 1001),
(3002, 1900.10, '1990-03-10', 2007, 1004),
(3005, 5160.45, '1990-03-10', 2003, 1002),
(3006, 1098.16, '1990-03-10', 2008, 1007),
(3009, 1713.23, '1990-04-10', 2002, 1003),
(3007, 75.75, '1990-04-10', 2004, 1002),
(3008, 4273.00, '1990-05-10', 2006, 1001),
(3010, 1309.95, '1990-06-10', 2004, 1002),
(3011, 9891.88, '1990-06-10', 2006, 1001);

SHOW DATABASES ;

SELECT * FROM SalesPeople ;

SELECT * FROM Customers ;

SELECT * FROM Orders ;

-- Count the number of Salesperson whose name begin with ‘a’/’A’.

SELECT COUNT(*) AS NumberOfSalespeople
FROM SalesPeople
WHERE LOWER(Sname) LIKE 'a%';

-- Display all the Salesperson whose all orders worth is more than Rs. 2000.

SELECT S.*
FROM SalesPeople S
WHERE S.Snum NOT IN (
    SELECT O.Snum
    FROM Orders O
    GROUP BY O.Snum
    HAVING SUM(O.Amt) <= 2000
);

-- Count the number of Salesperson belonging to Newyork.

SELECT COUNT(*) AS NumberOfSalespeopleInNewYork
FROM SalesPeople
WHERE City = 'New York';

-- Display the number of Salespeople belonging to London and belonging to Paris.

SELECT City, COUNT(*) AS NumberOfSalespeople
FROM SalesPeople
WHERE City IN ('London', 'Paris')
GROUP BY City;

--  Display the number of orders taken by each Salesperson and their date of orders.

SELECT S.Sname AS SalespersonName, O.Onum AS OrderNumber, O.Odate AS OrderDate
FROM SalesPeople S
JOIN Orders O ON S.Snum = O.Snum
ORDER BY S.Sname, O.Odate;



