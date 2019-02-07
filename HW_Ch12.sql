/*  Alexey Milovanov
	Ch12
	COMP269
    Instructor: Dr. Yin Bao
*/

-- Problem 1
create or replace view customer_address as

select c.customer_id, email_address, last_name, first_name,
ba.line1 as bill_line1, ba.line2 as bill_line2, ba.city as bill_city, ba.state as bill_state, ba.zip_code as bill_zip,
sa.line1 as ship_line1, sa.line2 as ship_line2, sa.city as ship_city, sa.state as ship_state, sa.zip_code as ship_zip
from customers c 
	join addresses ba on c.billing_address_id = ba.address_id
	join addresses sa on c.shipping_address_id = sa.address_id
order by last_name, first_name;


-- Problem 2
select customer_id, last_name, first_name, bill_line1
from customer_address;


-- Problem 3
update customer_address
set ship_line1 = '1990 Westwood Blvd'
where customer_id = 8;


-- Problem 4
create or replace view order_item_products as

	select order_date, tax_amount, ship_date,
			product_name, item_price, discount_amount,
			(item_price - discount_amount) as final_price, quantity,
            (item_price - discount_amount) * quantity as item_total
	from orders o
		join order_items li on o.order_id = li.order_id
		join products p on li.product_id = p.product_id;


-- Problem 5
create or replace view product_summary as

    select product_name,
		count(product_name) as order_count,
        sum(item_total) as order_total
    from order_item_products
  	group by product_name;


-- Problem 6
select product_name, order_total
from product_summary
order by order_total desc
limit 5;