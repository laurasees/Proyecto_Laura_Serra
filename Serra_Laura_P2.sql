
-- PROYECTO 2
-- Laura Serra Escorne


-- 01. Esquema de la BBDD


-- 02. Muestra los nombres de todas las películas con una clasificación por edades de ‘R’
SELECT title, release_year 
FROM film
order by release_year ;

-- 03. Encuentra los nombres de los actores que tengan un “actor_id” entre 30 y 40.
select actor_id, first_name, last_name
from actor 
where actor_id>=30 and actor_id<=40;

-- 04. Obtén las películas cuyo idioma coincide con el idioma original.
select title, f.language_id, name
from film f
inner join language l on f.language_id=l.language_id;

-- 05. Ordena las películas por duración de forma ascendente.
select title, length
from film
order by length;

-- 06. Encuentra el nombre y apellido de los actores que tengan ‘Allen’ en su apellido.
select first_name, last_name
from actor 
where last_name like '%ALLEN';

-- 07. Encuentra la cantidad total de películas en cada clasificación de la tabla “film” y muestra la clasificación junto con el recuento.
select count(title), c.name
from film f
inner join film_category fc on f.film_id = fc.film_id 
inner join category c on c.category_id = fc.category_id
group by c.category_id
order by count(title);

-- 08. Encuentra el título de todas las películas que son ‘PG-13’ o tienen una duración mayor a 3 horas en la tabla film.
select title 
from film 
where rating = 'PG-13' or length > 180;

-- 09. Encuentra la variabilidad de lo que costaría reemplazar las películas.
select stddev(replacement_cost) as desviacion_estandar, variance(replacement_cost) as varianza
from film;

-- 10. Encuentra la mayor y menor duración de una película de nuestra BBDD.
select max(length), min(length)
from film;

-- 11. Encuentra lo que costó el antepenúltimo alquiler ordenado por día.
select p.amount, r.rental_date
from payment p
inner join rental r on p.rental_id = r.rental_id
order by r.rental_date desc 
limit 1 offset 2;


-- 12. Encuentra el título de las películas en la tabla “film” que no sean ni ‘NC-17’ ni ‘G’ en cuanto a su clasificación.
select title 
from film 
where rating <>'G' and rating <> 'NC-17';

-- 13. Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la clasificación junto con el promedio de duración.
select c.name, avg(f.length)
from film f
inner join film_category fc on f.film_id = fc.film_id
inner join category c on fc.category_id = c.category_id
group by c.name;

-- 14. Encuentra el título de todas las películas que tengan una duración mayor a 180 minutos.
select title 
from film 
where length > 180;

-- 15. ¿Cuánto dinero ha generado en total la empresa?
select sum(amount)
from payment;

-- 16. Muestra los 10 clientes con mayor valor de id.
select first_name, last_name
from customer
order by customer_id desc
limit 10;

-- 17. Encuentra el nombre y apellido de los actores que aparecen en la película con título ‘Egg Igby’
select a.first_name, a.last_name
from actor a 
inner join film_actor fa on a.actor_id = fa.actor_id 
inner join film f on fa.film_id = f.film_id
where f.title ='EGG IGBY';

-- 18. Selecciona todos los nombres de las películas únicos. ?los títulos, son unicos no?
select title 
from film;

-- 19. Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla “film”
select f.title
from film f 
inner join film_category fc on f.film_id = fc.film_id  
inner join category c  on fc.category_id = c.category_id
where f.length > 180 and c.name = 'Comedy';

/*20. Encuentra las categorías de películas que tienen un promedio de duración superior a 110 minutos y muestra el nombre de la categoría
junto con el promedio de duración.*/
select c.name, avg(f.length) as average_length
from category c 
inner join film_category fc on fc.category_id = c.category_id  
inner join   film f on f.film_id = fc.film_id 
group by c.name
having avg(f.length)>110;

-- 21. ¿Cuál es la media de duración del alquiler de las películas?
select avg(rental_duration) as average_rental_duration
from film;

-- 22. Crea una columna con el nombre y apellidos de todos los actores y actrices.
select first_name || ' ' || last_name as actor_name
from actor;

-- 23. Números de alquiler por día, ordenados por cantidad de alquiler de forma descendente.
select date(rental_date) as day, count(*) as total_rent
from rental
group by date(rental_date)
order by total_rent;

