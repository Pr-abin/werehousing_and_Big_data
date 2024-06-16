-- Create dim_actor table
CREATE TABLE dim_actor (
    actor_id INTEGER PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50)
);

-- Populate dim_actor table with data from actor table
INSERT INTO dim_actor (actor_id, first_name, last_name)
SELECT actor_id, first_name, last_name
FROM actor;
