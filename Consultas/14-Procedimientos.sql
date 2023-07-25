#Escribe un procedimiento que no tenga ningún parámetro de entrada ni de salida y que muestre el texto ¡Hola mundo!.

DELIMITER $$
	DROP PROCEDURE IF EXISTS imprimo
	
	CREATE PROCEDURE imprimo()
	BEGIN
	  SELECT "Hola mundo";
	END;
	
$$

DELIMITER ;
	call imprimo();



-- Procedimiento que reciba un número real de entrada y muestre un mensaje indicando si el número es positivo,negativo o cero.


DELIMITER $$
	DROP PROCEDURE IF EXISTS positivooNo $$
	
	CREATE PROCEDURE positivooNo( IN num tinyint)
	BEGIN
		SELECT 
		  CASE 
		  	WHEN num>0 THEN "Positivo"
		  	WHEN num<0 THEN "Negativo"
		  	ELSE  "ES CERO"
	      end ;
	END;
	$$
	
DELIMITER ;
	call positivooNo(0);
	call positivooNo(-2);
	call positivooNo(3);


-- ------------------------------------------------------------------


DELIMITER $$
	DROP PROCEDURE IF EXISTS positivooNoIf
	
	CREATE PROCEDURE positivooNoIf( IN num tinyint)
	BEGIN
		if num>0 then 
			SELECT "Positivo";
		elseif num<0 THEN 
			select "Negativo";
		ELSE
			select  "ES CERO";
	  	end if;
	END;
	$$
	
DELIMITER ;
	call positivooNoIf(0);
	call positivooNoIf(-2);
	call positivooNoIf(3);


/*Modifique el procedimiento diseñado en el ejercicio anterior para que tenga un parámetro de entrada, con el valor un número 
real, y un parámetro de salida, con una cadena de caracteres indicando si el número es positivo, negativo o cero.*/


DELIMITER $$
	DROP PROCEDURE IF EXISTS positivooNo2
	
	CREATE PROCEDURE positivooNo2( IN num tinyint, OUT frasecita varchar(20) )
	BEGIN
		SELECT 
			CASE 
			  WHEN num>0 THEN "Positivo"
			  WHEN num<0 THEN "Negativo"
			  ELSE "CERO"
		  	end
		Into frasecita;
	END;
	$$
	
DELIMITER ;

	call positivooNo2(0, @frasecita);
	call positivooNo2(-1, @frasecita);
	call positivooNo2(6, @frasecita);

	SELECT @frasecita;


/*

Escribe un procedimiento que reciba un número real de entrada, que representa el valor de la nota de un alumno, y 
muestre un mensaje indicando qué nota ha obtenido teniendo en cuenta las siguientes condiciones:
[0,5) = Insuficiente [5,6) = Aprobado [6, 7) = Bien [7, 9) = Notable [9, 10] = Sobresaliente
En cualquier otro caso la nota no será válida.*/

	
DELIMITER $$
	DROP PROCEDURE IF EXISTS nota
	
	CREATE PROCEDURE nota( IN correccion float)
	BEGIN
		SELECT 
			CASE 
			  WHEN correccion>=0 and correccion<5 THEN "Insuficiente"
			  WHEN correccion>=5 and correccion<6 THEN "Aprobado"
			  WHEN correccion>=6 and correccion<7 THEN "Bien"
			  WHEN correccion>=7 and correccion<9 THEN "Notable"
			  WHEN correccion>=9 and correccion<=10 THEN "Sobresaliente"
			  ELSE "Entrada no valida"
		  	end;
	END;
	$$
	
	--  otra forma : WHEN numero < 0 THEN SET salida = 'El número es negativo';
	
