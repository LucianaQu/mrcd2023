-- Utilizando la base de datos AdventureWorks2019, resolver:

-- 1. Usando subconsultas, obtener Id y nombre de los productos que hayan sido vendidos durante
-- el año 2013.

-- SELECT p.ProductID, p.Name as ProductName
-- FROM AdventureWorks2019.Production.Product p
-- WHERE p.ProductID IN
--		(SELECT DISTINCT sod.ProductID
--		FROM AdventureWorks2019.Sales.SalesOrderDetail sod
--		INNER JOIN AdventureWorks2019.Sales.SalesOrderHeader soh on soh.SalesOrderID = sod.SalesOrderID
--		WHERE year(soh.OrderDate) = 2013)

-- 2. Usando subconsultas, obtener Id y nombre de los productos que no hayan sido vendidos
-- nunca.

-- SELECT p.ProductID, p.Name as ProductName
-- FROM AdventureWorks2019.Production.Product p
-- WHERE p.ProductID NOT IN
-- 		(SELECT DISTINCT sod.ProductID
-- 		FROM AdventureWorks2019.Sales.SalesOrderDetail sod
--		INNER JOIN AdventureWorks2019.Sales.SalesOrderHeader soh on soh.SalesOrderID = sod.SalesOrderID)

-- 3. Obtener los productos vendidos de mayor precio unitario, entre los vendidos en el año 2013.
-- No entendí la consigna pero lo resolví así:

--SELECT sod1.ProductID
--FROM AdventureWorks2019.Sales.SalesOrderDetail sod1
--INNER JOIN AdventureWorks2019.Sales.SalesOrderHeader soh on soh.SalesOrderID = sod1.SalesOrderID
--WHERE year(soh.OrderDate) = 2013 and sod1.UnitPrice = 
--		(SELECT MAX(sod2.UnitPrice)
--		FROM AdventureWorks2019.Sales.SalesOrderDetail sod2
--		WHERE sod1.ProductID =sod2.ProductID)
			
-- 4. Mostrar los departamentos que tengan máxima cantidad de empleados.
-- ¿A qué se refieren con máxima cantidad de empleados?
-- No entendí a qué se referían pero puse un ejemplo para practicar.

--SELECT edh.DepartmentID , COUNT(*) AS CantidadEmpleados
--FROM AdventureWorks2019.HumanResources.EmployeeDepartmentHistory edh
--GROUP BY edh.DepartmentID
--HAVING COUNT(*) >
--		(SELECT COUNT(*)
--		FROM AdventureWorks2019.HumanResources.EmployeeDepartmentHistory edh
--		WHERE edh.DepartmentID = 11)

-- 5. Hallar los empleados con menor antiguedad dentro de cada departamento.

--SELECT edh1.BusinessEntityID, edh1.StartDate, d.Name 
--FROM AdventureWorks2019.HumanResources.EmployeeDepartmentHistory edh1
--INNER JOIN AdventureWorks2019.HumanResources.Department d on edh1.DepartmentID = d.DepartmentID 
--WHERE edh1.StartDate =
--		(SELECT MIN(edh2.StartDate)
--		 FROM AdventureWorks2019.HumanResources.EmployeeDepartmentHistory edh2
--		 WHERE edh1.DepartmentID = edh2.DepartmentID)

-- 6. Hallar las provincias que tengan más cantidad de domicilios que los que 
-- tiene la provincia con Id 58.

--SELECT a.StateProvinceID, COUNT(*) as CantidadDeDomicilios
--FROM AdventureWorks2019.Person.Address a 
--GROUP BY a.StateProvinceID
--HAVING COUNT(*) >
--		(SELECT COUNT(*)
--		 FROM AdventureWorks2019.Person.Address a
--		 WHERE a.StateProvinceID = 58)

-- 7. Hallar año y mes de fechas de modificación coincidentes entre los registros 
-- de la tabla Person para el tipo de persona “EM” y los registros de la tabla 
-- Address para la provincia con nombre “Washington”.

