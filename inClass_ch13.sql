/*
Alexey Milovanov
inClass Ch13
Instructor: Dr. Yin Bao
11/26/18
*/

-- Problem #1
use ap;
drop procedure if exists Problem1;
delimiter //
create procedure Problem1()
begin
  declare invoice_count int;
  select count(*) into invoice_count from invoices
  where invoice_total - payment_total - credit_total >= 5000;
  select concat(invoice_count, ' invoices exceed $5000') as message;
end//
delimiter ;
call Problem1();

-- Problem #3
use ap;
drop procedure if exists Problem3;
delimiter //
create procedure Problem3()
begin
  declare count_balance_due   int;
  declare total_balance_due   decimal(9,2);
  select count(*), sum(invoice_total - payment_total - credit_total)
  into count_balance_due, total_balance_due
  from invoices
  where invoice_total - payment_total - credit_total > 0;
  if total_balance_due >= 30000 then
    select count_balance_due as count_balance_due, 
           total_balance_due as total_balance_due;
  else select 'Total balance due is less than $30,000.' as message;
  end if;
end//
delimiter ;
call Problem3();

-- Problem #4
use ap;
drop procedure if exists Problem4;
delimiter //
create procedure Problem4()
begin
  declare vendor_name_var     varchar(50);
  declare invoice_number_var  varchar(50);
  declare balance_due_var     decimal(9,2);
  declare result              varchar(400)   default '';
  declare row_not_found       int            default false;
  declare invoices_cursor cursor for
    select vendor_name, invoice_number, invoice_total - payment_total - credit_total as balance_due
    from vendors v join invoices i on v.vendor_id = i.vendor_id
    where invoice_total - payment_total - credit_total >= 5000
    order by balance_due desc;

  begin
    declare exit handler for not found
      set row_not_found = true;
    open invoices_cursor;
    while row_not_found = false do
      fetch invoices_cursor 
      into vendor_name_var, invoice_number_var, balance_due_var;
      set result = concat(result, balance_due_var, '|', invoice_number_var, '|', vendor_name_var, '//');
    end while;
  end;

  close invoices_cursor;    
  select result as message;
end//
delimiter ;
call Problem4;
