/*2. Muestra los nombres de todas las películas con una clasificación por
edades de ‘R’.*/

select "title"
from film 
where "rating" = 'R';


/*3. Encuentra los nombres de los actores que tengan un “actor_id” entre 30
y 40.*/

select concat("first_name", ' ', "last_name" ) as Nombre_completo
from actor 
where actor_id between 30 and 40 ;



/*4. Obtén las películas cuyo idioma coincide con el idioma original.*/

select "title"
from film 
where "language_id" = "original_language_id" ;



/*5. Ordena las películas por duración de forma ascendente.*/

select "title" , "length"
from film 
order by "length" ;



/*6. Encuentra el nombre y apellido de los actores que tengan ‘Allen’ en su
apellido.*/


select "first_name",  "last_name"
from actor 
where "last_name" like '%ALLEN%' ;


/*7. Encuentra la cantidad total de películas en cada clasificación de la tabla
“film” y muestra la clasificación junto con el recuento.*/

select "rating" , count(*)
from film 
group by rating ;



/*8. Encuentra el título de todas las películas que son ‘PG-13’ o tienen una
duración mayor a 3 horas en la tabla film*/

select "title" , "rating" , "length"
from film  
where "rating" = 'PG-13'
or "length" > 180 ;


/*9. Encuentra la variabilidad de lo que costaría reemplazar las películas.*/

select variance("replacement_cost")
from film  ;


/*10. Encuentra la mayor y menor duración de una película de nuestra BBDD.*/

select MAX("length") , MIN("length")
from film ;




/*11. Encuentra lo que costó el antepenúltimo alquiler ordenado por día*/

select *
from rental
inner join payment as pagos
on rental.rental_id = pagos.rental_id 
order by rental.rental_date desc
offset 2
limit 1 ;

/*12. Encuentra el título de las películas en la tabla “film” que no sean ni ‘NC17’ ni ‘G’ en cuanto a su clasificación*/


select "title" , "rating"
from film 
where "rating" not in ('NC-17' , 'G') ;




/*13. Encuentra el promedio de duración de las películas para cada
clasificación de la tabla film y muestra la clasificación junto con el
promedio de duración*/

select "rating" , AVG("length")
from film 
group by "rating" ;




/*14. Encuentra el título de todas las películas que tengan una duración mayor
a 180 minutos.*/


select "title" , "length"
from film 
where "length" > 180 ;


/*15. ¿Cuánto dinero ha generado en total la empresa?*/


select SUM("amount")
from payment  ;


/*16. Muestra los 10 clientes con mayor valor de id.*/

select "customer_id"
from payment 
group by "customer_id" 
order by "customer_id" desc
limit 10 ;


/*17. Encuentra el nombre y apellido de los actores que aparecen en la
película con título ‘Egg Igby’.*/


select Tabla_actores.first_name , Tabla_actores.last_name 
from film 
inner join film_actor as Tabla_peliactores
on film.film_id = Tabla_peliactores.film_id 
inner join actor as Tabla_actores
on Tabla_peliactores.actor_id  = Tabla_actores.actor_id 
where "title" = 'EGG IGBY' ;



/*18. Selecciona todos los nombres de las películas únicos.*/

select distinct "title"
from film ;



/*19. Encuentra el título de las películas que son comedias y tienen una
duración mayor a 180 minutos en la tabla “film”.*/


select film."title" , film."length" , categoria."name" 
from film 
inner join film_category as tabla_categoria
on film.film_id = tabla_categoria.film_id 
inner join category as categoria
on tabla_categoria.category_id = categoria.category_id 
where categoria."name" = 'Comedy'
and film.length > 180 ;



/*20. Encuentra las categorías de películas que tienen un promedio de
duración superior a 110 minutos y muestra el nombre de la categoría
junto con el promedio de duración.*/

