

-- 65. Modificar el campo de sexo para que aparezca H de Hombre dónde actualmente aparece V.

		
		UPDATE Voluntarios_OLD v
		SET v.Sexo ='H'
		WHERE v.Sexo = 'V';
		
	

-- 66. Modificar la provincia para que aparezca La Rioja dónde actualmente aparece Logroño.
	
	
		UPDATE provincias p
		SET p.provincia = 'La Rioja'
		WHERE p.provincia = 'Logoño';
		
	


-- 67. Modificar el campo de laboral para que en todos quede sin información.
	
		
		UPDATE laboral l 
		SET labor = '';

	
	

-- 68. Modificar el campo LABORAL y Deporte para que el contenido aparezca en mayúsculas.

	
		UPDATE deportes d
		set d.deporte = UPPER(d.deporte);
		
		UPDATE laboral l 
		set l.labor = UPPER(l.labor);
	
	
		

-- 69. Modificar el campo de Edad para que aparezca a edad exacta de la persona a fecha 13/12/1990.               ------?
	
	
	


/*70. Seleccionar el campo de pais mostrando solo aquellos diferentes. Crear la
tabla de paises con los registros seleccionados. (Voluntarios_OLD)*/
	
	
	
		CREATE TABLE SoloPaises AS 
			SELECT vo.Pais 
			FROM Voluntarios_OLD vo
			WHERE 1=2;
		
		INSERT INTO SoloPaises 
			SELECT DISTINCT v.Pais 
			FROM Voluntarios_OLD v;
			
			
		-- Para eliminar la tabla...
		
			DROP TABLE SoloPaises ;
	
	
		


/*71. Seleccionar el campo de pais y provincia mostrando sólo aquellas
provincias de España (las provincias no tienen que repetirse). Crear una
tabla de provincias con los registros seleccionados. Añadir a esta tabla el
resto de provincias que no sean de España.*/
		
	
		
		CREATE TABLE SoloProvincias (Pais varchar(100) ,Provinca varchar(100));
	
	
		INSERT into SoloProvincias 
		SELECT DISTINCT p.pais , pr.provincia 
		FROM provincias pr, paises p 
		WHERE p.idPais = pr.idPais AND p.pais = 'España';
	
		
		INSERT into SoloProvincias 
		SELECT DISTINCT p.pais , pr.provincia 
		FROM provincias pr, paises p 
		WHERE p.idPais = pr.idPais AND p.pais != 'España';
	
	
	

/*72. Seleccionar el campo de provincia y población mostrando solo aquellas
poblaciones diferentes. Crear la tabla de poblaciones con los registros
seleccionados.*/

	
	
		CREATE table ProvPoblac (Población varchar(50) , Provincia varchar (30) );
		
		INSERT into ProvPoblac
			select DISTINCT l.localidad , p.provincia 
			from localidades l, provincias p
			WHERE l.idProvincia = p.idProvincia ;
	
	
		-- DROP table ProvPoblac 
	


/*73. Asignar la tarea de Administrativo a :15 personas con conocimientos de
ingles ESCRITO o francés ESCRITO Medios o Altos, con nivel medio o
alto de informática*/
							-- sabiendo que el idTarea para administativo es 1
		
		
		
		update preferencias p
		inner join nivel n on p.IdVoluntario = n.IdVoluntario 
		inner JOIN  idiomas i on n.IdIdioma = i.Ididioma 
		INNER JOIN voluntarios v on p.IdVoluntario =v.IdVoluntarios 
		set p.IdTarea ="1"
		WHERE n.escrito in("Alto","Medio")
		AND i.idioma in("Ingles", "Frances1")
		AND v.nivelInformatica in ("Alto","Medio")
		LIMIT 15;
				
		


/*74. Asignar la tarea de Traducción 3  /Interprete 4  a:
a. 39 personas que tengan nivel Alto de inglés HABLADO.*/


		UPDATE preferencias p
		inner join nivel n on p.IdVoluntario = n.IdVoluntario 
		INNER JOIN idiomas i on i.Ididioma = n.IdIdioma 
		INNER JOIN voluntarios v on p.IdVoluntario =v.IdVoluntarios 
		SET p.IdTarea = 3
		WHERE n.hablado = 'Alto' AND i.idioma ='Ingles'
		LIMIT 39 ;



