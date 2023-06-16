--Unterabfragen/Subqueries/nested Queries

--Welche Bestellungen haben einen Freight Wert der über dem AVG liegt?

SELECT * FROM Orders
WHERE Freight > AVG(Freight)

--Lösung: Subquerie!

SELECT * FROM Orders

--Subqueries müssen eigenständig ausführbar sein!

SELECT * FROM Orders
WHERE Freight > 78.2442

SELECT * FROM Orders
WHERE Freight > (SELECT AVG(Freight) FROM Orders)

--Unterabfragen in Klammern. SQL führt Abfragen von "innen nach außen" aus; d.h Unterabfragen zu erst, dann äußere Abfrage

SELECT * FROM Orders
WHERE Freight > (SELECT TOP 3 Freight FROM Orders)

SELECT * FROM Orders
WHERE Freight > 32.38, 11.61, 65.83

SELECT * FROM Orders
WHERE Freight IN (SELECT TOP 3 Freight FROM Orders)


--Funktioniert im SELECT

SELECT *, (SELECT AVG(Quantity) FROM [Order Details]) 
FROM [Order Details]

SELECT *, AVG(Quantity)
FROM [Order Details]

--Funktioniert auch im FROM


SELECT PositionsSumme
FROM 
(
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
) as t  --Alias vergeben!

--Im FROM braucht die Unterabfrage "einen Namen", also ein Alias




--TempTables oder temporäre Tabellen oder #Tables
--"Existieren" nur innerhalb dieser Session (Skript Fenster); Werden in tempdb zwischengespeichert
--Ergebnisse werden "abgespeichert", daher muss die Abfrage nur einmal ausgeführt werden
--> TempTables sehr schnell, aber unter Umständen nicht mehr mit aktuelle Daten

SELECT 
Customers.CustomerID, Customers.CompanyName, 
Orders.OrderID, Orders.OrderDate, Orders.Freight, 
Employees.LastName, 
Products.ProductName, 
[Order Details].UnitPrice, [Order Details].Quantity, [Order Details].Discount,
CAST(Quantity * [Order Details].UnitPrice * (1 - Discount) as decimal(10,2)) as PositionsSumme

INTO #TempTable 
FROM  
[Order Details] INNER JOIN
Products ON [Order Details].ProductID = Products.ProductID INNER JOIN
Orders ON [Order Details].OrderID = Orders.OrderID INNER JOIN
Customers ON Orders.CustomerID = Customers.CustomerID INNER JOIN
Employees ON Orders.EmployeeID = Employees.EmployeeID INNER JOIN
Shippers ON Orders.ShipVia = Shippers.ShipperID



--
SELECT CompanyName, SUM((Quantity * UnitPrice * (1 - Discount))) as Summe
INTO #t
FROM [Order Details] od
JOIN Orders o ON o.OrderID = od.OrderID
JOIN Customers c ON c.CustomerID = o.CustomerID
GROUP BY CompanyName

SELECT AVG(Summe) FROM #t

--Mit 2 ## ist es eine globale Temp Table, diese ist auch in anderen Sessions aufrufbar
SELECT * INTO ##GlobalTempTable FROM Customers

DROP TABLE #t


DROP TABLE IF EXISTS #t
DROP TABLE IF EXISTS #t2
DROP TABLE IF EXISTS #t3
--SQL Server 2019 Feature (IF EXISTS)

SELECT CompanyName, SUM((Quantity * UnitPrice * (1 - Discount))) as Summe
INTO #t
FROM [Order Details] od
JOIN Orders o ON o.OrderID = od.OrderID
JOIN Customers c ON c.CustomerID = o.CustomerID
GROUP BY CompanyName

