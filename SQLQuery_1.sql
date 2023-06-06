-- 1. Mostrar el contenido de la tabla Person, del esquema Person.

SELECT * 
from AdventureWorks2019.Person.Person

-- 2. Mostrar los nombres y apelllido de cada persona que tenga como tratamiento “Ms.”

/* 
SELECT FirstName, MiddleName, LastName, Title
FROM AdventureWorks2019.Person.Person
WHERE Title = 'Ms.'
*/

-- 3. Mostrar el Id y apellido de las personas que se los llame como “Mr.” y su apellido sea “White”.

--SELECT BusinessEntityId, LastName, Title
--FROM AdventureWorks2019.Person.Person
--WHERE Title = 'Mr.' and LastName = 'White'

-- 4. ¿Cuáles son los tipos de personas existentes en la tabla?

-- SELECT DISTINCT PersonType 
-- from AdventureWorks2019.Person.Person

-- 5. Mostrar los datos de las personas que tengan asignado el tipo “SP” o el tipo “VC”.

-- SELECT *
-- FROM AdventureWorks2019.Person.Person
-- WHERE PersonType = 'SP' or PersonType = 'VC'

-- 6. Mostrar el contenido de la tabla Employee, del esquema HumanResources

-- SELECT *
-- FROM AdventureWorks2019.HumanResources.Employee

-- 7. Hallar el Id y fecha de nacimiento de los empleados que tengan como función “Research and
-- Development Manager” y que tengan menos de 10 “VacationHours”.

-- SELECT BusinessEntityID, BirthDate, JobTitle, VacationHours
-- FROM AdventureWorks2019.HumanResources.Employee
-- WHERE JobTitle = 'Research and Development Manager' and 'VacationHours' < '10'

-- NO HAY!!!! --

-- 8. ¿Cuáles son los tipos de “género” que figuran en la tabla de empleados?

-- SELECT DISTINCT Gender 
-- from AdventureWorks2019.HumanResources.Employee

-- 9. Mostrar el id, nombres, apellido de los empleados ordenados desde el de fecha de nacimiento más antigua.

-- SELECT Employee.BusinessEntityID, Employee.BirthDate, Person.FirstName, Person.MiddleName, Person.LastName -- El ejercicio pide poner datos de otras tablas pero no vimos cómo hacer eso.
-- FROM AdventureWorks2019.HumanResources.Employee
-- INNER JOIN AdventureWorks2019.Person.Person
-- ON Employee.BusinessEntityID = Person.BusinessEntityID
-- ORDER BY BirthDate DESC

-- 10. Mostrar el contenido de la tabla Departments

-- SELECT *
-- FROM AdventureWorks2019.HumanResources.Department

-- 11.¿Cuáles son los departamentos que están agrupados como “Manufacturing” ó como “Quality Assurance”?

-- SELECT DISTINCT Name, GroupName
-- FROM AdventureWorks2019.HumanResources.Department
-- WHERE GroupName = 'Manufacturing' or GroupName = 'Quality Assurance'

-- 12.¿Cuáles son los datos de los departamentos cuyo nombre esté relacionado con “Production”?

-- SELECT *
-- FROM AdventureWorks2019.HumanResources.Department
-- WHERE Name LIKE '%Production%'

-- 13. Mostrar los datos de los departamentos que no estén agrupados como “Research and Develpment”

-- SELECT *
-- FROM AdventureWorks2019.HumanResources.Department
-- WHERE GroupName != 'Research and Development'

-- 14. Mostrar los datos de la tabla Product del esquema Production

-- SELECT *
-- FROM AdventureWorks2019.Production.Product

-- 15. Hallar los productos que no tengan asignado color.

-- SELECT *
-- FROM AdventureWorks2019.Production.Product
-- WHERE  Color IS NULL

-- 16. Para todos los productos que tengan asignado algún color y que tengan un stock
-- (SafetyStockLevel) mayor a 900, mostrar su id, nombre y color. Ordernarlo por id descendente
-- y por color ascendente.

