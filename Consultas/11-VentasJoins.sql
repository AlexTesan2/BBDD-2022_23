-- (Composición interna)

/*Devuelve un listado con el identificador, nombre y los apellidos de todos los clientes que han realizado algún pedido. 
 El listado debe estar ordenado alfabéticamente y se deben eliminar los elementos repetidos.*/


		SELECT DISTINCT  c.id , c.nombre , c.apellido1 , c.apellido2 
		FROM cliente c , pedido p  
		WHERE c.id = p.id_cliente  
		order by c.nombre ASC , c.apellido1 ASC ;
	
		
		SELECT DISTINCT  c.id , c.nombre , c.apellido1 , c.apellido2 
		from cliente c inner join pedido p on c.id = p.id_cliente 
		order by c.nombre ASC , c.apellido1 ASC ;

	
	
/*Devuelve un listado que muestre todos los pedidos que ha realizado cada cliente. El resultado debe mostrar todos los
datos de los pedidos y del cliente. El listado debe mostrar los datos de los clientes ordenados alfabéticamente.*/
	
	
		SELECT DISTINCT c.*, p.*
		FROM pedido p , cliente c 
		WHERE p.id_cliente = c.id 
		order by c.nombre asc;
	
	
		SELECT DISTINCT c.*, p.*
		FROM pedido p inner join cliente c on c.id = p.id_cliente 
		order by c.nombre asc;
		

/*Devuelve un listado que muestre todos los pedidos en los que ha participado un comercial. El resultado debe mostrar todos
 * los datos de los pedidos y de los comerciales. El listado debe mostrar los datos de los comerciales ordenados alfabéticamente.*/
	
	
		SELECT  p.*, c.*
		FROM pedido p , comercial c 
		WHERE p.id_comercial = c.id 
		order by c.nombre ASC ;
	
		SELECT  p.*, c.*
		FROM pedido p inner join comercial c 
		on c.id = p.id_comercial 
		order by c.nombre ASC ;
	
	

-- muestre todos los clientes, con todos los pedidos que han realizado y con los datos de los comerciales asociados a cada pedido.
	
	
		SELECT cl.nombre as Cliente, p.id as Pedido , c.*
		FROM pedido p , comercial c , cliente cl
		WHERE p.id_comercial = c.id and p.id_cliente = cl.id 
		order by cl.nombre ASC , p.id asc;

	
		SELECT  cl.nombre as Cliente, p.id as Pedido , c.*
		FROM pedido p inner join comercial c 
		on c.id = p.id_comercial 
		INNER JOIN cliente cl 
		on cl.id = p.id_cliente 
		order by cl.nombre ASC , p.id asc;
	

-- Devuelve un listado de todos los clientes que realizaron un pedido durante el año 2017, cuya cantidad esté entre 300 € y 1000 €.
	
	
		SELECT  c.nombre , p.id , p.fecha , p.total 
		FROM cliente c , pedido p 
		WHERE p.id_cliente = c.id 
		and YEAR (p.fecha)=2017
		and p.total BETWEEN  300 and 1000;

		
		SELECT  c.nombre , p.id , p.fecha , p.total 
		FROM cliente c inner join pedido p 
		on p.id_cliente = c.id
		where YEAR (p.fecha)=2017
		and p.total BETWEEN  300 and 1000;
		
	

-- Devuelve el nombre y los apellidos de todos los comerciales que ha participado en algún pedido realizado por María Santana Moreno.
	
	
		SELECT  c.nombre , c.apellido1 , c.apellido2 , p.id , cl.nombre 
		FROM cliente cl , pedido p , comercial c 
		WHERE p.id_cliente = cl.id and c.id = p.id_comercial 
		and cl.nombre ="María" and cl.apellido1 ="Santana" and cl.apellido2 ="Moreno";

		
		SELECT   c.nombre , c.apellido1 , c.apellido2 , p.id , cl.nombre 
		FROM cliente cl inner join pedido p 
		on p.id_cliente = cl.id
		inner join comercial c on c.id = p.id_comercial 
		WHERE cl.nombre ="María" and cl.apellido1 ="Santana" and cl.apellido2 ="Moreno";
	
	

-- Devuelve el nombre de todos los clientes que han realizado algún pedido con el comercial Daniel Sáez Vega.


	
		SELECT  cl.nombre , p.id , c.nombre 
		FROM cliente cl , pedido p , comercial c 
		WHERE p.id_cliente = cl.id and c.id = p.id_comercial 
		and c.nombre ="Daniel" and c.apellido1 ="Sáez" and c.apellido2 ="Vega";

		
		SELECT  cl.nombre , p.id , c.nombre 
		FROM cliente cl inner join pedido p 
		on p.id_cliente = cl.id
		inner join comercial c on c.id = p.id_comercial 
		WHERE c.nombre ="Daniel" and c.apellido1 ="Sáez" and c.apellido2 ="Vega";
	
	
	
-- (Composición externa)


/* todos los clientes junto con los datos de los pedidos que han realizado. también los clientes que no han realizado ningún pedido.
 El listado debe estar ordenado alfabéticamente por el primer apellido, segundo apellido y nombre de los clientes.*/
	
	
		SELECT c.apellido1 , c.apellido2 ,c.nombre , p.*
		FROM cliente c left join  pedido p 
		on p.id_cliente = c.id 
		order BY c.apellido1 , c.apellido2 , c.nombre 
		
		
		
	

/* todos los comerciales junto con los datos de los pedidos que han realizado.también debe incluir los comerciales que no han 
realizado ningún pedido.debe estar ordenado alfabéticamente por el primer apellido,segundo apellido y nombre de los comerciales.*/
		
		
		SELECT c.apellido1 , c.apellido2 ,c.nombre , p.*
		FROM comercial c left join  pedido p 
		on p.id_comercial = c.id 
		order BY c.apellido1 , c.apellido2 , c.nombre 
		

-- Devuelve un listado que solamente muestre los clientes que no han realizado ningún pedido.
		
		
		SELECT c.nombre , p.id 
		FROM cliente c left join pedido p 
		on p.id_cliente = c.id 
		where p.id is null; 
		

-- Devuelve un listado que solamente muestre los comerciales que no han realizado ningún pedido.
	
	
		SELECT c.nombre , p.id 
		FROM comercial c left join pedido p 
		on p.id_comercial  = c.id 
		where p.id is null;
	
	

/*Devuelve  los clientes que no han realizado ningún pedido y de los comerciales que no han participado en ningún pedido 
Ordene  alfabéticamente por los apellidos y el nombre. En en listado deberá diferenciar de algún modo los clientes y los comerciales.*/

		
		SELECT c.id, c.nombre, c.apellido1, c.apellido2, 'Cliente' AS 'Tipo'
		FROM cliente c left join pedido p 
		on p.id_cliente = c.id 
		where p.id is null
		
		UNION
		
		SELECT c.id, c.nombre, c.apellido1, c.apellido2, 'Comercial' AS 'Tipo'
		FROM comercial c left join pedido p 
		on p.id_comercial  = c.id 
		where p.id is null
		order by apellido1, nombre ;
	


-- ¿Se podrían realizar las consultas anteriores con NATURAL LEFT JOIN o NATURAL RIGHT JOIN? Justifique su respuesta.
	
	#no, las natural joins no muestran los valores que sean null , ademas buscará las columnas de ambas
	# tablas que tengan el mismo nombre  y comparará el id del cliente/comercial con el id del pedido en vez de id_cliente/comercial