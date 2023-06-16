--CASE Klausel: Wird im SELECT aufgerufen (wie eine Spalte); unterscheidet Fälle
--END nicht vergessen!

SELECT *,
CASE 
	WHEN UnitsInStock > 0 THEN 'Passt'
	WHEN UnitsInStock = 0 THEN 'Nachbestellen!'
	ELSE 'Fehler'
END as LagerCheck
FROM Products

SELECT *,
CASE 
	WHEN UnitsInStock > 0 THEN 'Passt'
	WHEN UnitsInStock = 0 AND Discontinued = 0 THEN 'Nachbestellen!'
	WHEN UnitsInStock = 0 AND Discontinued = 1 THEN 'Aus dem Sortiment'
	ELSE 'Fehler'
END as LagerCheck
FROM Products
ORDER BY LagerCheck

--Übung:
/*
ProductNames kategorisieren in A, B oder C, abhängig von verkaufter Anzahl (Quantity) über gesamten
Zeitraum der Firma
A > 1000
B = 500 - 1000
C < 500
Zu erwarten 77 Ergebniszeilen; Spalten: ProductName, Quantity aggregiert, "Kategorie" A/B/C
Benötigte Tabellen: Products & Order Details (oder unsere Master View)
*/

SELECT ProductName, SUM(Quantity) as GesamtQuantity,
CASE
	WHEN SUM(Quantity) > 1000 THEN 'A'
	WHEN SUM(Quantity) BETWEEN 500 AND 1000 THEN 'B'
	ELSE 'C'
END as KategorieABC
FROM Products
JOIN [Order Details] ON Products.ProductID = [Order Details].ProductID
GROUP BY ProductName
ORDER BY KategorieABC, GesamtQuantity DESC

/*
INTERSECT

EXCEPT
*/