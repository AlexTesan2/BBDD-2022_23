

#  21 -Agrupar las películas por género
	

	SELECT p.TITULO , g.NOMBREGENERO 
	FROM Peliculas p , Generos g 
	WHERE g.CODIGOGENERO = p.GENERO 
	ORDER BY g.NOMBREGENERO ;



#  22 -Muestre cuantas películas existen de cada género. (Mostrar como título de columna TOTAL PELICULAS)


	SELECT g.NOMBREGENERO , COUNT(p.TITULO) AS TOTAL_PELICULAS
	FROM Peliculas p , Generos g 
	WHERE p.GENERO = g.CODIGOGENERO 
	GROUP BY g.NOMBREGENERO ;


#  23 -Muestre cuantas películas existen de cada género y nos muestre aquellos que superen 10 películas (Mostrar como título de columna TOTAL PELICULAS)


	SELECT g.NOMBREGENERO , COUNT(p.TITULO) AS TOTAL
	FROM Peliculas p , Generos g 
	WHERE p.GENERO = g.CODIGOGENERO 
	GROUP BY g.NOMBREGENERO 
	HAVING TOTAL > 10;



#  24- Muestrar cuantas películas existen de los géneros INFANTIL y MUSICAL. (Mostrar como título de columna TOTAL PELICULAS)

	SELECT COUNT(p.TITULO) AS total, g.NOMBREGENERO  
	FROM  Peliculas p , Generos g 
	WHERE p.GENERO = g.CODIGOGENERO 
		AND g.NOMBREGENERO IN ('Infantil','Musical')
	GROUP BY g.NOMBREGENERO ;
	
	

#  25 -Agrupe las películas por fecha de publicación
	
	
	SELECT  p.TITULO , FECHAPUBLICACION 
	FROM Peliculas p 
	ORDER BY p.FECHAPUBLICACION ;

	

#  26 -Muestre cuantas películas existen de cada fecha de publicación . (Mostrar como título de columna TOTAL PELICULAS)


	SELECT p.FECHAPUBLICACION , COUNT(p.TITULO) AS TotalPeliculas
	FROM Peliculas p 
	GROUP BY p.FECHAPUBLICACION ;

	

#  27 -Muestre cuantas películas existen de cada fecha de publicación mostrando sólo aquellas fechas que tengan 1 película. (Mostrar como título de columna TOTAL PELICULAS)



	SELECT p.FECHAPUBLICACION , COUNT(p.TITULO) AS TotalPeliculas
	FROM Peliculas p 
	GROUP BY p.FECHAPUBLICACION 
	HAVING COUNT(p.TITULO)=1;
	
	

#  28 -Agrupe las películas por  genero y fecha de publicación.


	SELECT p.TITULO , g.NOMBREGENERO , p.FECHAPUBLICACION 
	FROM Peliculas p , Generos g 
	WHERE p.GENERO = g.CODIGOGENERO 
	ORDER BY g.NOMBREGENERO , p.FECHAPUBLICACION ;
	



#  29 -Muestre cuantas películas existen de cada género y fecha de  publicación. (Mostrar como título de columna TOTAL PELICULAS)
	

	
	SELECT g.NOMBREGENERO , p.FECHAPUBLICACION , COUNT(p.TITULO) AS TotalPeliculas 
	FROM Peliculas p , Generos g 
	WHERE p.GENERO = g.CODIGOGENERO   
	GROUP BY g.NOMBREGENERO , p.FECHAPUBLICACION ;

	

#  30 -Añadir a la consulta anterior, la suma del precio.  (Mostrar como título de columna TOTAL)


	
	SELECT g.NOMBREGENERO , p.FECHAPUBLICACION , COUNT(p.TITULO) AS Total , SUM(p.PRECIO)  
	FROM Peliculas p , Generos g 
	WHERE p.GENERO = g.CODIGOGENERO   
	GROUP BY g.NOMBREGENERO , p.FECHAPUBLICACION ;



#  31 -Muestre el sumatorio de los precios de las películas publicadas en el año 2017 y al lado el sumatorio de los precios con un incremento del 21% de IVA .  (Mostrar como título de columnas TOTAL  AÑO 2017 y TOTAL AÑO 2017 con IVA)



	SELECT p.FECHAPUBLICACION , SUM(p.PRECIO) AS TotalAño2017, (SUM(p.PRECIO)+(21*SUM(p.PRECIO)/100)) AS TotalAño2017ConIVA
	FROM Peliculas p 
	WHERE YEAR (p.FECHAPUBLICACION)= 2017
	GROUP BY p.FECHAPUBLICACION ;



#  32 -Muestre por cada fecha de publicación, el promedio de los precios de las películas.  (Mostrar como título de columna  PROMEDIO)


	SELECT p.FECHAPUBLICACION , AVG(p.PRECIO)  AS Promedio
	FROM Peliculas p 
	GROUP BY p.FECHAPUBLICACION;
	


#  33 -Muestre de cada tipo de película la primera y la última fecha de publicación.


	SELECT t.MODALIDAD , MIN(p.FECHAPUBLICACION) AS MasVieja, MAX(p.FECHAPUBLICACION) AS MasNueva
	FROM Peliculas p , Tipopeliculas t 
	WHERE p.TIPOPELICULA = t.CODIGOENTREGA 
	GROUP BY t.MODALIDAD  ;


#  34 -Muestre por cada género, el precio más barato, el precio más caro y el promedio de precios de las películas. le he añadido la cantidad

	


	SELECT g.NOMBREGENERO , COUNT(p.TITULO) AS Cantidad , MIN(p.PRECIO) AS Barato, MAX(p.PRECIO) AS Caro , AVG(p.PRECIO)  AS Media 
	FROM Peliculas p , Generos g 
	WHERE p.GENERO = g.CODIGOGENERO 
	GROUP BY g.NOMBREGENERO ;





