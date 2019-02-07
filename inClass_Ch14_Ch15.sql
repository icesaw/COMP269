/*
Alexey Milovanov
inClass Ch14-15
Instructor: Dr. Yin Bao
12/03/18
*/


-- 14.1
use ap;
drop procedure if exists test;
delimiter //
create procedure test()
begin
  declare sql_error int default false;
  declare continue handler for sqlexception
    set sql_error = true;
  start transaction;
  update invoices set vendor_id = 123 
  where vendor_id = 122;
  delete from vendors 
  where vendor_id = 122;
  update vendors
  set vendor_name = 'FedUP' where vendor_id = 123;
  if sql_error = false then
    commit;
    select 'The transaction was commistted.';
  else
    rollback;
    select 'The transaction was rolled back.';
  end if;
end//
delimiter ;
-- Test success: 
call test();

-- 14.2
use ap;
drop procedure if exists test;
delimiter //
create procedure test()
begin
  declare sql_error int default false;
  declare continue handler for sqlexception set sql_error = true;
  start transaction;
  delete from invoice_line_items where invoice_id = 114;
  delete from invoices where invoice_id = 114;
  commit;
  if sql_error = false then commit;
    select 'The transaction was committed.';
  else
    rollback;
    select 'The transaction was rolled back.';
  end if;
end//
delimiter ;
-- Test success: 
call test();

-- 15.1
use ap;
drop procedure if exists insert_glaccount;
delimiter //
create procedure insert_glaccount
(account_number int, account_description  varchar(100))
begin
  insert into general_ledger_accounts
  values (account_number, account_description);
end //
delimiter ;
-- Test success: 
call insert_glaccount(1500, 'Test for 269 Class');