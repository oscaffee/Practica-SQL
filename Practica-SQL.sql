--2.Muestra los nombres de todas las películas con una clasificación por edades de ‘Rʼ
SELECT 
	title,
	rating 
FROM film f 
WHERE rating = 'R';




--3.Encuentra los nombres de los actores que tengan un “actor_idˮ entre 30 y 40.
SELECT
	actor_id ,
	concat(first_name,' ',last_name) AS "Nombre_actor"
FROM actor a 
WHERE actor_id BETWEEN 30 AND 40;





--4.Obtén las películas cuyo idioma coincide con el idioma original.
SELECT
	title 
FROM film f
WHERE language_id = original_language_id;





--5.Ordena las películas por duración de forma ascendente.
SELECT
	title,
	length 
FROM film f 
ORDER BY length ASC; 





--6. Encuentra el nombre y apellido de los actores que tengan ‘Allenʼ en su apellido.
SELECT 
	concat(first_name, ' ', last_name) AS "Nombre_actor"
FROM actor a 
WHERE last_name LIKE '%ALLEN%';





--7.Encuentra la cantidad total de películas en cada clasificación de la tabla “filmˮ y muestra la clasificación junto con el recuento.
SELECT
	f.rating,
	count(f.title) AS total_peliculas 
FROM film f 
GROUP BY f.rating ; 





--8.Encuentra el título de todas las películas que son ‘PG-13ʼ o tienen una duración mayor a 3 horas en la tabla film.
SELECT 
	title,
	rating,
	length
FROM film f 
WHERE rating = 'PG-13' OR length > 180;




--9. Encuentra la variabilidad de lo que costaría reemplazar las películas.
SELECT 
	stddev(replacement_cost) AS "Desv_est",
	variance(replacement_cost) AS "Var", 
	max(replacement_cost) - min(replacement_cost) AS "Rango" 
FROM film f; 






--10. Encuentra la mayor y menor duración de una película de nuestra BBDD.
SELECT
	max(length) AS "Max_length",
	min(length) AS "Min_Length"
FROM film f;





--11. Encuentra lo que costó el antepenúltimo alquiler ordenado por día.
SELECT
	amount,
	payment_date 
FROM payment p 
ORDER BY payment_date DESC 
OFFSET 2
LIMIT 1;





--12.Encuentra el título de las películas en la tabla “filmˮ que no sean ni ‘NC-17ʼ ni ‘Gʼ en cuanto a su clasificación.
SELECT
	title,
	rating 
FROM film f
WHERE rating NOT IN ('NC-17', 'G');




--13. Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la clasificación junto con el promedio de duración.
SELECT 
	f.rating AS "Clasificación",
	avg(f.length) AS "Prom_Length" 
FROM film f
GROUP BY f.rating;




--14.Encuentra el título de todas las películas que tengan una duración mayor a 180 minutos.
SELECT
	title,
	length AS "Duracion_Pelicula" 
FROM film f 
WHERE length > 180
ORDER BY length DESC; 






--15. ¿Cuánto dinero ha generado en total la empresa?
SELECT
	sum(amount) AS "Total_Ingresos" 
FROM payment p; 






--16.Muestra los 10 clientes con mayor valor de id.
SELECT
	customer_id
FROM customer c
ORDER BY customer_id DESC
LIMIT 10;





--17.Encuentra el nombre y apellido de los actores que aparecen en la película con título ‘Egg Igbyʼ.
SELECT
	f."title" AS "Titulo_pelicula",
	concat(first_name, ' ',last_name) AS "Nombre_Actor" 
FROM actor a 
INNER JOIN film_actor fa
	ON a.actor_id = fa.actor_id 
INNER JOIN film f 
	ON fa.film_id = f.film_id 
WHERE f.title = 'EGG IGBY';





--18.Selecciona todos los nombres de las películas únicos.
SELECT
	DISTINCT title AS "Titulo_pelicula"
FROM film f;





--19.Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla “filmˮ.
SELECT
	f.title,
	c."name" AS "Categoria_pelicula",
	f."length" AS "Duracion_pelicula"
FROM film f 
INNER JOIN film_category fc
	ON f.film_id = fc.film_id 
INNER JOIN category c 
	ON fc.category_id = c.category_id
