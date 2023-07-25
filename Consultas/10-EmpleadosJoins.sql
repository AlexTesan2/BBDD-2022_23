/*1.2.4 Consultas multitabla (Composición interna)
Resuelva todas las consultas utilizando la sintaxis de SQL1 y SQL2.*/

-- Devuelve un listado con los empleados y los datos de los departamentos donde trabaja cada uno.


		SELECT e.nombre , d.nombre 
		FROM empleado e , departamento d 
		WHERE d.id = e.id_departamento ;
	
		
		SELECT e.nombre , d.nombre 
		FROM empleado e inner join departamento d 
		on d.id = e.id_departamento ;
	

-- Devuelve un listado con los empleados y los datos de los departamentos donde trabaja cada uno. Ordena el resultado, en primer 
-- lugar por el nombre del departamento (en orden alfabético) y en segundo lugar por los apellidos y el nombre de los empleados.
	
	
		SELECT e.nombre , e.apellido1 ,d.nombre 
		FROM empleado e , departamento d 
		WHERE d.id = e.id_departamento
		order by d.nombre , e.nombre , e.apellido1 ;
	
		
		SELECT e.nombre , e.apellido1 ,d.nombre 
		FROM empleado e inner join departamento d 
		on d.id = e.id_departamento 
		order by d.nombre , e.nombre , e.apellido1 ;
	

-- Devuelve un listado con el identificador y el nombre del departamento, solamente de aquellos departamentos que tienen empleados.
	
		
		SELECT DISTINCT  d.id , d.nombre  
		FROM empleado e , departamento d 
		WHERE d.id = e.id_departamento ;
	
		
		SELECT DISTINCT  d.id , d.nombre  
		FROM empleado e inner join departamento d 
		on d.id = e.id_departamento ;
		
 

/*Devuelve un listado con el identificador, el nombre del departamento y el valor del presupuesto actual del que dispone, solamente
de aquellos departamentos que tienen empleados. El valor del presupuesto actual lo puede calcular restando al valor del presupuesto
 inicial (columna presupuesto) el valor de los gastos que ha generado (columna gastos).*/
	
	
		SELECT DISTINCT d.nombre , d.id , (d.presupuesto-d.gastos) as PresupuestoActual
		FROM departamento d , empleado e 
		WHERE d.id = e.id_departamento ;
	
	
		SELECT DISTINCT  d.nombre , d.id , (d.presupuesto-d.gastos) as PresupuestoActual
		FROM empleado e inner join departamento d 
		on d.id = e.id_departamento ;
			
		

-- Devuelve el nombre del departamento donde trabaja el empleado que tiene el nif 38382980M.
	
	
		SELECT DISTINCT  d.nombre  
		FROM empleado e , departamento d 
		WHERE d.id = e.id_departamento
		AND e.nif = "38382980M";
	
		
		SELECT DISTINCT d.nombre  
		FROM empleado e inner join departamento d 
		on d.id = e.id_departamento 
		WHERE e.nif = "38382980M";
		
		

-- Devuelve el nombre del departamento donde trabaja el empleado Pepe Ruiz Santana.
	
	
		SELECT  d.nombre  
		FROM empleado e , departamento d 
		WHERE d.id = e.id_departamento
		AND e.nombre ="Pepe" AND e.apellido1 ="Ruiz" AND e.apellido2 ="Santana";
	
		
		SELECT d.nombre  
		FROM empleado e inner join departamento d 
		on d.id = e.id_departamento 
		WHERE e.nombre ="Pepe" AND e.apellido1 ="Ruiz" AND e.apellido2 ="Santana";
	
	

-- Devuelve un listado con los datos de los empleados que trabajan en el departamento de I+D. Ordena el resultado alfabéticamente.
	
	
		SELECT  e.nombre , e.apellido1 ,d.nombre  
		FROM empleado e , departamento d 
		WHERE d.id = e.id_departamento
		and d.nombre = "I+D"
		order by e.nombre asc;
	
		
		SELECT e.nombre , e.apellido1 ,d.nombre 
		FROM empleado e inner join departamento d 
		on d.id = e.id_departamento 
		WHERE d.nombre = "I+D"
		order by e.nombre asc; 
	
	

