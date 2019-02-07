-- Milovanov Alexey
-- comp-269
-- 11/5/2018
-- Instructor: Dr. Yin Bao


-- 1 -- Using AP Database
use ap;
create index vendors_zip_code_ix on vendors (vendor_zip_code);

-- 2 - Using EX Database
use  ex;
drop table if exists members_groups;
drop table if exists members;
drop table if exists groups;

create table members 
(
  member_id     int           primary key   auto_increment, 
  first_name    varchar(50)   not null, 
  last_name     varchar(50)   not null, 
  address       varchar(50)   not null, 
  city          varchar(25)   not null, 
  state         char(2), 
  phone         varchar(20)
);

create table groups 
(
  group_id      int            primary key   auto_increment, 
  group_name    varchar(50)    not null
);

create table members_groups
(
  member_id  int not null, 
  group_id   int not null,
  constraint members_groups_fk_members foreign key (member_id) references members (member_id), 
  constraint members_groups_fk_groups foreign key (group_id) references groups (group_id)
);

-- 3
use  ex;
insert into members values (default, 'Alex', 'Milovanov', '38 Oak Dr.', 'Monmouth', 'NJ', '415-942-1901');
insert into members values (default, 'Done', 'Smith', '99 Lakewood St.', 'Ocean', 'NJ', '510-123-4567');

insert into groups values (default, 'Food Store');
insert into groups values (default, 'Cycle Club');

insert into members_groups values (1, 2);
insert into members_groups values (2, 1);
insert into members_groups values (2, 2);

select g.group_name, m.last_name, m.first_name
from groups g
  join members_groups mg
    on g.group_id = mg.group_id
  join members m
    on mg.member_id = m.member_id
order by g.group_name, m.last_name, m.first_name;

-- 4
use ex;
alter table members add annual_dues decimal(5,2) default 52.50;
alter table members add payment_date date;

-- 5 
-- This statement SHOULD FAIL - thats what in 11.5 Problem says. I cant insert another dublicate entry.
use ex;
alter table groups modify group_name varchar(50) not null unique;
insert into groups (group_name) values ('Food Store');