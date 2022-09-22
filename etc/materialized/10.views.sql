CREATE MATERIALIZED VIEW customer_addresses AS
SELECT a.id, a.type, a.state, a.city, a.street, c.first_name, c.last_name
FROM addresses AS a
LEFT JOIN customers AS c ON a.customer_id = c.id;
