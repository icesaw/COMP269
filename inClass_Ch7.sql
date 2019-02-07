-- Alexey Milovanov
-- inClass Lab ch7
-- 10.15.18

-- ex. 1
select vendor_name
from vendors
where vendor_id in (select distinct vendor_id 
                    from invoices)
order by vendor_name;

-- ex. 2
select invoice_number, invoice_total
from invoices
where payment_total > (select avg(payment_total) 
						from invoices where payment_total > 0)
order by invoice_total desc;

-- ex. 3
select account_number, account_description
from general_ledger_accounts gla
where not exists (select * from invoice_line_items 
                    where account_number = gla.account_number)
order by account_number;

-- ex. 4
select vendor_name, i.invoice_id, invoice_sequence, line_item_amount
from vendors v
join invoices i on v.vendor_id = i.vendor_id
join invoice_line_items ili on i.invoice_id = ili.invoice_id
where i.invoice_id in (select distinct invoice_id 
						from invoice_line_items 
                        where invoice_sequence > 1)
order by vendor_name, i.invoice_id, invoice_sequence;

-- ex. 5
# returns 7 rows - 1 part
 select vendor_id, max(invoice_total) as invoice_max  
 from invoices where invoice_total - credit_total - payment_total > 0 
 group by vendor_id; 


# retuns 1 row - 2 part - final
select sum(invoice_max) as sum_max_unpaid
from (select vendor_id, max(invoice_total) as invoice_max  
		from invoices 
        where invoice_total - credit_total - payment_total > 0 
		group by vendor_id) 
a; -- alias
      
-- ex. 6
select vendor_name, vendor_city, vendor_state
from vendors
where concat(vendor_state, vendor_city) not in (select concat(vendor_state, vendor_city) as vendor_city_state 
												from vendors 
                                                group by vendor_city_state 
                                                having count(*) > 1)
order by vendor_state, vendor_city;

-- ex. 7
select vendor_name, invoice_number, invoice_date, invoice_total
from invoices i 
join vendors v on i.vendor_id = v.vendor_id
where invoice_date = (select min(invoice_date)
						from invoices
                        where vendor_id = i.vendor_id)
order by vendor_name;