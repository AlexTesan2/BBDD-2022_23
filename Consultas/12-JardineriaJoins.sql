/*1.4.5 Consultas multitabla (Composición interna)
Resuelva todas las consultas utilizando la sintaxis de SQL1 y SQL2. Las consultas con sintaxis de SQL2 se deben resolver con INNER JOIN y NATURAL JOIN.

Obtén un listado con el nombre de cada cliente y el nombre y apellido de su representante de ventas.*/

	
	select c.nombre_cliente as cliente, e.nombre , e.apellido1 
	FROM cliente c , empleado e 
	WHERE e.codigo_empleado = c.codigo_empleado_rep_ventas ;


	
	select c.nombre_cliente as cliente, e.nombre , e.apellido1 
	FROM cliente c inner join empleado e on e.codigo_empleado = c.codigo_empleado_rep_ventas ;



-- Muestra el nombre de los clientes que hayan realizado pagos junto con el nombre de sus representantes de ventas.


		SELECT c.nombre_cliente , p.fecha_pago ,  p.total , e.nombre as empleado
		FROM cliente c , pago p , empleado e 
		WHERE c.codigo_cliente = p.codigo_cliente and e.codigo_empleado = c.codigo_empleado_rep_ventas ;
	
	
		
		SELECT c.nombre_cliente , p.fecha_pago ,  p.total , e.nombre as empleado
		from cliente c inner join pago p 
		on c.codigo_cliente = p.codigo_cliente 
		inner join empleado e 
		on e.codigo_empleado = c.codigo_empleado_rep_ventas ;
	

-- Muestra el nombre de los clientes que no hayan realizado pagos junto con el nombre de sus representantes de ventas.


		SELECT c.nombre_cliente as cliente , e.nombre as empleado
		FROM cliente c, empleado e
		WHERE c.codigo_empleado_rep_ventas = e.codigo_empleado
    	AND c.codigo_cliente NOT IN
    	(
        	SELECT c1.codigo_cliente
			FROM cliente c1,pago p
			WHERE c1.codigo_cliente = p.codigo_cliente
        );
       
       
       
       	SELECT c.nombre_cliente as cliente , e.nombre as empleado
		FROM cliente c INNER JOIN empleado e
   		ON c.codigo_empleado_rep_ventas = e.codigo_empleado
		WHERE c.codigo_cliente NOT IN 
		(
         SELECT p.codigo_cliente 
         FROM cliente c1 NATURAL JOIN  pago p
        );
       

	
	
#clientes que han hecho pagos y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.

       
       
       	SELECT c.nombre_cliente as Cliente, e.nombre as Representante, p.fecha_pago , o.ciudad 
       	FROM cliente c , pago p , empleado e , oficina o 
       	WHERE c.codigo_cliente = p.codigo_cliente 
       	and c.codigo_empleado_rep_ventas = e.codigo_empleado 
       	and o.codigo_oficina = e.codigo_oficina ;
       
       
       
       	SELECT c.nombre_cliente as Cliente, e.nombre as Representante, p.fecha_pago , o.ciudad
       	from cliente c inner join empleado e on c.codigo_empleado_rep_ventas = e.codigo_empleado 
       	inner join pago  p on p.codigo_cliente = c.codigo_cliente 
       	inner join oficina o on o.codigo_oficina = e.codigo_oficina ;
       	       	
       	
       
       	
       
/*Devuelve el nombre de los clientes que no hayan hecho pagos y el nombre de sus representantes junto con la ciudad de la 
oficina a la que pertenece el representante./*/	
       	
       	
       	
       	SELECT  c.nombre_cliente as Cliente, e.nombre  as Representante, o.ciudad
		FROM cliente c, empleado e, oficina o
		WHERE c.codigo_empleado_rep_ventas = e.codigo_empleado
    	AND e.codigo_oficina = o.codigo_oficina
   		AND c.codigo_cliente NOT IN 
   			(
        	SELECT c1.codigo_cliente
           	FROM cliente c1, pago p
           	WHERE c1.codigo_cliente = p.codigo_cliente
            );
           
           
           
        SELECT  c.nombre_cliente as Cliente, e.nombre  as Representante, o.ciudad
		FROM cliente c inner join empleado e on e.codigo_empleado = c.codigo_empleado_rep_ventas 
		inner join oficina o on o.codigo_oficina = e.codigo_oficina 
		WHERE c.codigo_cliente  not in 
		(
			SELECT cl.codigo_cliente 
			FROM cliente cl inner join pago p on p.codigo_cliente = cl.codigo_cliente  
		);
	
	
	
