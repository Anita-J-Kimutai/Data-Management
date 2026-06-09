----------------- Enable foreign key support 
PRAGMA foreign_keys = ON;

------------ Create customer table
DROP TABLE customers;
CREATE TABLE customers (
    customer_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT,
    email TEXT UNIQUE
);

------------------- Create Product table
DROP TABLE products;
CREATE TABLE products (
    product_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT,
    price REAL,
    stock INTEGER CHECK (stock >= 0)
);

-------------------- Create orders table
DROP TABLE orders;
CREATE TABLE orders (
    order_id INTEGER PRIMARY KEY AUTOINCREMENT,
    customer_id INTEGER,
    order_date TEXT DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-------------Create table order_items
DROP TABLE order_items;
CREATE TABLE order_items (
    order_item_id INTEGER PRIMARY KEY AUTOINCREMENT,
    order_id INTEGER,
    product_id INTEGER,
    quantity INTEGER CHECK (quantity > 0),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Insert data into the tables
INSERT INTO customers (name, email) VALUES
('Alice', 'alice@email.com'),
('Bob', 'bob@email.com');

INSERT INTO products (name, price, stock) VALUES
('Laptop', 1000, 10),
('Phone', 500, 20);


-----------ATOMICITY


BEGIN TRANSACTION;

INSERT INTO orders (customer_id) VALUES (1);

-------------- Get the last inserted order id
INSERT INTO order_items (order_id, product_id, quantity) VALUES (last_insert_rowid(), 1, 2);

--------------- Force error
INSERT INTO order_items (order_id, product_id, quantity) VALUES (last_insert_rowid(), 999, 1);

ROLLBACK;

------------Check results after rollback
SELECT order_id, customer_id, order_date FROM orders;


-----------CONSISTENCY

UPDATE products SET stock = -5 WHERE product_id = 1;


-------------ISOLATION

-------------Transaction 1
BEGIN TRANSACTION;

UPDATE products SET stock = stock - 2 WHERE product_id = 1;

-------------Transaction 2
UPDATE products
SET stock = stock - 1
WHERE product_id = 1;

---------------DURABILITY
BEGIN TRANSACTION;

INSERT INTO orders (customer_id) VALUES (2);

COMMIT;

---------------Verification
SELECT order_id, customer_id, order_date FROM orders;



