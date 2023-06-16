--Aggregat Funktionen

SELECT MIN(Freight), MAX(Freight), SUM(Freight), COUNT(Freight), AVG(Freight) FROM Orders

SELECT COUNT(Fax) FROM Customers
--Count zählt keine NULL Werte
SELECT COUNT(*) FROM Customers

--AVG kann auch so ausgedrückt werden:
SELECT SUM(freight) / COUNT(Freight) FROM Orders

--Aggregate funktionieren "einfach", wenn sonst keine anderen, nicht-Aggregat Spalten, aufgerufen werden


SELECT SUM(PositionsSumme) as GesamtUmsatz FROM vBestell_Übersicht
WHERE DATEPART(QUARTER, Orderdate) = 2 AND DATEPART(YEAR, Orderdate) = 1997


--Sobald andere Spalten im SELECT dazukommen, müssen wir Gruppieren mit GROUP BY:

SELECT CompanyName, SUM(PositionsSumme) FROM vBestell_Übersicht
GROUP BY CompanyName

SELECT CompanyName, SUM(PositionsSumme) as UmsatzSumme, LastName, ProductName FROM vBestell_Übersicht
GROUP BY CompanyName, LastName, ProductName
ORDER BY CompanyName

SELECT CompanyName, 
SUM(PositionsSumme) as UmsatzSumme,
CAST(AVG(PositionsSumme) as decimal(10,2)) as AvgPositionsSumme
FROM vBestell_Übersicht
GROUP BY CompanyName
ORDER BY UmsatzSumme

SELECT CompanyName, Country, City, SUM(PositionsSumme) as Umsatz FROM vBestell_Übersicht
GROUP BY Country, CompanyName, City
ORDER BY 2 DESC

SELECT OrderID, CompanyName, Country, City, SUM(PositionsSumme) as Umsatz FROM vBestell_Übersicht
GROUP BY OrderID, CompanyName, Country, City
ORDER BY 2 DESC

--Tipp: "Alles was kein Aggregat ist im SELECT --> Copy+Paste in die GROUP BY Klausel

--Es können nur Gruppen gebildet werden, wenn ALLE Spalten im SELECT den selben Wert haben
--(Vergleiche DISTINCT)

--Übungen:

--1. GesamtUmsatz pro Land (Customers.Country) + SUM(PositionSumme)
SELECT vBestell_Übersicht.*, Customers.Country FROM vBestell_Übersicht
JOIN Customers ON vBestell_Übersicht.CompanyName = Customers.CompanyName

SELECT Country, CAST(SUM(Quantity*UnitPrice*(1-Discount)) as decimal(10,2)) as UmsatzSumme FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
JOIN [Order Details] ON [Order Details].OrderID = Orders.OrderID
GROUP BY Country

SELECT Country, SUM(PositionsSumme) FROM vBestell_Übersicht
GROUP BY Country

--2. GesamtUmsatz pro Mitarbeiter (Employee LastName)
SELECT LastName, SUM(PositionsSumme) FROM vBestell_Übersicht
GROUP BY LastName

--3. Welches Produkt wurde 1997 am meisten verkauft? (ProductName, Quantity, OrderDate1997)
--Zusatz: Ist das Produkt mit dem größten UMSATZ in 1997 das selbe?
--Quantity: Pate chinoir, chartreuse verte x2, Gnocchi iwas
--Umsatz: chateu de playe
SELECT TOP 1 ProductName, SUM(Quantity) as BestellMenge FROM vBestell_Übersicht
--WHERE OrderDate BETWEEN '19970101' AND '19971231'
WHERE DATEPART(YEAR, OrderDate) = 1997
GROUP BY ProductName
ORDER BY BestellMenge DESC

--Falsch:
SELECT ProductName, MAX(Quantity) as BestellMenge FROM vBestell_Übersicht
WHERE DATEPART(YEAR, OrderDate) = 1997
GROUP BY ProductName
ORDER BY BestellMenge DESC

--Falsch:
SELECT ProductName, Quantity as BestellMenge FROM vBestell_Übersicht
WHERE DATEPART(YEAR, OrderDate) = 1997
GROUP BY ProductName, Quantity
ORDER BY BestellMenge DESC

--4. Spediteure (Shippers): Jahrweise Aufstellung der Anzahl von Orders und der 
--durchschnittlichen Lieferkosten (Freight); Beziehung zu Shippers über "ShipVia" in Orders
/* Ergebnis in etwa so:
Spediteur  Geschäftsjahr, AnzOrders, AvgFreight
Shipper1  1996 		, x		   , y
Shipper2  1996 		, x		   , y
Shipper3  1996 		, x		   , y
Shipper1  1997 		, x		   , y
Shipper2  1997 		, x		   , y
Shipper3  1997 		, x		   , y
*/


SELECT
CompanyName,
DATEPART(YEAR, ShippedDate) as GeschäftsJahr,
COUNT(*) as AnzBestellungen_WasAuchImmerDuWillst,
AVG(Freight) as AvgFreight
FROM Orders
JOIN Shippers ON Shippers.ShipperID = Orders.ShipVia
WHERE DATEPART(YEAR, ShippedDate) IS NOT NULL
GROUP BY CompanyName, DATEPART(YEAR, ShippedDate)
ORDER BY GeschäftsJahr, AnzBestellungen_WasAuchImmerDuWillst DESC

SELECT * FROM Orders


--Vorsicht: Wenn Order Details als Quelle verwendet wird, falsche Werte!
SELECT
SpediteurCompanyName,
DATEPART(YEAR, OrderDate) as GeschäftsJahr,
--COUNT(*) as AnzBestellungen_WasAuchImmerDuWillst,
AVG(Freight) as AvgFreight
FROM vBestell_Übersicht
WHERE DATEPART(YEAR, OrderDate) IS NOT NULL
GROUP BY SpediteurCompanyName, DATEPART(YEAR, OrderDate)
ORDER BY GeschäftsJahr DESC



--Welche Bestellungen haben einen Freight Wert der über dem AVG liegt?

SELECT * FROM Orders
WHERE Freight > AVG(Freight)


--HAVING Klausel: Funktioniert genau wie WHERE, nur dass Gruppen/aggregierte Werte gefiltert werden
--steht syntaktisch nach GROUP BY

--Alle Kunden die mehr als 100.000€ insgesamt umgesetzt haben

SELECT CompanyName, SUM(PositionsSumme) FROM vBestell_Übersicht
GROUP BY CompanyName
HAVING SUM(PositionsSumme) > 100000


SELECT Country, SUM(PositionsSumme) FROM vBestell_Übersicht
GROUP BY Country
HAVING Country IN ('Germany', 'Austria', 'Switzerland')

SELECT Country, SUM(PositionsSumme) FROM vBestell_Übersicht
WHERE Country IN ('Germany', 'Austria', 'Switzerland')
GROUP BY Country
HAVING SUM(PositionsSumme) > 100000

--HAVING NUR verwenden, wenn auch wirklich gruppierte Werte gefilter werden!
--Sonst wenn möglich IMMER mit WHERE filtern!

