CREATE TABLE orders(
orderid INT PRIMARY KEY,
customername VARCHAR(20),
products VARCHAR(50),
quantity INT,
orderDate DATE NOT NULL,
);

SELECT *
FROM orders


INSERT INTO orders 
(orderid, customername, products, quantity, orderDate)
VALUES 
(1, 'Aisha', 'Skincare', 3, '2026/02/01'),
(2, 'Salami', 'Foodstuff', 17, '2026/02/23'),
(3, 'Goodluck', 'Cables', 5, '2026/03/03'),
(4, 'Jonathan', 'Mouse', 11, '2026/03/07'),
(5, 'Tinubu', 'President', 20, '2026/06/12');

SELECT *
FROM orders
Drop TABLE orders

