USE Northwind
--Ergebniszeilen filtern mit WHERE

SELECT * FROM Customers
WHERE Country = 'Germany'

SELECT * FROM Customers
WHERE Country = ' Germany'

-- = wird nach exakten Treffern gefiltert

SELECT * FROM Orders
WHERE Freight = 100

-- alle boolschen Vergleichsoperatoren verwenden, >, <, >=, <=, != bzw. <>

SELECT * FROM Orders
WHERE Freight > 500

SELECT * FROM Customers
WHERE Country != 'Germany'


-- Kombinieren von WHERE Ausdrücken mit AND oder OR
SELECT * FROM Customers
WHERE Country = 'Germany' AND City = 'Berlin'

SELECT * FROM Customers
WHERE Country = 'Germany' OR City = 'Berlin'

--AND = "Beide" Ausdrücke müssen "wahr" sein (true oder 1)
--OR = Ein Ausdruck muss wahr sein
--Können beliebig viele kombiniert werden

--"Vorsicht" bei Kombination aus AND und OR

SELECT * FROM [Customers]
WHERE (City = 'Paris' OR City = 'Berlin') AND [Country] = 'Germany'


--AND "ist stärker bindent" als OR; Notfalls Klammern setzen!


SELECT * FROM Orders
WHERE Freight > 100 AND Freight < 500

--Alternativ mit BETWEEN, Randwerte mit inbegriffen
SELECT * FROM Orders
WHERE Freight BETWEEN 100 AND 500


SELECT * FROM Customers
WHERE Country = 'Brazil' OR Country = 'Germany' OR Country = 'France'

--Alternativ IN (Wert1, Wert2, usw....)

SELECT * FROM Customers
WHERE Country IN ('Brazil', 'Germany', 'France')

--IN verbindet mehrere OR Bedingungen die sich auf die selbe Spalte beziehen


-- Übungen:

--1. Alle Contactnames die als Title "Owner" haben

SELECT ContactName, ContactTitle FROM Customers
WHERE ContactTitle = 'Owner'

--2. Alle Order Details die ProductID 43 bestellt haben

SELECT * FROM [Order Details]
WHERE ProductID = 43

--3. Alle Kunden aus Paris, Berlin, Madrid und Brazilien

SELECT * FROM Customers
WHERE City IN ('Paris', 'Berlin', 'Madrid') OR Country = 'Brazil'

-- 4. Alle Produkte der Category "Beverages"

SELECT * FROM Categories
SELECT * FROM Products
WHERE CategoryID = 1

/*
SELECT * FROM [Products by Category]
WHERE CategoryName = 'Beverages'
*/

SELECT * FROM Products

--"Bonus": Alle Ansprechpartner deren Titel "Manager" beinhaltet
--Tabelle Customers ContactName/Title

SELECT ContactName, ContactTitle FROM Customers
WHERE ContactTitle = 'Manager'

--"Bonus/Problem2": Alle Kunden die eine Fax Nummer haben
--LIKE Klausel benötigt
SELECT * FROM Customers

--Filtern mit/nach NULL Werten:
--NULL bedeutet KEIN wert eingetragen, nicht dasselbe wie " " Leerzeichen

SELECT * FROM Customers
WHERE Fax IS NULL

SELECT * FROM Customers
WHERE Fax IS NOT NULL