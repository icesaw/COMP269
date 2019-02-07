
-- Solution for exercise 6

SELECT vendor_name, vendor_contact_last_name,vendor_contact_first_name
FROM vendors
ORDER BY  vendor_contact_last_name||vendor_contact_first_name;

-- Solution for Exercise 7

SELECT CONCAT(vendor_contact_last_name, ', ', vendor_contact_first_name) AS full_name
FROM vendors
WHERE  SUBSTR(vendor_contact_last_name, 1, 1) IN ('A','B','C','E')
ORDER BY vendor_contact_last_name||vendor_contact_first_name;

-- Solution for Exercise 8

SELECT invoice_due_date AS 'Due Date',
invoice_total AS 'Invoice Total',
invoice_total*0.1 AS '10%',
invoice_total*1.1 AS 'Plus 10%'
FROM invoices
WHERE invoice_total BETWEEN 500 AND 1000
ORDER BY invoice_due_date DESC;

-- Solution for Exercise 9

SELECT invoice_number, invoice_total, 
(payment_total + credit_total) AS payment_credit_total, 
(invoice_total - payment_total - credit_total) AS balance_due
FROM invoices 
WHERE (invoice_total - payment_total - credit_total) >= 500
ORDER BY (invoice_total - payment_total - credit_total) DESC
LIMIT 5;

-- Solution for Exercise 10

SELECT invoice_number, invoice_date, (invoice_total-payment_total-credit_total) AS balance_due, payment_date
FROM invoices
WHERE payment_date IS NULL;

-- Solution for Exercise 11
SELECT current_date as 'currect_date',
DATE_FORMAT(CURRENT_DATE, '%m-%d-%Y') AS 'mm-dd-yyyy';

-- Solution for Exercise 12

SELECT 50000 AS starting_principal, 
	50000*0.065 AS interest, 
	50000+50000*0.065 AS principal_plus_interest
FROM Dual;

