-- Alexey Milovanov
-- COMP269 - Database Concepts
-- Instructor - Dr. Yin Bao
-- Homework - Ch3

-- Solution for Exercise 1
SELECT product_code, product_name, list_price, discount_percent
FROM products
ORDER BY list_price DESC;

-- Solution for Exercise 2
SELECT CONCAT(last_name, ', ', first_name) AS full_name
FROM customers
WHERE SUBSTR(last_name, 1, 1) BETWEEN 'M' AND 'Z'
ORDER BY last_name;

-- Solution for Exercise 3
SELECT product_name, list_price, date_added 
FROM products
WHERE list_price > 500 AND list_price < 2000
ORDER BY date_added DESC;

-- Solution for Exercise 4
SELECT product_name, list_price, discount_percent, ROUND(discount_percent*list_price/100, 2) AS discount_amount, ROUND(list_price - discount_percent*list_price/100, 2) AS discount_price
FROM products
ORDER BY ROUND(discount_percent*list_price/100, 2) DESC
LIMIT 5;

-- Solution for Exercise 5
SELECT item_id, item_price, discount_amount, quantity, item_price*quantity AS price_total, discount_amount*quantity AS discount_total, quantity*(item_price - discount_amount) AS item_total
FROM order_items
WHERE quantity*(item_price - discount_amount) > 500
ORDER BY quantity*(item_price - discount_amount) DESC;

-- Solution for Exercise 6
SELECT order_id, order_date, ship_date FROM orders
WHERE ship_date IS NULL;

-- Solution for Exercise 7
SELECT NOW() AS 'today_unformatted', DATE_FORMAT(NOW(),'%d-%b-%Y') AS 'today_formatted'
FROM Dual;

-- Solution for Exercise 8 
SELECT 100 AS price, 0.07 AS tax_rate, 100 * .07 AS tax_amount, (100 + 100 * .07) AS total