-- Lista la dirección de las oficinas que tengan clientes en Fuenlabrada.
	
		
		SELECT o.codigo_oficina , o.ciudad , o.linea_direccion1 , c.nombre_cliente , c.ciudad 
		FROM oficina o , empleado e , cliente c
		WHERE o.codigo_oficina = e.codigo_oficina 
		and e.codigo_empleado = c.codigo_empleado_rep_ventas 
		and c.ciudad = 'Fuenlabrada';
	
	
		SELECT o.codigo_oficina , o.ciudad , o.linea_direccion1 , c.nombre_cliente , c.ciudad 
		from oficina o inner join empleado e on e.codigo_oficina = o.codigo_oficina 
		inner join cliente c on c.codigo_empleado_rep_ventas = e.codigo_empleado 
		WHERE c.ciudad = 'Fuenlabrada';
		
		

# nombre de los clientes y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.
	
	
	
		SELECT c.nombre_cliente as Cliente, e.nombre as Representante, o.ciudad 
       	FROM cliente c , empleado e , oficina o 
       	WHERE c.codigo_empleado_rep_ventas = e.codigo_empleado 
       	and o.codigo_oficina = e.codigo_oficina ;
       
       
       
       	SELECT c.nombre_cliente as Cliente, e.nombre as Representante, o.ciudad
       	from cliente c inner join empleado e on c.codigo_empleado_rep_ventas = e.codigo_empleado 
       	inner join oficina o on o.codigo_oficina = e.codigo_oficina ;
	
       
       

-- Devuelve un listado con el nombre de los empleados junto con el nombre de sus jefes.
       
       
       	SELECT e.nombre , e2.nombre as jefe
       	FROM empleado e , empleado e2 
       	WHERE e2.codigo_empleado = e.codigo_jefe ;
       	
       	SELECT e.nombre , e2.nombre as jefe
       	FROM empleado e inner join empleado e2 on e.codigo_jefe = e2.codigo_empleado ;
       
       

-- Devuelve un listado que muestre el nombre de cada empleados, el nombre de su jefe y el nombre del jefe de sus jefe.
       
       
       	SELECT e.nombre , e2.nombre as jefe, e3.nombre  as jefazo
       	FROM empleado e , empleado e2 , empleado e3 
       	WHERE e2.codigo_empleado = e.codigo_jefe and e2.codigo_jefe = e3.codigo_empleado  ;
       	
       	SELECT e.nombre , e2.nombre as jefe, e3.nombre  as jefazo
       	FROM empleado e inner join empleado e2 on e.codigo_jefe = e2.codigo_empleado
       	INNER join empleado e3 on e2.codigo_jefe = e3.codigo_empleado ;
       	
       

-- Devuelve el nombre de los clientes a los que no se les ha entregado a tiempo un pedido.
       
       
       SELECT c.nombre_cliente , p.fecha_esperada , p.fecha_entrega 
       FROM cliente c , pedido p 
       WHERE p.codigo_cliente =c.codigo_cliente 
       AND p.fecha_entrega > p.fecha_esperada ;
      
      
      SELECT c.nombre_cliente , p.fecha_esperada , p.fecha_entrega 
      FROM cliente c natural join pedido p 
      WHERE p.fecha_entrega > p.fecha_esperada ;
      
      	

-- Devuelve un listado de las diferentes gamas de producto que ha comprado cada cliente.
     
     
     	SELECT DISTINCT  c.nombre_cliente  , p2.nombre , p2.gama 
     	FROM cliente c , pedido p , detalle_pedido dp , producto p2 
     	WHERE p.codigo_cliente = c.codigo_cliente AND dp.codigo_pedido = p.codigo_pedido 
     	and dp.codigo_producto = p2.codigo_producto;
     
     	
     	SELECT DISTINCT  c.nombre_cliente  , p2.nombre , p2.gama 
     	from cliente c inner join pedido p on p.codigo_cliente = c.codigo_cliente
     	inner join detalle_pedido dp on p.codigo_pedido = dp.codigo_pedido 
     	inner join producto p2 on p2.codigo_producto = dp.codigo_producto ;
     

/*1.4.6 Consultas multitabla (Composición externa)
Resuelva todas las consultas utilizando las cláusulas LEFT JOIN, RIGHT JOIN, NATURAL LEFT JOIN y NATURAL RIGHT JOIN.

Devuelve un listado que muestre solamente los clientes que no han realizado ningún pago.*/
     
     
     	select c.nombre_cliente , p.total 
     	FROM pago p  right join cliente c 
     	on p.codigo_cliente =c.codigo_cliente 
     	where p.total is null;
     
     	select c.nombre_cliente , p.total 
     	FROM cliente c left join pago p  
     	on p.codigo_cliente =c.codigo_cliente 
     	where p.total is null;
     
     	select c.nombre_cliente , p.total 
     	FROM pago p  natural right join cliente c  
     	where p.total is null;

-- Devuelve un listado que muestre solamente los clientes que no han realizado ningún pedido.
     
     	
     	select c.nombre_cliente , p.codigo_pedido 
     	FROM pedido p  right join cliente c 
     	on p.codigo_cliente  =c.codigo_cliente 
     	where p.codigo_pedido  is null;
     
     
     	select c.nombre_cliente , p.codigo_pedido 
     	FROM pedido p  natural right join cliente c 
     	where p.codigo_pedido  is null;
     