-- otra forma, sin begin/end, con select dentro de los then y con end case	
	DROP PROCEDURE IF EXISTS calificaciones 

	CREATE PROCEDURE calificaciones(IN numero REAL)
    CASE
        WHEN numero >= 0 AND numero < 5 THEN SELECT 'Insuficiente';
        WHEN numero >= 5 AND numero < 6 THEN SELECT 'Aprobado';
        WHEN numero >= 6 AND numero < 7 THEN SELECT 'Bien';
        WHEN numero >= 7 AND numero < 9 THEN SELECT 'Notable';
        WHEN numero >= 9 AND numero <= 10 THEN SELECT 'Sobresaliente';
        ELSE SELECT 'Nota no valida';
    END CASE
	    
	CALL calificaciones(10);    
	    
DELIMITER ;


/*
Modifique el procedimiento diseñado en el ejercicio anterior para que tenga un parámetro de entrada, con el valor de la nota
en formato numérico y un parámetro de salida, con una cadena de texto indicando la nota correspondiente.*/


	
DELIMITER $$
	
	DROP PROCEDURE IF EXISTS nota2
	
	CREATE PROCEDURE nota2( IN correccion float, OUT frasecita varchar(20))
	BEGIN
		SELECT 
			CASE # o then set frasecita='Bien';
			  WHEN correccion>=0 and correccion<5 THEN "Insuficiente"
			  WHEN correccion>=5 and correccion<6 THEN "Aprobado"
			  WHEN correccion>=6 and correccion<7 THEN "Bien"
			  WHEN correccion>=7 and correccion<9 THEN "Notable"
			  WHEN correccion>=9 and correccion<=10 THEN "Sobresaliente"
			  ELSE "Entrada no valida"
		  	end
		  	into frasecita;
	END;

	$$
DELIMITER ;

	call nota2(10, @frasecita);
	SELECT @frasecita;



/*
Escribe un procedimiento que reciba como parámetro de entrada un valor numérico que represente un día de la 
semana y que devuelva una cadena de caracteres con el nombre del día de la semana correspondiente. Por ejemplo, 
para el valor de entrada 1 debería devolver la cadena lunes.*/



DELIMITER $$
	
	DROP PROCEDURE IF EXISTS semana
	
	CREATE PROCEDURE semana( IN dia float, OUT frasecita varchar(20))
	BEGIN
		SELECT 
			CASE 
			  WHEN dia = 1 THEN "lunes"
			  WHEN dia = 2 THEN "martes"
			  WHEN dia = 3 THEN "miercoles"
			  WHEN dia = 4 THEN "jueves"
			  WHEN dia = 5 THEN "viernes"
			  WHEN dia = 6 THEN "sabado"
			  WHEN dia = 7 THEN "domingo"
			  ELSE "Entrada no valida"
		  	end
		 into frasecita;
	END;

	$$
DELIMITER ;

	call semana(3, @frasecita);
	SELECT @frasecita;


/*Escribe un procedimiento que reciba el nombre de un país como parámetro de entrada y realice una consulta sobre la tabla cliente
para obtener todos los clientes que existen en la tabla de ese país.*/



DELIMITER $$
	
	DROP PROCEDURE IF EXISTS paisCleiente
	
	CREATE PROCEDURE paisCliente( IN paisQueMePasas varchar(20))
	BEGIN
		SELECT c.codigo_cliente ,c.nombre_cliente , c.pais 
		FROM cliente c 
		WHERE c.pais = paisQueMePasas;
	END;
$$
DELIMITER ;

	call paisCliente("Spain");








/*Escribe un procedimiento que reciba como parámetro de entrada una forma de pago, que será una cadena de caracteres
(Ejemplo: PayPal, Transferencia, etc). Y devuelva como salida el pago de máximo valor realizado para esa forma de pago.
Deberá hacer uso de la tabla pago de la base de datos jardineria.*/


DELIMITER $$
	
	DROP PROCEDURE IF EXISTS pago
	
	CREATE PROCEDURE pago( IN formaPago varchar(20), out maximo int )
	BEGIN
		SELECT MAX(p.total) into maximo
		FROM pago p
		WHERE p.forma_pago = formaPago;
	END;

$$
	
DELIMITER ;

	call pago("PayPal", @maximo);
	call pago("Transferencia", @maximo);
	call pago("Cheque", @maximo);

	SELECT @maximo;