-- b. 10 personas que tengan nivel Alto de francés HABLADO.
	
	
	
		UPDATE preferencias p
		inner join nivel n on p.IdVoluntario = n.IdVoluntario 
		INNER JOIN idiomas i on i.Ididioma = n.IdIdioma 
		INNER JOIN voluntarios v on p.IdVoluntario =v.IdVoluntarios 
		SET p.IdTarea = 3
		WHERE n.hablado = 'Alto' AND i.idioma ='Frances'
		LIMIT 10 ;
	  
	
	
	
-- c. 2 personas que tengan nivel Alto de alemán HABLADO.
	
	
		UPDATE preferencias p
		inner join nivel n on p.IdVoluntario = n.IdVoluntario 
		INNER JOIN idiomas i on i.Ididioma = n.IdIdioma 
		INNER JOIN voluntarios v on p.IdVoluntario =v.IdVoluntarios 
		SET p.IdTarea = 3
		WHERE n.hablado = 'Alto' AND i.idioma ='Aleman'
		LIMIT 2 ;
	
	
-- d. 2 personas que tengan nivel Alto de italiano HABLADO
	
	
	
		UPDATE preferencias p
		inner join nivel n on p.IdVoluntario = n.IdVoluntario 
		INNER JOIN idiomas i on i.Ididioma = n.IdIdioma 
		INNER JOIN voluntarios v on p.IdVoluntario =v.IdVoluntarios 
		SET p.IdTarea = 3
		WHERE n.hablado = 'Alto' AND i.idioma ='Italiano'
		LIMIT 2 ;
	



/*Realizar la siguiente consulta para poder realizar las sql a continuación
indicadas
ALTER TABLE voluntariado.voluntarios ADD Puesto VARCHAR(20) NULL;
ALTER TABLE voluntariado.Voluntarios_OLD ADD Puesto VARCHAR(20)
NULL;*/
	
	ALTER TABLE voluntariado.voluntarios ADD Puesto VARCHAR(20) NULL;
	ALTER TABLE voluntariado.Voluntarios_OLD ADD Puesto VARCHAR(20) NULL;
	
	

/*75. Asignar en la tabla voluntarios la columna puesto con el valor
“Informática” a:15 personas con nivel alto de informática y hayan elegido
Tareas Informática con preferencia 1 o 2.*/
	

	
		UPDATE voluntarios v 
		set v.Puesto ='Informatica'
		WHERE v.IdVoluntarios IN
		(
			SELECT IdVoluntarios from
			(
			SELECT  v.IdVoluntarios 
			FROM voluntarios v, preferencias p, tareas t
			WHERE v.IdVoluntarios = p.IdVoluntario AND p.IdTarea = t.IdTarea 
			AND p.Preferencia IN ("1","2") AND t.nombre = "Informática"
			AND v.nivelInformatica ="Alto"
			LIMIT 15
			) as t
		);
	
	
	------------------------------------------------
	
	
	
	UPDATE voluntarios v
	inner join preferencias p on p.IdVoluntario = v.IdVoluntarios 
	INNER JOIN tareas t on t.IdTarea = p.IdTarea 
	set v.Puesto = 'Informatica'
	WHERE v.nivelInformatica = "Alto" and p.Preferencia IN ("1","2")
	AND t.nombre ='Informática'
	LIMIT 15;
	


/*76. Asignar en la tabla voluntarios old la columna Puesto con el valor
“Protocolo” a: 20 personas que hayan elegido Tareas Protocolo con
preferencia 1 o 2, tengan nivel medio escrito de cualquier idioma.*/
	
	
	
		UPDATE Voluntarios_OLD v  
		set v.Puesto = "Protocolo"
		WHERE v.TareasProtocolo IN ('1','2')
		AND(v.InglesEs ='medio' or v.FrancesEs ='medio' or v.AlemanEs ='medio' or v.ItalianoEs ='medio' )
		LIMIT 20;

	
	


