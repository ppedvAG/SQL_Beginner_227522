--String Funktionen bzw. Text-Datentypen manipulieren


SELECT CompanyName, LEN(CompanyName) FROM Customers
--LEN gibt länge des Strings zurück (Anzahl Characters/Symbole) als int

SELECT LEFT(CompanyName, 5) FROM Customers
SELECT RIGHT(CompanyName, 5) FROM Customers
--LEFT/RIGHT geben die "linken" bzw. "rechten" x Zeichen eines Strings zurück

SELECT SUBSTRING(CompanyName, 5, 5), CompanyName FROM Customers
--SUBSTRING(Spalte, x, y) springt zu Position x in einem String und gibt y Zeichen zurück

SELECT STUFF(Phone, 5, 3, 'XXX') FROM Customers
--STUFF(Spalte, x, y, replace) ersetzt y Zeichen eines Strings ab Position x mit 'replace Wert' (optional)

SELECT STUFF(Phone, LEN(Phone) - 4, 5, 'XXXXX') FROM Customers

SELECT PATINDEX('%m%', CompanyName), companyname FROM Customers
--PATINDEX sucht nach 'Schema' (wie LIKE) in einem String und gibt Position aus,
--an der das Schema das erste mal gefunden wurde


SELECT CONCAT(FirstName, ' ', LastName, ' Supertyp') FROM Employees
SELECT FirstName + ' ' + LastName FROM Employees
--CONCAT fügt mehrere Strings in die selbe Spalte zusammen



--Datumsfunktionen

SELECT getdate() -- aktuelle Systemzeit mit Zeitstempel

SELECT getdate() + 5
SELECT * FROM Orders

SELECT DATEDIFF(day, '19930224', getdate()), DATEDIFF(DD, '19930224', getdate())
SELECT DATEDIFF(MONTH, '19930224', getdate()), DATEDIFF(MM, '19930224', getdate())
SELECT DATEDIFF(YEAR, '19930224', getdate()), DATEDIFF(YY, '19930224', getdate())
--DATEDIFF(interval, x, y): Zeitraum in gewünschtem Interval zwischen Datum x und y

SELECT DAY(OrderDate), Month(OrderDate), Year(OrderDate), OrderDate FROM Orders
--Kurzformen für die gängigsten DATEPART Intervalle

SELECT DATEPART(QUARTER, OrderDate) FROM Orders
SELECT DATEPART(YEAR, OrderDate) FROM Orders
-- Datepart gibt nur einen Teil/Interval eines Datums aus; fast alle Intervalle möglich

SELECT DATENAME(DW, OrderDate) FROM Orders
SELECT DATENAME(MONTH, OrderDate) FROM Orders
-- Ähnlich Datepart, nur Ergebnis als "Wort"/String (bspw. Montag oder Juli)

SELECT DATEADD(DAY, 14, getdate())
SELECT DATEADD(DAY, -14, getdate())
--addiert/subtrahiert ein Intervall von einem Datum


--Funktionen zu Datentypen

SELECT CAST(OrderDate as date) FROM Orders
--CAST(Spalte as neuer Datentyp): ändert Datentyp in der Ausgabe

SELECT CONVERT(varchar(20), OrderDate, 104) FROM Orders
--Ähnlich wie CAST; optionales drittes Argument "DateStyle" zur Formattierung eines Datums

SELECT FORMAT(10000, 'c', 'de')

SELECT format(12345686.25, 'N', 'de-de')
--Konvertiert eine Zahl in einen String, mit 1000er Trennzeichen

SELECT ISNULL(Fax, 'n/a') FROM Customers
--Prüft Spalte auf NULL Werte und ersetzt diese mit gewünschtem Wert


--Übungen:

-- 1. Alle Bestellungen(Orders) aus Q2 in 1997

SELECT * FROM Orders
WHERE DATEPART(YEAR, OrderDate) = 1997 AND DATEPART(QUARTER, OrderDate) = 1

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


SELECT 
f, f, f, f, f, f, f
FROM 

WHERE AND OR 

GROUP BY , , , 
ORDER BY , , ,

DATEPART
DATEDIFF
DAY
CAST(1, 2, 3)


SELECT Customers.City FROM Customers

SELECT * FROM [Order Details]

