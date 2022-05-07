use sakila;

-- 1. Rank films by length (filter out the rows that have nulls or 0s in length column). In your output, only select the columns title,
-- length, and the rank.
SELECT title, length, rank() over(order by length asc)
FROM film 
WHERE length is not null and title is not null and length!=0;

-- 2. Rank films by length within the rating category (filter out the rows that have nulls or 0s in length column). In your output, 
-- only select the columns title, length, rating and the rank.

SELECT title, rating, length, rank() over(partition by rating order by length asc) as lengh_rank_by_rating
FROM film 
WHERE length is not null and title is not null and length is not null and rating is not null and length!=0;

-- 3. How many films are there for each of the categories in the category table. Use appropriate join to write this query
SELECT *
FROM film_category;

SELECT * 
FROM category;

SELECT c.name, COUNT(c.name)
FROM film_category f
JOIN category c ON c.category_id=f.category_id
GROUP BY c.name;

-- 4. Which actor has appeared in the most films?
SELECT a.first_name,a.last_name, a.actor_id, (COUNT(a.actor_id)) as appearences
FROM film_actor f
JOIN actor a ON f.actor_id=a.actor_id
GROUP BY a.actor_id,a.first_name, a.last_name
ORDER BY appearences desc
LIMIT 1;

-- 5. Most active customer (the customer that has rented the most number of films)
SELECT c.first_name, c.last_name, r.customer_id, COUNT(r.rental_id) as rented_films 
FROM rental r
JOIN customer c ON c.customer_id=r.customer_id
GROUP BY r.customer_id, c.first_name,c.last_name
ORDER BY rented_films DESC
LIMIT 1;

-- Bonus: Which is the most rented film? The answer is Bucket Brotherhood This query might require using more than one join statement. 
-- Give it a try. We will talk about queries with multiple join statements later in the lessons.