-- 77. Asignar en la tabla voluntarios old la columna puesto con el valor “Conducción” a:
-- a. 10 personas con carnet de conducir tipo C.
	
	
		UPDATE Voluntarios_OLD v  
		set v.Puesto = "Conducion"
		WHERE v.CarnetC = 'SI'
		LIMIT 10;
	
	
	
/*b. 60 personas con carnet de conducir tipo B que tengan nivel hablado
bajo o medio de algún idioma y que preferiblemente sean de Jaca o Huesca o Zaragoza.*/
	
	
		UPDATE Voluntarios_OLD v 
		set v.Puesto = "conduccion"
		WHERE v.CarnetB ="si"
		AND (v.InglesHa IN ('Medio', 'Bajo') or v.FrancesHa IN ('Medio', 'Bajo') 
		or v.ItalianoHa IN ('Medio', 'Bajo') or v.AlemanHa IN ('Medio', 'Bajo'))
		AND v.Poblacion IN ('Zaragoza', 'Huesca', 'Jaca')
		LIMIT 60;



/*78. Asignar en la tabla voluntarios la columna puesto el valor “Sanitario” a: 30
personas, que hayan elegido Tareas Sanitarias con preferencia 1 o 2 y
preferiblemente tengan la situación laboral de trabajadores en caso
contrario de estudiante.*/

	
	
		UPDATE Voluntarios_OLD v  
		set v.Puesto = "Sanitario"
		WHERE v.TareasSanitaria  IN ('1','2')
		AND v.Laboral = 'trabajador' 
		LIMIT 30;



/*79. Asignar en la tabla voluntarios la columna puesto el valor “Comunicación”
a: 30 personas que hayan elegido Tareas Comunicación con preferencia 1 ó 2*/
	
	
		UPDATE voluntarios v
		INNER JOIN preferencias p  on v.IdVoluntarios = p.IdVoluntario 
		INNER JOIN tareas t on p.IdTarea = t.IdTarea 
		set v.Puesto = "Comunicacion"
		WHERE t.nombre ="Comunicación" AND p.Preferencia IN ('1','2') 
		LIMIT 30;
		



/*80. Asignar en la tabla voluntarios la columna puesto el valor “Acompañante”
a: 20 personas que hayan elegido Tareas Acompañante con preferencia 1 ó 2 ó 3*/
	
	
	UPDATE voluntarios v 
	inner join preferencias p on p.IdVoluntario = v.IdVoluntarios 
	INNER JOIN tareas t on t.IdTarea = p.IdTarea 
	set v.Puesto = 'Acompañante'
	WHERE p.Preferencia IN ('1','2','3') AND  t.nombre ='Acompañantes'
	LIMIT 20;



/*81. Asignar en la tabla voluntarios la columna puesto el valor “Logística” a: 30
personas que hayan elegido Tareas Logistica con preferencia 1 ó 2 ó 3 ó 4*/



	UPDATE voluntarios v 
	inner join preferencias p on p.IdVoluntario = v.IdVoluntarios 
	INNER JOIN tareas t on p.IdTarea = t.IdTarea 
	set v.Puesto = 'Logistica'
	WHERE p.Preferencia IN ('1','2','3','4') AND  t.nombre ='Logístico'
	LIMIT 30;


/*82. Asignar en la tabla voluntarios old la labor de Promoción a: 30 personas
que hayan elegido Tareas Promocion con preferencia 1 ó 2 ó 3 ó 4*/


		UPDATE Voluntarios_OLD v  
		set v.Puesto = "Promocion"
		WHERE v.TareasPromocion  IN ('1','2','3','4') 
		LIMIT 30;
	


-- 83. Asignar en la tabla voluntarios la columna puesto el valor “Apoyo” a: 60 personas que practiquen esquí

	
	
		UPDATE voluntarios v 
		inner join practicar p on p.IdVoluntarios = v.IdVoluntarios 
		inner join deportes d on p.IdDeportes = d.IdDeporte 
		set v.Puesto = "Apoyo"
		WHERE d.deporte LIKE '%esqui%'
		LIMIT 60;
		
		
		

