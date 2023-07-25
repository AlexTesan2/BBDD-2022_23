-- Manejo de errores en MySQL
/*Crea una base de datos llamada test que contenga una tabla llamada alumno. La tabla debe tener cuatro columnas:
id: entero sin signo (clave primaria).
nombre: cadena de 50 caracteres.
apellido1: cadena de 50 caracteres.
apellido2: cadena de 50 caracteres.*/

CREATE DataBase if not exists test ;
use test;
CREATE table if not exists alumno(
	id int unsigned primary key, 
	nombre varchar(50),
	apellido1 varchar(50),
	apeellido2 varchar (50)
);
/*Una vez creada la base de datos y la tabla deberá crear un procedimiento llamado insertar_alumno con las siguientes características
El procedimiento recibe cuatro parámetros de entrada (id, nombre, apellido1, apellido2) y los insertará en la tabla alumno. 
El procedimiento devolverá como salida un parámetro llamado error que tendrá un valor igual a 0 si la operación se ha podido 
realizar con éxito y un valor igual a 1 en caso contrario.
Deberá manejar los errores que puedan ocurrir cuando se intenta insertar una fila que contiene una clave primaria repetida.*/

DELIMITER $$
	
DROP PROCEDURE IF EXISTS insertar_alumno
	
CREATE PROCEDURE insertar_alumno(
	IN id int unsigned,
	in nombre varchar(50),
	in apellido1 varchar(50),
	in apellido2 varchar(50),
	out error int
	)
BEGIN
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SET error = 1;  #si se produce el error 23000, la variable error sera 1
																  # el error 23000 s la violacion de las claves primarias
    SET error = 0; # se inicializa erro a 0
   	INSERT INTO test.alumno VALUES (id, nombre, apellido1, apellido2); # aqui es donde se producira el error sin se repite una insercion de la misma clave primaria													
    SELECT error;
END;

$$

DELIMITER ;

	call insertar_alumno('2','yo','miApellido','elSegundoApellido',@error);-- 0
	call insertar_alumno('2','elOtro','suApellido','suSegundoApellido',@error);-- 1


-- Transacciones con procedimientos almacenados
/*Crea una base de datos llamada cine que contenga dos tablas con las siguientes columnas.
 
Tabla cuentas:
id_cuenta: entero sin signo (clave primaria).
saldo: real sin signo.

Tabla entradas:
id_butaca: entero sin signo (clave primaria).
nif: cadena de 9 caracteres.*/

create database if not exists cine;
use cine;

create table if not exists cuentas (id_cuenta int unsigned primary key, saldo int unsigned );
create table if not exists entradas (id_butaca int unsigned primary key, nif varchar(9));


/*Una vez creada la base de datos y las tablas deberá crear un procedimiento llamado comprar_entrada con las siguientes
características. El procedimiento recibe 3 parámetros de entrada (nif, id_cuenta, id_butaca) y devolverá como salida
un parámetro llamado error que tendrá un valor igual a 0 si la compra de la entrada se ha podido realizar con éxito y
un valor igual a 1 en caso contrario.*/
/*El procedimiento de compra realiza los siguientes pasos:

Inicia una transacción.
Actualiza la columna saldo de la tabla cuentas cobrando 5 euros a la cuenta con el id_cuenta adecuado.
Inserta una una fila en la tabla entradas indicando la butaca (id_butaca) que acaba de comprar el usuario (nif).
Comprueba si ha ocurrido algún error en las operaciones anteriores. Si no ocurre ningún error entonces aplica
 un COMMIT a la transacción y si ha ocurrido algún error aplica un ROLLBACK.
Deberá manejar los siguientes errores que puedan ocurrir durante el proceso.

ERROR 1264 (Out of range value)
ERROR 1062 (Duplicate entry for PRIMARY KEY)*/

DELIMITER $$
DROP PROCEDURE IF EXISTS comprar_entrada $$
CREATE PROCEDURE comprar_entrada(
	IN nif VARCHAR(9),
	IN id_cuenta INT UNSIGNED,
	IN id_butaca INT UNSIGNED,
	OUT error INT UNSIGNED)
	
    BEGIN
        DECLARE EXIT HANDLER FOR 1264
            BEGIN
                SET error = 1;
                SELECT error, 'Out of range value' as 'ERROR TYPE';
            ROLLBACK;
        END;
       
        DECLARE EXIT HANDLER FOR 1062
            BEGIN
                SET error = 1;
                SELECT error, 'Duplicate entry for PRIMARY KEY' as 'ERROR TYPE';
            ROLLBACK;
        END;
       
        SET error = 0;
        START TRANSACTION;
            UPDATE cuentas SET saldo = saldo - 5 WHERE cuentas.id_cuenta = id_cuenta;
            INSERT INTO entradas VALUES (id_butaca, nif);
            SELECT error;
        COMMIT;
    END $$
