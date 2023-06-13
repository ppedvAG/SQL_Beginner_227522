--Aggregat Funktionen

SELECT MIN(Freight), MAX(Freight), SUM(Freight), COUNT(Freight), AVG(Freight) FROM Orders

--AVG kann auch so ausgedr�ckt werden:
SELECT SUM(freight) / COUNT(Freight) FROM Orders


SELECT SUM(PositionsSumme) as GesamtUmsatz FROM vBestell_�bersicht
WHERE DATEPART(QUARTER, Orderdate) = 2 AND DATEPART(YEAR, Orderdate) = 1997


SELECT CompanyName, SUM(PositionsSumme) FROM vBestell_�bersicht
GROUP BY CompanyName

SELECT CompanyName, SUM(PositionsSumme) as UmsatzSumme, LastName, ProductName FROM vBestell_�bersicht
GROUP BY CompanyName, LastName, ProductName
ORDER BY CompanyName

SELECT CompanyName, 
SUM(PositionsSumme) as UmsatzSumme,
CAST(AVG(PositionsSumme) as decimal(10,2)) as AvgPositionsSumme
FROM vBestell_�bersicht
GROUP BY CompanyName
ORDER BY UmsatzSumme

SELECT CompanyName, Country, City SUM(PositionsSumme) as Umsatz FROM vBestell_�bersicht
GROUP BY Country, CompanyName, City
ORDER BY 2 DESC

SELECT OrderID, CompanyName, Country, City, SUM(PositionsSumme) as Umsatz FROM vBestell_�bersicht
GROUP BY Country, CompanyName, City, OrderID
ORDER BY 2 DESC


