-- 1.8.3 Funciones sin sentencias SQL

SET GLOBAL log_bin_trust_function_creators = 1;


-- Escribe una función que reciba un número entero de entrada y devuelva TRUE si el número es par o FALSE en caso contrario.


DELIMITER $$
DROP FUNCTION IF EXISTS esPar;

CREATE FUNCTION esPar(num int)
  RETURNS boolean # no sql
BEGIN
  DECLARE respuesta boolean ;
 
	if num%2=0 then
		set respuesta= TRUE ;
	else 
		set respuesta=FALSE ;
	end if;

  RETURN respuesta;
END;
$$

DELIMITER ;
SELECT esPar(8);


DELIMITER $$
DROP FUNCTION IF EXISTS es_numero_par 
CREATE FUNCTION es_numero_par(numero INT UNSIGNED)
    RETURNS BOOLEAN NO SQL
    BEGIN
        IF numero%2 = 0 THEN
            RETURN TRUE;
        ELSE
            RETURN FALSE;
        END IF;
    END ;
DELIMITER ;
SELECT IF (es_numero_par(1), 'TRUE', 'FALSE') AS 'Par?';



-- Escribe una función que devuelva el valor de la hipotenusa de un triángulo a partir de los valores de sus lados.

DELIMITER $$
DROP FUNCTION IF EXISTS hipotenusa;

CREATE FUNCTION hipotenusa(cateto1 int, cateto2 int)
  RETURNS float no sql 
BEGIN
  DECLARE hipoCua int;
  DECLARE hipo float;
 
	set hipoCua=((cateto1*cateto1)+(cateto2*cateto2));
	set hipo=SQRT(hipoCua);
	
  RETURN hipo;
END;
$$

DELIMITER ;
SELECT hipotenusa(2,2);



/*Escribe una función que reciba como parámetro de entrada un valor numérico que represente un día de la semana y que devuelva 
una cadena de caracteres con el nombre del día de la semana correspondiente. Por ejemplo, para el valor de entrada 1 debería
devolver la cadena lunes.*/


DELIMITER $$
DROP FUNCTION IF EXISTS semana;

CREATE FUNCTION semana(dia int)
  RETURNS Varchar (20) no sql 
BEGIN
  DECLARE nombre Varchar(20);
 
	SELECT 
		CASE 
			when dia=1 then "Lunes"
			when dia=2 then "Martes"
			when dia=3 then "Miercoles"
			when dia=4 then "Jueves"
			when dia=5 then "Viernes"
			when dia=6 then "Sabado"
			when dia=7 then "Domingo"
			else "entrada no valida"
		end 
		into nombre;
  RETURN nombre;
END;
$$

DELIMITER ;
SELECT semana(5);


/*
Escribe una función que reciba tres números reales como parámetros de entrada y devuelva el mayor de los tres.*/


DELIMITER $$
DROP FUNCTION IF EXISTS mayor;

	CREATE FUNCTION mayor(x int,y int, z int)
	  RETURNS int no sql
	BEGIN
	  DECLARE maximo int;
	 	set maximo=x;
	 
	 	if y>maximo then
	 		set maximo=y; 
	 	end if;
	 
	 	if z>maximo then
	 		set maximo=z;
	 	end if;
	
	  RETURN maximo;
	END;
$$

DELIMITER ;
SELECT mayor(5,7,1);



#función que devuelva el valor del área de un círculo a partir del valor del radio que se recibirá como parámetro de entrada.

DELIMITER $$
DROP FUNCTION IF EXISTS area_circulo;

CREATE FUNCTION area_circulo(radio INT UNSIGNED)
    RETURNS VARCHAR(40) NO SQL
    BEGIN
        IF (radio > 0) THEN
            RETURN PI()*POW(radio, 2);
        ELSE
            RETURN 'El radio tiene que ser mayor de 0';
        END IF;
    END 
    $$
DELIMITER ;
SELECT area_circulo(9 );



/*Escribe una función que devuelva como salida el número de años que han transcurrido entre dos fechas que se reciben
como parámetros de entrada. Por ejemplo, si pasamos como parámetros de entrada las fechas 2018-01-01 y 2008-01-01 la 
función tiene que devolver que han pasado 10 años.Para realizar esta función puede hacer uso de las siguientes funciones
 que nos proporciona MySQL: DATEDIFF  TRUNCATE**/

DELIMITER $$
DROP FUNCTION IF EXISTS CalcularAnnos;

CREATE FUNCTION CalcularAnnos(fecha1 DATE, fecha2 DATE)
RETURNS INT
BEGIN
  DECLARE dias INT;
  DECLARE operacion int;
  
  SET dias = DATEDIFF(fecha1, fecha2);
  set operacion=(dias/365);
  
  RETURN operacion;
END;


DELIMITER ;

SELECT CalcularAnnos('2018-01-01','2008-01-01');



/*
Escribe una función que reciba una cadena de entrada y devuelva la misma cadena pero sin acentos. La función tendrá que 
reemplazar todas las vocales que tengan acento por la misma vocal pero sin acento. Por ejemplo, si la función recibe como 
parámetro de entrada la cadena María la función debe devolver la cadena Maria.*/


DELIMITER $$
DROP FUNCTION IF EXISTS quitar_acentos ;

