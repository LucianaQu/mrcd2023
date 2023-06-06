-- 1. La tabla Employee no contiene el nombre de los empleados. Ese dato se encuentra en la tabla
-- Person. La columna que relaciona ambas tablas es BusinessEntityID

-- a) Si existe una FK entre ambas tablas, cómo podemos corroborar su existencia?
-- SELECT e.NationalIDNumber, p.FirstName, p.MiddleName, p.LastName
-- from AdventureWorks2019.Person.Person p, AdventureWorks2019.HumanResources.Employee e
-- WHERE e.BusinessEntityID = p.BusinessEntityID

-- SELECT * 
-- from AdventureWorks2019.Person.Person

-- SELECT * 
-- from AdventureWorks2019.HumanResources.Employee

-- b) Obtener el nombre, apellido, cargo y fecha de nacimiento de todos los empleados.
-- SELECT p.FirstName, p.LastName, e.JobTitle, e.BirthDate
-- FROM AdventureWorks2019.Person.Person p, AdventureWorks2019.HumanResources.Employee e
-- WHERE e.BusinessEntityID = p.BusinessEntityID


-- c) Obtener el nombre y apellido de los empleados que nacieron durante el año 1986 y su
-- “género” es F.
-- SELECT p.FirstName, p.LastName, e.BirthDate, e.Gender
-- FROM AdventureWorks2019.Person.Person p, AdventureWorks2019.HumanResources.Employee e
-- WHERE e.BusinessEntityID = p.BusinessEntityID and e.Gender = 'F' and YEAR(e.BirthDate) = 1986

-- d) Contar la cantidad de empleados cuyo nombre comience con la letra “J” y hayan nacido
-- después del año 1977.

-- SELECT Count_people = COUNT(e.BusinessEntityID)
-- FROM AdventureWorks2019.Person.Person p, AdventureWorks2019.HumanResources.Employee e
-- WHERE e.BusinessEntityID = p.BusinessEntityID and p.FirstName LIKE 'J%' and YEAR(e.BirthDate) > 1977


-- e) Para las mismas condiciones del punto anterior, cuántos empleados están registrados
-- según su género?

-- SELECT Count_people = COUNT(e.BusinessEntityID)
-- FROM AdventureWorks2019.Person.Person p, AdventureWorks2019.HumanResources.Employee e
-- WHERE e.BusinessEntityID = p.BusinessEntityID and p.FirstName LIKE 'J%' and YEAR(e.BirthDate) > 1977 and e.Gender IS NOT NULL

-- 2. La tabla Customers tampoco contiene el nombre de los clientes. La columna que las relaciona
-- es, PersonID

-- a) Obtener nombre, apellido, storeId para aquellos clientes que estén en el TerritoryID = 4 ó
-- que pertenezcan al tipo de persona 4 (PersonType)

-- SELECT p.FirstName, p.LastName, c.StoreID, c.TerritoryID, p.PersonType
-- FROM AdventureWorks2019.Person.Person p, AdventureWorks2019.Sales.Customer c
-- WHERE p.BusinessEntityID = c.PersonID and c.TerritoryID = 4 and p.PersonType = 'SC'

-- -- NO SÉ A QUÉ SE REFIEREN CON PERSON TYPE 4

-- b) ¿cuáles son el nombre, apellido y número de orden de venta (SaleOrderID) para los
-- clientes que pertenecen al tipo de persona 4?

-- SELECT p.FirstName, p.LastName, c.StoreID--, p.SalesOrderID
-- FROM AdventureWorks2019.Person.Person p, AdventureWorks2019.Sales.Customer c
-- WHERE p.BusinessEntityID = c.PersonID and p.PersonType = 'SC'

-- NO EXISTE EL SALESORDERID EN ESTA TABLA

-- 3. La tabla Product contiene los productos y la tabla ProductModel, los modelos.
-- a) Encontrar la descripción del producto, su tamaño y la descripción del modelo relacionado,
-- para aquellos productos que no tengan color indicado y para los cuales el nivel seguro de
-- stock (SafetyStockLevel) sea menor estricto a 1000.

-- SELECT p.Name, p.Size, m.CatalogDescription, p.Color, p.SafetyStockLevel
-- FROM AdventureWorks2019.Production.Product p, AdventureWorks2019.Production.ProductModel m
-- WHERE p.ProductModelID = m.ProductModelID and p.Color IS NULL and p.SafetyStockLevel < 1000

