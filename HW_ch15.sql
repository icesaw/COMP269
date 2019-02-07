/*  Alexey Milovanov
	Ch15
	COMP269
    Instructor: Dr. Yin Bao
*/


-- 1
drop procedure if exists insert_category;
delimiter //
create procedure insert_category(
	in	category_param	varchar (100)
)
begin
	insert into categories values(default, category_param);
end //
delimiter ;

-- Test fail:
call insert_category('Guitar');
-- Test Success:
call insert_category('New Category');
-- Clean up:
delete from categories where category_id = last_insert_id();

-- 2
drop function if exists discount_price;
delimiter //
create function discount_price (id int)
returns decimal (10,2)
begin
	declare amount decimal (10,2);
	select (item_price - discount_amount) into amount
		from order_items where item_id = id;
	return amount;
end; //
delimiter ;
select item_id, item_price, discount_amount, discount_price(item_id) as dicount_price from order_items; 