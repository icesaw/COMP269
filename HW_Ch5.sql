-- Milovanov Alexey
-- COMP269
-- Chapter 5 Guitar Shop HW
-- Instructor - Dr. Yin Bao

-- Solution for Exercise 1
INSERT INTO categories (category_id, category_name)
VALUES (DEFAULT,'Brass');

-- Solution for Exercise 2
UPDATE categories
SET category_name = 'Woodwinds' WHERE category_name = 'Brass';

-- Solution for Exercise 3
DELETE FROM categories WHERE category_id = 5;

-- Solution for Exercise 4
INSERT INTO products (product_id, category_id, product_code, product_name, description, list_price, discount_percent, date_added)
VALUES (DEFAULT, 4, 'dgx_640', 'Yamaha DGX 640 88-Key Digital Piano', 'Long description to come', 799.99, 0, NOW());

-- Solution for Exercise 5
UPDATE products 
SET discount_percent = 35 WHERE product_id = 11;

-- Solution for Exercise 6
DELETE FROM products WHERE category_id = 4;
DELETE FROM categories WHERE category_id = 4;