/*Escribe un procedimiento que reciba como parámetro de entrada una forma de pago, que será una cadena de 
caracteres (Ejemplo: PayPal, Transferencia, etc). Y devuelva como salida los siguientes valores teniendo 
en cuenta la forma de pago seleccionada como parámetro de entrada:
el pago de máximo valor, el pago de mínimo valor, el valor medio de los pagos realizados,
la suma de todos los pagos, el número de pagos realizados para esa forma de pago.
Deberá hacer uso de la tabla pago de la base de datos jardineria.*/


DELIMITER $$
	
DROP PROCEDURE IF EXISTS pagoAdmin
	
CREATE PROCEDURE pagoAdmin(
	IN formaPago varchar(20),
	out nombre varchar(20),
	out maximo int,
	out minimo int ,
	out media float ,
	out total int, 
	out veces int
	)
BEGIN
	SELECT 
		p.forma_pago ,
        MAX(p.total),  
        MIN(p.total), 
        AVG(p.total), 
        SUM(p.total), 
        COUNT(p.total)
    INTO 
    	nombre, 
        maximo, 
        minimo, 
        media, 
        total, 
        veces
	FROM pago p
	WHERE p.forma_pago = formaPago
	GROUP BY p.forma_pago;
END;

$$
	
DELIMITER ;

	call pagoAdmin("PayPal",@nombre, @maximo, @minimo, @media, @total, @veces);
	call pagoAdmin("Transferencia",@nombre, @maximo, @minimo, @media, @total, @veces);
	call pagoAdmin("Cheque",@nombre, @maximo, @minimo, @media, @total, @veces);

	SELECT @nombre as nombre, @maximo AS maximo, 
	@minimo AS minimo, @media AS media, @total AS total, @veces AS veces;







/*Crea una base de datos llamada procedimientos que contenga una tabla llamada cuadrados. La tabla cuadrados debe tener dos columnas
de tipo INT UNSIGNED, una columna llamada número y otra columna llamada cuadrado.*/

	
	CREATE DATABASE IF NOT EXISTS 	procedimientos ;
	
	use procedimientos; # sirve para cambiar de BD desde codigo
	
	CREATE TABLE if not exists cuadrados(
	    numero INT UNSIGNED,
	    cuadrado INT UNSIGNED
	);
	

/*Una vez creada la base de datos y la tabla deberá crear un procedimiento llamado calcular_cuadrados con las siguientes 
características. El procedimiento recibe un parámetro de entrada llamado tope de tipo INT UNSIGNED y calculará el valor 
de los cuadrados de los primeros números naturales hasta el valor introducido como parámetro. El valor del números y de 
sus cuadrados deberán ser almacenados en la tabla cuadrados que hemos creado previamente.
Tenga en cuenta que el procedimiento deberá eliminar el contenido actual de la tabla antes de insertar los nuevos valores de los cuadrados que va a calcular.
Utilice un bucle WHILE para resolver el procedimiento.*/



DELIMITER $$
	
DROP PROCEDURE IF EXISTS calcular_cuadrados;
	
CREATE PROCEDURE calcular_cuadrados (IN tope INT UNSIGNED)
BEGIN
	DECLARE cuadrado INT UNSIGNED;
	DECLARE i INT ;
	set i=1;
	TRUNCATE TABLE procedimientos.cuadrados;# DELETE FROM cuadrados

	while i<=tope DO
		set cuadrado=i*i;
		INSERT into cuadrados values (i,cuadrado);
		set i = i+1;
	end while;
	 
END;

$$
	
DELIMITER ;

	call calcular_cuadrados(10);






#Utilice un bucle REPEAT para resolver el procedimiento del ejercicio anterior.

DELIMITER $$
	
DROP PROCEDURE IF EXISTS calcular_cuadradosRepeat;
	