-- 24. Encuentra las películas con una duración superior al promedio.
select title
from film 
where length > (
select avg(length)
from film 
);

-- 25. Averigua el número de alquileres registrados por mes.
select date_trunc('month', rental_date) as month, count(*) as rental_per_month
from rental 
group by date_trunc('month', rental_date)
order by month;

-- 26. Encuentra el promedio, la desviación estándar y varianza del total pagado.
select avg(amount) as promedio, stddev(amount) as desviacion_estandar, variance(amount) as varianza
from payment;

-- 27. ¿Qué películas se alquilan por encima del precio medio?
select title, rental_rate
from film f
where rental_rate > (
select avg(rental_rate)
from film
)
order by rental_rate desc;

-- 28. Muestra el id de los actores que hayan participado en más de 40 películas.
select a.actor_id
from actor a
inner join film_actor fa on fa.actor_id = a.actor_id
group by a.actor_id 
having count(fa.film_id)>40;

-- 29. Obtener todas las películas y, si están disponibles en el inventario, mostrar la cantidad disponible.
select title, count(i.inventory_id) AS available_quantity
from film f
left join inventory i on i.film_id = f.film_id
group by f.title;

-- 30. Obtener los actores y el número de películas en las que ha actuado.
select first_name || ' ' || last_name as actor, count(f.film_id) as film_number
from actor a
inner join film_actor fa on a.actor_id = fa.actor_id 
inner join film f on fa.film_id = f.film_id 
group by a.actor_id;

-- 31. Obtener todas las películas y mostrar los actores que han actuado en ellas, incluso si algunas películas no tienen actores asociados.
select title, string_agg(first_name || ' ' || last_name, ', ') as actors
from film f
left join film_actor fa on fa.film_id = f.film_id 
left join actor a on a.actor_id = fa.actor_id
group by f.title;

-- 32. Obtener todos los actores y mostrar las películas en las que han actuado, incluso si algunos actores no han actuado en ninguna película.
select first_name || ' ' || last_name as actor, string_agg(title, ', ') as films
from actor a
left join film_actor fa on a.actor_id = fa.actor_id 
left join film f on fa.film_id = f.film_id 
group by a.actor_id;

-- 33. Obtener todas las películas que tenemos y todos los registros de alquiler.
select f.title, r.rental_id, r.rental_date
from film f
left join inventory i on f.film_id = i.film_id
left join customer c on c.store_id = i.store_id
left join rental r on c.customer_id = r.customer_id;

-- 34. Encuentra los 5 clientes que más dinero se hayan gastado con nosotros.
select c.first_name ||' '|| c.last_name as name, sum(p.amount) as total_amount 
from customer c
inner join payment p on p.customer_id = c.customer_id 
group by c.first_name, c.last_name
order by name;

-- 35. Selecciona todos los actores cuyo primer nombre es ' Johnny'.
select first_name, last_name
from actor 
where first_name = 'JOHNNY';

-- 36. Renombra la columna “first_name” como Nombre y “last_name” como Apellido.
select  first_name as Nombre,  last_name as Apellido
from actor;

-- 37. Encuentra el ID del actor más bajo y más alto en la tabla actor.
-- 1a manera
select max(actor_id) as max_id, min(actor_id) as min_id
from actor;
-- 2a manera
select *
from actor
where actor_id = (select  MIN(actor_id) from actor)
   or actor_id = (select MAX(actor_id) from actor);

-- 38. Cuenta cuántos actores hay en la tabla “actor”
select count(actor_id) as number_of_actors
from actor;

-- 39. Selecciona todos los actores y ordénalos por apellido en orden ascendente.
select first_name, last_name
from actor
order by last_name;

-- 40. Selecciona las primeras 5 películas de la tabla “film”
select title
from film
order by title
limit 5;

-- 41. Agrupa los actores por su nombre y cuenta cuántos actores tienen el mismo nombre. ¿Cuál es el nombre más repetido?
select count(first_name) as same_name, first_name
from actor
group by first_name
order by same_name desc; -- el nombre más repetido es Kenneth