WHERE C."name" = 'Comedy' AND f."length" > 180; 	





--20.Encuentra las categorías de películas que tienen un promedio de duración superior a 110 minutos y muestra el nombre de la categoría junto con el promedio de duración.
SELECT
	c."name" AS "Categoria_pelicula",
	avg(f.length) AS "Prom_duracion" 
FROM film f 
INNER JOIN film_category fc 
	ON f.film_id = fc.film_id 
INNER JOIN category c 
	ON fc.category_id = c.category_id
GROUP BY c."name" 
HAVING avg(f.length) > 110;





--21.¿Cuál es la media de duración del alquiler de las películas?
SELECT 
	avg(rental_duration) AS "Rental_duration" 
FROM film f;





--22.Crea una columna con el nombre y apellidos de todos los actores y actrices.
SELECT
	concat(first_name, ' ', last_name) AS "Nombre_actor/actriz" 
FROM actor a;





--23.Números de alquiler por día, ordenados por cantidad de alquiler de forma descendente.
SELECT
	rental_date AS "Fecha_alquier",
	count(rental_id) AS "Alquiler_cantidad" 
FROM rental r 
GROUP BY rental_date
ORDER BY count(rental_id) DESC;




--24.Encuentra las películas con una duración superior al promedio.
SELECT
	title AS "Titulo",
	length AS "Duracion"	 
FROM film f  
WHERE length > (
	SELECT 
		avg(length)
	FROM film
	)
ORDER BY length DESC;
	




--25.Averigua el número de alquileres registrados por mes.
SELECT
	EXTRACT(YEAR FROM rental_date) AS "Año",
	EXTRACT(MONTH FROM rental_date) AS "Mes",
	count(rental_id) AS "Cantidad_Alquileres"
FROM rental r 
GROUP BY 
	EXTRACT(YEAR FROM rental_date),
	EXTRACT(MONTH FROM rental_date);





--26.Encuentra el promedio, la desviación estándar y varianza del total pagado.
SELECT 
	avg(amount) AS "Promedio",
	stddev(amount) AS "Desv_est",
	variance(amount) AS " Varianza" 
FROM payment p;






--27.¿Qué películas se alquilan por encima del precio medio?
SELECT 
	f.title AS "Titulo",
	p.amount AS "Precio_alquiler"
FROM payment p
INNER JOIN rental r 
	ON p.rental_id = r.rental_id 
INNER JOIN inventory i 
	ON i.inventory_id = r.inventory_id 
INNER JOIN film f 
	ON f.film_id = i.film_id 
WHERE amount > (
	SELECT 
		avg(amount) 
	FROM payment p 
)
ORDER BY p.amount DESC;






--28.Muestra el id de los actores que hayan participado en más de 40 películas.
SELECT
	actor_id,
	count(film_id) AS "Nº_peliculas" 
FROM film_actor fa  
GROUP BY actor_id 
HAVING count(film_id) > 40; 





--29.Obtener todas las películas y, si están disponibles en el inventario, mostrar la cantidad disponible.
SELECT
	f.film_id, 
	count(i.film_id) AS "Stock_restante" 
FROM film f 
LEFT JOIN inventory i 
	ON f.film_id = i.film_id
GROUP BY f.film_id;





--30.Obtener los actores y el número de películas en las que ha actuado.
SELECT 
	actor_id,
	count(film_id) AS "Nº_peliculas" 
FROM film_actor fa
GROUP BY actor_id;





--31.Obtener todas las películas y mostrar los actores que han actuado en ellas, incluso si algunas películas no tienen actores asociados.
SELECT 
	f.film_id,
	count(fa.actor_id) AS "Nº Actores" 
FROM film f 
LEFT JOIN film_actor fa 
	ON f.film_id = fa.film_id 
GROUP BY f.film_id;






--32.Obtener todos los actores y mostrar las películas en las que han actuado, incluso si algunos actores no han actuado en ninguna película.
SELECT
	a.actor_id,
	count(fa.film_id) AS "Nº_peliculas" 
FROM actor a 
LEFT JOIN film_actor fa 
	ON a.actor_id = fa.actor_id 
GROUP BY a.actor_id;





