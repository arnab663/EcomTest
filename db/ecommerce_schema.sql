
PRAGMA foreign_keys = OFF;

-- Drop tables if they already exist
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS users;

-- Create tables
CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    name TEXT
);

CREATE TABLE products (
    id INTEGER PRIMARY KEY,
    name TEXT,
    price REAL
);

CREATE TABLE orders (
    id INTEGER PRIMARY KEY,
    user_id INTEGER,
    product_id INTEGER,
    quantity INTEGER,
    order_date TEXT,
    FOREIGN KEY(user_id) REFERENCES users(id),
    FOREIGN KEY(product_id) REFERENCES products(id)
);

-- Insert sample data
INSERT INTO users VALUES (1, 'Alice'), (2, 'Bob');

INSERT INTO products VALUES
(1, 'Laptop', 1000),
(2, 'Phone', 500),
(3, 'Keyboard', -30); 
-- (3, 'Keyboard', -30);  -- Invalid data (negative price)

INSERT INTO orders VALUES
(1, 1, 1, 1, '2024-06-01'),
-- (2, 2, 2, 0, '2025-10-01'),  -- Invalid (quantity 0)
-- (3, 99, 2, 1, '2024-05-05'), -- Invalid (non-existent user)
-- (4, 1, 3, 1, '2030-01-01');  -- Invalid future date