-- 42. Encuentra todos los alquileres y los nombres de los clientes que los realizaron.
select rental_id, first_name || ' ' || last_name as customer
from rental r
inner join customer c on c.customer_id = r.customer_id;

-- 43. Muestra todos los clientes y sus alquileres si existen, incluyendo aquellos que no tienen alquileres.
select first_name || ' ' || last_name as customer, rental_id
from customer c 
left join rental r on c.customer_id = r.customer_id;

-- 44. Realiza un CROSS JOIN entre las tablas film y category. ¿Aporta valor esta consulta? ¿Por qué? Deja después de la consulta la contestación.
select f.title, c.name as category
from film f
cross join category c; 
/*Hemos hecho el producto cartesiano, y el resultado nos muestra cada pelicula con cada una de las categorías, aunque no esten relacionadas.
 * Por tanto, la consulta no aporta ningún valor, ya que los datos (las relaciones) no son reales. */


-- 45. Encuentra los actores que han participado en películas de la categoría 'Action'.
select first_name || ' ' || last_name as actor
from actor a
inner join film_actor fa on a.actor_id = fa.actor_id 
inner join film_category fc  on fa.film_id = fc.film_id 
inner join category c on c.category_id = fc.category_id 
where c.name = 'Action';

-- 46. Encuentra todos los actores que no han participado en películas.
select first_name || ' ' || last_name as actor
from actor a
left join film_actor fa on fa.actor_id = a.actor_id 
where fa.actor_id is null;


-- 47. Selecciona el nombre de los actores y la cantidad de películas en las que han participado.
select first_name || ' ' || last_name as actor, count(f.film_id) as number_films
from actor a
inner join film_actor fa on fa.actor_id = a.actor_id
inner join film f on f.film_id = fa.film_id 
group by first_name, last_name;

-- 48. Crea una vista llamada “actor_num_peliculas” que muestre los nombres de los actores y el número de películas en las que han participado.
create view actor_num_peliculas as
select first_name || ' ' || last_name as actor, count(f.film_id) as number_films
from actor a
inner join film_actor fa on fa.actor_id = a.actor_id
inner join film f on f.film_id = fa.film_id 
group by first_name, last_name;

-- 49. Calcula el número total de alquileres realizados por cada cliente.
select c.first_name || ' ' || c.last_name as customer, count(rental_id) as rental_number
from customer c 
left join rental r on c.customer_id = r.customer_id
group by c.first_name, c.last_name
order by rental_number;

-- 50. Calcula la duración total de las películas en la categoría 'Action'.
select sum(length) as total_length
from film f
inner join film_category fc on fc.film_id = f.film_id 
inner join category c on c.category_id = fc.category_id 
where c."name" = 'Action';

-- 51. Crea una tabla temporal llamada “cliente_rentas_temporal” para almacenar el total de alquileres por cliente.
create temporary table cliente_rentas_temporal as
select c.customer_id, c.first_name || ' ' || c.last_name as customer, count(r.rental_id) as total_rent
from customer c
left join rental r on r.customer_id = c.customer_id
group by c.customer_id, c.first_name, c.last_name;

-- 52. Crea una tabla temporal llamada “peliculas_alquiladas” que almacene las películas que han sido alquiladas al menos 10 veces.
create temporary table peliculas_alquiladas as
select f.film_id, f.title, count(r.rental_id) as total_rent
from film f
inner join inventory i on i.film_id = f.film_id 
inner join rental r on i.inventory_id = r.inventory_id 
group by f.film_id, f.title
having count(r.rental_id)>=10;

/* 53. Encuentra el título de las películas que han sido alquiladas por el cliente con el nombre ‘Tammy Sanders’ y que aún no se han devuelto. 
Ordena los resultados alfabéticamente por título de película.*/
select f.title 
from film f
inner join inventory i on i.film_id = f.film_id 
inner join rental r on r.inventory_id = i.inventory_id 
inner join customer c on c.customer_id = r.customer_id 
where c.first_name = 'TAMMY' and c.last_name = 'SANDERS' and r.rental_date is null
order by f.title;

-- Observamos que no hay ninguna película que no haya sido devuelta


