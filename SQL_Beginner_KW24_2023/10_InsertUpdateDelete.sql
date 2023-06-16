--SELECT INTO: Kopie erstellen in neuer Tabelle

SELECT * INTO BackupCustomers
FROM Customers

SELECT * FROM BackupCustomers

SELECT OrderID INTO OrderTest FROM Orders

SELECT * FROM OrderTest


--Tabellen l�schen mit DROP TABLE

DROP TABLE OrderTest
--DROP DATABASE Northwind
DROP VIEW


--Neue Datens�tze hinzuf�gen mit INSERT INTO

INSERT INTO Customers
VALUES (

INSERT INTO Customers (CustomerID, CompanyName, City, Country)
VALUES ('PPEDV', 'ppedv AG', 'Burghausen', 'Germany')

SELECT * FROM Customers

INSERT INTO Orders (CustomerID, EmployeeID, OrderDate)
VALUES ('PPEDV', 5, getdate())

SELECT * FROM ORders WHERE CustomerID = 'PPEDV'


INSERT INTO Orders (CustomerID, EmployeeID, OrderDate)
VALUES
('PPEDV', 5, getdate()),
('PPEDV', 1, getdate()),
('PPEDV', 2, getdate()),
('PPEDV', 8, getdate())


--UPDATE: �ndert Werte von Zellen eines Datensatzes (oder mehrerer Datens�tze gleichzeitig!)
--Vorsicht! Where Filter nicht vergessen, sonst werden alle Datens�tze ge�ndert!

UPDATE Customers
SET ContactName = 'Nico'
WHERE CustomerID = 'PPEDV'

SELECT * FROM Customers
WHERE Country = 'Germany'

UPDATE Customers
SET City = 'Berlin'
WHERE Country = 'Germany'

--Begin TRAN versetzt uns in eine Art "Freeze Zustand"
BEGIN TRAN

UPDATE Customers
SET City = 'Bonn'
WHERE Country = 'Germany'

ROLLBACK --Macht Transaktion r�ckg�ngig
COMMIT --Best�tigt Transaktion und schreibt auf die DB

SELECT @@TRANCOUNT --Gibt aktuelles Transaktionslevel aus; 0 = keine Transaktion

SELECT * FROM Customers


UPDATE Customers
SET City = 'Bonn'
WHERE Country = 'Germany'

--Tipp: Vorher mit einem SELECT Befehl pr�fen, ob die richtigen Zeilen "getroffen" werden
SELECT * FROM 
UPDATE Customers
SET City = 'Bonn'
WHERE Country = 'Germany'


UPDATE Customers
SET ContactName = NULL
WHERE CustomerID = 'PPEDV'


--DELETE FROM l�scht komplette Datens�tze
--Vorsicht! Where Filter nicht vergessen, sonst werden alle Datens�tze gel�scht!

DELETE FROM Customers
WHERE CustomerID = 'PPEDV'

DROP TABLE Customers

--CREATE TABLE um neuee Tabelle zu erstellen

CREATE TABLE Fuhrpark
(
AutoID int NOT NULL,
Modell varchar(20) NULL,
EmployeeID int NOT NULL
)


ALTER TABLE Fuhrpark
ADD PRIMARY KEY (AutoID)

DROP TABLE Fuhrpark

CREATE TABLE Fuhrpark
(
AutoID int identity(10000,1) NOT NULL PRIMARY KEY,
Modell varchar(20) NULL,
EmployeeID int NOT NULL
)

--Erstellen eines Foreign Keys, bzw. einer Relation zwischen 2 Tabellen:
ALTER TABLE Fuhrpark
ADD CONSTRAINT FK_Fuhrpark_Employees
FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)

INSERT INTO Fuhrpark
VALUES ('Audi A4', 1)
INSERT INTO Fuhrpark
VALUES ('3er BMW', 5)

SELECT * FROM Fuhrpark
RIGHT JOIN Employees ON Fuhrpark.EmployeeID = Employees.EmployeeID