-- b) Obtener todas las ventas de los meses de junio y julio del 2011. Mostrar el nombre y
-- apellido del cliente, el nro de venta, su fecha, nombre y modelo del producto vendido.

-- SELECT p.SellStartDate
-- FROM AdventureWorks2019.Production.Product p, AdventureWorks2019.Production.ProductModel m
-- WHERE p.ProductModelID = m.ProductModelID and YEAR(p.SellStartDate) = 2011 and (MONTH(p.SellStartDate) = 6 OR MONTH(p.SellStartDate) = 7)-- and p.Color IS NULL and p.SafetyStockLevel < 1000

-- ENTIENDO QUE HABRÍA QUE SUMAR MÁS TABLAS.
-- Sí, hay que sumar mil tablas

--SELECT *
--FROM AdventureWorks2019.Sales.SalesOrderDetail

--SELECT p.FirstName, p.LastName, sod.SalesOrderDetailID, soh.OrderDate, p2.Name, pm.Name 
--FROM AdventureWorks2019.Sales.SalesOrderDetail sod 
--INNER JOIN AdventureWorks2019.Sales.SalesOrderHeader soh ON sod.SalesOrderID = soh.SalesOrderID
--INNER JOIN AdventureWorks2019.Sales.Customer c ON soh.CustomerID = c.CustomerID 
--INNER JOIN AdventureWorks2019.Person.Person p ON p.BusinessEntityID = c.PersonID
--INNER JOIN AdventureWorks2019.Production.Product p2 ON sod.ProductID =p2.ProductID 
--INNER JOIN AdventureWorks2019.Production.ProductModel pm ON p2.ProductModelID = pm.ProductModelID
--WHERE YEAR(soh.OrderDate) = 2011 AND (MONTH(soh.OrderDate) = 6 OR MONTH(soh.OrderDate) = 7)


-- 4. Mostrar todos la descripción de los productos y el id de la orden de venta. Incluir aquellos
-- productos que nunca se hayan vendido.

--SELECT p2.Name, sod.SalesOrderID 
--FROM  AdventureWorks2019.Production.Product p2
--LEFT OUTER JOIN AdventureWorks2019.Sales.SalesOrderDetail sod ON p2.ProductID = sod.ProductID 

-- 5. Mostrar la descripción de los productos que nunca hayan sido vendidos.

--SELECT p2.Name, sod.SalesOrderID 
--FROM  AdventureWorks2019.Production.Product p2
--LEFT OUTER JOIN AdventureWorks2019.Sales.SalesOrderDetail sod ON p2.ProductID = sod.ProductID 
--WHERE sod.SalesOrderID IS NULL

-- 6. En la tabla SalesPerson se modelan los vendedores. Mostrar el id de todos los vendedores
-- junto al id de la venta, para aquellas con numero de revisión igual a 9 y que se hayan vendido
-- en el 2013. Incluir a aquellos vendedores que no hayan efectuado ventas.

--SELECT soh.SalesOrderID, soh.RevisionNumber, year(soh.OrderDate) as 'year', sp.BusinessEntityID 
--FROM AdventureWorks2019.Sales.SalesPerson sp
--LEFT OUTER JOIN AdventureWorks2019.Sales.SalesOrderHeader soh ON sp.BusinessEntityID = soh.SalesPersonID
--WHERE soh.RevisionNumber = 9 and year(soh.OrderDate) = 2013

-- YO CREO QUE ESTA CONSULTA NO TIENE MUCHO SENTIDO.

-- 7. Modificar la resolución del punto anterior para agregar el nombre del vendedor, que se
-- encuentra en la tabla Person.

--SELECT soh.SalesOrderID, soh.RevisionNumber, year(soh.OrderDate) as 'year', sp.BusinessEntityID, p2.FirstName, p2.LastName 
--FROM AdventureWorks2019.Sales.SalesPerson sp
--LEFT OUTER JOIN AdventureWorks2019.Sales.SalesOrderHeader soh ON sp.BusinessEntityID = soh.SalesPersonID
--INNER JOIN AdventureWorks2019.HumanResources.Employee e on e.BusinessEntityID = sp.BusinessEntityID
--INNER JOIN AdventureWorks2019.Person.Person p2 on e.BusinessEntityID = p2.BusinessEntityID
--WHERE soh.RevisionNumber = 9 and year(soh.OrderDate) = 2013

