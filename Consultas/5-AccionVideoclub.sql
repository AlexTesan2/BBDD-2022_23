
-- 41. Borrar todos los registros de clientes que residan fuera de Zaragoza.


		DELETE 
		FROM Clientes c 
		WHERE c.CIUDAD  != 'Zaragoza';

		


-- 42. Borrar todos los registros de Peliculas cuyo precio sea inferior a 15 €.

	
		DELETE 
		FROM Peliculas p 
		WHERE p.PRECIO < 15;


-- 43. Borrar todos los registros de películas que empiecen por H.


		DELETE  
		FROM Peliculas p 
		WHERE p.TITULO LIKE 'h%';


-- 44. Borrar todos los registros de películas cuya modalidad sea ESTRENO

	
		DELETE p.*
		FROM Peliculas p , Generos g 
		WHERE g.CODIGOGENERO = p.GENERO AND g.NOMBREGENERO ='Estreno'




-- 45. Borrar todos los registros de películas del género de TERROR

		
		DELETE  p.*
		FROM Peliculas p , Generos g 
		WHERE g.CODIGOGENERO = p.GENERO AND g.NOMBREGENERO ='Terror';




-- 46. Borrar todos los registros de películas cuyo género sea AVENTURAS y hayan sido adquiridas en el año 98

		
		DELETE  p.*
		FROM Peliculas p , Generos g , Alquileres a 
		WHERE p.GENERO = g.CODIGOGENERO  AND g.NOMBREGENERO ='Aventuras'
			AND p.CODIGOPELICULA = a.CODIGOPELICULA AND YEAR(a.FECHADESCARGA)=1998;




-- 47. Añadir un registro nuevo en Generos cuyo numero sea 14 y se denomine DOCUMENTAL

		
		INSERT INTO Generos (CODIGOGENERO,NOMBREGENERO)
		VALUES (14,'Documental');



-- 48. Añadir un registro nuevo en la tabla de clientes cuya información corresponda a vuestros datos personales.


	INSERT INTO Clientes c (c.NOMBRECLIENTE, c.APELLIDO1CLIENTE)
	VALUES ('Alex', 'Tesán');




/*49. Crear una tabla vacía (llamada CopiaGeneros) con los mismos campos de la tabla de
Generos. Traspasar toda la información de Generos a CopiaGeneros.*/


	CREATE TABLE CopiaGeneros(codigoGenero integer not null, nombreGenero varchar(100) )
	SELECT g.CODIGOGENERO , g.NOMBREGENERO 
	FROM Generos g ;

-- ---------------------------------------


	CREATE TABLE copia_generos LIKE Generos;
	INSERT Into copia_generos SELECT * FROM Generos g;



-- 50. Eliminar los registros de la tabla de CopiaGeneros cuyo nombre comience por C


		DELETE 
		FROM CopiaGeneros c
		WHERE c.NOMBREGENERO Like 'C%';
	



-- 51. Añadir a la tabla CopiaGeneros los registros de Generos cuyo nombre comience por C


		INSERT INTO CopiaGeneros 
		SELECT *
		FROM Generos g
		WHERE g.NOMBREGENERO Like 'C%';
	
		- ----------------
		
		INSERT INTO CopiaGeneros c (c.CODIGOGENERO, c.NOMBREGENERO) 
		SELECT (g.CODIGOGENERO, g.NOMBREGENERO)
		FROM Generos g
		WHERE g.NOMBREGENERO Like 'C%';



/*52. Crear una tabla vacía (llamada Infantiles) con los mismos campos de la tabla de
Peliculas. Traspasar todos los registros de la tabla Peliculas a la tabla Infantiles, que
tengan como genero Infantil, Aventuras, Ciencia-ficción*/


		CREATE Table Infantiles like Peliculas;
		Insert into Infantiles
		select p.* 
		from Peliculas p, Generos g
		WHERE g.CODIGOGENERO = p.GENERO AND g.NOMBREGENERO IN ('Infantil', 'Aventuras', 'Ciencia-ficción');



/*53. Dividir la tabla de clientes en dos tablas llamadas Capital y Provincias con la misma
estructura, en la primera guardaremos todos los registros de clientes que sean de
Zaragoza y en Provincias el resto.*/

	
		CREATE TABLE Capital LIKE Clientes;
		CREATE TABLE Provincias LIKE Clientes;
	
		INSERT Into Capital 
		SELECT  c.*  FROM Clientes c
		WHERE c.PROVINCIA = 'Zaragoza';
	
		INSERT Into Procincias 
		SELECT  c.*  FROM Clientes c
		WHERE c.PROVINCIA != 'Zaragoza';




-- 54. Modificar el campo de Codigo Postal de la tabla de clientes para que a todos les aparezca 50900


		UPDATE Clientes c 
		SET c.codigopostal = 50900;
		




/*55. Modificar el campo de Observaciones de la tabla de clientes para que a todos les
ponga un CODIGO formado por 3 caracteres de la izda del nombre + los 2
ultimos del 2 apellido+ 3 digitos centrales del telefono*/
	
	
		UPDATE Clientes c 
		SET c.OBSERVACIONES  =
		(
			SELECT CONCAT( LEFT(c.NOMBRECLIENTE, 3),RIGHT(c.APELLIDO2CLIENTE, 2),MID(c.TELEFONO,3,2) )
		);






/*56. Modificar el campo de Observaciones de la tabla de clientes para que a todos los que
se dieron de alta en el mes de Abril del 99 les aparezca el mensaje de BONIFICADO*/


		UPDATE Clientes c 
		SET c.OBSERVACIONES = 'Bonificado'
		WHERE YEAR (c.FECHALTA)=1999 AND MONTH (c.FECHALTA)=4;



/*57. Modificar el campo de Ciudad de la tabla de clientes para que todos los que residan
en Zaragoza les aparezca la ciudad en mayúsculas.*/


		UPDATE Clientes c
		SET c.CIUDAD = 'ZARAGOZA'
		WHERE c.CIUDAD = 'Zaragoza';




-- 58. Modificar el título de películas para que en todas que empiecen por R les aparezca ----


		UPDATE Peliculas p
		SET p.TITULO = '----'
		WHERE p.TITULO LIKE 'r%';




-- 59. Incrementar el precio de cada película un cinco por ciento.


		UPDATE Peliculas p 
		set p.PRECIO = (p.PRECIO+(p.PRECIO*5)/100);



-- 60. Acentuar el apellido de López en la tabla de Clientes.


		UPDATE Clientes c 
		SET c.APELLIDO1CLIENTE = 'López'
		WHERE c.APELLIDO1CLIENTE = 'Lopez';
		UPDATE Clientes c 
		SET c.APELLIDO2CLIENTE = 'López'
		WHERE c.APELLIDO2CLIENTE ='Lopez';




























