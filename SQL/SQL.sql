## SQL

-- QUESTION 1
---------------------------------------------------------------------------------
use avinesh_masih;
CREATE TABLE employees (
    emp_id INT NOT NULL PRIMARY KEY,  -- Primary Key, should not be NULL
    emp_name TEXT NOT NULL,           -- Employee name should not be NULL
    age INT CHECK (age >= 18),        -- Ensures age is at least 18
    email TEXT UNIQUE,                -- Ensures unique email for each employee
    salary DECIMAL DEFAULT 30000      -- Default salary is 30,000
);

-- Answer:
-- The table 'employees' has been successfully created with the given constraints.
-- Now, you can insert employee records into this table.
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------

-- QUESTION 2
---------------------------------------------------------------------------------
-- Constraints are rules that help maintain data integrity by ensuring the accuracy, consistency, 
-- and reliability of data in a database.

-- Common types of constraints:

-- PRIMARY KEY: Ensures unique and non-null values for a column.
CREATE TABLE example_primary_key (
    id INT PRIMARY KEY,  -- 'id' must be unique and cannot be NULL
    name TEXT NOT NULL   -- 'name' cannot be NULL
);


-- NOT NULL: Prevents NULL values in a column.
CREATE TABLE example_not_null (
    id INT PRIMARY KEY,
    email TEXT NOT NULL
);

-- UNIQUE: Ensures all values in a column are distinct.
CREATE TABLE example_unique (
    id INT PRIMARY KEY,
    username TEXT UNIQUE
);

-- CHECK: Ensures values meet a specific condition.
CREATE TABLE example_check (
    id INT PRIMARY KEY,
    age INT CHECK (age >= 18)
);

-- DEFAULT: Assigns a default value if none is provided.
CREATE TABLE example_default (
    id INT PRIMARY KEY,
    salary DECIMAL DEFAULT 30000
);

-- FOREIGN KEY: Enforces referential integrity between tables.
CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name TEXT NOT NULL
);

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name TEXT NOT NULL,
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
-- QUESTION 3
---------------------------------------------------------------------------------

-- The NOT NULL constraint ensures that a column cannot have NULL values.
-- It is used when a column must always contain a value, preventing missing or undefined data.
-- This helps maintain data integrity and consistency.

-- Example: Using NOT NULL to enforce required fields
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,  -- Primary Key, must be unique and NOT NULL by default
    name VARCHAR(100) NOT NULL,   -- Name is mandatory
    email VARCHAR(255) UNIQUE NOT NULL  -- Email must be unique and cannot be NULL
);


-- Can a primary key contain NULL values?
-- No, a primary key cannot contain NULL values.
-- The purpose of a primary key is to uniquely identify each row in a table.
-- If it had NULL values, uniqueness would be violated because NULL represents an unknown value.

-- Example: Attempting to insert NULL into a primary key column will fail
INSERT INTO customers (customer_id, name, email) VALUES (NULL, 'John Doe', 'john@example.com');
-- This will result in an error since 'customer_id' is a PRIMARY KEY and cannot be NULL.

---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
-- QUESTION 4
---------------------------------------------------------------------------------

-- To add or remove constraints on an existing table, we use the ALTER TABLE command.

-- 1. Adding a constraint:
-- Example: Adding a UNIQUE constraint to the 'email' column in the 'employees' table.
ALTER TABLE employees 
ADD CONSTRAINT unique_email UNIQUE (email);

-- 2. Removing a constraint:
-- Example: Removing the UNIQUE constraint from the 'email' column.
ALTER TABLE employees 
DROP CONSTRAINT unique_email;

-- Note:
-- - PRIMARY KEY constraints cannot be added or removed directly; instead, you must recreate the table.
-- - FOREIGN KEY and CHECK constraints can also be added or removed using ALTER TABLE.

---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
-- QUESTION 5
---------------------------------------------------------------------------------

-- Constraints ensure data integrity, so violating them leads to errors.
-- Consequences of violating constraints:

-- 1. Attempting to insert a duplicate value into a column with a UNIQUE constraint:
INSERT INTO employees (emp_id, emp_name, age, email, salary) 
VALUES (1, 'John Doe', 25, 'john@example.com', 50000);

