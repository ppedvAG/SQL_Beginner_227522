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
WHERE PostalCode LIKE '[123EA]%'

-- "[a-z]" oder Gegenteil mit ^ [^a-z]

SELECT * FROM Customers
WHERE PostalCode LIKE '[^123]%'

SELECT * FROM Customers
WHERE PostalCode LIKE '[1-5 a-g]%'


-- LIKE 'M[eaiy][yai]%'


SELECT * FROM Customers
WHERE CompanyName LIKE '%''%'

SELECT * FROM Customers
WHERE CompanyName LIKE '%[%]%'



