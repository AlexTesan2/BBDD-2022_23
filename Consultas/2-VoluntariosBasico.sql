#1. Extranjeros que vienen al FOJE

	SELECT V.IdVoluntarios , V.nombre , P.pais , P.idPais , PR.provincia , L.localidad 
	FROM  paises P , provincias PR , localidades L, voluntarios  V
	WHERE V.idLocalidad = L.idLocalidad
	AND L.idProvincia = PR.idProvincia 
	AND PR.idPais = P.idPais 
	AND P.pais = 'EXTRANJEROS'
	ORDER BY V.IdVoluntarios ;
	
	
#2. Personas de fuera de Aragón

	
	SELECT v.IdVoluntarios , v.nombre , p.provincia , l.localidad 
	FROM voluntarios v , localidades l , provincias p 
	WHERE v.idLocalidad = l.idLocalidad 
		AND l.idProvincia = p.idProvincia 
		AND p.provincia != 'Zaragoza' AND  p.provincia != 'Huesca' AND p.provincia != 'Teruel'
	ORDER BY p.provincia ;
	

#3. Personas de Jaca


	SELECT  v.nombre , l.localidad , v.idLocalidad , l.idLocalidad 
	FROM voluntarios v , localidades l 
	WHERE	v.idLocalidad = l.idLocalidad 
		AND l.localidad = 'Jaca';
	
	
	
#4. Personas que no tengan alojamiento durante el FOJE
	
	SELECT  v.nombre , v.alojamiento 
	FROM voluntarios v 
	WHERE v.alojamiento = 'False';



#5. Personas entre 18 y 25 años que pesen más de 70Kg y lleven la talla M o L  /// Sin resultados



	SELECT v.nombre ,  v.peso , v.talla, (YEAR (NOW())-YEAR (v.fNacimiento)) AS EDAD
	FROM voluntarios v 
	WHERE (YEAR (NOW())-YEAR (v.fNacimiento)) BETWEEN 18 AND 25
		AND v.peso > 70  AND v.talla IN ('M', 'L');
		
	
	
	
	#Select DATEDIFF(YEAR,FechaNac,GETDATE()) as Edad from clientes
	
	
#6. Personas entre 26 y 40 años de Zaragoza o Personas entre 41 y 55 años de huesca
	
	
	
	SELECT v.nombre , p.provincia , (YEAR (NOW())-YEAR (v.fNacimiento)) AS EDAD
	FROM voluntarios v , localidades l , provincias p 
	WHERE v.idLocalidad = l.idLocalidad AND l.idProvincia = p.idProvincia 
		AND(( (YEAR (NOW())-YEAR (v.fNacimiento)) BETWEEN 26 AND 40 AND p.provincia = 'Zaragoza')
		 OR ( (YEAR (NOW())-YEAR (v.fNacimiento)) BETWEEN 41 AND 50 AND p.provincia = 'Huesca'))
	ORDER BY p.provincia DESC , EDAD
	
		 
		 
	
#7. Personas mayores a 55 años
	
	
	
	SELECT v.nombre , v.fNacimiento, (YEAR (NOW())-YEAR (v.fNacimiento)) AS EDAD
	FROM voluntarios v 
	WHERE (YEAR (NOW())-YEAR (v.fNacimiento)) > 55 ;
	
	
	
#8. Personas con una talla XXL y cuya altura sea inferior a 175cm
	
	
	SELECT v.nombre , v.talla , v.altura 
	FROM voluntarios v 
	WHERE  v.talla = 'XXL' AND v.altura < 175
	ORDER BY v.altura DESC ;


#9. Personas estudiantes con nivel ALTO en informatica

	
	SELECT v.nombre , v.nivelInformatica , l.labor 
	FROM voluntarios v , laboral l 
	WHERE v.idLabor = l.IdLabor 
		AND l.labor = 'Estudiante' AND  v.nivelInformatica = 'alto';
	
	
	
#10. Personas estudiantes con un nivel ALTO en ingles hablado y escrito
	
	
	SELECT v.nombre , l.labor , i.idioma , n.hablado , n.escrito 
	FROM voluntarios v , idiomas i , nivel n , laboral l 
	WHERE v.IdVoluntarios = n.IdVoluntario 
		AND n.IdIdioma = i.Ididioma 
		AND v.idLabor = l.IdLabor 
		AND l.labor = 'Estudiante' AND i.idioma ='Ingles'
		AND n.hablado = 'Alto'  AND n.escrito = 'Alto';
	
	
	