CREATE PROCEDURE calcular_cuadradosRepeat (IN tope INT UNSIGNED)
BEGIN
	DECLARE cuadrado INT UNSIGNED;
	DECLARE i INT ;
	set i=1;
	TRUNCATE TABLE procedimientos.cuadrados;

	REPEAT
		set cuadrado=i*i;
		INSERT into cuadrados values (i,cuadrado);
		set i = i+1;
	UNTIL i>tope		#No usa punto&Coma
	end repeat;
	 
END;

$$	
DELIMITER ;

	call calcular_cuadradosRepeat(3);
	SELECT c.* FROM cuadrados c ;



-- Utilice un bucle LOOP para resolver el procedimiento del ejercicio anterior.

	
	
DELIMITER $$
	
DROP PROCEDURE IF EXISTS calcular_cuadradosLoop;
	
CREATE PROCEDURE calcular_cuadradosLoop (IN tope INT UNSIGNED)
BEGIN
	DECLARE cuadrado INT UNSIGNED;
	DECLARE i INT ;
	set i=1;
	TRUNCATE TABLE procedimientos.cuadrados;

	bucle: LOOP
		set cuadrado=i*i;
		INSERT into cuadrados values (i,cuadrado);
		set i = i+1;
		if(i>tope) then
			LEAVE bucle;
		END if;
	end loop;
END;

$$	
DELIMITER ;

	call calcular_cuadradosLoop(7);
	SELECT c.* FROM cuadrados c ;
	




/*Crea una base de datos llamada procedimientos que contenga una tabla llamada ejercicio. La tabla debe tener
una única columna llamada número y el tipo de dato de esta columna debe ser INT UNSIGNED.*/

	
	CREATE database if not exists procedimientos2;
	use procedimientos2;
	
	CREATE table if not exists ejercicio(numero int unsigned);



/*Una vez creada la base de datos y la tabla deberá crear un procedimiento llamado calcular_números con las siguientes
características. El procedimiento recibe un parámetro de entrada llamado valor_inicial de tipo INT UNSIGNED y deberá
 almacenar en la tabla ejercicio toda la secuencia de números desde el valor inicial pasado como entrada hasta el 1.
Tenga en cuenta que el procedimiento deberá eliminar el contenido actual de las tablas antes de insertar los nuevos valores.
Utilice un bucle WHILE para resolver el procedimiento.*/

	
DELIMITER $$
	
DROP PROCEDURE IF EXISTS calcular_númerosW;
	
CREATE PROCEDURE calcular_númerosW (IN valor_inicial INT UNSIGNED)
BEGIN
	DECLARE uno INT ;
	set uno=1;
	TRUNCATE TABLE procedimientos2.ejercicio ;

	while valor_inicial>=uno DO
		INSERT INTO ejercicio values (valor_inicial);
		set valor_inicial=valor_inicial-uno;
	end while;
END;

$$	
DELIMITER ;

	call calcular_númerosW(7);
	SELECT e.numero FROM ejercicio e  ;




-- Utilice un bucle REPEAT para resolver el procedimiento del ejercicio anterior.



DELIMITER $$
	
DROP PROCEDURE IF EXISTS calcular_númerosR;
	
CREATE PROCEDURE calcular_númerosR (IN valor_inicial INT UNSIGNED)
BEGIN
	DECLARE uno INT ;
	set uno=1;
	TRUNCATE TABLE procedimientos2.ejercicio ;

	repeat
		INSERT INTO ejercicio values (valor_inicial);
		set valor_inicial=valor_inicial-uno;
		UNTIL valor_inicial<uno
	end repeat ;
END;

$$	
DELIMITER ;

	call calcular_númerosR(5);
	SELECT e.numero FROM ejercicio e  ;





-- Utilice un bucle LOOP para resolver el procedimiento del ejercicio anterior.


DELIMITER $$
	
DROP PROCEDURE IF EXISTS calcular_númerosL;
	
CREATE PROCEDURE calcular_númerosL (IN valor_inicial INT UNSIGNED)
BEGIN
	DECLARE uno INT ;
	set uno=1;
	TRUNCATE TABLE procedimientos2.ejercicio ;

	bucle: loop
		INSERT INTO ejercicio values (valor_inicial);
		set valor_inicial=valor_inicial-uno;
		if valor_inicial<uno then
			leave bucle;
		end if;
	end loop ;
