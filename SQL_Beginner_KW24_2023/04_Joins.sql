--Problem: Produkte nach Kategorie "Beverages" filtern

SELECT * FROM Categories --Zwischenschritt: Welche ID hat "Beverages"?
SELECT * FROM Products
WHERE CategoryID = 1

--Besser: Lösung mit nur einer Abfrage über Joins

/* 
Join Syntax:
SELECT * FROM Tabelle A
JOIN Tabelle B ON A.Spalte1 = B.Spalte1
*/

--Generelles Join Beispiel:
SELECT ProductName FROM Products
INNER JOIN Categories ON Products.CategoryID = Categories.CategoryID
WHERE CategoryName = 'Beverages'

--Übung: Bestellungen die Herr King bearbeitet hat
SELECT * FROM Orders as o
JOIN Employees as e ON o.EmployeeID = e.EmployeeID
WHERE LastName = 'King'


--Bisher: INNER Join



--OUTER Joins: LEFT/RIGHT und FULL OUTER

--LEFT:
SELECT * 
FROM Orders as o LEFT JOIN Customers as c ON o.CustomerID = c.CustomerID

--RIGHT:
SELECT * 
FROM Orders as o RIGHT JOIN Customers as c ON o.CustomerID = c.CustomerID

--FULL OUTER:
SELECT * 
FROM Orders as o FULL OUTER JOIN Customers as c ON o.CustomerID = c.CustomerID


--JOIN "invertieren", d.h. keine Schnittmenge anzeigen, durch filtern nach NULL:
SELECT * 
FROM Orders as o RIGHT JOIN Customers as c ON o.CustomerID = c.CustomerID
WHERE o.OrderID IS NULL


--3. Join Art: CROSS JOIN, erstellt kathesisches Produkt zweier Tabellen (A x B)
SELECT * FROM Orders CROSS JOIN Customers


--SELF JOIN (eigentlich INNER JOIN):
SELECT e1.EmployeeID, e1.Lastname as Vorgesetzter, e2.EmployeeID, e2.LastName as Angestellter 
FROM Employees as e1 RIGHT JOIN Employees as e2 ON e1.EmployeeID = e2.ReportsTo
--nützlich für hierarchische Beziehungen innerhalb einer Tabelle

--Übungen:

--1. Welche Produkte (Produktnamen) hat "Leverling" bisher verkauft?
--Employees - Orders - Order Details - Products

SELECT DISTINCT ProductName, LastName FROM Employees e
JOIN Orders o ON e.EmployeeID = o.EmployeeID
JOIN [Order Details] od ON od.OrderID = o.OrderID
JOIN Products p ON p.ProductID = od.ProductID
WHERE LastName = 'Leverling'

--2. Wieviele Bestellungen haben Kunden aus Argentinien aufgegeben? (Anzahl OrderIDs bzw. Anzahl Ergebniszeilen)
--Customers - Orders

SELECT OrderID --COUNT(OrderID) 
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE Country = 'Argentina'

--3. Was war die größte Bestellmenge (Quantity) von Chai Tee (ProductName = 'Chai')?
--Order Details - Products

SELECT TOP 1 ProductName, Quantity FROM Products p 
JOIN [Order Details] od ON p.ProductID = od.ProductID
WHERE ProductName = 'Chai'
ORDER BY Quantity DESC

/*
SELECT MAX(Quantity) FROM Products p 
JOIN [Order Details] od ON p.ProductID = od.ProductID
WHERE ProductName = 'Chai'
*/

/*
Join "Reihenfolge":

1. FROM Tabelle A JOIN Tabelle B

2. FROM Tabelle AB JOIN Tabelle C

3. FROM Tabelle ABC LEFT JOIN Tabelle D

*/
/*

1. Normalform (NF): Atomare Werte

2. NF: Eindeutige Datensätze (ID Spalten verwenden)
--> Primärschlüssel (Primary Key) (zusammengesetzter Primärschlüssel)
*/
SELECT * FROM Orders
/*

3. NF: Für "logische Einheiten" eigene Tabellen anlegen und mit Fremdschlüsseln (Foreign Key) versehen

*/


SELECT * 
FROM Orders
INNER JOIN Employees ON Orders.EmployeeID = Employees.EmployeeID

SELECT * 
FROM Orders
INNER JOIN Employees ON Employees.EmployeeID = Orders.EmployeeID
INNER JOIN Customers ON Customers.CustomerID = Orders.CustomerID

SELECT * 
FROM Orders
INNER JOIN Customers ON Customers.CustomerID = Orders.CustomerID
INNER JOIN Employees ON Employees.EmployeeID = Orders.EmployeeID


--Übungen:

--Alle Produkte mit ihrer jeweiligen Kategoriebezeichnung

SELECT ProductName, CategoryName FROM Products
INNER JOIN Categories ON Products.CategoryID = Categories.CategoryID


--Welche Bestellungen (Orders) wurden mit dem Speditionsunternehmen (Shippers) 'Speedy Express' versandt?
--Beziehung Shippers (ShipperID) zu Orders (ShipVia)

SELECT Orders.* FROM Shippers
INNER JOIN Orders ON Shippers.ShipperID = Orders.ShipVia
WHERE CompanyName = 'Speedy Express'


SELECT Orders.* FROM Shippers as Ship
INNER JOIN Orders ON Ship.ShipperID = Orders.ShipVia
WHERE CompanyName = 'Speedy Express'

SELECT Orders.* FROM Shippers
INNER JOIN Orders ON ShipperID = ShipVia
WHERE CompanyName = 'Speedy Express'


--Übung: "MasterTable" erstellen
--CustomerID, CompanyName, OrderID, OrderDate, ProductName, "Umsatz"

CREATE VIEW vBestell_Übersicht 
AS
SELECT 
Customers.CustomerID, Customers.CompanyName, 
Orders.OrderID, Orders.OrderDate, Orders.Freight, 
Employees.LastName, 
Products.ProductName, 
[Order Details].UnitPrice, [Order Details].Quantity, [Order Details].Discount,
CAST(Quantity * [Order Details].UnitPrice * (1 - Discount) as decimal(10,2)) as PositionsSumme
FROM  [Order Details] INNER JOIN
Products ON [Order Details].ProductID = Products.ProductID INNER JOIN
Orders ON [Order Details].OrderID = Orders.OrderID INNER JOIN
Customers ON Orders.CustomerID = Customers.CustomerID INNER JOIN
Employees ON Orders.EmployeeID = Employees.EmployeeID INNER JOIN
Shippers ON Orders.ShipVia = Shippers.ShipperID


SELECT * FROM vBestell_Übersicht

SELECT PositionsSumme FROM vBestell_Übersicht

SELECT PositionsSumme*1.1 FROM vBestell_Übersicht

CREATE VIEW vKundenDatenShort
AS
SELECT CustomerID, CompanyName, ContactName FROM Customers

SELECT * FROM vKundenDatenShort

SELECT DISTINCT CompanyName FROM vBestell_Übersicht

SELECT CAST(10000 as decimal(10,2))

