/*  Alexey Milovanov
	Ch13
	COMP269
    Instructor: Dr. Yin Bao
*/

-- 1
use my_guitar_shop;
drop procedure if exists test1;
delimiter //
create procedure test1()
begin
    declare count_of_all_products int;
    select count(product_id)
    into count_of_all_products
    from products;
IF (count_of_all_products >= 7 ) then
select 'The number of products is greater than or equal to 7' as message;
else select 'The number of products is less than 7' as message;
end if;
end//
delimiter ;
call test1();

-- 2
use my_guitar_shop;
drop procedure if exists test2;
delimiter //
create procedure test2()
begin
    declare count_of_all_products int;
    declare avg_of_all_products int;
    select count(product_id)
    into count_of_all_products
    from products;
    select avg(list_price)
    into avg_of_all_products
    from products;
IF (count_of_all_products >= 7 ) then
select count_of_all_products, avg_of_all_products;
else select 'The number of products is less than 7' as message;
end if;
end//
delimiter ;
call test2();

-- 3
use my_guitar_shop;
drop procedure if exists test3;
delimiter //
create procedure test3()
begin
declare product_name_var varchar(50);
declare list_price_var decimal(9,2);
declare row_not_found tinyint default false;
declare s_var varchar(400) default '';
declare invoice_cursor cursor for
    select
        product_name,
        list_price
    from
        products
    where
        list_price > 700
    order by list_price desc;
declare continue handler for not found
    set row_not_found = true;
open invoice_cursor;
fetch invoice_cursor into product_name_var, list_price_var;
while row_not_found = false do
    set s_var = concat(s_var,'"',product_name_var,'","',list_price_var,'"|');
    fetch invoice_cursor into product_name_var, list_price_var;
end while;
select s_var as message;
end//
delimiter ;
call test3();