-- 84. Asignar en la tabla voluntarios la columna puesto el valor “Accesos” a: 30 personas mas altas.
	
	
	
			UPDATE voluntarios v 
			set v.Puesto = "Acesos"
			WHERE v.IdVoluntarios in
			(
				SELECT IdVoluntarios from
				(
					select v.IdVoluntarios , v.altura 
					FROM voluntarios v
					order by v.altura desc
					limit 30
				)as mas_altos
			);			
		

-- 85. Asignar en la tabla voluntarios la columna puesto el valor “Voluntarios” a: 30 personas de menor peso

		
		
			UPDATE voluntarios v 
			set v.Puesto = "Voluntarios"
			WHERE v.IdVoluntarios in
			(
				SELECT IdVoluntarios from
				(
					select v.IdVoluntarios , v.altura 
					FROM voluntarios v
					order by v.altura 
					limit 30
				)as mas_bajos
			);
		
		

-- 86. Asignar en la tabla voluntarios la columna puesto el valor “Información” a: 30 personas
		
		
		UPDATE voluntarios v 
		set v.Puesto = "Información"
		LIMIT 30;
	


/*87. Asignar en la tabla voluntarios la columna puesto el valor “Palacio de
congresos” a personas con las siguientes tareas:
a. 10 personas Traducción o Interprete ,*/
	
	
			UPDATE voluntarios v
			INNER JOIN preferencias p on p.IdVoluntario = v.IdVoluntarios 
			INNER JOIN tareas t on t.IdTarea = p.IdTarea 
			SET v.Puesto = "Palacio de congresos"
			WHERE t.nombre IN ('Traducción', 'Interprete' )
			LIMIT 10;
			
	
	
-- b. 4 sanitarios,
		
		
			UPDATE voluntarios v
			INNER JOIN preferencias p on p.IdVoluntario = v.IdVoluntarios 
			INNER JOIN tareas t on t.IdTarea = p.IdTarea 
			SET v.Puesto = "Palacio de congresos"
			WHERE t.nombre = 'Sanitaria'
			LIMIT 4;
	
	
-- c. 10 administrativos,
		
		
			UPDATE voluntarios v
			INNER JOIN preferencias p on p.IdVoluntario = v.IdVoluntarios 
			INNER JOIN tareas t on t.IdTarea = p.IdTarea 
			SET v.Puesto = "Palacio de congresos"
			WHERE t.nombre = 'Administrativas'
			LIMIT 10;
	
	
-- d. 5 información,
		
		
			UPDATE voluntarios v
			INNER JOIN preferencias p on p.IdVoluntario = v.IdVoluntarios 
			INNER JOIN tareas t on t.IdTarea = p.IdTarea 
			SET v.Puesto = "Palacio de congresos"
			WHERE t.nombre = 'Información'
			LIMIT 5;
	
	
	
-- e. 5 informaticos,
	
		
			UPDATE voluntarios v
			INNER JOIN preferencias p on p.IdVoluntario = v.IdVoluntarios 
			INNER JOIN tareas t on t.IdTarea = p.IdTarea 
			SET v.Puesto = "Palacio de congresos"
			WHERE t.nombre = 'Informática'
			LIMIT 5;
	
	
-- f. 10 protocolo
		
		
			UPDATE voluntarios v
			INNER JOIN preferencias p on p.IdVoluntario = v.IdVoluntarios 
			INNER JOIN tareas t on t.IdTarea = p.IdTarea 
			SET v.Puesto = "Palacio de congresos"
			WHERE t.nombre = 'Protocolo'
			LIMIT 10;
	
	
-- g. 5 logistica
		
		
		
			UPDATE voluntarios v
			INNER JOIN preferencias p on p.IdVoluntario = v.IdVoluntarios 
			INNER JOIN tareas t on t.IdTarea = p.IdTarea 
			SET v.Puesto = "Palacio de congresos"
			WHERE t.nombre = 'Logístico'
			LIMIT 5;



/*88. Asigna en la tabla voluntarios la columna puesto el valor “Pista de Hielo”
a personas con las siguientes tareas:*/
		
		
-- a. 8 personas de Accesos,
		
			
			UPDATE voluntarios v
			INNER JOIN preferencias p on p.IdVoluntario = v.IdVoluntarios 
			INNER JOIN tareas t on t.IdTarea = p.IdTarea 
			SET v.Puesto = "Pista de Hielo"
			WHERE t.nombre = 'Accesos'
			LIMIT 8;
		
		