--33.Obtener todas las películas que tenemos y todos los registros de alquiler.
SELECT
	f.film_id,
	count(r.rental_id) AS "Reg_alquiler" 
FROM film f
LEFT JOIN inventory i 
	ON f.film_id = i.film_id
LEFT JOIN rental r
	ON i.inventory_id = r.inventory_id 
GROUP BY f.film_id;





--34.Encuentra los 5 clientes que más dinero se hayan gastado con nosotros.
SELECT
	concat(c.first_name, ' ',c.last_name) AS "Cliente",
	sum(p.amount) AS "Dinero_gastado"
FROM customer c
INNER JOIN payment p 
	ON c.customer_id = p.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY "Dinero_gastado" DESC
LIMIT 5;
	



--35.Selecciona todos los actores cuyo primer nombre es 'Johnny'.
SELECT
	first_name,
	last_name
FROM actor a
WHERE upper(first_name) LIKE 'JOHNNY';





--36.Renombra la columna “first_nameˮ como Nombre y “last_nameˮ como Apellido.
SELECT
	first_name AS "Nombre",
	last_name AS "Apellido"
FROM actor a
WHERE upper(first_name) LIKE 'JOHNNY';





--37. Encuentra el ID del actor más bajo y más alto en la tabla actor.
SELECT 
	min(actor_id) AS "Minimo",
	max(actor_id) AS "Maximo" 
FROM actor a; 






--38.Cuenta cuántos actores hay en la tabla “actorˮ.
SELECT
	count(actor_id) AS "Nº_actores" 
FROM actor a;





--39.Selecciona todos los actores y ordénalos por apellido en orden ascendente.
SELECT 
	first_name AS "Nombre_actor",
	last_name AS "Apellido_actor"
FROM actor a 
ORDER BY last_name ASC;





--40.Selecciona las primeras 5 películas de la tabla “filmˮ.
SELECT 
	title
FROM film f
LIMIT 5;




--41.Agrupa los actores por su nombre y cuenta cuántos actores tienen el mismo nombre. ¿Cuál es el nombre más repetido?
SELECT
	first_name AS "Actor",
	count(*) AS "Repeticiones"
FROM actor a 
GROUP BY first_name 
ORDER BY "Repeticiones" DESC
LIMIT 1;




--42.Encuentra todos los alquileres y los nombres de los clientes que los realizaron.
SELECT
	r.rental_id,
	c.first_name AS "Cliente"
FROM rental r 
INNER JOIN customer c 
	ON r.customer_id = c.customer_id;






--43.Muestra todos los clientes y sus alquileres si existen, incluyendo aquellos que no tienen alquileres.
SELECT
	first_name AS "Cliente",
	r.rental_id
FROM customer c 
LEFT JOIN rental r 
	ON c.customer_id = r.customer_id; 

	
	
	

--44.Realiza un CROSS JOIN entre las tablas film y category. ¿Aporta valor esta consulta? ¿Por qué? Deja después de la consulta la contestación.
	SELECT*
	FROM film f 
	CROSS JOIN film_category fc
	CROSS JOIN category c;
	--No aporta valor, realizar aqui un Cross Join hará la unión de las 3 tablas mostrando las combinaciones existentes entre las 3 y por ello no obteniendo ninguna conclusion util y logica de ello.
	
	
	
	
	
	
--45. Encuentra los actores que han participado en películas de la categoría 'Action'.
	SELECT
		a.first_name,
		c."name"
	FROM actor a 
	INNER JOIN film_actor fa 
		ON a.actor_id = fa.actor_id 
	INNER JOIN film f 
		ON f.film_id = fa.film_id
	INNER JOIN film_category fc 
		ON f.film_id = fc.film_id 
	INNER JOIN category c 
		ON fc.category_id = c.category_id
	WHERE c."name" = 'Action';

	


	
--46.Encuentra todos los actores que no han participado en películas.
SELECT
	a2.first_name,
	a2.last_name
FROM actor a2 
LEFT JOIN film_actor fa 
	 ON a2.actor_id = fa.actor_id
WHERE fa.actor_id IS NULL;




--47. Selecciona el nombre de los actores y la cantidad de películas en las que han participado.
SELECT 
	a.first_name,
	a.last_name,
	count(fa.film_id) AS "Nº_peliculas_realizadas" 