INSERT INTO employees (emp_id, emp_name, age, email, salary) 
VALUES (2, 'Jane Doe', 30, 'john@example.com', 60000);  -- ERROR: Duplicate email

-- Expected Error:
-- ERROR 1062 (23000): Duplicate entry 'john@example.com' for key 'employees.email'

-- 2. Inserting NULL into a NOT NULL column:
INSERT INTO employees (emp_id, emp_name, age, email, salary) 
VALUES (3, NULL, 28, 'jane@example.com', 45000);  -- ERROR: emp_name cannot be NULL

-- Expected Error:
-- ERROR 1048 (23000): Column 'emp_name' cannot be null

-- 3. Violating CHECK constraint:
INSERT INTO employees (emp_id, emp_name, age, email, salary) 
VALUES (4, 'Alice', 16, 'alice@example.com', 32000);  -- ERROR: Age must be at least 18

-- Expected Error:
-- ERROR 3819 (HY000): Check constraint 'employees_chk_1' is violated

-- 4. Deleting a record referenced by a FOREIGN KEY constraint:
DELETE FROM departments WHERE dept_id = 1;  -- ERROR: Cannot delete referenced department

-- Expected Error:
-- ERROR 1451 (23000): Cannot delete or update a parent row: a foreign key constraint fails

-- Conclusion:
-- Constraints prevent incorrect data from being inserted, updated, or deleted.
-- Violating them results in SQL errors, ensuring data consistency and reliability.

---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
-- QUESTION 6
---------------------------------------------------------------------------------

-- To modify the existing `products` table and add the constraints:

-- Creating a products table 
CREATE TABLE products (
    product_id INT, 
    product_name VARCHAR(50), 
    price DECIMAL(10, 2)
);


-- 1. Adding PRIMARY KEY constraint to `product_id`
ALTER TABLE products 
ADD CONSTRAINT pk_product PRIMARY KEY (product_id);

-- 2. Adding DEFAULT constraint to `price`
ALTER TABLE products 
ALTER COLUMN price SET DEFAULT 50.00;

-- Verification:
-- Describe the table structure to check applied constraints.
DESC products;

-- Expected Output:
-- The `product_id` column is now a PRIMARY KEY.
-- The `price` column has a default value of 50.00.

---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
-- QUESTION 7
---------------------------------------------------------------------------------

-- Using INNER JOIN to fetch student_name along with their respective class_name
-- creating table
CREATE TABLE Students (
    student_id INT PRIMARY KEY, 
    student_name VARCHAR(50), 
    class_id INT
);

CREATE TABLE Classes (
    class_id INT PRIMARY KEY, 
    class_name VARCHAR(50)
);

SELECT s.student_name, c.class_name
FROM Students s
INNER JOIN Classes c ON s.class_id = c.class_id;

---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
-- QUESTION 8
---------------------------------------------------------------------------------
-- Using INNER JOIN and LEFT JOIN to retrieve all orders with customer names 
-- and ensure that all products are listed even if they are not associated with an order.

SELECT o.order_id, c.customer_name, p.product_name
FROM Orders o
INNER JOIN Customers c ON o.customer_id = c.customer_id
LEFT JOIN Products p ON o.order_id = p.product_id;

---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
-- QUESTION 9
---------------------------------------------------------------------------------
-- Using INNER JOIN and SUM() to calculate the total sales amount for each product.

SELECT p.product_name, SUM(s.amount) AS total_sales
FROM Sales s
INNER JOIN Products p ON s.product_id = p.product_id
GROUP BY p.product_name;

---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
-- QUESTION 10
---------------------------------------------------------------------------------

-- Using INNER JOIN to fetch order_id, customer_name, and total quantity of products ordered.

SELECT o.order_id, c.customer_name, SUM(od.quantity) AS total_quantity
FROM Orders o
INNER JOIN Customers c ON o.customer_id = c.customer_id
INNER JOIN Order_Details od ON o.order_id = od.order_id
GROUP BY o.order_id, c.customer_name;
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------


