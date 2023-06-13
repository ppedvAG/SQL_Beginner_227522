--String Funktionen bzw. Text-Datentypen manipulieren


SELECT CompanyName, LEN(CompanyName) FROM Customers

SELECT LEFT(CompanyName, 5) FROM Customers
SELECT RIGHT(CompanyName, 5) FROM Customers

SELECT SUBSTRING(CompanyName, 5, 5), CompanyName FROM Customers

SELECT STUFF(Phone, 5, 3, 'XXX') FROM Customers

SELECT STUFF(Phone, LEN(Phone) - 4, 5, 'XXXXX') FROM Customers

SELECT PATINDEX('%m%', CompanyName), companyname FROM Customers



--Datumsfunktionen

SELECT getdate() -- aktuelle Systemzeit mit Zeitstempel

SELECT getdate() + 5
SELECT * FROM ORders

SELECT DATEDIFF(day, '19930224', getdate()), DATEDIFF(DD, '19930224', getdate())
SELECT DATEDIFF(MONTH, '19930224', getdate()), DATEDIFF(MM, '19930224', getdate())
SELECT DATEDIFF(YEAR, '19930224', getdate()), DATEDIFF(YY, '19930224', getdate())
-- Zeitraum in Interval x zwischen 2 Daten

SELECT DAY(OrderDate), Month(OrderDate), Year(OrderDate), OrderDate FROM Orders

SELECT DATEPART(QUARTER, OrderDate) FROM Orders
SELECT DATEPART(YEAR, OrderDate) FROM Orders
-- Datepart gibt nur einen Teil/Interval eines Datums aus; fast alle Intervalle möglich

SELECT DATENAME(DW, OrderDate) FROM Orders
SELECT DATENAME(MONTH, OrderDate) FROM Orders
-- Ähnlich Datepart, nur Ergebnis als "Wort"/String

SELECT DATEADD(DAY, 14, getdate())
SELECT DATEADD(DAY, -14, getdate())
--addiert/subtrahiert ein Intervall von einem Datum


--Funktionen zu Datentypen

SELECT CAST(OrderDate as date) FROM Orders

SELECT CONVERT(varchar(20), OrderDate, 104) FROM Orders

SELECT FORMAT(10000, 'c', 'de')

--Übungen:

-- 1. Alle Bestellungen(Orders) aus Q2 in 1997

SELECT * FROM Orders
WHERE DATEPART(YEAR, OrderDate) = 1997 AND DATEPART(QUARTER, OrderDate) = 2

SELECT * FROM Orders
WHERE OrderDate BETWEEN '19970401' AND '19970630'

-- 2. Alle Produkte(ProductName) die um Weihnachten herum (+- 10 Tage) in 1996 verkauft wurden
--   (Alternativ im Dezember 1996)

SELECT ProductName FROM Products
JOIN [Order Details] ON Products.ProductID = [Order Details].ProductID
JOIN Orders ON Orders.OrderID = [Order Details].OrderID
WHERE OrderDate BETWEEN '19961214' AND '19970103'

SELECT Products.ProductID, ProductName FROM Products
JOIN [Order Details] ON Products.ProductID = [Order Details].ProductID
JOIN Orders ON Orders.OrderID = [Order Details].OrderID
WHERE OrderDate BETWEEN '19961214' AND '19970103'



--Alternativ 1:
SELECT ProductName
,OrderDate
FROM Products p
JOIN [Order Details] od ON p.ProductID = od.ProductID
JOIN Orders o ON od.OrderID = o.OrderID
WHERE DATEDIFF(day, '19961224', OrderDate) >= -10
AND DATEDIFF(day, '19961224', OrderDate) <= 10

--Alternativ 2:
SELECT ProductName
,OrderDate
FROM Products p 
JOIN [Order Details] od ON p.ProductID = od.ProductID
JOIN Orders o ON od.OrderID = o.OrderID
WHERE DATEDIFF(day, '19961224', OrderDate) BETWEEN -10 AND 10

--Für Dezember:
SELECT ProductName FROM Products
JOIN [Order Details] ON Products.ProductID = [Order Details].ProductID
JOIN Orders ON Orders.OrderID = [Order Details].OrderID
WHERE DATEPART(MONTH, OrderDate) = 12 AND DATEPART(YEAR, OrderDate) = 1996

--Alternativ
SELECT ProductName FROM Products
JOIN [Order Details] ON Products.ProductID = [Order Details].ProductID
JOIN Orders ON Orders.OrderID = [Order Details].OrderID
WHERE DATEPART(YEAR, OrderDate) = 1996 AND DATENAME(Month, OrderDate) = 'Dezember'


-- 3. Hatten wir Bestellungen mit Lieferverzögerungen? Wenn ja, wieviele Tage?
-- Lieferverzögerung = RequiredDate zu ShippedDate in Tabelle Orders

SELECT OrderID, 
DATEDIFF(DAY, RequiredDate, ShippedDate) as Lieferverzögerung,
ShippedDate,
RequiredDate
FROM Orders
WHERE DATEDIFF(DAY, RequiredDate, ShippedDate) > 0 
ORDER BY Lieferverzögerung DESC

SELECT OrderID, 
DATEDIFF(DAY, RequiredDate, ISNULL(ShippedDate, getdate())) as Lieferverzögerung,
ShippedDate,
RequiredDate
FROM Orders
WHERE DATEDIFF(DAY, RequiredDate, ISNULL(ShippedDate, getdate())) > 0 
ORDER BY Lieferverzögerung DESC


SELECT * FROM Orders
WHERE ShippedDate IS NULL
