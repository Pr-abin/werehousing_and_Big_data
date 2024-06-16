CREATE TABLE fact_sales (
    rental_id INTEGER,
    customer_id INTEGER,
    film_id INTEGER,
    store_id INTEGER,
    rental_date TIMESTAMP,
    return_date TIMESTAMP,
    rental_amount NUMERIC(10, 2),
    actor_id INTEGER
);

INSERT INTO fact_sales (rental_id, customer_id, film_id, store_id, rental_date, return_date, rental_amount, actor_id)
SELECT 
    r.rental_id, 
    r.customer_id, 
    i.film_id, 
    i.store_id, 
    r.rental_date, 
    r.return_date,
    COALESCE(p.total_amount, 0) AS rental_amount, -- Use COALESCE to handle rentals without payments
    a.actor_id
FROM 
    rental r
INNER JOIN 
    inventory i ON r.inventory_id = i.inventory_id
LEFT JOIN (
    SELECT 
        rental_id, 
        SUM(amount) AS total_amount -- Summing up the payments for each rental
    FROM 
        payment
    GROUP BY 
        rental_id
) p ON r.rental_id = p.rental_id
LEFT JOIN (
    SELECT 
        fa.film_id, 
        MIN(fa.actor_id) AS actor_id -- Choose the first actor (lowest actor_id) for each film
    FROM 
        film_actor fa
    GROUP BY 
        fa.film_id
) a ON i.film_id = a.film_id;

select *from fact_sales;