select categoria."name" , AVG(film."length" )
from film 
inner join film_category as tabla_categoria
on film.film_id = tabla_categoria.film_id 
inner join category as categoria
on tabla_categoria.category_id = categoria.category_id 
group by categoria."name" 
having AVG(film."length" ) > 110 ;




/*21. ¿Cuál es la media de duración del alquiler de las películas?*/

select AVG(rental_duration )
from film ;



/*22. Crea una columna con el nombre y apellidos de todos los actores y
actrices.*/


select concat("first_name" , ' ' , "last_name") as Nombre_completo
from actor ;




/*23. Números de alquiler por día, ordenados por cantidad de alquiler de
forma descendente.*/


select "rental_date" , count(*) as total
from rental 
group by "rental_date"
order by total desc ;


/*24. Encuentra las películas con una duración superior al promedio.*/

select "title" , "length"
from film 
where "length" > (
	select avg("length") 
	from film ) ;


/*25. Averigua el número de alquileres registrados por mes.*/


select date_trunc('month', "rental_date") as mes, count(*) as total_alquileres
from rental r 
group by mes 
order by mes ;




/*26. Encuentra el promedio, la desviación estándar y varianza del total
pagado.*/

select round(avg("amount"), 2) as Promedio , round(stddev("amount"), 2) as Desviacion_estandar , round(variance("amount") , 2)
as varianza
from payment ;


/*27. ¿Qué películas se alquilan por encima del precio medio?*/

select "title" , "rental_rate"
from film 
where "rental_rate" > (
	select avg("rental_rate") 
	from film ) ;




/*28. Muestra el id de los actores que hayan participado en más de 40
películas.*/

select "actor_id", count("film_id") as Numero_peliculas
from film_actor  
group by actor_id  
having count("film_id") > 40 ;



/*29. Obtener todas las películas y, si están disponibles en el inventario,
mostrar la cantidad disponible.*/


select "title" as Titulo_pelicula , count(inventario.inventory_id) as Total_disponibles
from film as peliculas
left join inventory as inventario
on peliculas.film_id = inventario.film_id 
group by peliculas.title 
order by count(inventario.inventory_id) desc ;



/*30. Obtener los actores y el número de películas en las que ha actuado*/


select concat(actores.first_name , ' ' , actores.last_name  ) as nombre_actor , count(peliculas.film_id ) as peliculas_actuadas
from film as peliculas
inner join film_actor as codigo_actores
on peliculas.film_id = codigo_actores.film_id 
inner join actor as actores
on codigo_actores.actor_id = actores.actor_id 
group by nombre_actor ;



/*31. Obtener todas las películas y mostrar los actores que han actuado en
ellas, incluso si algunas películas no tienen actores asociados.*/

select peliculas.title , concat(actores.first_name , ' ' , actores.last_name  ) as nombre_actor
from film as peliculas
full join film_actor as codigo_actores
on peliculas.film_id = codigo_actores.film_id 
full join actor as actores
on codigo_actores.actor_id = actores.actor_id 
order by peliculas.title ;


/*32. Obtener todos los actores y mostrar las películas en las que han
actuado, incluso si algunos actores no han actuado en ninguna película*/


select concat(actores.first_name , ' ' , actores.last_name  ) as nombre_actor , peliculas.title as titulo_peliculas
from film as peliculas
full join film_actor as codigo_actores
on peliculas.film_id = codigo_actores.film_id 
full join actor as actores
on codigo_actores.actor_id = actores.actor_id ;



/*33. Obtener todas las películas que tenemos y todos los registros de
alquiler*/

select peliculas.title , alquiler.rental_id , alquiler.rental_date , alquiler.return_date 
from film as peliculas
left join inventory as inventario
on peliculas.film_id = inventario.film_id
left join rental as alquiler
on inventario.inventory_id = alquiler.inventory_id
order by peliculas.title ;



/*34. Encuentra los 5 clientes que más dinero se hayan gastado con nosotros*/

