/*
Milovanov Alexey
COMP269
in-Class Lab
Instructor: Dr. Yin Bao
*/

use ap;
drop trigger if exists invoices_before_update;
delimiter //
create trigger invoices_before_update
  before update on invoices
  for each row
begin
  declare sum_line_item_amount decimal(9,2);
  
  select sum(line_item_amount) 
  into sum_line_item_amount
  from invoice_line_items
  where invoice_id = new.invoice_id;
  
  if sum_line_item_amount != new.invoice_total then
    signal sqlstate 'HY000'
      set message_text = 'Line Item Total must match Invoice Total.';
  elseif new.payment_total + new.credit_total > old.invoice_total then
    signal sqlstate 'HY000'
      set message_text = 'Sum of Total Payment total and Credit Total can not be greater than Invoice Total.';
  end if;
end//

delimiter ;

-- change payment_total and credit_total eqaul 10976.06 to get an Error about Summary
update invoices
set payment_total = 500, credit_total = 500
where invoice_id = 112;

select invoice_id, invoice_total, credit_total, payment_total
from invoices
where invoice_id = 112;

-- To get Error where invoice total matches item total uncomment line below
-- update invoices set invoice_total = 100 where invoice_id = 1;

-- 2

use ap;
-- not creating table causes error
create table invoices_audit
(
	vendor_id		int				not null,
	invoice_number	varchar(50)		not null,
	invoice_total	decimal(9,2)	not null,
	action_type		varchar(50)		not null,
	action_date		datetime		not null
);

drop trigger if exists invoices_after_update;
delimiter //
create trigger invoices_after_update
	after update on invoices
	for each row
begin
	insert into invoices_audit values
	(old.vendor_id, old.invoice_number, old.invoice_total, 'updated', now());
end //
delimiter ;

-- testing 
update invoices
set payment_total = 50
where invoice_id = 7;
select * from invoices_audit