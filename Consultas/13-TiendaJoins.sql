/*1.1.4 Consultas multitabla (Composición interna)
Resuelva todas las consultas utilizando la sintaxis de SQL1 y SQL2.*/

-- Devuelve una lista con el nombre del producto, precio y nombre de fabricante de todos los productos de la base de datos.



		SELECT p.nombre , p.precio , f.nombre 
		FROM producto p , fabricante f 
		WHERE p.id_fabricante = f.id ;
	
	
		SELECT p.nombre , p.precio , f.nombre 
		FROM producto p
		inner join fabricante f on f.id = p.id_fabricante ;
	
	
	
	
	

/*Devuelve una lista con el nombre del producto, precio y nombre de fabricante de todos los productos de la base de datos.
Ordene el resultado por el nombre del fabricante, por orden alfabético.*/
	
	
		SELECT p.nombre , p.precio , f.nombre 
		FROM producto p , fabricante f 
		WHERE p.id_fabricante = f.id 
		ORDER by f.nombre ASC ;
	
	
	
		SELECT p.nombre , p.precio , f.nombre 
		FROM producto p
		inner join fabricante f on f.id = p.id_fabricante 
		ORDER by f.nombre ASC ;

	


/*Devuelve una lista con el identificador del producto, nombre del producto, identificador del 
fabricante y nombre del fabricante, de todos los productos de la base de datos.*/

	
	SELECT p.id , p.nombre , f.id , f.nombre 
	FROM producto p , fabricante f 
	WHERE p.id_fabricante = f.id ;
	


	SELECT p.id , p.nombre , f.id , f.nombre 
	FROM producto p 
	INNER join fabricante f on f.id =p.id_fabricante ;
	
	
	
-- Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto más barato.
	
	
		SELECT p.nombre , p.precio, f.nombre  
		FROM fabricante f , producto p 
		WHERE p.id_fabricante = f.id 
		ORDER BY p.precio ASC
		limit 1;
		
	
		SELECT p.nombre , p.precio, f.nombre  
		from producto p inner join fabricante f on f.id = p.id_fabricante 
		ORDER BY p.precio ASC
		limit 1;
		

-- Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto más caro.
	
	
		SELECT p.nombre , p.precio, f.nombre  
		FROM fabricante f , producto p 
		WHERE p.id_fabricante = f.id 
		ORDER BY p.precio DESC 
		limit 1;
		
	
		SELECT p.nombre , p.precio, f.nombre  
		from producto p inner join fabricante f on f.id = p.id_fabricante 
		ORDER BY p.precio DESC 
		limit 1;

	
-- Devuelve una lista de todos los productos del fabricante Lenovo.
	
	
		SELECT p.nombre , f.nombre 
		FROM producto p , fabricante f 
		WHERE p.id_fabricante = f.id 
		AND f.nombre ="Lenovo";
	
		SELECT p.nombre, f.nombre  
		from producto p inner join fabricante f on f.id = p.id_fabricante 
		WHERE f.nombre ="Lenovo";
		
	

-- Devuelve una lista de todos los productos del fabricante Crucial que tengan un precio mayor que 200€.
	
	
		SELECT p.nombre ,p.precio , f.nombre 
		FROM producto p , fabricante f 
		WHERE p.id_fabricante = f.id 
		AND f.nombre ="Crucial"
		and p.precio > 200;
	
		SELECT p.nombre,p.precio , f.nombre  
		from producto p inner join fabricante f on f.id = p.id_fabricante 
		WHERE f.nombre ="Crucial"
		AND p.precio > 200;
	
	

-- Devuelve un listado con todos los productos de los fabricantes Asus, Hewlett-Packard y Seagate. Sin utilizar el operador IN.
	
		
		SELECT p.nombre , f.nombre 
		FROM producto p , fabricante f 
		WHERE p.id_fabricante = f.id 
		AND (f.nombre = "Asus" or f.nombre = "Hewlett-Packard" or f.nombre = "Seagate");
	
		SELECT p.nombre , f.nombre 
		FROM producto p inner join fabricante f on f.id = p.id_fabricante 
		WHERE (f.nombre = "Asus" or f.nombre = "Hewlett-Packard" or f.nombre = "Seagate");
		
		
		
	

