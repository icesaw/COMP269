-- alexey milovanov
-- comp269
-- ch6 homework

-- exersice 1
select count(*) as order_count, 
sum(tax_amount) as tax_total from orders;

-- exercise 2
select category_name, 
count(p.product_id) as product_count, 
max(list_price) as most_expensive_product
from categories c join products p on c.category_id = p.category_id
group by category_name order by list_price;

-- exercise 3
select email_address, 
sum(item_price * quantity) as item_price_total, 
sum(discount_amount * quantity) as discount_amount_total
from customers c join orders o on c.customer_id = o.customer_id
join order_items oi on o.order_id = oi.order_id
group by email_address order by item_price_total desc;

-- exercise 4
select email_address,
count(o.order_id) as order_count, 
sum((item_price - discount_amount) * quantity) as order_total
from customers c join orders o on c.customer_id = o.customer_id
join order_items oi on o.order_id = oi.order_id
group by email_address having count(*) > 1 order by order_total desc;

-- exercise 5
select email_address,
count(o.order_id) as order_count, 
sum((item_price - discount_amount) * quantity) as order_total
from customers c join orders o on c.customer_id = o.customer_id
join order_items oi on o.order_id = oi.order_id where oi.item_price > 400
group by email_address having count(*) > 1 order by order_total desc;

-- exercise 6
select product_name,
sum((oi.item_price - oi.discount_amount) * oi.quantity) as product_total
from products p join order_items oi on p.product_id = oi.product_id
group by product_name with rollup;

-- exercise 7
select email_address,
count(o.order_id) as number_of_products
from customers c join orders o on c.customer_id = o.customer_id
join order_items oi on o.order_id = oi.order_id
group by email_address having number_of_products > 1;