-- SELECT ProductID, Name, Color, SafetyStockLevel
-- FROM AdventureWorks2019.Production.Product
-- WHERE Color IS NOT NULL and SafetyStockLevel > 900
-- ORDER BY ProductID DESC, Color

-- 17. Hallar el Id y el nombre de los productos cuyo nombre comience con “Chain”

-- SELECT ProductId, Name
-- FROM AdventureWorks2019.Production.Product
-- WHERE Name LIKE 'Chain%'

-- 18. Hallar el Id y el nombre de los productos cuyo nombre contenga “helmet”
-- SELECT ProductId, Name
-- FROM AdventureWorks2019.Production.Product
-- WHERE Name LIKE '%helmet%'

-- 19. Modificar la consulta anterior para que retorne aquellos productos cuyo nombre no contenga “helmet”
-- SELECT ProductId, Name
-- FROM AdventureWorks2019.Production.Product
-- WHERE Name NOT LIKE '%helmet%'

-- 20. Mostrar los datos principales de las personas (tabla Person) cuyo LastName termine con “es” y
-- contenga en total 5 caracteres.

-- SELECT *
-- FROM AdventureWorks2019.Person.Person
-- WHERE LastName LIKE '___es'

-- 21. Usando la tabla SpecialOffer del esquema Sales, mostrar la diferencia entre MinQty y MaxQty,
-- con el id y descripción.

-- SELECT SpecialOfferID, Description, MinQty, MaxQty, Diff = MaxQty - MinQty
-- FROM AdventureWorks2019.Sales.SpecialOffer

-- 22. ¿Cómo el motor resuelve la anterior consulta cuando no tiene asignado valor MinQty ó MaxQty?
-- En esos casos, el motor pone el valor NULL

-- 23. Para resolver el problema anterior, usar la función ISNULL para, cuando no tengan asignado
-- valor, reemplazarlo - en el cálculo – por 0 (cero).

-- SELECT SpecialOfferID, Description, MinQty, MaxQty, Diff = ISNULL(MaxQty - MinQty, 0)
-- FROM AdventureWorks2019.Sales.SpecialOffer

-- 24. ¿Cuántos clientes están almacenados en la tabla Customers?
-- SELECT COUNT(CustomerID)
-- FROM AdventureWorks2019.Sales.Customer
-- Resultado: 19.820

-- 25. ¿Cuál es la cantidad de clientes por tienda? Y cuál es la cantidad de clientes por territorio para
-- aquellos territorios que tengan más de 100 clientes? ¿Cuáles son las tiendas (su Id) asociadas
-- al territorio Id 4 que tienen menos de 2 clientes?

-- SELECT *
-- FROM AdventureWorks2019.Sales.Customer

-- SELECT StoreID, Num_CustomerID = COUNT(CustomerID)
-- FROM AdventureWorks2019.Sales.Customer
-- GROUP BY StoreID

-- SELECT TerritoryID, Num_CustomerID = COUNT(CustomerID)
-- FROM AdventureWorks2019.Sales.Customer
-- GROUP BY TerritoryID
-- HAVING COUNT(*) > 100
-- El tema acá es que todas tienen más de 100

-- SELECT TerritoryID, StoreID, Num_CustomerID = COUNT(CustomerID)
-- FROM AdventureWorks2019.Sales.Customer
-- WHERE TerritoryID = 4
-- GROUP BY TerritoryID, StoreID
-- HAVING COUNT(*) < 2

-- 26.Para la tabla SalesOrderDetail del esquema Sales, calcular cuál es la cantidad total de items
-- ordenados (OrderQty) para el producto con Id igual a 778.

-- SELECT *
-- FROM AdventureWorks2019.Sales.SalesOrderDetail

-- SELECT ProductID, Sum_OrderQty = SUM(OrderQty)
-- FROM AdventureWorks2019.Sales.SalesOrderDetail
-- WHERE ProductID = 778
-- GROUP BY ProductID