select customer_id as cliente , sum(amount) as dinero_gastado
from payment
group by cliente
order by dinero_gastado desc
limit 5 ;


/*35. Selecciona todos los actores cuyo primer nombre es 'Johnny'*/

select *
from actor
where first_name = 'JOHNNY' ;


/*36. Renombra la columna “first_name” como Nombre y “last_name” como
Apellido.*/


select first_name as Nombre , last_name as Apellido
from actor ;


/*37. Encuentra el ID del actor más bajo y más alto en la tabla actor*/

select Min(actor_id ) as mas_bajo , max(actor_id) as mas_alto
from actor ;



/*38. Cuenta cuántos actores hay en la tabla “actor”.*/


select count(*) as Total_actores
from actor ;




/*39. Selecciona todos los actores y ordénalos por apellido en orden
ascendente.*/

select first_name , last_name 
from actor
order by last_name ;



/*40. Selecciona las primeras 5 películas de la tabla “film”.*/

select *
from film
limit 5 ;


/*41. Agrupa los actores por su nombre y cuenta cuántos actores tienen el
mismo nombre. ¿Cuál es el nombre más repetido?*/

select first_name , count(first_name)
from actor
group by first_name 
order by count(first_name) desc ;




/*42. Encuentra todos los alquileres y los nombres de los clientes que los
realizaron.*/

select alquiler.rental_id , clientes. first_name , clientes.last_name , alquiler.rental_date , alquiler.return_date 
from rental as alquiler
left join customer as clientes
on alquiler.customer_id = clientes.customer_id ;



/*43. Muestra todos los clientes y sus alquileres si existen, incluyendo
aquellos que no tienen alquileres.*/

select clientes. first_name , clientes.last_name, alquileres.rental_id  , alquileres.rental_date , alquileres.return_date 
from customer as clientes
left join rental as alquileres
on clientes.customer_id = alquileres.customer_id ;


/*44. Realiza un CROSS JOIN entre las tablas film y category. ¿Aporta valor
esta consulta? ¿Por qué? Deja después de la consulta la contestación.*/



select *
from film as peliculas
cross join category as categorias 

/*Para mi no refleja valor porque este tipo de consulta es mejor para otro tipo de objetivos
ya que en esta consulta el saber todas las posibilidades no sirve de nada, es más, es erróneo porque
cada pelicula solo puede tener una categoría*/




/*45. Encuentra los actores que han participado en películas de la categoría
'Action'.*/


select concat(actores.first_name , ' ' , actores.last_name) as nombre_completo , peliculas.title , categorias.name 
from category as categorias
inner join film_category as fc
on categorias.category_id = fc.category_id 
inner join film as peliculas
on fc.film_id = peliculas.film_id 
inner join film_actor as fa
on peliculas.film_id = fa.film_id 
inner join actor as actores
on fa.actor_id = actores.actor_id 
where categorias.name = 'Action' ;



/*46. Encuentra todos los actores que no han participado en películas*/

select concat(actores.first_name , ' ' , actores.last_name) as nombre_completo 
from actor as actores
left join film_actor as fa
on actores.actor_id  = fa.actor_id  
where fa.film_id is null ;


/*47. Selecciona el nombre de los actores y la cantidad de películas en las
que han participado.*/

select concat(actores.first_name , ' ' , actores.last_name) as nombre_completo , count(peliculas.title) as numero_peliculas
from actor as actores
inner join film_actor as fa
on actores.actor_id  = fa.actor_id
inner join film as peliculas
on peliculas.film_id = fa.film_id 
group by nombre_completo 
order by numero_peliculas ;



/*48. Crea una vista llamada “actor_num_peliculas” que muestre los nombres
de los actores y el número de películas en las que han participado.*/

create view actor_num_peliculas as
select concat(actores.first_name , ' ' , actores.last_name) as nombre_completo , count(peliculas.title) as numero_peliculas
from actor as actores
inner join film_actor as fa
on actores.actor_id  = fa.actor_id
inner join film as peliculas
on peliculas.film_id = fa.film_id 
group by nombre_completo 
order by numero_peliculas ;



