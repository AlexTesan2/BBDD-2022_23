
# 1-campos Título, FECHAPUBLICACION de todas las películas, ordenado descendentemente por el Título.

		SELECT  TITULO , FECHAPUBLICACION 
		FROM Peliculas p 
		ORDER BY TITULO DESC ;
	
		
	
# 2-Título, FECHAPUBLICACION y Género de todas las películas, ordenando ascendentemente por FECHAPUBLICACION y descendentemente por Género.
	
		
		SELECT p.TITULO , p.FECHAPUBLICACION , p.GENERO , g.NOMBREGENERO 
		FROM Peliculas p , Generos g 
		WHERE p.GENERO = g.CODIGOGENERO 
		ORDER BY p.FECHAPUBLICACION, p.GENERO DESC ;
	
		
	
# 3-Título, FECHAPUBLICACION, Género y Tipo de todas las películas, ordenando ascendentemente por Tipo y Título
	
	
		SELECT p.TITULO , p.FECHAPUBLICACION , g.NOMBREGENERO , p.TIPOPELICULA
		FROM Peliculas p ,Generos g 
		WHERE p.GENERO = g.CODIGOGENERO 
		ORDER BY p.TIPOPELICULA, p.TITULO ;
	
	
	
# 4-Título y Género de las 7 últimas películas (en orden alfabético) del género Comedia
		
		 
		SELECT  p.TITULO , g.NOMBREGENERO 
		FROM Peliculas p , Generos g 
		WHERE p.GENERO = g.CODIGOGENERO 
			AND g.NOMBREGENERO = 'Comedia'
		ORDER BY p.TITULO DESC 
		LIMIT 7;
	
	
	
# 5-muestre todos los campos de las películas cuyo género sea Drama o Comedia, ordenadas por genero.
	
	
		SELECT *
		FROM Peliculas p ,Generos g 
		WHERE p.GENERO = g.CODIGOGENERO 
			AND (g.NOMBREGENERO = 'Drama' OR g.NOMBREGENERO = 'Comedia')
		ORDER BY p.GENERO ;
	
	
	
# 6-todos los campos de las películas cuyo precio esté entre 15 y 16, ordenadas por título.
	
	
		SELECT *
		FROM Peliculas p 
		WHERE PRECIO BETWEEN 15 AND 16
		ORDER BY TITULO ;
		
		
	
# 7-todos los campos de las películas PUBLICADAS en el año 2017.
	
	
		SELECT *
		FROM Peliculas p 
		WHERE YEAR (FECHAPUBLICACION) = 2017;
	
	
	
# 8-todos los campos de las películas PUBLICADAS en el mes de marzo del año 2017
	
	
		SELECT *
		FROM Peliculas p 
		WHERE MONTH (FECHAPUBLICACION)=3 
			AND YEAR(FECHAPUBLICACION)=2017;
	
		
				
/* 9-el Título de la película y al lado una columna donde aparezca 'Para niños' 
	si el género es INFANTIL, o que aparezca 'Para adultos' en caso contrario. 
	(El título de la nueva columna se llamará RECOMENDADA)*/# no da resultados con infantil
		
		
		SELECT p.TITULO ,
		IF (g.NOMBREGENERO = 'infantil', 'Para Niños' , 'Para Adultos') AS RECOMENDADA
		FROM Peliculas p , Generos g 
		WHERE p.GENERO = g.CODIGOGENERO ;
	
	
	
# 10-los Títulos de películas que empiezan por M o P.
	
	
		SELECT TITULO 
		FROM Peliculas p 
		WHERE TITULO LIKE 'M%' 
		   OR TITULO LIKE 'P%';
		  
		  
		  
# 11-Títulos de películas que acaben en la letra S.
		  
		  
		SELECT TITULO 
		FROM Peliculas p 
		WHERE TITULO LIKE '%S';
		 
		 
		 
# 12-Títulos de películas que contengan la palabra AMOR.
		 
		 
		SELECT TITULO 
		FROM Peliculas p 
		WHERE TITULO LIKE '%AMOR%';
		
	
	
# 13-Títulos y Géneros de películas que tengan 4 caracteres en su título
	
	
		SELECT p.TITULO , g.NOMBREGENERO 
		FROM Peliculas p , Generos g 
		WHERE p.GENERO = g.CODIGOGENERO 
			AND LENGTH (p.TITULO) = 4;
		
		
		
# 14-Títulos y Géneros de películas que tengan 4 caracteres en su título y sean de género Acción.
		
		
		SELECT p.TITULO , g.NOMBREGENERO 
		FROM Peliculas p , Generos g 
		WHERE p.GENERO = g.CODIGOGENERO 
			AND g.NOMBREGENERO = 'Accion'
			AND TITULO LIKE '____';
		
		
		
# 15-Títulos de películas que tengan por lo menos un carácter numérico
		
		
		SELECT TITULO 
		FROM Peliculas p 
		WHERE TITULO REGEXP '[0-9]+';
	
	
	
# 16-los Títulos y la fecha de publicación de las películas que empiezan por alguno de los siguientes caracteres: C,D,E,F,G,H
	
	
		SELECT TITULO , FECHAPUBLICACION 
		FROM Peliculas p 
		WHERE TITULO RLIKE '^[C-H]';
		
		
		
# 17-Títulos y la fecha de publicación de las películas que empiezan por alguno de los siguientes caracteres: C,D,E,F,G,H,P,Q,R,S,T,U,V
	
	
		SELECT TITULO , FECHAPUBLICACION 
		FROM Peliculas p 
		WHERE TITULO RLIKE '^[C-H]' 
		   OR TITULO RLIKE '^[P-V]';
		  
		  ----------------------------
		  
		SELECT TITULO , FECHAPUBLICACION 
		FROM Peliculas p 
		WHERE TITULO RLIKE '^[C-H]|^[P-V]'
		

		  
# 18-Títulos y la fecha de publicación de las películas que no terminen por alguno de los siguientes caracteres: I,J,K,L,M,N,O,P	
		  
		  
		SELECT TITULO , FECHAPUBLICACION 
		FROM Peliculas p 
		WHERE TITULO NOT RLIKE '[I-P]$' ;
		
		
		
# 19-Títulos de películas que no contengan la letra a.
	
	
	
		SELECT  TITULO 
		FROM Peliculas p 
		WHERE TITULO NOT LIKE '%A%';
		
		#---------------------------------------
		
		SELECT  TITULO 
		FROM Peliculas p 
		WHERE TITULO NOT RLIKE 'A|Á';
	
	
	
# 20-Títulos y el género de las películas cuyo género sea TERROR, COMEDIA, INFANTIL ordenadas ascendentemente por el título./ solo resultados con comedia
	
	
	
		SELECT p.TITULO , g.NOMBREGENERO 
		FROM Peliculas p , Generos g 
		WHERE g.NOMBREGENERO IN ("TERROR", "COMEDIA", "INFANTIL")
			AND g.CODIGOGENERO = p.GENERO 
		ORDER BY TITULO ;
		
		
	
		
		
		