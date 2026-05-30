CREATE DATABASE sql_sales_project;

USE sql_sales_project;

CREATE TABLE sales (
    order_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    product_name VARCHAR(50),
    quantity INT,
    price DECIMAL(10,2)
);

INSERT INTO sales
VALUES
(1, 'John', 'Laptop', 1, 1000.00),
(2, 'Emma', 'Mouse', 2, 25.00),
(3, 'John', 'Keyboard', 1, 80.00),
(4, 'Sarah', 'Laptop', 1, 1000.00),
(5, 'Emma', 'Monitor', 2, 200.00);

select *
from sales; 

SELECT
    customer_name,
    SUM(quantity * price) AS total_spent
FROM sales
GROUP BY customer_name;

SELECT
    customer_name,
    SUM(quantity * price) AS total_spent
FROM sales
GROUP BY customer_name
HAVING SUM(quantity * price) > 500;