-- b. 8 personas de logística,
		
		
			UPDATE voluntarios v
			INNER JOIN preferencias p on p.IdVoluntario = v.IdVoluntarios 
			INNER JOIN tareas t on t.IdTarea = p.IdTarea 
			SET v.Puesto = "Pista de Hielo"
			WHERE t.nombre = 'Logístico'
			LIMIT 8;
			
		
-- c. 6 sanitarios ,
		
			UPDATE voluntarios v
			INNER JOIN preferencias p on p.IdVoluntario = v.IdVoluntarios 
			INNER JOIN tareas t on t.IdTarea = p.IdTarea 
			SET v.Puesto = "Pista de Hielo"
			WHERE t.nombre = 'Sanitaria'
			LIMIT 6;
		
		
		
-- d. 5 información,
		
			UPDATE voluntarios v
			INNER JOIN preferencias p on p.IdVoluntario = v.IdVoluntarios 
			INNER JOIN tareas t on t.IdTarea = p.IdTarea 
			SET v.Puesto = "Pista de Hielo"
			WHERE t.nombre = 'Información'
			LIMIT 5;
		
		
-- e. 5 informaticos
		
			UPDATE voluntarios v
			INNER JOIN preferencias p on p.IdVoluntario = v.IdVoluntarios 
			INNER JOIN tareas t on t.IdTarea = p.IdTarea 
			SET v.Puesto = "Pista de Hielo"
			WHERE t.nombre = 'Informática'
			LIMIT 5;




/*89. Asigna en la tabla voluntarios la columna puesto el valor “Centro de
Transporte” a personas con las siguientes tareas:
a. 70 personas de conducción,*/
		
			UPDATE voluntarios v
			INNER JOIN preferencias p on p.IdVoluntario = v.IdVoluntarios 
			INNER JOIN tareas t on t.IdTarea = p.IdTarea 
			SET v.Puesto = "Centro de Transporte"
			WHERE t.nombre = 'Conducción'
			LIMIT 70;
		
		
-- b. 5 administrativos
		
			UPDATE voluntarios v
			INNER JOIN preferencias p on p.IdVoluntario = v.IdVoluntarios 
			INNER JOIN tareas t on t.IdTarea = p.IdTarea 
			SET v.Puesto = "Centro de Transporte"
			WHERE t.nombre = 'Administrativas'
			LIMIT 5;
		
		
-- c. 5 informaticos
		
		
			UPDATE voluntarios v
			INNER JOIN preferencias p on p.IdVoluntario = v.IdVoluntarios 
			INNER JOIN tareas t on t.IdTarea = p.IdTarea 
			SET v.Puesto = "Centro de Transporte"
			WHERE t.nombre = 'Informática'
			LIMIT 5;
		
		
-- d. 5 logistica
		
			UPDATE voluntarios v
			INNER JOIN preferencias p on p.IdVoluntario = v.IdVoluntarios 
			INNER JOIN tareas t on t.IdTarea = p.IdTarea 
			SET v.Puesto = "Centro de Transporte"
			WHERE t.nombre = 'Logístico'
			LIMIT 5;
		
		
-- e. 5 informacion
		
			UPDATE voluntarios v
			INNER JOIN preferencias p on p.IdVoluntario = v.IdVoluntarios 
			INNER JOIN tareas t on t.IdTarea = p.IdTarea 
			SET v.Puesto = "Centro de Transporte"
			WHERE t.nombre = 'Información'
			LIMIT 5;




/*90. asigna en la tabla voluntarios la columna puesto el valor “Nave de
Logistica” a personas con las siguientes tareas:
a. 2 personas de Accesos*/
		
			UPDATE voluntarios v
			INNER JOIN preferencias p on p.IdVoluntario = v.IdVoluntarios 
			INNER JOIN tareas t on t.IdTarea = p.IdTarea 
			SET v.Puesto = "Nave de Logistica"
			WHERE t.nombre = 'Accesos'
			LIMIT 2;
		