-- Devuelve los empleados que trabajan en el departamento de Sistemas, Contabilidad o I+D. Ordena el resultado alfabéticamente.
	
	
		SELECT e.nombre , d.nombre 
		FROM  departamento d , empleado e 
		WHERE d.id = e.id_departamento 
		AND d.nombre IN ("Sistemas", "Contabilidad", "I+D")
		order by e.nombre ASC ;
	
	
		SELECT e.nombre , d.nombre 
		FROM empleado e inner join departamento d 
		on d.id = e.id_departamento 
		WHERE d.nombre IN ("Sistemas", "Contabilidad", "I+D")
		order by e.nombre asc; 
	
	

-- nombre de los empleados que tienen los departamentos que no tienen un presupuesto entre 100000 y 200000 euros.
	

		SELECT e.nombre , d.nombre , d.presupuesto 
		FROM  departamento d , empleado e 
		WHERE d.id = e.id_departamento 
		AND d.presupuesto NOT BETWEEN 100000 and 200000;

	
	
		SELECT e.nombre , d.nombre , d.presupuesto 
		FROM empleado e inner join departamento d 
		on d.id = e.id_departamento 
		WHERE d.presupuesto NOT BETWEEN 100000 and 200000;

		
		
		

-- Devuelve un listado con el nombre de los departamentos donde existe algún empleado cuyo segundo apellido sea NULL.
-- Tenga en cuenta que no debe mostrar nombres de departamentos que estén repetidos.
	
	
		SELECT distinct  d.nombre as Departamento,  e.nombre as Empleado , e.apellido2
		FROM  departamento d , empleado e 
		WHERE d.id = e.id_departamento 
		AND e.apellido2 is null;

	
	
		SELECT distinct  d.nombre as Departamento,  e.nombre as Empleado , e.apellido2
		FROM empleado e inner join departamento d 
		on d.id = e.id_departamento 
		WHERE e.apellido2 is null;
		
		

/*1.2.5 Consultas multitabla (Composición externa)
Resuelva todas las consultas utilizando las cláusulas LEFT JOIN y RIGHT JOIN.
Devuelve un listado con todos los empleados junto con los datos de los departamentos donde trabajan. 
Este listado también debe incluir los empleados que no tienen ningún departamento asociado.*/
	
	
		select e.nombre as Empleado , d.nombre as Departamento
		FROM empleado e left join departamento d 
		on e.id_departamento = d.id ;
		
	

-- Devuelve un listado donde sólo aparezcan aquellos empleados que no tienen ningún departamento asociado.

	
		select e.nombre as Empleado , d.nombre as Departamento
		FROM empleado e left join departamento d 
		on e.id_departamento = d.id 
		where d.nombre is null;
	
	
-- Devuelve un listado donde sólo aparezcan aquellos departamentos que no tienen ningún empleado asociado.
	
	
		select  d.nombre as Departamento, e.nombre as Empleado
		FROM empleado e right join departamento d 
		on e.id_departamento = d.id 
		where e.nombre is null;
		

/*Devuelve un listado con todos los empleados junto con los datos de los departamentos donde trabajan. El listado debe 
 incluir los empleados que no tienen ningún departamento asociado y los departamentos que no tienen ningún empleado asociado. 
 Ordene el listado alfabéticamente por el nombre del departamento.*/
	
	
		select  d.nombre as Departamento, e.nombre as Empleado
		FROM empleado e right join departamento d 
		on e.id_departamento = d.id 
		union 
		select  d.nombre as Departamento, e.nombre as Empleado
		FROM empleado e left join departamento d 
		on e.id_departamento = d.id

		
/*Devuelve un listado con los empleados que no tienen ningún departamento asociado y los departamentos que no tienen ningún 
empleado asociado. Ordene el listado alfabéticamente por el nombre del departamento.*/
		
		
		select  d.nombre as Departamento, e.nombre as Empleado
		FROM empleado e right join departamento d 
		on e.id_departamento = d.id 
		where e.nombre is null
		union 
		select  d.nombre as Departamento, e.nombre as Empleado
		FROM empleado e left join departamento d 
		on e.id_departamento = d.id
		where d.nombre is null
	
	
	
	
	
	
	