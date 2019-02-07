-- Milovanov Alexey
-- comp269
-- hw ch7

-- Solution for ex.1
select category_name
from categories c 
	where category_id in 
		(select category_id
		 from products p 
         where c.category_id = p.category_id)
order by category_name;
     

-- Solution for ex.2
select product_name, list_price
from products
where 
	list_price > (select avg(list_price)        /* avg(list_price) = 841.90 */
				  from products)
order by list_price desc;


-- Solution for ex.3 
select category_name
from categories c 
	where category_id not in 
		(select category_id
         from products p 
         where c.category_id = p.category_id)
order by category_name;


-- Solution for ex.4
select email_address, order_id, max(order_total)
from (select email_address, order_id,
      sum((item_price - discount_amount) * quantity) as order_total
	  from customers c natural join orders natural join order_items
	  group by email_address, order_id)t
			group by email_address;

-- Solution for ex.5
select product_name, discount_percent
from products
	where discount_percent not in 
	(select discount_percent 
	 from products
	 group by discount_percent
	 having count(discount_percent) > 1)
order by product_name;

-- Solution for ex.6
select email_address, order_id, order_date
from customers c join orders o
	on c.customer_id = o.customer_id 
	where order_date =
	(select min(order_date) 
	 from orders
	 where customer_id = o.customer_id)
order by email_address;