--SELECT YEAR(p.ModifiedDate), MONTH(p.ModifiedDate)
--FROM AdventureWorks2019.Person.Person p
--WHERE p.PersonType = 'EM' and p.ModifiedDate IN 
--		(SELECT a.ModifiedDate 
--		 FROM AdventureWorks2019.Person.Address a
--		 INNER JOIN AdventureWorks2019.Person.StateProvince sp on a.StateProvinceID = sp.StateProvinceID 
--		 WHERE sp.Name = 'Washington')

-- 8. Determinar si existen empleados y clientes con mismo Id, usando subconsultas

--SELECT e.BusinessEntityID 
--FROM AdventureWorks2019.HumanResources.Employee e
--WHERE e.BusinessEntityID IN
--		(SELECT c.PersonID 
--		FROM AdventureWorks2019.Sales.Customer c)
	
-- 9. Mostrar los años de las ventas registradas y de las compras registradas. 
-- Identificar para cada año, si corresponde a ventas o a compras.

-- NO ENTIENDO LA CONSIGNA

--SELECT *
--FROM AdventureWorks2019.Purchasing.PurchaseOrderHeader poh 

-- SELECT *
-- FROM AdventureWorks2019.Sales.SalesOrderHeader soh 

-- 10. Para la anterior consulta, ordenarla por año descendente

-- COMO DEPENDE DE LA 9, TAMPOCO ENTIENDO

-- 11. Para cada venta, encontrar la denominación del producto de mayor precio total 
-- (precio x cantidad) de su propia orden.

-- SELECT p.Name, sod.ProductID, sod.SalesOrderID 
--FROM AdventureWorks2019.Sales.SalesOrderDetail sod
--INNER JOIN AdventureWorks2019.Production.Product p on p.ProductID = sod.ProductID 
--WHERE sod.LineTotal = 
--		(SELECT MAX(LineTotal) 
--		 FROM AdventureWorks2019.Sales.SalesOrderDetail sod2
--		 WHERE sod.SalesOrderID = sod2.SalesOrderID)

-- 12. Encontrar el nombre de los productos que no pertenezcan a la subcategoría “Wheels”. Usar
-- EXISTS.

--SELECT p.Name, p.ProductSubcategoryID 
--FROM AdventureWorks2019.Production.Product p
--WHERE EXISTS (SELECT *
--				FROM AdventureWorks2019.Production.ProductSubcategory ps
--				WHERE Name != 'Wheels' and ps.ProductSubcategoryID = p.ProductSubcategoryID)

-- 13. Encontrar el nombre de los productos cuyo precio de lista es mayor o igual al máximo precio
-- de lista de cualquier subcategoría de producto.
-- LA REDACCIÓN ME RESULTA RARA. NO SÉ SI SE REFIEREN A ESTO O A SELECCIONAR A AQUELLOS PRODUCTOS QUE SEAN
-- MAYORES O IGUALES AL MAYOR DE TODOS LOS PRODUCTOS.

--SELECT p2.Name, p2.ListPrice 
--FROM AdventureWorks2019.Production.Product p2
--WHERE p2.ListPrice >= ANY 
--	(SELECT MAX(p.ListPrice) as maxPrice
--		FROM AdventureWorks2019.Production.Product p
--		GROUP BY p.ProductSubcategoryID
--		)

-- 14. Encontrar los nombres de los empleados que también sean vendedores. Usar subconsultas
-- anidadas.
		 
--SELECT p.FirstName, p.LastName 
--FROM AdventureWorks2019.HumanResources.Employee e
--INNER JOIN AdventureWorks2019.Person.Person p on e.BusinessEntityID = p.BusinessEntityID
--WHERE e.BusinessEntityID IN
--	(SELECT sp.BusinessEntityID
--	 FROM AdventureWorks2019.Sales.SalesPerson sp)