/*49. Calcula el número total de alquileres realizados por cada cliente*/


select customer_id as cliente , count(rental_id)
from rental 
group by cliente ;



/*50. Calcula la duración total de las películas en la categoría 'Action'*/


select sum(peliculas.length) as duracion_total
from category as categorias
inner join film_category as fc
on categorias.category_id = fc.category_id 
inner join film as peliculas
on fc.film_id = peliculas.film_id 
where categorias.name = 'Action' ;



/*51. Crea una tabla temporal llamada “cliente_rentas_temporal” para
almacenar el total de alquileres por cliente.*/

create temporary table clientes_rentas_temporal as (
select customer_id as cliente , count(rental_id) total_alquileres
from rental 
group by customer_id 
order by cliente ) ;


/*52. Crea una tabla temporal llamada “peliculas_alquiladas” que almacene las
películas que han sido alquiladas al menos 10 veces.*/

create temporary table peliculas_alquiladas as (
select peliculas.title as titulo_pelicula , count(alquileres.inventory_id) as veces_alquilada
from film as peliculas
inner join inventory as inventario
on peliculas.film_id = inventario.film_id 
inner join rental as alquileres
on inventario.inventory_id = alquileres.inventory_id 
group by peliculas.title 
having count(alquileres.inventory_id) >= 10
order by veces_alquilada ) ;






/*53. Encuentra el título de las películas que han sido alquiladas por el cliente
con el nombre ‘Tammy Sanders’ y que aún no se han devuelto. Ordena
los resultados alfabéticamente por título de película.*/


select peliculas.title as titulo_peliculas , concat(clientes.first_name , ' ' , clientes.last_name) as nombre_cliente
from film as peliculas
inner join inventory as inventario
on peliculas.film_id = inventario.film_id 
inner join rental as alquileres
on inventario.inventory_id = alquileres.inventory_id 
inner join customer as clientes
on alquileres.customer_id = clientes.customer_id 
where alquileres.return_date is NULL
and concat(clientes.first_name , ' ' , clientes.last_name) = 'TAMMY SANDERS'
order by titulo_peliculas ;


/*54. Encuentra los nombres de los actores que han actuado en al menos una
película que pertenece a la categoría ‘Sci-Fi’. Ordena los resultados
alfabéticamente por apellido.*/


select actores.first_name , actores.last_name , peliculas.title as titulo_pelicula, 
categoria."name" as categoria_pelicula 
from actor as actores
inner join film_actor as fa
on actores.actor_id  = fa.actor_id
inner join film as peliculas
on peliculas.film_id = fa.film_id 
inner join film_category as fc
on peliculas.film_id = fc.film_id 
inner join category as categoria
on fc.category_id = categoria.category_id 
where categoria."name" = 'Sci-Fi' 
order by actores.last_name ;



/*55. Encuentra el nombre y apellido de los actores que han actuado en
películas que se alquilaron después de que la película ‘Spartacus
Cheaper’ se alquilara por primera vez. Ordena los resultados
alfabéticamente por apellido.*/



select distinct actores.first_name as nombre , actores.last_name as apellido
from actor as actores
inner join film_actor as fa
on actores.actor_id  = fa.actor_id
inner join film as peliculas
on peliculas.film_id = fa.film_id 
inner join inventory as inventario
on peliculas.film_id = inventario.film_id 
inner join rental as alquileres
on inventario.inventory_id = alquileres.inventory_id
where alquileres.rental_date > (
select MIN("rental_date")
from "rental"
inner join "inventory" as inventario2
on rental.inventory_id = inventario2.inventory_id 
inner join "film" as peliculas2
on inventario2.film_id = peliculas2.film_id
where peliculas2.title = 'SPARTACUS CHEAPER' )
order by apellido ;