CREATE FUNCTION quitar_acentos(cadena VARCHAR(50))
    RETURNS VARCHAR(50) NO SQL
    BEGIN
        SET cadena = REPLACE(cadena, 'á', 'a');
        SET cadena = REPLACE(cadena, 'é', 'e');
        SET cadena = REPLACE(cadena, 'í', 'i');
        SET cadena = REPLACE(cadena, 'ó', 'o');
        SET cadena = REPLACE(cadena, 'ú', 'u');
        SET cadena = REPLACE(cadena, 'Á', 'A');
        SET cadena = REPLACE(cadena, 'É', 'E');
        SET cadena = REPLACE(cadena, 'Í', 'I');
        SET cadena = REPLACE(cadena, 'Ó', 'O');
        SET cadena = REPLACE(cadena, 'Ú', 'U');
        RETURN cadena;
    END ;
   
DELIMITER ;
SELECT quitar_acentos('ÁÉÍÓÚ áéíóú ¿desacentuará o no desacentuará?');



-- 1.8.4 Funciones con sentencias SQL

use tienda;

-- Escribe una función para la base de datos tienda que devuelva el número total de productos que hay en la tabla productos.


DELIMITER $$
DROP FUNCTION IF EXISTS totalProductos;

	CREATE FUNCTION totalProductos()
	  RETURNS int 
	BEGIN
	  DECLARE total int;
	 
	 	SELECT COUNT(p.id) 
	 	FROM producto p 
	 	into total;
	  RETURN total;
	 
	END;
$$

DELIMITER ;
SELECT totalProductos();


/*Escribe una función para la base de datos tienda que devuelva el valor medio del precio de los productos de un determinado
fabricante que se recibirá como parámetro de entrada. El parámetro de entrada será el nombre del fabricante.*/

DELIMITER $$
DROP FUNCTION IF EXISTS mediaPrecio;

	CREATE FUNCTION mediaPrecio(fabricante Varchar(40))
	  RETURNS int DETERMINISTIC
	BEGIN
	  DECLARE media int;
	 
	 	SELECT AVG(p.precio) 
	 	FROM producto p   #INNER JOIN fabricante f ON p.id_fabricante = f.id WHERE f.nombre = fabricante;
	 	WHERE p.id_fabricante =
	 	(
			SELECT 	f.id 
			FROM fabricante f 
			WHERE f.nombre = fabricante
	 	)
	 	into media;
	  RETURN media;
	 
	END;
$$

DELIMITER ;
SELECT mediaPrecio("Asus");
SELECT mediaPrecio("Xiaomi");
SELECT mediaPrecio("Hewlett-Packard");
SELECT mediaPrecio("Samsung");


/*Escribe una función para la base de datos tienda que devuelva el valor máximo del precio de los productos de un determinado
 fabricante que se recibirá como parámetro de entrada. El parámetro de entrada será el nombre del fabricante.*/

DELIMITER $$
DROP FUNCTION IF EXISTS maximoPrecio;

	CREATE FUNCTION maximoPrecio(fabricante Varchar(40))
	  RETURNS int DETERMINISTIC
	BEGIN
	  DECLARE maximo int;
	 
	 	SELECT MAX(p.precio) 
	 	FROM producto p 
	 	WHERE p.id_fabricante =
	 	(
			SELECT 	f.id 
			FROM fabricante f 
			WHERE f.nombre = fabricante
	 	)
	 	into maximo;
	  RETURN maximo;
	 
	END;
$$

DELIMITER ;
SELECT maximoPrecio("Asus");
SELECT maximoPrecio("Hewlett-Packard");
SELECT maximoPrecio("Samsung");



/*Escribe una función para la base de datos tienda que devuelva el valor mínimo del precio de los productos de un determinado
 fabricante que se recibirá como parámetro de entrada. El parámetro de entrada será el nombre del fabricante.*/



DELIMITER $$
DROP FUNCTION IF EXISTS minPrecio;

	CREATE FUNCTION minPrecio(fabricante Varchar(40))
	  RETURNS int unsigned deterministic
	BEGIN
	  DECLARE minimo int;
	 
	 	SELECT MIN(p.precio) 
	 	FROM producto p 
	 	WHERE p.id_fabricante =
	 	(
			SELECT 	f.id 
			FROM fabricante f 
			WHERE f.nombre = fabricante
	 	)
	 	into minimo;
	  RETURN minimo;
	 
	END
$$

DELIMITER ;
SELECT minPrecio("Asus");
SELECT minPrecio("Hewlett-Packard");
SELECT minPrecio("Samsung");


DELIMITER $$
DROP FUNCTION IF EXISTS producto_menor_valor_fabricante 
CREATE FUNCTION producto_menor_valor_fabricante(fabricante VARCHAR(20))
    RETURNS INT UNSIGNED DETERMINISTIC
    BEGIN
        DECLARE valorMin INT UNSIGNED;
        SELECT MIN(p.precio) INTO valorMin
        FROM producto p
        INNER JOIN fabricante f
            ON p.id_fabricante = f.id
        WHERE f.nombre = fabricante;
        RETURN valorMin;
    END ;
DELIMITER ;
SELECT producto_menor_valor_fabricante('Asus');


	