FROM actor a
INNER JOIN film_actor fa 
	ON a.actor_id = fa.actor_id 
GROUP BY a.first_name, a.last_name;





--48.Crea una vista llamada “actor_num_peliculasˮ que muestre los nombres de los actores y el número de películas en las que han participado.
CREATE VIEW actor_num_peliculas AS
SELECT
	a.first_name,
	a.last_name,
	count(fa.film_id) AS "Nº_peliculas_realizadas" 
FROM actor a
INNER JOIN film_actor fa
	ON a.actor_id = fa.actor_id
GROUP BY a.first_name, a.last_name;





--49.Calcula el número total de alquileres realizados por cada cliente.
SELECT
	c.customer_id,
	c.first_name,
	c.last_name, 
	count(r.rental_id) AS "Nº_alquileres" 
FROM customer c
LEFT JOIN rental r
	ON c.customer_id = r.customer_id 
GROUP BY c.customer_id;





--50.Calcula la duración total de las películas en la categoría 'Action'.
SELECT
	c."name",
	sum(f.length) AS "Duracion" 
FROM film f
INNER JOIN film_category fc 
	ON f.film_id = fc.film_id 
INNER JOIN category c
	ON fc.category_id = c.category_id
WHERE c."name" = 'Action'
GROUP BY c."name";





--51.Crea una tabla temporal llamada “cliente_rentas_temporalˮ para almacenar el total de alquileres por cliente.
CREATE TEMPORARY TABLE cliente_rentas_temporal (
	customer_id INT,
	first_name VARCHAR(255),
	last_name VARCHAR(255),
	"Nº_alquileres" INT
);
INSERT INTO cliente_rentas_temporal (customer_id, first_name, last_name, "Nº_alquileres")
SELECT
	c.customer_id,
	c.first_name,
	c.last_name,
	count(r.rental_id) AS "Nº_alquileres" 
FROM customer c
LEFT JOIN rental r
	ON c.customer_id = r.customer_id 
GROUP BY c.customer_id;





--52.Crea una tabla temporal llamada “peliculas_alquiladasˮ que almacene las películas que han sido alquiladas al menos 10 veces.
CREATE TEMPORARY TABLE peliculas_alquiladas(
	film_id INT,
	title VARCHAR(255),
	"Nº_veces_alquiler" INT
);
INSERT INTO peliculas_alquiladas (film_id, title, "Nº_veces_alquiler")
SELECT 
	f.film_id,
	f.title AS "Titulo_pelicula",
	count(r.rental_id) AS "Nº_veces_alquiler" 
FROM film f
INNER JOIN inventory i
	ON f.film_id = i.film_id
INNER JOIN rental r 
	ON i.inventory_id = r.inventory_id
GROUP BY f.film_id, f.title
HAVING count(r.rental_id) >= 10
ORDER BY "Nº_veces_alquiler" DESC;



--53.Encuentra el título de las películas que han sido alquiladas por el cliente con el nombre ‘Tammy Sandersʼ y que aún no se han devuelto. Ordena los resultados alfabéticamente por título de película.
SELECT
	f.title
FROM film f 
INNER JOIN inventory i 
	ON f.film_id = i.film_id
INNER JOIN rental r 
	ON r.inventory_id = i.inventory_id 
INNER JOIN customer c
	ON c.customer_id = r.customer_id
WHERE c.first_name = 'TAMMY' 
AND c.last_name = 'SANDERS' 
AND r.return_date IS NULL 
ORDER BY f.title;



--54. Encuentra los nombres de los actores que han actuado en al menos una película que pertenece a la categoría ‘Sci-Fiʼ. Ordena los resultados alfabéticamente por apellido.
SELECT DISTINCT 
	a.first_name,
	a.last_name
FROM category c 
INNER JOIN film_category fc 
	ON c.category_id = fc.category_id 
INNER JOIN film f 
	ON fc.film_id = f.film_id 
INNER JOIN film_actor fa 
	ON fa.film_id = f.film_id 
INNER JOIN actor a
	ON a.actor_id = fa.actor_id
WHERE c.name = 'Sci-Fi'
ORDER BY a.last_name;




