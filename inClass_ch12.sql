/*
Milovanov Alexey
inClass_ch12
11/12/18
Instructor: Dr. Yin Bao
*/

-- Solution for Problem 1
create or replace view open_items as
select vendor_name, invoice_number, invoice_total,
  invoice_total - payment_total - credit_total as balance_due
from  vendors join invoices
  on vendors.vendor_id = invoices.vendor_id
where invoice_total - payment_total - credit_total > 0
order by vendor_name;

-- Solution for Problem 2
select * from open_items where balance_due >= 1000
order by balance_due desc;

-- Solution for Problem 3
create or replace view open_items_summary as
select vendor_name, count(*) as open_item_count,
       sum(invoice_total - credit_total - payment_total) as open_item_total
from vendors join invoices on vendors.vendor_id = invoices.vendor_id
where invoice_total - credit_total - payment_total > 0
group by vendor_name
order by open_item_total desc;

-- Solution for Problem 4
select * from open_items_summary limit 5;

-- Solution for Problem 5
create or replace view vendor_address as
select vendor_id, vendor_address1, vendor_address2, vendor_city, vendor_state, vendor_zip_code
from vendors;

-- Solution for Problem 6
/* 

to view row with adress1 first (so we will see how vendor_address1 looks like)

select vendor_id, vendor_address1, vendor_address2
from vendors
where vendor_id = 4
order by vendor_id;
 */

update vendor_address
set vendor_address1 = '1990 Westwood Blvd', vendor_address2 = 'Ste 260'
where vendor_id = 4;
