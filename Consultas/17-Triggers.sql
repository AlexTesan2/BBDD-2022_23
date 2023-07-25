/*1.8.8 Triggers
Crea una base de datos llamada test que contenga una tabla llamada alumnos con las siguientes columnas.
Tabla alumnos:
id (entero sin signo)
nombre (cadena de caracteres)
apellido1 (cadena de caracteres)
apellido2 (cadena de caracteres)
nota (número real)*/


DROP DATABASE IF EXISTS test;
CREATE DATABASE if not exists test;
USE test;
create table if not exists alumnos(
	id int unsigned,
	nombre varchar(30),
	apellido1 varchar(30),
	apellido2 varchar(30),
	nota int 
);

/*
Una vez creada la tabla escriba dos triggers con las siguientes características:
Trigger 1: trigger_check_nota_before_insert
Se ejecuta sobre la tabla alumnos.
Se ejecuta antes de una operación de inserción.
Si el nuevo valor de la nota que se quiere insertar es negativo, se guarda como 0.
Si el nuevo valor de la nota que se quiere insertar es mayor que 10, se guarda como 10.*/

DELIMITER $$
DROP TRIGGER IF EXISTS trigger_check_nota_before_insert

CREATE TRIGGER trigger_check_nota_before_insert
BEFORE INSERT
ON alumnos FOR EACH ROW
BEGIN
  IF NEW.nota < 0 THEN
    set NEW.nota = 0;
  ELSEIF NEW.nota > 10 THEN
    set NEW.nota = 10;
  END IF;
END



/*Trigger2 : trigger_check_nota_before_update
Se ejecuta sobre la tabla alumnos.
Se ejecuta antes de una operación de actualización.
Si el nuevo valor de la nota que se quiere actualizar es negativo, se guarda como 0.
Si el nuevo valor de la nota que se quiere actualizar es mayor que 10, se guarda como 10.
Una vez creados los triggers escriba varias sentencias de inserción y actualización sobre la tabla alumnos
 y verifica que los triggers se están ejecutando correctamente.*/

DELIMITER $$
DROP TRIGGER IF EXISTS trigger_check_nota_before_update$$

CREATE TRIGGER trigger_check_nota_before_update
BEFORE UPDATE
ON alumnos FOR EACH ROW
BEGIN
  IF NEW.nota < 0 THEN
    set NEW.nota = 0;
  ELSEIF NEW.nota > 10 THEN
    set NEW.nota = 10;
  END IF;
END

delimiter ;

INSERT INTO alumnos VALUES (1, 'Pepe', 'López', 'López', -1);
INSERT INTO alumnos VALUES (2, 'María', 'Sánchez', 'Sánchez', 11);
INSERT INTO alumnos VALUES (3, 'Juan', 'Pérez', 'Pérez', 8.5);

-- Paso 5
SELECT * FROM alumnos;

-- Paso 6
UPDATE alumnos SET nota = -4 WHERE id = 3;
UPDATE alumnos SET nota = 14 WHERE id = 2;
UPDATE alumnos SET nota = 9.5 WHERE id = 1;

/*
Crea una base de datos llamada test que contenga una tabla llamada alumnos con las siguientes columnas.
Tabla alumnos:

id (entero sin signo)
nombre (cadena de caracteres)
apellido1 (cadena de caracteres)
apellido2 (cadena de caracteres)
email (cadena de caracteres)*/


DROP DATABASE IF EXISTS test;
CREATE DATABASE if not exists test;
USE test;
create table if not exists alumnos(
	id int unsigned,
	nombre varchar(30),
	apellido1 varchar(30),
	apellido2 varchar(30),
	email varchar(30) 
);

/*Escriba un procedimiento llamado crear_email que dados los parámetros de entrada: nombre, apellido1, 
 apellido2 y dominio, cree una dirección de email y la devuelva como salida.

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
	
DROP PROCEDURE IF EXISTS crear_email
	
CREATE PROCEDURE crear_email(
	IN nombre varchar (20),
	in apellido1 varchar(20),
	in apellido2 varchar(20),
	in dominio varchar(20),
	out email varchar (50)
	)
BEGIN
	SEt email =  
		CONCAT(LEFT(nombre, 1),
		LEFT(apellido1 , 3),
		LEFT(apellido2 , 3),
		"@",
		dominio);
END;

DELIMITER ;
DELETE from alumnos;



/*Una vez creada la tabla escriba un trigger con las siguientes características:

Trigger: trigger_crear_email_before_insert
Se ejecuta sobre la tabla alumnos.
Se ejecuta antes de una operación de inserción.
Si el nuevo valor del email que se quiere insertar es NULL, entonces se le creará automáticamente una dirección de 
email y se insertará en la tabla.
Si el nuevo valor del email no es NULL se guardará en la tabla el valor del email.
Nota: Para crear la nueva dirección de email se deberá hacer uso del procedimiento crear_email.*/
	
	
	
	
DELIMITER $$
DROP TRIGGER IF EXISTS trigger_crear_email_before_insert;

CREATE TRIGGER trigger_crear_email_before_insert
BEFORE insert
ON alumnos FOR EACH ROW
BEGIN
    	IF NEW.email IS NULL THEN
        	CALL crear_email(NEW.nombre, NEW.apellido1, NEW.apellido2, "SalesianosZgz", @email);
        SET NEW.email = @email;
    END IF;
