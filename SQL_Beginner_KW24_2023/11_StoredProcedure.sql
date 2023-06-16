--Stored Procedure/gespeicherte Prozedur/benutzerdefinierter(userdefined) Prozedure


CREATE PROCEDURE spKundenVonLand @MeineVariable varchar(20)
AS
SELECT * FROM Customers
WHERE Country = @MeineVariable


EXEC spKundenVonLand Brazil

ALTER PROCEDURE spKundenVonLand @MeineVariable varchar(20) = 'Germany' --Default Wert für Variable
AS
SELECT * FROM Customers
WHERE Country = @MeineVariable

EXEC spKundenVonLand


ALTER PROCEDURE spKundenVonLand @Land varchar(20) = 'Germany', @Stadt varchar(50) --Default Wert für Variable
AS
SELECT * FROM Customers
WHERE Country = @Land AND City = @Stadt

EXEC spKundenVonLand France, Paris



--Variablen allgemein auch außerhalb von Prozeduren möglich, über DECLARE

DECLARE @var1 int, @var2 int

SET @var1 = 5 
SET @var2 = 7
SELECT @var1 * @var2

DECLARE @Land varchar(20)

SET @Land = (SELECT TOP 1 Country FROM Customers)
SELECT * FROM Customers
WHERE Country = @Land 


DECLARE @AVGFreight float = (SELECT AVG(Freight) FROM Orders)

SELECT * FROM Orders
WHERE Freight > @AVGFreight