DELIMITER ;
CALL comprar_entrada('18447807J', 5, 8, @error);




/*¿Qué ocurre cuando intentamos comprar una entrada y le pasamos como parámetro un número de cuenta que no existe
en la tabla cuentas?   ¿Ocurre algún error o podemos comprar la entrada?*/
-- no devuelve ningun error, por lo que se puede comprar la entrada  

-- En caso de que exista algún error, ¿cómo podríamos resolverlo?.
-- Deberiamos crear una condición para evitarlo:

DELIMITER $$
DROP PROCEDURE IF EXISTS comprar_entrada 
CREATE PROCEDURE comprar_entrada(IN nif VARCHAR(9), IN id_cuenta INT UNSIGNED, IN id_butaca INT UNSIGNED, OUT error INT UNSIGNED)
    BEGIN
        DECLARE EXIT HANDLER FOR 1264
            BEGIN
                SET error = 1;
                SELECT error, 'Out of range value' as 'ERROR TYPE';
            ROLLBACK;
        END;
        DECLARE EXIT HANDLER FOR 1062
            BEGIN
                SET error = 1;
                SELECT error, 'Duplicate entry for PRIMARY KEY' as 'ERROR TYPE';
            ROLLBACK;
        END;
        SET error = 0;
        START TRANSACTION;
            IF ((SELECT COUNT(cuentas.id_cuenta)
               FROM cuentas
               WHERE cuentas.id_cuenta = id_cuenta) = 0) THEN
                   SELECT 'Cuenta no encontrada';
                   ROLLBACK;
            ELSE
                UPDATE cuentas SET saldo = saldo - 5 WHERE cuentas.id_cuenta = id_cuenta;
                INSERT INTO entradas VALUES (id_butaca, nif);
                SELECT error;
            END IF;
        COMMIT;
    END $$
DELIMITER ;
CALL comprar_entrada('18447807J', 1, 85, @error);


/*1.8.7 Cursores
Escribe las sentencias SQL necesarias para crear una base de datos llamada test, una tabla llamada alumnos y
4 sentencias de inserción para inicializar la tabla. La tabla alumnos está formada por las siguientes columnas:
id (entero sin signo y clave primaria)
nombre (cadena de caracteres)
apellido1 (cadena de caracteres)
apellido2 (cadena de caracteres
fecha_nacimiento (fecha)/**/


CREATE DATABASE IF NOT EXISTS test2;
USE test2;
DROP TABLE IF EXISTS alumno;
CREATE TABLE IF NOT EXISTS alumno(
    id INT UNSIGNED,
    nombre VARCHAR(50),
    apellido1 VARCHAR(50),
    apellido2 VARCHAR(50),
    fecha_nacimiento DATETIME,
    PRIMARY KEY (id)
);


/*Una vez creada la tabla se decide añadir una nueva columna a la tabla llamada edad que será un valor calculado
a partir de la columna fecha_nacimiento. Escriba la sentencia SQL necesaria para modificar la tabla y añadir la nueva columna.*/

ALTER TABLE alumno ADD COLUMN edad int;


/*Escriba una función llamada calcular_edad que reciba una fecha y devuelva el número de años que han pasado desde la fecha 
actual hasta la fecha pasada como parámetro:
Función: calcular_edad
Entrada: Fecha
Salida: Número de años (entero)*/


DELIMITER $$
DROP FUNCTION IF EXISTS calcular_edad 

CREATE FUNCTION calcular_edad(fecha datetime)
    RETURNS INT deterministic
    
    BEGIN
    	DECLARE annos INT;
    	SET annos = YEAR(NOW())-YEAR(fnac);
    	RETURN annos;
    END ;
DELIMITER ;

 
/*Ahora escriba un procedimiento que permita calcular la edad de todos los alumnmos que ya existen en la tabla. 
Para esto será necesario crear un procedimiento llamado actualizar_columna_edad que calcule la edad de cada alumno 
y actualice la tabla. Este procedimiento hará uso de la función calcular_edad que hemos creado en el paso anterior.*/



DROP PROCEDURE IF EXISTS actualizar_columna_edad;
CREATE PROCEDURE actualizar_columna_edad()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE id_a INT;
    DECLARE edad INT;
    DECLARE fnac DATETIME;
    DECLARE cur1 CURSOR FOR SELECT id, fecha_nacimiento FROM alumno;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    OPEN cur1;
    bucle: LOOP
        FETCH cur1
        INTO id_a,
            fnac;
        SET edad = 0;
        IF done = 1 THEN
            LEAVE bucle;
        END IF;
        START TRANSACTION;
            UPDATE alumno
            SET edad = calcular_edad(fnac)
            WHERE id = id_a;
        COMMIT;
    END LOOP bucle;
    CLOSE cur1;
