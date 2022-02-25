Use sakila;
#Write a query to display for each store its store ID, city, and country.

create temporary table store_co
select s.store_id, c.city, co.country, a.address_id
from store s
join address a
using (address_id)
join city c 
using (city_id)
join country co
using (country_id);

select * from store_co;

#Write a query to display how much business, in dollars, each store brought in.
create temporary table store_bus
select s.store_id, c.customer_id, sum(p.amount) as amount
from store s
join customer c
using (store_id)
join payment p 
using (customer_id);

select store_id, amount
from store_bus
group by store_id;

#What is the average running time of films by category?
create temporary table film_cat_avg
select f.film_id, fc.category_id, c.name, avg(f.length) as length
from film f
join film_category fc
using (film_id)
join category c  
using (category_id)
group by f.film_id, fc.category, c.name;
select name, length from film_cat_avg;

#Which film categories are longest?
select name, length 
from film_cat_avg
order by length desc;

#Display the most frequently rented movies in descending order.
create temporary table film_rental
select f.film_id, f.title, i.inventory_id, count(r.rental_id) as num_rentals
from film f
join inventory i
using (film_id)
join rental r
using (inventory_id)
group by f.film_id, f.title, i.inventory_id;

#List the top five genres in gross revenue in descending order.
create temporary table cat_rev
select c.name, fc.category_id, i.inventory_id, r.rental_id, p.amount
from category c
join film_category fc
using (category_id)
join inventory i
using (film_id)
join rental r
using (inventory_id)
join payment p
using (rental_id);

#List the top five genres in gross revenue in descending order.
select name, sum(amount)
from cat_rev
group by name 
order by amount desc
limit 5;

#Is "Academy Dinosaur" available for rent from Store 1?
create temporary table dinosaur
select f.title, i.film_id, s.store_id
from film f
join inventory i
using (film_id)
join store s
using (store_id);

select title, store_id
from dinosaur
where title = "Academy Dinosaur"
group by store_id
having store_id = 1;