-- b. 30 promocion
		
			UPDATE voluntarios v
			INNER JOIN preferencias p on p.IdVoluntario = v.IdVoluntarios 
			INNER JOIN tareas t on t.IdTarea = p.IdTarea 
			SET v.Puesto = "Nave de Logistica"
			WHERE t.nombre = 'Promocion'
			LIMIT 30;
		
-- c. 5 logistica
		
			UPDATE voluntarios v
			INNER JOIN preferencias p on p.IdVoluntario = v.IdVoluntarios 
			INNER JOIN tareas t on t.IdTarea = p.IdTarea 
			SET v.Puesto = "Nave de Logistica"
			WHERE t.nombre = 'Logístico'
			LIMIT 5;
		


/*91. Asigna en la tabla voluntarios la columna puesto el valor “Escuela militar de montaña” 
 * a personas con las siguientes tareas:
a. 5 Accesos*/
		
			UPDATE voluntarios v
			INNER JOIN preferencias p on p.IdVoluntario = v.IdVoluntarios 
			INNER JOIN tareas t on t.IdTarea = p.IdTarea 
			SET v.Puesto = "Escuela militar de montaña"
			WHERE t.nombre = 'Accesos'
			LIMIT 5;
		
		
-- b. 30 voluntarios
		
		
			UPDATE voluntarios v
			INNER JOIN preferencias p on p.IdVoluntario = v.IdVoluntarios 
			INNER JOIN tareas t on t.IdTarea = p.IdTarea 
			SET v.Puesto = "Escuela militar de montaña"
			WHERE t.nombre = 'Voluntarios'
			LIMIT 30;


/*92. Asigna en la tabla voluntarios la columna puesto el valor “delegaciones”
a personas con las siguientes tareas:
a. 43 personas de Traducción/Interprete*/
		
			UPDATE voluntarios v
			INNER JOIN preferencias p on p.IdVoluntario = v.IdVoluntarios 
			INNER JOIN tareas t on t.IdTarea = p.IdTarea 
			SET v.Puesto = "delegaciones"
			WHERE t.nombre = 'Traducción'
			LIMIT 43;
		
		
-- b. 10 protocolo
		
			UPDATE voluntarios v
			INNER JOIN preferencias p on p.IdVoluntario = v.IdVoluntarios 
			INNER JOIN tareas t on t.IdTarea = p.IdTarea 
			SET v.Puesto = "delegaciones"
			WHERE t.nombre = 'Protocolo'
			LIMIT 10;
		
-- c. 20 acompañantes
		
			UPDATE voluntarios v
			INNER JOIN preferencias p on p.IdVoluntario = v.IdVoluntarios 
			INNER JOIN tareas t on t.IdTarea = p.IdTarea 
			SET v.Puesto = "delegaciones"
			WHERE t.nombre = 'Acompañantes'
			LIMIT 20;
-- d. 7 logistica
		
			UPDATE voluntarios v
			INNER JOIN preferencias p on p.IdVoluntario = v.IdVoluntarios 
			INNER JOIN tareas t on t.IdTarea = p.IdTarea 
			SET v.Puesto = "delegaciones"
			WHERE t.nombre = 'Logístico'
			LIMIT 7;
		
		
-- e. 5 comunicación

			UPDATE voluntarios v
			INNER JOIN preferencias p on p.IdVoluntario = v.IdVoluntarios 
			INNER JOIN tareas t on t.IdTarea = p.IdTarea 
			SET v.Puesto = "delegaciones"
			WHERE t.nombre = 'Comunicación'
			LIMIT 5;


		

/*93. Asigna en la tabla voluntarios la localidad “Berja” a personas con las
siguientes tareas:
a. 12 personas Apoyo*/
		
		
		UPDATE voluntarios v 
		INNER JOIN preferencias p on p.IdVoluntario = v.IdVoluntarios 
		INNER JOIN tareas t on t.IdTarea = p.IdTarea 
		INNER JOIN localidades l on l.idLocalidad = v.idLocalidad 
		set l.localidad ='Berja'
		WHERE t.nombre = 'Apoyo'
		limit 12;
		
		
		
