--- Create database for e-commerce
CREATE DATABASE E_COMMERCE;
USE E_COMMERCE;
-- Customers table
CREATE TABLE Customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    address VARCHAR(255)
);

-- Categories table
CREATE TABLE Categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100)
);

-- Products table
CREATE TABLE Products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    price DECIMAL(10,2),
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)
);

-- Orders table
CREATE TABLE Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- Order_Items table
CREATE TABLE Order_Items (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- Payments table
CREATE TABLE Payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    payment_date DATE,
    amount DECIMAL(10,2),
    payment_method VARCHAR(50),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);
--- insert data into Customer table
INSERT INTO Customers (name, email, address) VALUES
('John Doe', 'john@example.com', '123 Maple St'),
('Jane Smith', 'jane@example.com', '456 Oak Ave'),
('Alice Johnson', 'alice@example.com', '789 Pine Rd'),
('Bob Lee', 'bob@example.com', '321 Birch Blvd'),
('Sara Kim', 'sara@example.com', '654 Cedar Ln');
--- insert data into Categories table
INSERT INTO Categories (category_name) VALUES
('Electronics'),
('Books'),
('Clothing');
--- insert data into Product table
INSERT INTO Products (name, price, category_id) VALUES
('Smartphone', 499.99, 1),
('Laptop', 999.99, 1),
('Fiction Book', 15.99, 2),
('Textbook', 45.50, 2),
('T-shirt', 9.99, 3),
('Jeans', 29.99, 3);
--- insert data into Orders table
INSERT INTO Orders (customer_id, order_date, total_amount) VALUES
(1, '2025-06-01', 515.98),
(2, '2025-06-02', 75.49),
(3, '2025-06-03', 29.99),
(4, '2025-06-04', 1045.49),
(5, '2025-06-05', 15.99);
--- insert dta into Order_items table
INSERT INTO Order_Items (order_id, product_id, quantity, price) VALUES
(1, 1, 1, 499.99),   -- Smartphone
(1, 3, 1, 15.99),    -- Fiction Book
(2, 4, 1, 45.50),    -- Textbook
(2, 5, 3, 9.99),     -- 3 T-shirts
(3, 6, 1, 29.99),    -- Jeans
(4, 2, 1, 999.99),   -- Laptop
(4, 4, 1, 45.50),    -- Textbook
(5, 3, 1, 15.99),    -- Fiction Book
(2, 3, 1, 15.99),    -- Fiction Book
(1, 5, 2, 9.99);     -- 2 T-shirts
--- insert data into Payments table
INSERT INTO Payments (order_id, payment_date, amount, payment_method) VALUES
(1, '2025-06-01', 515.98, 'Credit Card'),
(2, '2025-06-02', 75.49, 'UPI'),
(3, '2025-06-03', 29.99, 'Debit Card'),
(4, '2025-06-04', 1045.49, 'Net Banking'),
(5, '2025-06-05', 15.99, 'Cash');

--- total sales day by day
SELECT 
    order_date,
    SUM(total_amount) AS total_sales
FROM Orders
GROUP BY order_date
ORDER BY order_date;
---- total sales by product
SELECT 
    p.name AS product_name,
    SUM(oi.quantity * oi.price) AS total_sales
FROM Order_Items oi
JOIN Products p ON oi.product_id = p.product_id
GROUP BY p.product_id
ORDER BY total_sales DESC;
---- top 5 customers by total purchase
SELECT 
    c.name AS customer_name,
    SUM(o.total_amount) AS total_spent
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id
ORDER BY total_spent DESC
LIMIT 5;
---- monthly sales report
SELECT 
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    COUNT(order_id) AS total_orders,
    SUM(total_amount) AS total_revenue
FROM Orders
GROUP BY month
ORDER BY month;


