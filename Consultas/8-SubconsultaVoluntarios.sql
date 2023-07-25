
/*60. Mostrar voluntarios de la provincia de Madrid cuya edad supere la media de
edades de los voluntarios de Zaragoza.*/
	

	SELECT v.*
	FROM voluntarios v , localidades l , provincias pr
	WHERE v.idLocalidad = l.idLocalidad AND l.idProvincia = pr.idProvincia 
	AND pr.provincia ='Madrid' 
	AND YEAR(NOW())-YEAR(v.fNacimiento)>
	(
		SELECT AVG(YEAR(NOW())-YEAR(v.fNacimiento)) 
		FROM voluntarios v , localidades l , provincias pr
		WHERE v.idLocalidad = l.idLocalidad AND l.idProvincia = pr.idProvincia 
		AND pr.provincia ='Zaragoza'
	);
		       


/*61. Mostrar voluntarios y edad que superen a todas las edades de los voluntarios
de la provincia de Madrid.*/
	

	SELECT v.nombre , YEAR(CURRENT_DATE)-YEAR(v.fNacimiento) AS Edad, p.provincia 
	FROM voluntarios v , localidades l , provincias p 
	WHERE v.idLocalidad =l.idLocalidad AND l.idProvincia = p.idProvincia 
		AND YEAR(CURRENT_DATE)-YEAR(v.fNacimiento)<2000
		AND YEAR(CURRENT_DATE)-YEAR(v.fNacimiento)>
		(
			SELECT MAX(YEAR(CURRENT_DATE)-YEAR(v2.fNacimiento))  AS MediaMadrid
			FROM voluntarios v2 , localidades l2 , provincias p2 
			WHERE v2.idLocalidad =l2.idLocalidad AND l2.idProvincia = p2.idProvincia
				AND p2.provincia = 'Madrid'
		)
	ORDER BY Edad DESC 
	


/*62. Mostrar voluntarios y altura, que superen el peso más alto de los voluntarios de
Barcelona.*/

	
	SELECT v.nombre , v.peso , v.altura 
	FROM voluntarios v 
	WHERE v.peso >
		(
			SELECT MAX(v2.peso) 
			FROM voluntarios v2, localidades l , provincias p 
			WHERE v2.idLocalidad = l.idLocalidad AND l.idProvincia = p.idProvincia 
			AND p.provincia = 'Barcelona'
		)
	ORDER BY v.peso DESC , v.altura DESC



/*63. Mostrar voluntarios y altura cuyo altura sea inferior a cualquier altura de los
voluntarios de Burgos.*/
	
	
		SELECT v.nombre , v.altura , p.provincia 
		FROM voluntarios v , localidades l , provincias p 
		WHERE v.idLocalidad = l.idLocalidad AND l.idProvincia = p.idProvincia
			AND v.altura >1
			AND v.altura <
			(
				SELECT MIN(v2.altura) AS AlturaMinBurgos
				FROM voluntarios v2 , localidades l2 , provincias p2 
				WHERE v2.idLocalidad =l2.idLocalidad AND l2.idProvincia = p2.idProvincia
					AND p2.provincia ='Burgos'
			)
		ORDER BY v.altura DESC;
		
	
		
/*64. Mostrar nombre de voluntarios y altura cuya altura coincida con alturas de
voluntarios de Valencia.*/

	
	SELECT v.nombre , v.altura, p.provincia 
	FROM voluntarios v , localidades l , provincias p 
	WHERE v.idLocalidad = l.idLocalidad AND l.idProvincia = p.idProvincia
		AND p.provincia !='Valencia/València'
		AND v.altura IN
		(
			SELECT  v2.altura 
			FROM voluntarios v2 , localidades l, provincias p
			WHERE v2.idLocalidad = l.idLocalidad AND l.idProvincia = p.idProvincia 
				AND p.provincia ='Valencia/València'
		)
	ORDER BY v.altura 
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