-- b. 4 sanitarios
	
	
		UPDATE voluntarios v 
		INNER JOIN preferencias p on p.IdVoluntario = v.IdVoluntarios 
		INNER JOIN tareas t on t.IdTarea = p.IdTarea 
		INNER JOIN localidades l on l.idLocalidad = v.idLocalidad 
		set l.localidad ='Berja'
		WHERE t.nombre = 'Sanitaria'
		limit 4;
	
	
-- c. 3 informacion
	
		UPDATE voluntarios v 
		INNER JOIN preferencias p on p.IdVoluntario = v.IdVoluntarios 
		INNER JOIN tareas t on t.IdTarea = p.IdTarea 
		INNER JOIN localidades l on l.idLocalidad = v.idLocalidad 
		set l.localidad ='Berja'
		WHERE t.nombre = 'Información'
		limit 3;
	
-- d. 5 comunicacion
	
		UPDATE voluntarios v 
		INNER JOIN preferencias p on p.IdVoluntario = v.IdVoluntarios 
		INNER JOIN tareas t on t.IdTarea = p.IdTarea 
		INNER JOIN localidades l on l.idLocalidad = v.idLocalidad 
		set l.localidad ='Berja'
		WHERE t.nombre = 'Comunicación'
		limit 5;
	
	
-- e. 3 accesos
	
	
		UPDATE voluntarios v 
		INNER JOIN preferencias p on p.IdVoluntario = v.IdVoluntarios 
		INNER JOIN tareas t on t.IdTarea = p.IdTarea 
		INNER JOIN localidades l on l.idLocalidad = v.idLocalidad 
		set l.localidad ='Berja'
		WHERE t.nombre = 'Accesos'
		limit 3;




/*94. Asigna en la tabla voluntarios la localidad “Jaca” a personas con las
siguientes tareas:
a. 12 personas Apoyo*/
	
		UPDATE voluntarios v 
		INNER JOIN preferencias p on p.IdVoluntario = v.IdVoluntarios 
		INNER JOIN tareas t on t.IdTarea = p.IdTarea 
		INNER JOIN localidades l on l.idLocalidad = v.idLocalidad 
		set l.localidad ='Jaca'
		WHERE t.nombre = 'Apoyo'
		limit 12;	
	
-- b. 4 sanitarios
	
		UPDATE voluntarios v 
		INNER JOIN preferencias p on p.IdVoluntario = v.IdVoluntarios 
		INNER JOIN tareas t on t.IdTarea = p.IdTarea 
		INNER JOIN localidades l on l.idLocalidad = v.idLocalidad 
		set l.localidad ='Jaca'
		WHERE t.nombre = 'Sanitaria'
		limit 4;
	
	
-- c. 3 informacion
	
		UPDATE voluntarios v 
		INNER JOIN preferencias p on p.IdVoluntario = v.IdVoluntarios 
		INNER JOIN tareas t on t.IdTarea = p.IdTarea 
		INNER JOIN localidades l on l.idLocalidad = v.idLocalidad 
		set l.localidad ='Jaca'
		WHERE t.nombre = 'Información'
		limit 3;
	
	
-- d.5 comunicacion
	
		UPDATE voluntarios v 
		INNER JOIN preferencias p on p.IdVoluntario = v.IdVoluntarios 
		INNER JOIN tareas t on t.IdTarea = p.IdTarea 
		INNER JOIN localidades l on l.idLocalidad = v.idLocalidad 
		set l.localidad ='Jaca'
		WHERE t.nombre = 'Comunicación'
		limit 5;

	
	-- e. 3 accesos
	
		UPDATE voluntarios v 
		INNER JOIN preferencias p on p.IdVoluntario = v.IdVoluntarios 
		INNER JOIN tareas t on t.IdTarea = p.IdTarea 
		INNER JOIN localidades l on l.idLocalidad = v.idLocalidad 
		set l.localidad ='Jaca'
		WHERE t.nombre = 'Accesos'
		limit 3;




/*95. Asigna en la tabla voluntarios la localidad “Formentera” a personas con
las siguientes tareas:
a. 12 personas Apoyo*/
	
	
	
		UPDATE voluntarios v 
		INNER JOIN preferencias p on p.IdVoluntario = v.IdVoluntarios 
		INNER JOIN tareas t on t.IdTarea = p.IdTarea 
		INNER JOIN localidades l on l.idLocalidad = v.idLocalidad 
		set l.localidad ='Formentera'
		WHERE t.nombre = 'Apoyo'
		limit 12;
	
