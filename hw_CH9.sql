/* 	Alexey Milovanov
	Hw ch9
    Comp269
    Instructor: Dr. Yin Bao
*/

-- 1
select list_price, discount_percent, 
		ROUND(list_price * discount_percent/100, 2) as discount_amount
from products;

-- 2
select order_date,
		date_format(order_date, '%Y') as 'order_year',
        date_format(order_date, '%b-%d-%Y') as 'order_date_formated',
        date_format(order_date, '%h:%i %p')  as  'order_time',
        date_format(order_date, '%c/%e/%y %H:%i') as 'order_datetime'
from orders;

-- 3 
select card_number, 
	LENGTH(card_number) as 'car_number_length', 
    concat(substring(card_number, -4)) as 'last_four_digits',
    concat('XXXX-XXXX-XXXX-', substring(card_number, -4)) as 'formated_card'
from orders;
	
 -- 4 
select order_id, 
	DATE(order_date) as order_date,
		adddate(left(order_date, 10), interval 2 day) as approx_ship_date,

	DATE(ship_date) as ship_date,
		datediff(ship_date, order_date) as days_to_ship
from orders
where month(order_date) = 3 and year(order_date) = 2015

























