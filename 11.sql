-- 1. Create and select database
CREATE DATABASE sql_sales_project;
USE sql_sales_project;

-- 2. Create main sales table
CREATE TABLE sales (
    order_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    product_name VARCHAR(50),
    quantity INT,
    price DECIMAL(10 , 2 ),
    order_date DATE,
    region VARCHAR(50)
);

-- 3. Insert sample data
INSERT INTO sales VALUES
(1, 'John',  'Laptop',   1, 1000.00, '2024-01-10', 'North'),
(2, 'Emma',  'Mouse',    2,   25.00, '2024-01-12', 'West'),
(3, 'John',  'Keyboard', 1,   80.00, '2024-01-15', 'North'),
(4, 'Sarah', 'Laptop',   1, 1000.00, '2024-01-20', 'South'),
(5, 'Emma',  'Monitor',  2,  200.00, '2024-01-22', 'West'),
(6, 'David', 'Laptop',   1, 1000.00, '2024-02-01', 'East'),
(7, 'Emma',  'Mouse',    1,   25.00, '2024-02-05', 'West');

-- 4. Create products table
CREATE TABLE products (
    product_name VARCHAR(50) PRIMARY KEY,
    category VARCHAR(50),
    cost DECIMAL(10,2)
);

-- 5. Insert product metadata
INSERT INTO products VALUES
('Laptop', 'Electronics', 700.00),
('Mouse', 'Accessories', 10.00),
('Keyboard', 'Accessories', 30.00),
('Monitor', 'Electronics', 120.00);

-- 6. Basic select
SELECT * FROM sales;

-- 7. Customer total spending
SELECT
    customer_name,
    SUM(quantity * price) AS total_spent
FROM sales
GROUP BY customer_name;

-- 8. Customers spending more than 500
SELECT
    customer_name,
    SUM(quantity * price) AS total_spent
FROM sales
GROUP BY customer_name
HAVING SUM(quantity * price) > 500;

-- 9. Product revenue ranking
SELECT
    product_name,
    SUM(quantity * price) AS total_revenue
FROM sales
GROUP BY product_name
ORDER BY total_revenue DESC;

-- 10. Customer order frequency + spending
SELECT
    customer_name,
    COUNT(order_id) AS total_orders,
    SUM(quantity * price) AS total_spent
FROM sales
GROUP BY customer_name
ORDER BY total_spent DESC;

-- 11. Window function: rank customers by spending
SELECT
    customer_name,
    SUM(quantity * price) AS total_spent,
    RANK() OVER (ORDER BY SUM(quantity * price) DESC) AS spending_rank
FROM sales
GROUP BY customer_name;

-- 12. Join with products to calculate profit
SELECT
    s.product_name,
    SUM(s.quantity * (s.price - p.cost)) AS total_profit
FROM sales s
JOIN products p ON s.product_name = p.product_name
GROUP BY s.product_name
ORDER BY total_profit DESC;

-- 13. Create a view for customer revenue
CREATE VIEW customer_revenue AS
SELECT
    customer_name,
    SUM(quantity * price) AS total_spent
FROM sales
GROUP BY customer_name;

-- 14. Query the view
SELECT * FROM customer_revenue ORDER BY total_spent DESC;

-- 15. Revenue by region
SELECT
    region,
    SUM(quantity * price) AS region_revenue
FROM sales
GROUP BY region
ORDER BY region_revenue DESC;

-- 16. Monthly revenue trend
SELECT
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    SUM(quantity * price) AS monthly_revenue
FROM sales
GROUP BY month
ORDER BY month;