END $$
DELIMITER ;
CALL actualizar_columna_edad();



/*Modifica la tabla alumnos del ejercicio anterior para añadir una nueva columna email.*/

ALTER TABLE alumno ADD COLUMN email VARCHAR(40);

/*Una vez que hemos modificado la tabla necesitamos asignarle una dirección de correo electrónico de forma automática.
Escriba un procedimiento llamado crear_email que dados los parámetros de entrada: nombre, apellido1, apellido2 y dominio, cree una 
dirección de email y la devuelva como salida.

Procedimiento: crear_email
Entrada:
nombre (cadena de caracteres)
apellido1 (cadena de caracteres)
apellido2 (cadena de caracteres)
dominio (cadena de caracteres)
Salida:
email (cadena de caracteres)
devuelva una dirección de correo electrónico con el siguiente formato:

El primer carácter del parámetro nombre.
Los tres primeros caracteres del parámetro apellido1.
Los tres primeros caracteres del parámetro apellido2.
El carácter @.
El dominio pasado como parámetro.*/

DELIMITER $$
DROP PROCEDURE IF EXISTS crear_email $$
CREATE PROCEDURE crear_email3(
		IN nombre VARCHAR(30),
		IN apellido1 VARCHAR(30),
		IN apellido2 VARCHAR(30), 
		IN dominio VARCHAR(30), 
		OUT direccion VARCHAR(30))
    BEGIN
        SET direccion = CONCAT(
        	LOWER(LEFT(nombre,1)),
            LOWER(LEFT(apellido1, 3)),
            LOWER(LEFT(apellido2,3)),
            '@',
            LOWER(dominio));
    END $$
DELIMITER ;
CALL crear_email('Alex', 'Tesan', 'Delgado', 'salesianos.edu', @direccion);
SELECT @direccion;

/*
Ahora escriba un procedimiento que permita crear un email para todos los alumnmos que ya existen en la tabla. 
Para esto será necesario crear un procedimiento llamado actualizar_columna_email que actualice la columna email de la
 tabla alumnos. Este procedimiento hará uso del procedimiento crear_email que hemos creado en el paso anterior.*/

DELIMITER $$
DROP PROCEDURE IF EXISTS actualizar_columna_email $$
CREATE PROCEDURE actualizar_columna_email()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE id_a INT;
    DECLARE nomb VARCHAR(30);
    DECLARE ap1 VARCHAR(30);
    DECLARE ap2 VARCHAR(30);
    DECLARE dominio VARCHAR(30) DEFAULT 'salesianos.edu';
    DECLARE mail VARCHAR(30);
   
    DECLARE cur1 CURSOR FOR
                SELECT id,
                       nombre,
                       apellido1,
                       apellido2
                FROM alumno;
               
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    OPEN cur1;
    bucle: LOOP
        FETCH cur1
        INTO id_a,
            nomb,
            ap1,
            ap2;
        SET mail = '';
        IF done = 1 THEN
            LEAVE bucle;
        END IF;
        START TRANSACTION;
            CALL crear_email(nomb, ap1, ap2, dominio, mail);
            UPDATE alumno
            SET email = mail
            WHERE id = id_a;
        COMMIT;
    END LOOP bucle;
    CLOSE cur1;
END $$
DELIMITER ;
CALL actualizar_columna_email();


/*Escribe un procedimiento llamado crear_lista_emails_alumnos que devuelva la lista de emails de la tabla alumnos separados 
 por un punto y coma. Ejemplo: juan@iescelia.org;maria@iescelia.org;pepe@iescelia.org;lucia@iescelia.org.*/
DELIMITER $$
DROP PROCEDURE IF EXISTS crear_lista_emails_alumnos $$
CREATE PROCEDURE crear_lista_emails_alumnos(OUT lista VARCHAR(300))
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE mail VARCHAR(30);
    DECLARE cur1 CURSOR FOR
                SELECT email
                FROM alumno;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    OPEN cur1;
    bucle: LOOP
        FETCH cur1
        INTO mail;
        IF done = 1 THEN
            LEAVE bucle;
        END IF;
        START TRANSACTION;
            SET lista = CONCAT_WS(';',lista, mail);
        COMMIT;
    END LOOP bucle;
    CLOSE cur1;
END $$
DELIMITER ;
CALL crear_lista_emails_alumnos(@lista);
SELECT @lista;