#11. Personas jubiladas con un nivel ALTO en frances hablado y escrito o con un nivel ALTO en inglés hablado y escrito
	
	
	SELECT v.nombre , l.labor , i.idioma , n.hablado , n.escrito 
	FROM voluntarios v , idiomas i , nivel n , laboral l 
	WHERE v.IdVoluntarios = n.IdVoluntario 
		AND n.IdIdioma = i.Ididioma 
		AND v.idLabor = l.IdLabor 
		AND l.labor = 'Jubilado' 
		AND n.hablado = 'Alto'  AND n.escrito = 'Alto'
		AND i.idioma IN ('Ingles', 'Frances');
	
	
#12. Personas que practiquen esquí en cualquiera de sus modalidades

	
	SELECT v.nombre , d.deporte 
	FROM voluntarios v , deportes d , practicar p 
	WHERE v.IdVoluntarios = p.IdVoluntarios 
		AND p.IdDeportes = d.IdDeporte 
		AND d.deporte LIKE '%Esqui%';
	

#13. Personas que cumplen años hoy
	
	
	SELECT V.nombre , V.fNacimiento 
	FROM voluntarios V
	WHERE DAY (V.fNacimiento) = DAY(NOW()) AND MONTH (V.fNacimiento)= MONTH (NOW());
	
	
#14. Personas que cumplen años en el mes de diciembre

	
		SELECT V.Nombre , V.fNacimiento  
		FROM voluntarios V
		WHERE MONTH (V.fNacimiento)=12;
	
	
#15. Personas que cumplen años en invierno   
	
	
		SELECT V.Nombre , V.fNacimiento 
		FROM  voluntarios V
		WHERE ( MONTH (V.fNacimiento)=12 AND DAY (V.fNacimiento)>=20)
		OR MONTH (V.fNacimiento)=1
		OR MONTH (V.fNacimiento)=2 
	    OR (MONTH (V.fNacimiento)=3 AND DAY (V.fNacimiento)<=20);
	   
	   
#16. Personas que cumplen años en el primer trimestre del año
	   
	   
	   	SELECT v.Nombre , v.fNacimiento 
		FROM  voluntarios v 
		WHERE MONTH (v.fNacimiento) IN ('1', '2', '3');
	
	
#17. Personas que tengan preferencia 1 en tareas de informática o preferencia 1 en tareasde conducción
	
	
		SELECT v.nombre , t.nombre , p.Preferencia 
		FROM voluntarios v , preferencias p , tareas t 
		WHERE v.IdVoluntarios = p.IdVoluntario 
			AND p.IdTarea = t.IdTarea 
			AND p.Preferencia = 1
			AND t.nombre IN ('Informatica', 'Conduccion');
		
		
#18. Personas que tengan preferencia 1 en tareas de interprete y que tengan un nivel hablado alto en cualquiera de los idiomas
		
		
		SELECT  v.nombre , i.idioma , n.hablado , t.nombre , p.Preferencia 
		FROM voluntarios v , preferencias p , tareas t , nivel n , idiomas i 
		WHERE v.IdVoluntarios = n.IdVoluntario 
			AND n.IdIdioma = i.Ididioma 
			AND v.IdVoluntarios = p.IdVoluntario 
			AND p.IdTarea = t.IdTarea 
			AND n.hablado = 'Alto' 
			AND t.nombre ='Interprete'
			AND p.Preferencia =1;
		
		
#19. Personas que tengan preferencia 1 en tareas de informatica y tengan un nivel medio o alto en informatica
		
		
		SELECT  v.nombre , t.nombre , p.Preferencia , v.nivelInformatica 
		FROM voluntarios v , preferencias p , tareas t 
		WHERE v.IdVoluntarios = p.IdVoluntario 
			AND p.IdTarea = t.IdTarea 
			AND t.nombre = 'Informatica'
			AND p.Preferencia = 1
			AND v.nivelInformatica = 'alto';
		
		
		
		
/*20. Personas que tengan preferencia 1 en tareas de conducción, tengan un nivel medio o
alto de ingles hablado, sean mayores de 26 años, tengan carnet de conducir B y sean
de Huesca.*/	# sin resultados
		
		
		SELECT  v.nombre , i.idioma , n.hablado, t.nombre  , pf.Preferencia ,
				p.provincia , v.carnetB ,(YEAR (NOW())-YEAR (v.fNacimiento)) AS EDAD
				
		FROM voluntarios v , idiomas i , nivel n ,localidades l ,
			 provincias p , preferencias pf, tareas t 
		
		WHERE v.IdVoluntarios = pf.IdVoluntario AND pf.IdTarea = t.IdTarea 
			AND v.IdVoluntarios = n.IdVoluntario AND n.IdIdioma = i.Ididioma
			AND v.idLocalidad = l.idLocalidad AND l.idProvincia = p.idProvincia 
			
			AND v.carnetB = 'True' AND p.provincia = 'Huesca'
			AND i.idioma = 'Ingles' AND n.hablado IN ('Medio', 'Alto')
			AND (YEAR (NOW())-YEAR (v.fNacimiento)) > 26
			AND pf.Preferencia = 1 
			AND t.nombre = 'Traduccion';	
			
			
		
		