END;

$$	
DELIMITER ;

	call calcular_númerosL(6);
	SELECT e.numero FROM ejercicio e  ;





/*
Crea una base de datos llamada procedimientos que contenga una tabla llamada pares y otra tabla llamada impares. 
Las dos tablas deben tener única columna llamada número y el tipo de dato de esta columna debe ser INT UNSIGNED.*/


CREATE database if not exists procedimientos3;
use procedimientos3;
CREATE TABLE IF NOT EXISTS pares (
  numero INT UNSIGNED PRIMARY KEY
);

CREATE TABLE IF NOT EXISTS impares (
  numero INT UNSIGNED PRIMARY KEY
);

/*
Una vez creada la base de datos y las tablas deberá crear un procedimiento llamado calcular_pares_impares con las siguientes 
características. El procedimiento recibe un parámetro de entrada llamado tope de tipo INT UNSIGNED y deberá almacenar en la
 tabla pares aquellos números pares que existan entre el número 1 el valor introducido como parámetro. Habrá que realizar 
 la misma operación para almacenar los números impares en la tabla impares.
 Tenga en cuenta que el procedimiento deberá eliminar el contenido actual de las tablas antes de insertar los nuevos valores.
Utilice un bucle WHILE para resolver el procedimiento.*/


DELIMITER $$
	
DROP PROCEDURE IF EXISTS calcular_pares_impares;

CREATE PROCEDURE calcular_pares_impares(IN tope INT UNSIGNED)
BEGIN
    DECLARE i INT UNSIGNED DEFAULT 1;
    TRUNCATE TABLE pares;
    TRUNCATE TABLE impares;

    WHILE i <= tope DO
        IF i % 2 = 0 THEN
            INSERT INTO pares (numero) VALUES (i);
        ELSE
            INSERT INTO impares (numero) VALUES (i);
        END IF;

        SET i = i+1;
    END WHILE;
END;

$$	
DELIMITER ;

	call calcular_pares_impares(6);
	SELECT p.* FROM  pares p;
	SELECT i.* FROM  impares i  ;



-- Utilice un bucle REPEAT para resolver el procedimiento del ejercicio anterior.


DELIMITER $$
	
DROP PROCEDURE IF EXISTS calcular_pares_impares2;

CREATE PROCEDURE calcular_pares_impares2(IN tope INT UNSIGNED)
BEGIN
    DECLARE i INT UNSIGNED DEFAULT 1;
    TRUNCATE TABLE pares;
    TRUNCATE TABLE impares;

    repeat
        IF i % 2 = 0 THEN
            INSERT INTO pares (numero) VALUES (i);
        ELSE
            INSERT INTO impares (numero) VALUES (i);
        END IF;

        SET i = i+1;
     until i>tope
    END repeat;
END;

$$	
DELIMITER ;

	call calcular_pares_impares2(7);
	SELECT p.* FROM  pares p;
	SELECT i.* FROM  impares i  ;



-- Utilice un bucle LOOP para resolver el procedimiento del ejercicio anterior.*/


DELIMITER $$
	
DROP PROCEDURE IF EXISTS calcular_pares_imparesl;

CREATE PROCEDURE calcular_pares_imparesl(IN tope INT UNSIGNED)
BEGIN
    DECLARE i INT UNSIGNED DEFAULT 1;
    TRUNCATE TABLE pares;
    TRUNCATE TABLE impares;

    bucle: loop
        IF i % 2 = 0 THEN
            INSERT INTO pares (numero) VALUES (i);
        ELSE
            INSERT INTO impares (numero) VALUES (i);
        END IF;

        SET i = i+1;
    	if i>tope then
   			LEAVE bucle;
    end if;
    end loop;
END;

$$	
DELIMITER ;

	call calcular_pares_imparesl(3);
	SELECT p.* FROM  pares p;
	SELECT i.* FROM  impares i  ;


