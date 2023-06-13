--Für ungenaue Filterung/Suche können wir LIKE verwenden (statt Vergleichsoperatoren)

SELECT ContactName FROM Customers
WHERE ContactTitle LIKE 'Manager'

--Wildcards

-- "%"-Zeichen: Beliebiges Symbol, beliebig viele davon

SELECT ContactName, ContactTitle FROM Customers
WHERE ContactTitle LIKE '%Manager%'


-- "_"-Zeichen: EIN beliebiges Symbol

SELECT * FROM Customers
WHERE CompanyName LIKE '_l%'

-- "[]"-Zeichen: Alles in den Klammern ist gültiges Symbol an dieser einen Stelle

SELECT * FROM Customers
WHERE PostalCode LIKE '[123]%'

-- "[a-z]" oder Gegenteil mit ^ [^a-z]

SELECT * FROM Customers
WHERE PostalCode LIKE '[^123]%'


-- LIKE 'M[eaiy][yai]%'