-- 8. Mostrar todas los valores de BusinessEntityID de la tabla SalesPerson junto a cada valor
-- ProductID de la tabla Product

-- SELECT sp.BusinessEntityID, p.ProductID 
-- FROM AdventureWorks2019.Sales.SalesPerson sp
-- INNER JOIN AdventureWorks2019.Sales.SalesOrderHeader soh ON sp.BusinessEntityID = soh.SalesPersonID
-- INNER JOIN AdventureWorks2019.Sales.SalesOrderDetail sod ON sod.SalesOrderID = soh.SalesOrderID
-- INNER JOIN AdventureWorks2019.Production.Product p ON p.ProductID = sod.ProductID

-- 9. Calcular para los tipos de contacto, cuántas personas asociadas están registradas. Ordenar el
-- resultado por cantidad, descendente. (esquema Person)

-- SELECT ct.Name, COUNT(*) as Cantidad
-- FROM AdventureWorks2019.Person.Person p
-- INNER JOIN AdventureWorks2019.Person.BusinessEntityContact bec ON p.BusinessEntityID = bec.PersonID
-- INNER JOIN AdventureWorks2019.Person.ContactType ct ON bec.ContactTypeID = ct.ContactTypeID
-- GROUP BY ct.Name 

-- 10. Mostrar nombre y apellido de los empleados del estado de “Oregon” (esquemas Person y
-- HumanResources) 

-- SELECT sp.Name, p2.FirstName, p2.LastName 
-- FROM AdventureWorks2019.HumanResources.Employee e
-- INNER JOIN AdventureWorks2019.Person.Person p2 on e.BusinessEntityID = p2.BusinessEntityID
-- INNER JOIN AdventureWorks2019.Person.BusinessEntity be on p2.BusinessEntityID = be.BusinessEntityID
-- INNER JOIN AdventureWorks2019.Person.BusinessEntityAddress bea on be.BusinessEntityID = bea.BusinessEntityID
-- INNER JOIN AdventureWorks2019.Person.Address a on a.AddressID = bea.AddressID 
-- INNER JOIN AdventureWorks2019.Person.StateProvince sp on a.StateProvinceID = sp.StateProvinceID
-- WHERE sp.Name = 'Oregon'

-- 11. Calcular la suma de las ventas (SalesQuota) históricas por persona y año. Mostrar el apellido
-- de la persona. (esquemas Sales (SalesPersonQuotaHistory) y Person)

-- SELECT p.LastName, year(spqh.QuotaDate) as year, SUM(spqh.SalesQuota) as ventas 
-- FROM AdventureWorks2019.Sales.SalesPersonQuotaHistory spqh
-- INNER JOIN AdventureWorks2019.Person.Person p on p.BusinessEntityID = spqh.BusinessEntityID
-- GROUP BY year(spqh.QuotaDate), p.LastName

-- 12. Calcular el total vendido por territorio, para aquellos que tengan más de 100 ventas a nivel
-- producto. Considerar precio unitario y cantidad vendida. (esquema Sales)

--SELECT st.Name, sod.ProductID, sum(sod.OrderQty * sod.UnitPrice) as TotalAmount, SUM(sod.OrderQty) as CantidadVendida
--FROM AdventureWorks2019.Sales.SalesOrderDetail sod
--INNER JOIN AdventureWorks2019.Sales.SalesOrderHeader soh on sod.SalesOrderID = soh.SalesOrderID 
--INNER JOIN AdventureWorks2019.Sales.SalesTerritory st on soh.TerritoryID = st.TerritoryID 
--GROUP BY st.Name , sod.ProductID
--HAVING SUM(sod.OrderQty) > 100

-- PREGUNTAR SI ESTÁ OK ASÍ. SOBRE QUÉ SE QUIERE APLICAR EL FILTRO???

-- 13. Mostrar para cada provincia (id y nombre), la cantidad de domicilios que tenga registrados,
-- sólo para aquellas provincias que tengan más de 1000 domicilios.

SELECT prov.Name, prov.StateProvinceID, COUNT(ad.AddressID) as q_addresses
FROM AdventureWorks2019.Person.StateProvince prov, AdventureWorks2019.Person.Address ad
WHERE prov.StateProvinceID = ad.StateProvinceID 
GROUP BY prov.Name, prov.StateProvinceID
HAVING COUNT(ad.AddressID) >1000

