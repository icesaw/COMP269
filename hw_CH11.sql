/*  
    Alexey Milovanov
	Ch11
	COMP269
    Instructor: Dr. Yin Bao

-- 1 
This assigment will give you an error because there is no actual 
field zip_code or something like that in customers table in DB guitar_shop.
Check ERR Diagram and Vendors Table
this problem has same structure as for AP DB in-class Lab
use ap;
create index vendors_zip_code_ix on vendors (vendor_zip_code);
*/

use my_guitar_shop;
create index zip_code_ix on customers (zip_code);

-- Problem #2
drop database if exists my_web_db;
create database my_web_db;
use my_web_db;
drop table if exists downloads;
drop table if exists users;
drop table if exists products;

create table users
(
	user_id				int				primary key,
	email_address		varchar(100),
	first_name			varchar(45),
	last_name			varchar(45)
)
ENGINE = InnoDB;
alter table my_web_db.users CHARSET utf8 collate utf8_general_ci;

create table products
(
	product_id		int					primary key,
    product_name	varchar(45)
);

alter table my_web_db.products charset utf8 collate utf8_general_ci;

create table downloads
(
	download_id		int					primary key		AUTO_INCREMENT,
    user_id			int,
    download_date	datetime,
    filename		varchar(45),
    product_id		int,
    constraint users_fk_downloads
		foreign key (user_id)
			references users (user_id),
	constraint products_fk_downloads
		foreign key (product_id)
			references products (product_id)
);

alter table my_web_db.downloads charset utf8 collate utf8_general_ci;
show engines;

-- Problem #3
insert into users values (1, 'johnsmith@gmail.com', 'John', 'Smith');
insert into users values (2, 'janedoe@yahoo.com', 'Jane', 'Doe');
insert into products values (1, 'Local Music Vol 1');
insert into products values (2, 'Local Music Vol 2');
insert into downloads values (default, 1, now(), 'pedal_are_falling.mp3', 1);
insert into downloads values (default, 2, now(), 'turn_signal.mp3', 1);
insert into downloads values (default, 2, now(), 'one_horse_town.mp3', 2);

select email_address, first_name, last_name, download_date, filename, product_name
from users natural join products natural join downloads
order by email_address desc, product_name asc;

-- Problem #4
alter table products
add (
	product_price double default 9.99,
    product_date datetime default now()
);

-- Problem #5 - Gives you errors and thats what problem #5 asks first_name
-- cant be null either more than 20 chars (alter table seq) 
alter table users modify first_name varchar(20) not null;

update users set first_name = null where user_id = 1;
update users set first_name = 123456789098765432123 where user_id = 1;