-- 27.Usando la misma tabla,
-- a) Cuál es el precio unitario más caro vendido?
-- SELECT Max_UnitPrice = MAX(UnitPrice)
-- FROM AdventureWorks2019.Sales.SalesOrderDetail

-- b) Cuál es el número total de items ordenado para cada producto?
-- SELECT ProductID, Sum_OrderQty = SUM(OrderQty)
-- FROM AdventureWorks2019.Sales.SalesOrderDetail
-- GROUP BY ProductID

-- c) Cuál es la cantidad de líneas de cada orden?
-- SELECT SalesOrderID, Count_SalesOrderDetailID = COUNT(SalesOrderDetailID)
-- FROM AdventureWorks2019.Sales.SalesOrderDetail
-- GROUP BY SalesOrderID

-- d) Cuál es la cantidad de líneas de cada orden, sólo para aquellas órdenes que tengan
-- más de 3 líneas? Ordenar por id de orden descendente.
-- SELECT SalesOrderID, Count_SalesOrderDetailID = COUNT(SalesOrderDetailID)
-- FROM AdventureWorks2019.Sales.SalesOrderDetail
-- GROUP BY SalesOrderID
-- HAVING COUNT(*) >3
-- ORDER BY SalesOrderID DESC

-- e) Cuál es el importe total (LineTotal) de cada orden, para aquellas que tengan menos de
-- 3 líneas?
-- SELECT SalesOrderID, Sum_LineTotal = SUM(LineTotal)
-- FROM AdventureWorks2019.Sales.SalesOrderDetail
-- GROUP BY SalesOrderID
-- HAVING COUNT(SalesOrderDetailID) <3

-- f) Cuál es la cantidad distinta de productos ordenados?
-- SELECT COUNT( DISTINCT (OrderQty))
-- FROM AdventureWorks2019.Sales.SalesOrderDetail

-- 28. Usando la tabla SalesOrderHeader, cuál es la cantidad de órdenes emitidas en cada año?
-- (usar la función Year, aplicada a la columna OrderDate).

-- SELECT *
-- FROM AdventureWorks2019.Sales.SalesOrderHeader

-- SELECT YEAR(OrderDate) as Year, COUNT(SalesOrderID) as Count_SalesOrderID
-- FROM AdventureWorks2019.Sales.SalesOrderHeader
-- GROUP BY YEAR(OrderDate)

-- 29. Usando la misma tabla, cuál es la cantidad de órdenes emitidas para cada cliente en cada año?

-- SELECT CustomerID, YEAR(OrderDate) as Year, COUNT(SalesOrderID) as Count_SalesOrderID
-- FROM AdventureWorks2019.Sales.SalesOrderHeader
-- GROUP BY YEAR(OrderDate), CustomerID
-- ORDER BY CustomerID, YEAR(OrderDate)

-- 30. Para los empleados, contar la cantidad de empleados solteros nacidos por año y por género,
-- para aquellos años donde hayan nacido más de 10 empleados.

SELECT *
FROM AdventureWorks2019.HumanResources.Employee

SELECT YEAR(BirthDate) as Year, Gender, COUNT(MaritalStatus) as Count
FROM AdventureWorks2019.HumanResources.Employee
WHERE Gender = 'S'
GROUP BY YEAR(BirthDate), Gender
HAVING COUNT(*) > 10
ORDER BY Year, Gender

-- 31. Para la tabla Product:

-- SELECT *
-- FROM AdventureWorks2019.Production.Product

-- a) Cuál es el promedio del precio de lista por color de producto?

-- SELECT Color, Avg_ListPrice = AVG(ListPrice)
-- FROM AdventureWorks2019.Production.Product
-- GROUP BY Color
-- ORDER BY Avg_ListPrice

-- b) Cuál es el promedio del precio de lista por color de producto para aquellos colores que
-- tengan más de 15 productos?

-- SELECT Color, Avg_ListPrice = AVG(ListPrice), Count_product = COUNT(ProductID)
-- FROM AdventureWorks2019.Production.Product
-- GROUP BY Color
-- HAVING COUNT(*) > 15
-- ORDER BY Avg_ListPrice