-- b. 4 sanitarios
	
	
		UPDATE voluntarios v 
		INNER JOIN preferencias p on p.IdVoluntario = v.IdVoluntarios 
		INNER JOIN tareas t on t.IdTarea = p.IdTarea 
		INNER JOIN localidades l on l.idLocalidad = v.idLocalidad 
		set l.localidad ='Formentera'
		WHERE t.nombre = 'Sanitaria'
		limit 4;
	
-- c. 3 informacion
	
	
		UPDATE voluntarios v 
		INNER JOIN preferencias p on p.IdVoluntario = v.IdVoluntarios 
		INNER JOIN tareas t on t.IdTarea = p.IdTarea 
		INNER JOIN localidades l on l.idLocalidad = v.idLocalidad 
		set l.localidad ='Formentera'
		WHERE t.nombre = 'Información'
		limit 3;
	
	
-- d. 5 comunicacion
	
	
		UPDATE voluntarios v 
		INNER JOIN preferencias p on p.IdVoluntario = v.IdVoluntarios 
		INNER JOIN tareas t on t.IdTarea = p.IdTarea 
		INNER JOIN localidades l on l.idLocalidad = v.idLocalidad 
		set l.localidad ='Formentera'
		WHERE t.nombre = 'Comunicación'
		limit 5;
	
	
-- e. 3 accesos
	
	
	
		UPDATE voluntarios v 
		INNER JOIN preferencias p on p.IdVoluntario = v.IdVoluntarios 
		INNER JOIN tareas t on t.IdTarea = p.IdTarea 
		INNER JOIN localidades l on l.idLocalidad = v.idLocalidad 
		set l.localidad ='Formentera'
		WHERE t.nombre = 'Accesos'
		limit 3;
	



/*96. Asigna la tarea de Panticosa a personas con las siguientes tareas:
a. 12 personas Apoyo*/
	
		UPDATE voluntarios v 
		INNER JOIN preferencias p on p.IdVoluntario = v.IdVoluntarios 
		INNER JOIN tareas t on t.IdTarea = p.IdTarea 
		INNER JOIN localidades l on l.idLocalidad = v.idLocalidad 
		set l.localidad ='Panticosa'
		WHERE t.nombre = 'Apoyo'
		limit 12;
	
-- b. 4 sanitarios
	
	
		UPDATE voluntarios v 
		INNER JOIN preferencias p on p.IdVoluntario = v.IdVoluntarios 
		INNER JOIN tareas t on t.IdTarea = p.IdTarea 
		INNER JOIN localidades l on l.idLocalidad = v.idLocalidad 
		set l.localidad ='Panticosa'
		WHERE t.nombre = 'Sanitaria'
		limit 4;
	
	
-- c. 3 informacion
	
	
		UPDATE voluntarios v 
		INNER JOIN preferencias p on p.IdVoluntario = v.IdVoluntarios 
		INNER JOIN tareas t on t.IdTarea = p.IdTarea 
		INNER JOIN localidades l on l.idLocalidad = v.idLocalidad 
		set l.localidad ='Panticosa'
		WHERE t.nombre = 'Información'
		limit 3;
	
	
-- d. 5 comunicacion
	
	
		UPDATE voluntarios v 
		INNER JOIN preferencias p on p.IdVoluntario = v.IdVoluntarios 
		INNER JOIN tareas t on t.IdTarea = p.IdTarea 
		INNER JOIN localidades l on l.idLocalidad = v.idLocalidad 
		set l.localidad ='Panticosa'
		WHERE t.nombre = 'Comunicación'
		limit 5;
	
	
	
	
-- e. 3 accesoS




		UPDATE voluntarios v 
		INNER JOIN preferencias p on p.IdVoluntario = v.IdVoluntarios 
		INNER JOIN tareas t on t.IdTarea = p.IdTarea 
		INNER JOIN localidades l on l.idLocalidad = v.idLocalidad 
		set l.localidad ='Panticosa'
		WHERE t.nombre = 'Accesos'
		limit 3;