#21. Personas que tengan preferencia 2 en tareas administrativas, tengan un nivel medio o alto de ingles hablado y sean mayores de 40 años.
		
		
		
		
			SELECT v.nombre , (YEAR (NOW())-YEAR (v.fNacimiento)) AS EDAD, t.nombre , p.Preferencia , i.idioma , n.hablado 
			FROM voluntarios v , preferencias p ,tareas t , nivel n , idiomas i 
			WHERE v.IdVoluntarios = p.IdVoluntario 
				AND p.IdTarea = t.IdTarea 
				AND v.IdVoluntarios = n.IdVoluntario 
				AND n.IdIdioma = i.Ididioma 
				AND t.nombre = 'Administrativas' AND p.Preferencia = 2
				AND i.idioma = 'Ingles' AND n.hablado IN ('Medio','Alto')
				AND (YEAR (NOW())-YEAR (v.fNacimiento))>40;
		
		
			
			
#22. Personas cuyo nombre comience por A y que sean de Cataluña
		
			
			
		SELECT v.nombre , p.provincia 
		FROM voluntarios v , localidades l , provincias p  
		WHERE v.idLocalidad = l.idLocalidad 
			AND l.idProvincia = p.idProvincia 
			AND p.provincia IN ('LLEIDA', 'TARRAGONA', 'BARCELONA', 'GIRONA')
			AND v.nombre LIKE 'A%'
		
			
			
#23. Personas cuyo codigo postal comience por 2 y termine en 6
		
		 
		SELECT V.Nombre ,V.Cp 
		FROM Voluntarios_OLD V
		WHERE V.Cp LIKE '2%' AND V.Cp LIKE '%6';
		#en este hay q usar voluntarios old
		
	
	
#24. Personas cuya población comience por CAN
	
		SELECT v.nombre , l.localidad 
		FROM  voluntarios v , localidades l 
		WHERE v.idLocalidad = l.idLocalidad 
			AND l.localidad LIKE 'CAN%';
		
		
		
#25. Personas cuyo nombre comience por cualquiera de las siguientes letras F,G.H,I,J,K,L,M
		
		
		
		SELECT v.nombre 
		FROM voluntarios v 
		WHERE v.nombre RLIKE '^[F-M]'
		ORDER BY  nombre; 
		
	
	
#26. Personas cuya cuarta letra del nombre tenga una de las siguientes letras P,Q,R,S,T y además sean aragonesas.
		
	
		
		SELECT v.nombre , p.provincia 
		FROM  voluntarios v , localidades l , provincias p 
		WHERE  v.idLocalidad = l.idLocalidad AND l.idProvincia = p.idProvincia 
			AND p.provincia IN ('Zaragoza', 'Huesca', 'Teruel')
			AND (MID(v.Nombre, 4, 1) RLIKE '[P-T]');
		
		#     ^([A-Za-z]{3})[P-T]
		
		
#27. Personas cuyo nombre comience por cualquiera de las siguientes letras A,B,C,D,E,F,G,H,I,J,K,L sean varones y residan en Galicia
	
		
		
		SELECT V.Nombre , V.Sexo , V.Provincia 
		FROM Voluntarios_OLD V
		WHERE V.Sexo ='M'
		AND V.Provincia IN ( 'LUGO','OURENSE','PONTEVEDRA', 'A CORUÑA')
		AND V.Nombre RLIKE '^[A-L]';
		
	
		
	
#28. PERSONAS CUYO NOMBRE EMPIECE Y TERMINE POR VOCAL 
	
	
	
		SELECT v.nombre 
		FROM voluntarios v 
		WHERE 	v.nombre RLIKE '^[aeiou].*[aeiou]$';
		
		
	
#29. Personas cuyo nombre tenga 3 letras o tenga 10 letras
		
		SELECT v.nombre 
		FROM voluntarios v 
		WHERE LENGTH (v.nombre)=3 OR LENGTH (v.nombre)=10
		ORDER BY LENGTH (v.nombre);
	
	
		