/* 54. Encuentra los nombres de los actores que han actuado en al menos una película que pertenece a la categoría ‘Sci-Fi’. Ordena los resultados
alfabéticamente por apellido.*/
select distinct  a.first_name, a.last_name 
from actor a
inner join film_actor fa on a.actor_id = fa.actor_id
inner join film_category fc on fa.film_id = fc.film_id 
inner join category c on c.category_id = fc.category_id
where c.name = 'Sci-Fi'
order by a.last_name;


/* 55. Encuentra el nombre y apellido de los actores que han actuado en películas que se alquilaron después de que la película ‘Spartacus
Cheaper’ se alquilara por primera vez. Ordena los resultados alfabéticamente por apellido.*/

-- obtenemos la rental_date mínima de a película ‘Spartacus Cheaper’
select min(r.rental_date)
from film f
inner join inventory i on i.film_id = f.film_id
inner join rental r on r.inventory_id = i.inventory_id
where f.title = 'SPARTACUS CHEAPER';

-- lo aplicamos a la resolución del ejercicio 
select distinct  a.first_name, a.last_name 
from actor a
inner join film_actor fa on a.actor_id = fa.actor_id
inner join inventory i on i.film_id = fa.film_id
inner join rental r on r.inventory_id = i.inventory_id
where r.rental_date > (
select min(r2.rental_date)
from film f2
inner join inventory i2 on i2.film_id = f2.film_id
inner join rental r2 on r.inventory_id = i2.inventory_id
where f2.title = 'SPARTACUS CHEAPER'
)
order by a.first_name, a.last_name;


-- 56. Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría ‘Music’
select distinct a.first_name, a.last_name 
from actor a
where not exists (
select 1
from film_actor fa 
inner join film_category fc on fa.film_id = fc.film_id 
inner join category c on c.category_id = fc.category_id
where fa.actor_id = a.actor_id and c.name = 'Music'
)
order by a.first_name, a.last_name;

-- 57. Encuentra el título de todas las películas que fueron alquiladas por más de 8 días.
select f.film_id, f.title
from film f
inner join inventory i on i.film_id = f.film_id 
inner join rental r on i.inventory_id = r.inventory_id 
group by f.film_id, f.title
having count(r.rental_id)>8;

-- 58. Encuentra el título de todas las películas que son de la misma categoría que ‘Animation’
select title
from film f
inner join film_category fc on fc.film_id = f.film_id 
inner join category c on c.category_id = fc.category_id 
where c."name" = 'Animation';

/*59. Encuentra los nombres de las películas que tienen la misma duración que la película con el título ‘Dancing Fever’. Ordena los resultados
alfabéticamente por título de película.*/
select title
from film f
where length = (select length from film where title ='DANCING FEVER')
order by title;

-- 60. Encuentra los nombres de los clientes que han alquilado al menos 7 películas distintas. Ordena los resultados alfabéticamente por apellido.
select c.first_name, c.last_name
from customer c
inner join rental r on c.customer_id = r.customer_id
inner join inventory i on r.inventory_id = i.inventory_id 
inner join film f on f.film_id = i.film_id 
group by c.customer_id, c.first_name, c.last_name
having count(distinct f.film_id)>=7
order by c.last_name, c.first_name;

-- 61. Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres.
select c.name as categoria , count(f.film_id) as cantidad_peliculas_alquiladas
from category c
inner join film_category fc on c.category_id = fc.category_id
inner join film f on fc.film_id = f.film_id
inner join inventory i on f.film_id = i.film_id
inner join rental r on i.inventory_id = r.inventory_id
group by c.name
order by c.name;

-- 62. Encuentra el número de películas por categoría estrenadas en 2006.
select c.name, count(f.film_id) 
from film f
inner join film_category fc on fc.film_id = f.film_id 
inner join category c on c.category_id = fc.category_id 
where f.release_year =2006
group by c.name;

-- 63. Obtén todas las combinaciones posibles de trabajadores con las tiendas que tenemos.
select first_name ||' '|| last_name as name, s2.store_id
from staff s
cross join store s2;


/*64. Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y apellido junto con la cantidad de
películas alquiladas.*/ 
select c.customer_id, c.first_name ||' '|| c.last_name as name, count(r.rental_id) as peliculas_alquiladas 
from customer c
inner join rental r on c.customer_id = r.customer_id 
group by c.customer_id, c.first_name, c.last_name
order by c.customer_id;






