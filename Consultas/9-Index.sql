/*Consulte cuáles son los índices que hay en la tabla producto utilizando las instrucciones SQL que nos permiten obtener 
esta información de la tabla. */

	SHOW INDEX FROM producto;


/*Haga uso de EXPLAIN para obtener información sobre cómo se están realizando las consultas y
diga cuál de las dos consultas realizará menos comparaciones para encontrar el producto que estamos buscando.
¿Cuántas comparaciones se realizan en cada caso? ¿Por qué?.*/



EXPLAIN SELECT *
FROM producto
WHERE codigo_producto = 'OR-114';

		#solo se compara una fila ya que tiene un indice sobre el codigo del producto.


EXPLAIN SELECT *
FROM producto
WHERE nombre = 'Evonimus Pulchellus';

		#se comparan 276 filas, ya que no tiene ningun indice creado.



/*Suponga que estamos trabajando con la base de datos jardineria y queremos saber optimizar las siguientes consultas. ¿Cuál de las
 dos sería más eficiente?. Se recomienda hacer uso de EXPLAIN para obtener información sobre cómo se están realizando las consultas.*/


EXPLAIN SELECT AVG(total)
FROM pago
WHERE YEAR(fecha_pago) = 2008;

		# La función YEAR no se aprobecha de los indices por lo que si la siguiente consulta utilizas index, la segunda sería mas eficiente  


EXPLAIN SELECT AVG(total)
FROM pago
WHERE fecha_pago >= '2008-01-01' AND fecha_pago <= '2008-12-31';

		#esta consulta si que se podria aprobechar de los indices y ser mas eficiente, pero no hay ningun indice que influya sobre fecha_pago
		#CONCLUSION: ambas analizan 26 filas, por lo ambas son iguales

-- Nota: Lectura recomendada sobre la función YEAR y el uso de índices.


/*Optimiza la siguiente consulta creando índices cuando sea necesario. Se recomienda hacer uso de EXPLAIN para obtener 
información sobre cómo se están realizando las consultas.*/

show index from pedido ;


CREATE index pedido_codigo_cliente_INDX using BTREE on jardineria.pedido (codigo_cliente);
CREATE INDEX cliente_nombre_cliente_IDX USING BTREE ON jardineria.cliente (nombre_cliente);

EXPLAIN SELECT *
FROM cliente INNER JOIN pedido
ON cliente.codigo_cliente = pedido.codigo_cliente
WHERE cliente.nombre_cliente LIKE 'A%';


-- ¿Por qué no es posible optimizar el tiempo de ejecución de las siguientes consultas, incluso haciendo uso de índices?



explain SELECT *
FROM cliente INNER JOIN pedido
ON cliente.codigo_cliente = pedido.codigo_cliente
WHERE cliente.nombre_cliente LIKE '%A%';

explain SELECT *
FROM cliente INNER JOIN pedido
ON cliente.codigo_cliente = pedido.codigo_cliente
WHERE cliente.nombre_cliente LIKE '%A';

		#Estas consultas utilizan like, los like no se aprovecha de los indices, por lo que no se pueden optimizar


-- Crea un índice de tipo FULLTEXT sobre las columnas nombre y descripcion de la tabla producto.


		CREATE fulltext index producto_nombre_descripcion_INDX on jardineria.producto (nombre, descripcion);
	
		show index from producto;
	
	

/*Una vez creado el índice del ejercicio anterior realiza las siguientes consultas haciendo uso de la función MATCH,
para buscar todos los productos que:

Contienen la palabra planta en el nombre o en la descripción. Realice una consulta para cada uno de los modos de búsqueda 
full-text que existen en MySQL (IN NATURAL LANGUAGE MODE, IN BOOLEAN MODE y WITH QUERY EXPANSION) y compare los resultados
 que ha obtenido en cada caso.*/
	
	
		explain 
		SELECT *
		FROM producto
		WHERE MATCH (nombre, descripcion) AGAINST ('planta' in NATURAL LANGUAGE MODE);	#5 resultados
		
		
		
		SELECT * 
		FROM producto 
		WHERE MATCH (nombre, descripcion) against ('+planta' in boolean MODE );	#5 resultados
		
-- Permite utilizar operadores de búsqueda (+ (AND) con esta palabra, -(NOT) sin esta palabra, si no pongo nada es como un OR)
		
		
		
		SELECT * 
		FROM producto  
		WHERE MATCH (nombre, descripcion) against ('planta' WITH QUERY EXPANSION ); #131 resultados

		
