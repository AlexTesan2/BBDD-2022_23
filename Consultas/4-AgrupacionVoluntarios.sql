#  41. Cantidad de personas de cada país.


		SELECT pa.pais , COUNT(v.IdVoluntarios) 
		FROM voluntarios v , localidades l , provincias p , paises pa
		WHERE v.idLocalidad = l.idLocalidad AND l.idProvincia = p.idProvincia AND  p.idPais  = pa.idPais 
		GROUP BY pa.pais ;
	


#  42. Cantidad de personas de las diferentes provincias de España.
	
	
	
		SELECT p.provincia , COUNT( DISTINCT v.IdVoluntarios) 
		FROM voluntarios v , localidades l , provincias p , paises p2 
		WHERE v.idLocalidad = l.idLocalidad AND l.idProvincia = p.idProvincia AND p.idPais = p2.idPais 
			AND p2.pais = 'España'	
		GROUP BY p.provincia ;



#  43. Cantidad de personas de las tres provincias de Aragón.

	

		SELECT p.provincia , COUNT(v.nombre) 
		FROM voluntarios v , localidades l , provincias p 
		WHERE v.idLocalidad = l.idLocalidad AND l.idProvincia = p.idProvincia
			AND p.provincia  IN ('Zaragoza','Huesca','Teruel')
		GROUP BY p.provincia  ;
	
	

#  44. Cantidad de personas de las diferentes poblaciones de Huesca.
	
	
	
		SELECT l.localidad , COUNT(v.IdVoluntarios), p.provincia  
		FROM voluntarios v , localidades l , provincias p 
		WHERE v.idLocalidad = l.idLocalidad AND l.idProvincia = p.idProvincia
			AND p.provincia = 'Huesca'
		GROUP BY l.localidad ;

	
	

/* 45.
a. Cantidad de personas que se llaman igual.
b. Nombre que más se repite
c. Nombre que se repiten entre 5 y 10 veces*/
	
		#A
		
		SELECT nombre , COUNT(IdVoluntarios) as total 
		FROM voluntarios v 
		GROUP BY nombre 
		ORDER BY total DESC ;
	
	
		#B
		
		SELECT nombre , COUNT(IdVoluntarios) as total 
		FROM voluntarios v 
		GROUP BY nombre 
		ORDER BY total DESC 
		LIMIT 1;
	
		#C
	
		SELECT nombre , COUNT(IdVoluntarios) as total 
		FROM voluntarios v 
		GROUP BY nombre 
		HAVING total BETWEEN 5 AND 10
		ORDER BY total DESC ;
		
	
	
#  46. Cantidad de personas por edades.

	
	
	
		SELECT  (YEAR (NOW())-YEAR (v.fNacimiento)) AS EDAD, COUNT(v.IdVoluntarios) AS Cantidad
		FROM voluntarios v 
		GROUP BY EDAD
		ORDER BY  EDAD;
	
	
	
	
#  47. Cantidad de personas por tallas.

	
		SELECT v.talla , COUNT(v.IdVoluntarios) AS Cantidad
		FROM  voluntarios v 
		GROUP BY v.talla 
		ORDER BY v.talla ;


#  48. Cantidad de personas por profesion.

	
	
		SELECT l.labor , COUNT(v.IdVoluntarios) AS Cantidad
		FROM voluntarios v , laboral l
		WHERE v.idLabor = l.IdLabor 
		GROUP BY l.labor ;
		
		
	
#  49. Cantidad de personas por sexo.
	
	
		SELECT v.Sexo , COUNT(v.Nombre)  AS Cantidad
		FROM Voluntarios_OLD v
		GROUP BY v.Sexo ;



#  50. Cantidad de personas nacidas en cada mes.

	
	
		SELECT   MONTHNAME (v.fNacimiento) AS MES , COUNT(v.IdVoluntarios) AS Cantidad
		FROM voluntarios v 
		GROUP BY MES ;
	
		