#Devuelve un listado con todos los productos de los fabricantes Asus, Hewlett-Packard y Seagate. Utilizando el operador IN.
	
	
		SELECT p.nombre , f.nombre 
		FROM producto p , fabricante f 
		WHERE p.id_fabricante = f.id 
		AND f.nombre  IN ("Asus","Hewlett-Packard", "Seagate");
	
	
		SELECT p.nombre , f.nombre 
		FROM producto p inner join fabricante f on f.id = p.id_fabricante 
		WHERE f.nombre  IN ("Asus","Hewlett-Packard", "Seagate");
	
	

#Devuelve un listado con el nombre y el precio de todos los productos de los fabricantes cuyo nombre termine por la vocal e.
	
	
		SELECT p.nombre, p.precio  , f.nombre 
		FROM producto p , fabricante f 
		WHERE p.id_fabricante = f.id 
		AND f.nombre like "%e";
	
		SELECT p.nombre, p.precio  , f.nombre  
		FROM producto p inner join fabricante f on f.id = p.id_fabricante
		WHERE f.nombre like "%e";
		
	

-- Devuelve el nombre y el precio de todos los productos cuyo nombre de fabricante contenga el carácter w en su nombre.
	
		SELECT p.nombre ,f.nombre ,p.precio   
		FROM producto p , fabricante f 
		WHERE f.id = p.id_fabricante 
		AND f.nombre like "%w%";
	
		SELECT p.nombre, p.precio  , f.nombre  
		FROM producto p inner join fabricante f on f.id = p.id_fabricante
		WHERE f.nombre like "%w%";
		
	
	

# n.producto, precio y nombre de fabricante, de todos los productos que tengan un precio mayor o igual a 180€. Ordene el 
#resultado en primer lugar por el precio (en orden descendente) y en segundo lugar por el nombre (en orden ascendente)
	
	
		SELECT p.nombre , p.precio , f.nombre 
		FROM  producto p , fabricante f 
		WHERE p.id_fabricante = f.id AND p.precio > 180
		order by p.precio desc , p.nombre asc;
	
		SELECT p.nombre , p.precio , f.nombre 
		from producto p inner join fabricante f on f.id = p.id_fabricante 
		WHERE p.precio > 180 
		order by p.precio desc , p.nombre asc;
	

-- Devuelve el id y el nombre de fabricante, solamente de aquellos fabricantes que tienen productos asociados en la base de datos.
	
		SELECT DISTINCT  f.id , f.nombre 
		from producto p ,fabricante f 
		WHERE f.id = p.id_fabricante ;
	
	

/*1.1.5 Consultas multitabla (Composición externa)
Resuelva todas las consultas utilizando las cláusulas LEFT JOIN y RIGHT JOIN.*/

/*Devuelve un listado de todos los fabricantes que existen en la base de datos, junto con los productos que tiene cada 
 uno de ellos. El listado deberá mostrar también aquellos fabricantes que no tienen productos asociados.*/
	
	
	
		SELECT	f.nombre , p.nombre 
		FROM fabricante f left JOIN producto p 
		on f.id = p.id_fabricante
		order by f.nombre ;
	
	
		SELECT	f.nombre , p.nombre 
		FROM producto p right JOIN fabricante f
		on p.id_fabricante=f.id 
		order by f.nombre ;

-- Devuelve un listado donde sólo aparezcan aquellos fabricantes que no tienen ningún producto asociado.
	
		SELECT f.nombre , p.nombre 
		FROM fabricante f left join producto p 
		on  f.id = p.id_fabricante
		WHERE p.nombre  is NULL ;

-- ¿Pueden existir productos que no estén relacionados con un fabricante? Justifique su respuesta.*/
	
	/* Sí, en una consulta SQL es posible que existan productos que no estén relacionados con un fabricante 
	  Si se utiliza un JOIN se podrán recuperar solo aquellos productos que tengan una correspondencia en la tabla de fabricantes.
	 */
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	