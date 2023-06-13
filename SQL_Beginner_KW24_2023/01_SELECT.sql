--USE Datenbankname wechselt angesprochene Datenbank
--Alternativ "oben links" im Drop-Down Menü richtige DB auswählen

USE Northwind



--Ist ein einzeiliger Kommentar

/*
Mehrzeiliger Kommentar
bis wieder
geschlossen wird mit */


--SELECT: wählt Spalten aus, die im Ergebnisfenster angezeigt werden sollen

SELECT * FROM Customers -- * = alle Spalten in der angesprochenen Tabelle

--"Custom"-Werte und mathematische Operationen ebenfalls möglich

SELECT 100

SELECT 'Hallo!'

SELECT 'Hallo', 100

SELECT 100 + 5, 7 * 8

-- Nur einzelne "Sachen" ausführen: Zeile(n) markieren, ausführen F5 oder STRG+E



SELECT CompanyName, Country FROM Customers

SeLeCt			CoUNTRY,

    CompanyName
	FROm CusTOMERS

--SQL ist NICHT case-sensitive, Formatierung spielt keine Rolle, keine semicolons nötig

SELECT * FROM [Order Details]



-- Sortieren mit ORDER BY

SELECT * FROM Customers
ORDER BY City

-- Absteigend sortieren mit DESC

SELECT * FROM Customers
ORDER BY City DESC

-- Auch mehrere Spalten gleichzeitig möglich, DESC bezieht sich immer nur 
-- auf eine Spalte!

SELECT * FROM Customers
ORDER BY City DESC, CompanyName DESC



-- TOP x gibt nur die ersten x Zeilen aus

SELECT TOP 10 * FROM Customers
SELECT TOP 1000 * FROM Customers

-- TOP X PERCENT
SELECT TOP 10 PERCENT * FROM Customers 

SELECT TOP 10 * FROM Customers
ORDER BY CustomerID DESC

-- "BOTTOM" X existiert nicht, Ergebnisse einfach "umdrehen" mit ORDER BY


SELECT TOP 10 * FROM Orders
ORDER BY Freight DESC

SELECT TOP 10 * FROM Orders
ORDER BY Freight 

-- Duplikate "filtern" mit SELECT DISTINCT
-- Filtert alle Ergebnisse/Datensätze deren Werte exakt gleich sind

SELECT DISTINCT City FROM Customers

SELECT DISTINCT City, Country FROM Customers

SELECT DISTINCT * FROM Customers


-- UNION führt mehrere Ergebnistabellen vertikal in eine Tabelle zusammen
-- UNION macht automatisch ein DISTINCT mit
-- Spaltenanzahl muss gleich sein, Datentypen müssen kompatibel sein

SELECT * FROM Customers
UNION
SELECT * FROM Customers

-- mit UNION ALL wird KEIN Distinct ausgeführt

SELECT * FROM Customers
UNION ALL
SELECT * FROM Customers

SELECT 100, 'Hallo'
UNION
SELECT 'Tschüss', 5

SELECT 100, 'Hallo'
UNION
SELECT 5.5, 'Tschüss'


-- Spalten "umbenennen" über Aliase bzw. "as"

SELECT 100 as Zahl, 'Hallo' as Begrüßung

SELECT City as Stadt FROM Customers

-- Aliase können auch für Tabellennamen vergeben werden

SELECT * FROM Customers as cus



/*
SELECT * FROM sys.tables
SELECT * FROM sys.columns
*/