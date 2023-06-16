--�bung: "MasterTable" erstellen
--CustomerID, CompanyName, OrderID, OrderDate, ProductName, "Umsatz"

CREATE VIEW vBestell_�bersicht 
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


SELECT * FROM vBestell_�bersicht

SELECT PositionsSumme FROM vBestell_�bersicht

SELECT PositionsSumme*1.1 FROM vBestell_�bersicht

CREATE VIEW vKundenDatenShort
AS
SELECT CustomerID, CompanyName, ContactName FROM Customers

SELECT * FROM vKundenDatenShort

SELECT DISTINCT CompanyName FROM vBestell_�bersicht

SELECT CAST(10000 as decimal(10,2))