--55. Encuentra el nombre y apellido de los actores que han actuado en películas que se alquilaron después de que la película ‘Spartacus Cheaperʼ se alquilara por primera vez. Ordena los resultados alfabéticamente por apellido.
SELECT
	a.first_name,
	a.last_name 
FROM actor a 
INNER JOIN film_actor fa
	ON a.actor_id = fa.actor_id 
INNER JOIN film f
	ON f.film_id = fa.film_id
INNER JOIN inventory i
	ON i.film_id = f.film_id
INNER JOIN rental r
	ON r.inventory_id = i.inventory_id
WHERE r.rental_date > (
	SELECT min(r.rental_date)
	FROM rental r
	INNER JOIN inventory i
		ON r.inventory_id = i.inventory_id
	INNER JOIN film f
		ON i.film_id = f.film_id
	WHERE f.title = 'SPARTACUS CHEAPER'
)
ORDER BY a.last_name;
	



--56. Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría ‘Musicʼ.
SELECT DISTINCT
	a2.first_name,
	a2.last_name
FROM actor a2 
WHERE a2.actor_id NOT IN(
	SELECT DISTINCT fa.actor_id
	FROM film_actor fa
	INNER JOIN film_category fc
		ON fc.film_id = fa.film_id
	INNER JOIN category c
		ON c.category_id = fc.category_id
	WHERE c.name LIKE 'MUSIC'
);




--57. Encuentra el título de todas las películas que fueron alquiladas por más de 8 días.
SELECT
	f.title
FROM film f
INNER JOIN inventory i
	ON f.film_id = i.film_id
INNER JOIN rental r
	ON r.inventory_id  = i.inventory_id
WHERE r.return_date IS NOT NULL 
AND EXTRACT(DAY FROM r.return_date - r.rental_date) > 8;




--58.Encuentra el título de todas las películas que son de la misma categoría que ‘Animationʼ.
SELECT
	f.title
FROM film f
INNER JOIN film_category fc 
	ON fc.film_id = f.film_id
INNER JOIN category c
	ON c.category_id = fc.category_id
WHERE c.name = 'Animation';




--59. Encuentra los nombres de las películas que tienen la misma duración que la película con el título ‘Dancing Feverʼ. Ordena los resultados alfabéticamente por título de película.
SELECT
	title
FROM film f
WHERE f.length = (
	SELECT 
	f2.length 
	FROM film f2
	WHERE title = 'DANCING FEVER'
)
ORDER BY f.title;




--60.Encuentra los nombres de los clientes que han alquilado al menos 7 películas distintas. Ordena los resultados alfabéticamente por apellido.
SELECT
	c.first_name, 
	c.last_name 
FROM customer c
INNER JOIN rental r
	ON r.customer_id = c.customer_id
INNER JOIN inventory i
	ON i.inventory_id = r.inventory_id 
GROUP BY c.customer_id
HAVING count(DISTINCT i.film_id) >= 7
ORDER BY c.last_name;




--61.Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres.
SELECT
	c."name",
	count(*) AS "Nº_alquileres" 
FROM category c
INNER JOIN film_category fc
	ON c.category_id = fc.category_id
INNER JOIN film f
	ON fc.film_id = f.film_id
INNER JOIN inventory i 
	ON f.film_id = i.film_id
INNER JOIN rental r
	ON i.inventory_id = r.inventory_id
GROUP BY c."name";

	
	
	

--62.Encuentra el número de películas por categoría estrenadas en 2006.
SELECT
	c.name,
	count(f.film_id) AS "Nº_peliculas" 
FROM film f
INNER JOIN film_category fc
	ON f.film_id = fc.film_id 
INNER JOIN category c
	ON c.category_id = fc.category_id 
WHERE f.release_year = 2006
GROUP BY c.name;



--63.Obtén todas las combinaciones posibles de trabajadores con las tiendas que tenemos.
SELECT *
FROM staff s 
CROSS JOIN store s2;




--64.Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y apellido junto con la cantidad de películas alquiladas.
SELECT
	c.customer_id,
	c.first_name,
	c.last_name,
	count(r.rental_id) AS "Cantidad_alquileres"
FROM customer c
INNER JOIN rental r
	ON c.customer_id = r.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name;



