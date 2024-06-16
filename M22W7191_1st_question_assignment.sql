___ this is  the answer of the 1st Questions 
WITH actor_rental_counts AS (
    SELECT 
        fs.actor_id,
        COUNT(DISTINCT fs.film_id) AS film_count
    FROM 
        fact_sales fs
    GROUP BY 
        fs.actor_id
),
most_popular_actor AS (
    SELECT 
        ar.actor_id
    FROM 
        actor_rental_counts ar
    WHERE 
        ar.film_count = (
            SELECT MAX(film_count) FROM actor_rental_counts
        )
    LIMIT 1
)
SELECT 
    SUM(fs.rental_amount) AS total_rental_amount
FROM 
    fact_sales fs
JOIN 
    most_popular_actor mpa ON fs.actor_id = mpa.actor_id;