# 51. Cantidad de personas nacidas en cada trimestre.
	
	
		
		
		SELECT COUNT(v.IdVoluntarios) AS Cantidad , QUARTER(v.fNacimiento) AS trimestre
		FROM voluntarios v 
		GROUP BY trimestre;
	
	



# 52. Cantidad de personas nacidas en cada trimestre, pero solo de aquellos trimestres que tengan más de 110 personas.

	
	
	
		SELECT COUNT(v.IdVoluntarios) AS Cantidad , QUARTER(v.fNacimiento) AS trimestre
		FROM voluntarios v 
		GROUP BY trimestre
		HAVING Cantidad > 110;

	

# 53. Cantidad de personas de los diferentes niveles de italiano hablado.
	
	
	
		SELECT  n.hablado , COUNT(v.IdVoluntarios) AS Cantidad ,i.idioma 
		FROM voluntarios v , nivel n , idiomas i 
		WHERE v.IdVoluntarios = n.IdVoluntario AND n.IdIdioma = i.Ididioma 
				AND i.idioma = 'Italiano'
		GROUP BY n.hablado ;



# 54. Cantidad de personas de los diferentes niveles de frances hablado

		
		SELECT  n.hablado , COUNT(v.IdVoluntarios) AS Cantidad ,i.idioma 
		FROM voluntarios v , nivel n , idiomas i 
		WHERE v.IdVoluntarios = n.IdVoluntario AND n.IdIdioma = i.Ididioma 
				AND i.idioma = 'Frances'
		GROUP BY n.hablado ;
		


# 55. Cantidad de personas de los diferentes niveles de ingles hablado.
	
		
		SELECT  n.hablado , COUNT(v.IdVoluntarios) AS Cantidad ,i.idioma 
		FROM voluntarios v , nivel n , idiomas i 
		WHERE v.IdVoluntarios = n.IdVoluntario AND n.IdIdioma = i.Ididioma 
				AND i.idioma = 'Ingles'
		GROUP BY n.hablado ;



# 56. Cantidad de personas de los diferentes niveles de ingles hablado y por edades.
	
	
	
		SELECT (YEAR (NOW())-YEAR (v.fNacimiento)) AS EDAD, n.hablado , COUNT(v.IdVoluntarios) AS Cantidad ,i.idioma 
		FROM voluntarios v , nivel n , idiomas i 
		WHERE v.IdVoluntarios = n.IdVoluntario AND n.IdIdioma = i.Ididioma 
				AND i.idioma = 'Ingles'
		GROUP BY n.hablado, EDAD 
		ORDER BY n.hablado, EDAD;



# 57. Promedio de edades, Más viejo, Más Joven
	
	
		
		SELECT AVG (YEAR (NOW())-YEAR (v.fNacimiento)) AS Media,
				MAX(YEAR (NOW())-YEAR (v.fNacimiento)) AS MasViejo,
				MIN(YEAR (NOW())-YEAR (v.fNacimiento))  AS MasJoven
		FROM voluntarios v 
		WHERE (YEAR (NOW())-YEAR (v.fNacimiento))<1000;


	
		
# 58. Promedio de edades de cada provincia.
	
	
		SELECT p.provincia ,AVG (YEAR (NOW())-YEAR (v.fNacimiento)) AS Promedio 
		FROM voluntarios v , localidades l , provincias p 
		WHERE v.idLocalidad = l.idLocalidad AND l.idProvincia = p.idProvincia 
		GROUP BY p.provincia ;
		


#59. Edad de la persona más viejo y más joven de cada pais.

	
	
		SELECT pa.pais , MAX(YEAR (NOW())-YEAR (v.fNacimiento)) AS MasViejo, MIN(YEAR (NOW())-YEAR (v.fNacimiento))  AS MasJoven
		FROM voluntarios v , localidades l , provincias pr, paises pa
		WHERE v.idLocalidad = l.idLocalidad AND l.idProvincia = pr.idProvincia AND pr.idPais = pa.idPais 
		AND (YEAR (NOW())-YEAR (v.fNacimiento))<1000
		GROUP BY pa.pais ;
	
	
	