#30. Personas en cuya población aparezca la palabra VILLANUEVA
		
	
	
		SELECT v.nombre , l.localidad 
		FROM voluntarios v , localidades l 
		WHERE v.idLocalidad = l.idLocalidad 
		AND l.localidad LIKE '%VILLANUEVA%';
		
	
		
		
#31. Personas en cuya población aparezca la letra Ñ
	
	
	
		SELECT v.nombre , l.localidad
		FROM voluntarios v , localidades l 
		WHERE v.idLocalidad = l.idLocalidad 
		AND l.localidad RLIKE 'Ñ';
		
		
	
#32. Personas en cuya población aparezca una vocal acentuada
		
		
	
	
		SELECT v.nombre , l.localidad
		FROM voluntarios v , localidades l 
		WHERE v.idLocalidad = l.idLocalidad 
		AND l.localidad RLIKE '[áéíóú]';
	
	
	
		
#33. Seleccionar el campo nombre, otro que contenga las tres primeras posiciones del nombre, otro que contenga las dos últimas posiciones del nombre.
		
		
	
	
		SELECT v.nombre , LEFT (v.nombre, 3) AS Primero , RIGHT (v.nombre, 2) AS Ultimo
		FROM voluntarios v ;
		
	
	

#34. Seleccionar el campo nombre, población, otro que contenga las posiciones 2 y 3 del nombre, y otro que contenga la posición primera y última de la población.


		
		SELECT v.nombre , l.localidad , MID(v.nombre,2,2) AS MedNom  , CONCAT(LEFT(l.localidad,1),RIGHT(l.localidad,1) ) AS PrimUltLoc
		FROM voluntarios v , localidades l 
		WHERE v.idLocalidad = l.idLocalidad; 
	
	
		

/*35. Seleccionar el campo nombre, población, otro al que llamaremos usuario, que
contenga las tres primeras posiciones del nombre junto con las tres ultimas posiciones
de la población y el idvoluntario y otro al que llamaremos clave que contenga los
dígitos 3 y 4 del codigo postal junto con el idvoluntario y el mes de nacimiento.*/


		SELECT v.Nombre , v.Poblacion , CONCAT(LEFT(v.Nombre,3),RIGHT (v.Poblacion,3),v.Idvoluntario ) AS Usuario,
				CONCAT(MID(v.Cp,3,2),v.Idvoluntario,MONTH(v.FechaNacimiento)) AS Clave,
				v.Cp , v.Idvoluntario , v.FechaNacimiento 
		FROM Voluntarios_OLD v;

	
	

/*36. Seleccionar el campo nombre y otro llamado Dias Vividos donde muestre la diferencia
de dias entre la fecha actual y la de su nacimiento.*/
	
	
		SELECT v.nombre , DATEDIFF(CURRENT_DATE(), fNacimiento) AS DiasVividos
		FROM voluntarios v ;



/*37. Seleccionar el campo de nombre, fecha, otro llamado Dia Nacimiento en el que se
muestre el día de la semana en el que nació, otro llamado Trimestre en el que se
muestre el trimestre correspondiente a la fecha de nacimiento.*/
	
		
		SELECT v.nombre , v.fNacimiento , DAYOFWEEK(v.fNacimiento) AS DiaNacimiento , QUARTER(v.fNacimiento) AS Trimestre 
		FROM voluntarios v ;



/*38. Seleccionar el campo de nombre, provincia y otro al que llamaremos comunidad y el
cual llevará ARAGONES si la persona reside en cualquier provincia de Aragón,
ANDALUZ si reside en cualquier provincia de Andalucía y guiones (--------) en caso
contrario.*/


		SELECT v.nombre , p.provincia , 
		
		CASE
			WHEN p.provincia IN ('Zaragoza','Huesca','Teruel') THEN 'ARAGONES'
			
			WHEN p.provincia IN ('Huelva','Sevilla','Cordoba','Jaen','Almeria','Granada','Malaga', 'Cadiz') THEN 'ANDALUZ'
			
			ELSE '---------'
			
		END AS Comunidad
		
		FROM voluntarios v , provincias p , localidades l 
		WHERE v.idLocalidad = l.idLocalidad AND l.idProvincia = p.idProvincia 
		ORDER BY Comunidad DESC , p.provincia DESC;

;

#39. Selecciona el campo de nombre, fecha, edad y prepara un campo llamado EdadExacta que contenga la edad exacta de la persona



		SELECT v.nombre , v.fNacimiento , (YEAR (NOW())-YEAR (v.fNacimiento)) AS EDAD,
		       ((DATE(NOW())-DATE(v.fNacimiento))/10) AS EdadExacta
		FROM voluntarios v ;



		