-- Devuelve un listado que muestre los clientes que no han realizado ningún pago y los que no han realizado ningún pedido.
     
     
     	SELECT c.nombre_cliente 
     	FROM cliente c left join pago p 
     	on p.codigo_cliente = c.codigo_cliente 
		LEFT join pedido pe ON pe.codigo_cliente = c.codigo_cliente 
		WHERE (pe.codigo_pedido is null or p.codigo_cliente is null)
		
     

-- Devuelve un listado que muestre solamente los empleados que no tienen una oficina asociada.
		
		
		SELECT e.nombre , e.apellido1 , o.codigo_oficina 
		FROM empleado e left join oficina o 
		on e.codigo_oficina = o.codigo_oficina 
		WHERE o.codigo_oficina is null;
	
	
		SELECT e.nombre , e.apellido1 , o.codigo_oficina 
		FROM empleado e  natural left join oficina o 
		WHERE o.codigo_oficina is null;
	
	

-- Devuelve un listado que muestre solamente los empleados que no tienen un cliente asociado.

	
		SELECT e.nombre as empleado, c.nombre_cliente as cliente 
		FROM  cliente c right join empleado e
		on c.codigo_empleado_rep_ventas = e.codigo_empleado 
		WHERE c.codigo_cliente is null;
	
	
	
-- muestre solamente los empleados que no tienen un cliente asociado junto con los datos de la oficina donde trabajan.
	
	
		SELECT e.nombre as epmleado, c.nombre_cliente as cliente , o.*
		FROM  cliente c right join empleado e
		on c.codigo_empleado_rep_ventas = e.codigo_empleado
		inner join oficina o on o.codigo_oficina = e.codigo_oficina 
		WHERE c.codigo_cliente is null;
	

-- Devuelve un listado que muestre los empleados que no tienen una oficina asociada y los que no tienen un cliente asociado.
	
	
		SELECT e.nombre as epmleado, c.nombre_cliente as cliente , o.codigo_oficina 
		FROM  cliente c right join empleado e
		on c.codigo_empleado_rep_ventas = e.codigo_empleado
		inner join oficina o on o.codigo_oficina = e.codigo_oficina 
		WHERE c.codigo_cliente is null or o.codigo_oficina is null;
		
		

-- Devuelve un listado de los productos que nunca han aparecido en un pedido.
	
	
		SELECT p.nombre , dp.codigo_pedido 
		FROM  detalle_pedido dp natural right join  producto p
		WHERE dp.codigo_pedido is null;
	
	

--  productos que nunca han aparecido en un pedido. El resultado debe mostrar el nombre, la descripción y la imagen del producto.
	
	
		SELECT DISTINCT dp.codigo_pedido , p.nombre , p.gama , g.imagen 
		FROM  detalle_pedido dp natural right join  producto p
		inner join gama_producto g on g.gama = p.gama 
		WHERE dp.codigo_pedido is null;
	

/*oficinas donde no trabajan ninguno de los empleados que hayan sido los representantes de ventas de algún cliente
 que haya realizado la compra de algún producto de la gama Frutales.*/
	
		
		SELECT DISTINCT o.codigo_oficina, o.ciudad
		FROM oficina o
		WHERE o.codigo_oficina NOT IN
    	(
    		SELECT o2.codigo_oficina
	    	FROM oficina o2
	        INNER JOIN empleado e
	            ON o2.codigo_oficina = e.codigo_oficina
	        INNER JOIN cliente c
	            ON c.codigo_empleado_rep_ventas = e.codigo_empleado
	        INNER JOIN pedido p
	            ON c.codigo_cliente = p.codigo_cliente
	        INNER JOIN detalle_pedido dp
	            ON p.codigo_pedido = dp.codigo_pedido
	        INNER JOIN producto p2
	            ON dp.codigo_producto = p2.codigo_producto
	        INNER JOIN gama_producto gp
	            ON p2.gama = gp.gama
	    	WHERE gp.gama = 'Frutales'
    );
	

-- Devuelve un listado con los clientes que han realizado algún pedido pero no han realizado ningún pago.
   
   
   		SELECT c.nombre_cliente , pe.codigo_pedido , pa.total 
   		FROM cliente c inner join  pedido pe on pe.codigo_cliente = c.codigo_cliente 
   		left join pago pa on pa.codigo_cliente = c.codigo_cliente 
   		WHERE pa.total is null;
     

-- Devuelve un listado con los datos de los empleados que no tienen clientes asociados y el nombre de su jefe asociado.*/
	
	
	
		SELECT e.nombre as empleado, c.nombre_cliente as cliente , e2.nombre as jefe
		FROM  cliente c right join empleado e
		on c.codigo_empleado_rep_ventas = e.codigo_empleado 
		inner join empleado e2 on e2.codigo_empleado = e.codigo_jefe 
		WHERE c.codigo_cliente is null;
	
	
	
	
	