END

	insert into alumnos (id, nombre, apellido1, apellido2) values (1,"Alex","Tesan", "Delgado");
	
/*
Modifica el ejercicio anterior y añade un nuevo trigger que las siguientes características:
Trigger: trigger_guardar_email_after_update:

Se ejecuta sobre la tabla alumnos.
Se ejecuta después de una operación de actualización.
Cada vez que un alumno modifique su dirección de email se deberá insertar un nuevo registro en una tabla llamada log_cambios_email.
La tabla log_cambios_email contiene los siguientes campos:

id: clave primaria (entero autonumérico)
id_alumno: id del alumno (entero)
fecha_hora: marca de tiempo con el instante del cambio (fecha y hora)
old_email: valor anterior del email (cadena de caracteres)
new_email: nuevo valor con el que se ha actualizado*/

CREATE TABLE IF NOT EXISTS log_cambios_email(
            id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
            id_alumno INT,
            fecha_hora DATETIME,
            old_email VARCHAR(30),
            new_email VARCHAR(30)
        );

DELIMITER $$
DROP TRIGGER IF EXISTS trigger_guardar_email_after_update $$
CREATE TRIGGER trigger_guardar_email_after_update
    AFTER UPDATE
    ON alumnos FOR EACH ROW
    BEGIN
        IF NEW.email != OLD.email THEN
            INSERT INTO log_cambios_email(id_alumno, fecha_hora, old_email, new_email)
            VALUES (OLD.id, NOW(), OLD.email, NEW.email);
        END IF;
    END $$
DELIMITER ;

UPDATE alumnos SET email = 'albertosaz@gmail.com' WHERE id = 1;
UPDATE alumnos SET email = 'periquin@gmail.com' WHERE id = 2;
UPDATE alumnos SET email = '' WHERE id = 3;





/*
Modifica el ejercicio anterior y añade un nuevo trigger que tenga las siguientes características:
Trigger: trigger_guardar_alumnos_eliminados:

Se ejecuta sobre la tabla alumnos.
Se ejecuta después de una operación de borrado.
Cada vez que se elimine un alumno de la tabla alumnos se deberá insertar un nuevo registro en una tabla llamada log_alumnos_eliminados.
La tabla log_alumnos_eliminados contiene los siguientes campos:

id: clave primaria (entero autonumérico)
id_alumno: id del alumno (entero)
fecha_hora: marca de tiempo con el instante del cambio (fecha y hora)
nombre: nombre del alumno eliminado (cadena de caracteres)
apellido1: primer apellido del alumno eliminado (cadena de caracteres)
apellido2: segundo apellido del alumno eliminado (cadena de caracteres)
email: email del alumno eliminado (cadena de caracteres)*/

CREATE TABLE IF NOT EXISTS log_alumnos_eliminados(
            id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
            id_alumno INT,
            fecha_hora DATETIME,
            nombre VARCHAR(30),
            apellido1 VARCHAR(30),
            apellido2 VARCHAR(30),
            email VARCHAR(30)
        );

DELIMITER $$
DROP TRIGGER IF EXISTS trigger_guardar_alumnos_eliminados $$
CREATE TRIGGER trigger_guardar_alumnos_eliminados
    AFTER DELETE
    ON alumnos FOR EACH ROW
    BEGIN
        INSERT INTO log_alumnos_eliminados(id_alumno, fecha_hora, nombre, apellido1, apellido2, email)
            VALUES (OLD.id, NOW(), OLD.nombre, OLD.apellido1, OLD.apellido2, OLD.email);
    END $$
DELIMITER ;

DELETE FROM alumnos;







/**/


DELIMITER $$
DROP PROCEDURE IF EXISTS examen$$

CREATE PROCEDURE examen(
		In nombre varchar(45),
		In apellidos varchar(45), 
		Out sum_avg_time integer)
BEGIN
	DECLARE id_jefe INT;
	DECLARE id_almacen INT;

	DECLARE done INT DEFAULT 0;
	-- recupereamos el id del empleado jefe a partir del nombre y los apellidos
	set id_jefe = 	select id_empleado  
					from empleado e 
					where e.nombre  = nombre 
					and e.apellidos = apellidos ;
				
-- recuperamos el id del almacen al que está asociado el jefe
	set id_almacen =select id_al 
					from almacen a 
					where a.id_empleado_jefe = id_jefe limit 1;
				
	-- esto se puede optimizar con join
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

	-- uso un cursor para recorrer todos los empleados del almacen
	DECLARE empleados_almacen CURSOR FOR select id_emepleado from empleado e where e.id_almacen = id_almacen ;
	open empleados_almacen;
DECLARE average_per_emp INT DEFAULT 0;
	bucle: LOOP FETCH empleados_almacen into id_e;
		SET average_per_emp = 0;
		if done = 1 THEN
			leave bucle;
		end if;
		-- deberiamos comprobar que la fecha devolucion es posterior a la fecha alquiler
		select avg(DATEDIFF(a.fecha_devolucion - a.fecha_alquiler)) 
				into average_per_emp 
				from alquiler a 
				where a.id_empleado = id_e and a.fecha_devolucion > a.fecha_alquiler ;
		set sum_avg_time = sum_avg_time + average_per_emp;
	end loop bucle;	
	c
close empleados_almacen;
	END$$
