-- Milovanov Alexey
-- comp269
-- MidTerm Exam
-- Turn off 'Safe Updates' in
-- 'Edit - Preferences - SQL Editor' or #8 will be an error.

-- 1
select invoice_number 'Invoice Number', 
		invoice_date 'Date', 
		(invoice_total-payment_total-credit_total) 'Amount Due'
from ap.invoices
	where (invoice_total-payment_total-credit_total) >= 200
	order by (invoice_total-payment_total-credit_total) desc;
    
-- 2
select invoice_id 'Invoice Number', payment_total 'Invoice Amount', invoice_due_date 'Invoice Due'
from ap.invoices
where payment_total > 100 and invoice_due_date < '2014-08-15' 
order by payment_total desc;

-- 3
select concat(vendor_contact_first_name," ", vendor_contact_last_name,", ",vendor_name," , ", "Phone: ", vendor_phone) AS 'Vendor Contact Information'
from ap.vendors
where vendor_state = "PA";

-- 4
select vendor_contact_first_name 'First Name', vendor_contact_last_name 'Last Name', vendor_city 'City'
from ap.vendors
where left(vendor_contact_first_name, 1) = left(vendor_contact_last_name, 1);

-- 5
select vendor_name 'Vendors Name', invoice_number 'Invoice Number'
from ap.vendors 
	natural join invoices
	where vendor_name = "Federal Express Corporation"
	order by invoice_number;

-- 6
INSERT INTO invoices (invoice_id, vendor_id, invoice_number, invoice_date, invoice_total, payment_total, credit_total, terms_id, invoice_due_date, payment_date) 
				VALUE (115,	123,'263253255','2014-08-03', 8544.50, 8544.50,	0.00, 3, '2014-09-03' ,	'2014-09-04');

-- 7 - to run this query you have to turn off 'Safe Updates'
delete 
	from invoices 
    where invoice_number = '263253255';

-- 8
select vendor_name 'Vendors Name', vendor_id 'Vendor Number', vendor_zip_code 'Vendor Zip Code'
from vendors v
where vendor_zip_code in (select vendor_zip_code from vendors where vendor_zip_code = v.vendor_zip_code and vendor_id != v.vendor_id)
order by vendor_zip_code;

-- 9 
select vendor_name 'Vendors Name', i.invoice_number 'Invoice Number', il.line_item_amount 'Item Amount'
from vendors 
	natural join invoices i 
	natural join invoice_line_items il
where vendor_name = "Federal Express Corporation"
order by line_item_amount desc
limit 5;

-- 10
select vendor_name 'Vendors Name', vendor_city 'City'
from vendors
where vendor_id not in (select vendor_id from invoices)
order by vendor_name desc;
    
-- 11
select now() 'Calculated Date', count(distinct vendor_name) 'Number of Vendors with invoices'
from(
	select vendor_name, invoice_number, invoice_total
from vendors v 
	left join invoices i
	on i.vendor_id = v.vendor_id
	where invoice_number is not null)s;
    
-- 12
select vendor_name 'Vendors Name', 
	count(invoice_id) 'Number of invoices'
from vendors natural join invoices
	group by vendor_name
	order by count(invoice_id) desc;
    
-- 13
select invoice_number 'Invoice Number', invoice_date 'Date of Invoice', invoice_total 'Invoice Total'
from invoices
where invoice_total <
	(select avg(invoice_total)
		from invoices)
order by invoice_total desc;

-- 14
select vendor_name 'Vendor Name', max(invoice_total) 'Max Invoice Total', invoice_id 'Invoice Number'
FROM vendors join invoices using(vendor_id)
group by vendor_id
order by invoice_total desc;