-- Contienen la palabra planta seguida de cualquier carácter o conjunto de caracteres, en el nombre o en la descripción.
		
		
		SELECT p.*
		FROM producto p 
		WHERE MATCH (nombre, descripcion) against ('planta*' in boolean mode);
	
	
	
-- Empiezan con la palabra planta en el nombre o en la descripción.
	
	
		SELECT *
		FROM producto
		WHERE MATCH(nombre, descripcion) AGAINST ('planta' IN BOOLEAN MODE) 
    		AND nombre LIKE 'planta%' OR descripcion LIKE 'planta%';
   
   
	
-- Contienen la palabra tronco o la palabra árbol en el nombre o en la descripción.
    	
    	
		SELECT p.*
		FROM producto p 
		WHERE MATCH (nombre, descripcion) against ('tronco arbol' in boolean mode);
	
	
-- Contienen la palabra tronco y la palabra árbol en el nombre o en la descripción.
	
	
		SELECT p.*
		FROM producto p 
		WHERE MATCH (nombre, descripcion) against ('+tronco +arbol' in boolean mode);
	
	
-- Contienen la palabra tronco pero no contienen la palabra árbol en el nombre o en la descripción.
	
		SELECT p.*
		FROM producto p 
		WHERE MATCH (nombre, descripcion) against ('+tronco -arbol' in boolean mode);
	
-- Contiene la frase proviene de las costas en el nombre o en la descripción.
	
	
		SELECT p.*
		FROM producto p 
		WHERE MATCH (nombre, descripcion) against ('"proviene de las costas"' in boolean mode);
	
	
/*Crea un índice de tipo INDEX compuesto por las columnas apellido_contacto y nombre_contacto de la tabla cliente.
Una vez creado el índice del ejercicio anterior realice las siguientes consultas haciendo uso de EXPLAIN:*/
	
	create index cliente__apellido_contacto__nombre_contacto on cliente(apellido_contacto, nombre_contacto );
	
	show index from cliente ;
	
	
-- Busca el cliente Javier Villar. ¿Cuántas filas se han examinado hasta encontrar el resultado?
	
		explain
		SELECT c.apellido_contacto , c.nombre_contacto 
		FROM cliente c 
		WHERE c.nombre_contacto = 'javier' and c.apellido_contacto = 'villar';
		
		# solo se ha examinado 1 fila porque se ha servido del index cliente__apellido_contacto__nombre_contacto
		
		
	
-- Busca el ciente anterior utilizando solamente el apellido Villar. ¿Cuántas filas se han examinado hasta encontrar el resultado?
		
		explain
		SELECT c.apellido_contacto , c.nombre_contacto 
		FROM cliente c 
		WHERE c.apellido_contacto = 'villar';
	
	# solo se ha examinado 1 fila
	
/*Busca el ciente anterior utilizando solamente el nombre Javier. ¿Cuántas filas se han examinado hasta encontrar el resultado? 
¿Qué ha ocurrido en este caso?*/
	
	
		explain
		SELECT c.apellido_contacto , c.nombre_contacto 
		FROM cliente c 
		WHERE c.nombre_contacto = 'javier'
		
		#se han examinado 36 filas 
	
	
	
/*Calcula cuál podría ser un buen valor para crear un índice sobre un prefijo de la columna nombre_cliente de la tabla cliente. 
Tenga en cuenta que un buen valor será aquel que nos permita utilizar el menor número de caracteres para diferenciar todos los 
valores que existen en la columna sobre la que estamos creando el índice.*/
#1 calculamos cuántos valores distintos existen en la columna nombre_cliente. Necesitarás utilizar la función COUNT y DISTINCT.
		
		
SELECT COUNT(DISTINCT c.nombre_cliente)
FROM cliente c;

--  35  resultados.
		
/*Haciendo uso de la función LEFT ve calculando el número de caracteres que necesitas utilizar como prefijo para diferenciar
 todos los valores de la columna. Necesitarás la función COUNT, DISTINCT y LEFT.*/

SELECT COUNT(DISTINCT (LEFT(c.nombre_cliente, 11)))
FROM cliente c;


#Una vez que hayas encontrado el valor adecuado para el prefijo, crea el índice sobre la columna nombre_cliente de la tabla cliente.

	CREATE index  nombre_clienteIndex on cliente(nombre_cliente(11)) ;

	show index from cliente;

#Ejecuta algunas consultas de prueba sobre el índice que acabas de crear.

EXPLAIN SELECT *
FROM cliente c
WHERE nombre_cliente = 'Camunas Jardines S.L.';



