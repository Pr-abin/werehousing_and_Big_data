SELECT 
    da.actor_id,
    da.first_name,
    da.last_name,
    SUM(fs.rental_amount) AS total_rental_amount
FROM 
    fact_sales fs
JOIN 
    dim_actor da ON fs.actor_id = da.actor_id
GROUP BY 
    da.actor_id, da.first_name, da.last_name
ORDER BY 
    total_rental_amount DESC
LIMIT 5;