/*56. Encuentra el nombre y apellido de los actores que no han actuado en
ninguna película de la categoría ‘Music’*/
	
select  a.first_name as nombre, a.last_name AS apellido
from actor a
where a.actor_id not in (
    select fa.actor_id
    from film_actor fa
    join film_category fc on fa.film_id = fc.film_id
    join category c on fc.category_id = c.category_id
    where c.name = 'Music' )
order by apellido, nombre;




/*57. Encuentra el título de todas las películas que fueron alquiladas por más
de 8 días.*/


select peliculas.title as titulo_pelicula , alquileres.rental_date as dia_compra , alquileres.return_date as dia_devolucion
from film as peliculas
inner join inventory as inventario
on peliculas.film_id = inventario.film_id 
inner join rental as alquileres
on inventario.inventory_id = alquileres.inventory_id
where extract(day from (alquileres.return_date - alquileres.rental_date)) > 8 ;





/*58. Encuentra el título de todas las películas que son de la misma categoría
que ‘Animation’*/


select peliculas.title as titulo_pelicula , categorias.name as categoria
from category as categorias
inner join film_category as fc
on categorias.category_id = fc.category_id 
inner join film as peliculas
on fc.film_id = peliculas.film_id 
where categorias.name = 'Animation' ;





/*59. Encuentra los nombres de las películas que tienen la misma duración
que la película con el título ‘Dancing Fever’. Ordena los resultados
alfabéticamente por título de película.*/


select title as titulo_pelicula , length as duracion
from film 
where length = (
	select length 
	from film
	where title = 'DANCING FEVER' )
order by titulo_pelicula ;



/*60. Encuentra los nombres de los clientes que han alquilado al menos 7
películas distintas. Ordena los resultados alfabéticamente por apellido.*/


select cliente.first_name , cliente.last_name , count(distinct peliculas.film_id) as peliculas_distintas
from film as peliculas
inner join inventory as inventario
on peliculas.film_id = inventario.film_id 
inner join rental as alquileres
on inventario.inventory_id = alquileres.inventory_id
inner join customer as cliente
on alquileres.customer_id = cliente.customer_id
group by cliente.first_name , cliente.last_name 
having count(distinct peliculas.film_id) >= 7
order by cliente.last_name ;



/*61. Encuentra la cantidad total de películas alquiladas por categoría y
muestra el nombre de la categoría junto con el recuento de alquileres*/

select categorias."name" as categoria , count(alquileres.rental_id ) as total_alquileres
from category as categorias
inner join film_category as fc
on categorias.category_id = fc.category_id 
inner join film as peliculas
on fc.film_id = peliculas.film_id 
inner join inventory as inventario
on peliculas.film_id = inventario.film_id 
inner join rental as alquileres
on inventario.inventory_id = alquileres.inventory_id
group by categoria ;




/*62. Encuentra el número de películas por categoría estrenadas en 2006.*/


select categorias.name as categoria , count(peliculas.film_id ) as total_estrenadas , peliculas.release_year as estreno
from category as categorias
inner join film_category as fc
on categorias.category_id = fc.category_id 
inner join film as peliculas
on fc.film_id = peliculas.film_id
group by categoria , peliculas.release_year 
having peliculas.release_year = 2006 ;



/*63. Obtén todas las combinaciones posibles de trabajadores con las tiendas
que tenemos.*/


select *
from store as tienda
cross join staff as trabajadores ;




/*64. Encuentra la cantidad total de películas alquiladas por cada cliente y
muestra el ID del cliente, su nombre y apellido junto con la cantidad de
películas alquiladas.*/


select customer.customer_id , customer.first_name as nombre , customer.last_name as apellido , count(alquileres.rental_id)
as peliculas_alquiladas
from customer
inner join rental as alquileres
on customer.customer_id = alquileres.customer_id
group by customer.customer_id , customer.first_name , customer.last_name ;

