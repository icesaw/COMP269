-- Alexey Milovanov
-- COMP269
-- inClass Lab Ch5
-- 10/01/18

-- Solution for exercise 1
INSERT INTO terms (terms_id, terms_description, terms_due_days) 
VALUES (6, 'Net Due 120 Days', 120); 

-- Solution for exercise 2
UPDATE terms 
SET terms_description = 'Net Due 125 Days', terms_due_days = 125
WHERE terms_id = 6;

-- Solution for exercise 3
DELETE FROM terms
WHERE terms_id = 6;

-- Solution for exercise 4
INSERT INTO invoices
VALUES (DEFAULT, 32, 'AX-014-027', '2014-08-01', 434.58, 0.00, 0.00, 2, '2014-08-31', NULL);

-- Solution for exercise 5
INSERT INTO invoice_line_items
VALUES (115, 1, 160, 180.23, 'Hard Drive'), (115, 2, 527, 254.35, 'Exchange Server update');
   
-- Solution for exercise 6
UPDATE invoices
SET credit_total = invoice_total * .1, 
	payment_total = invoice_total - credit_total
WHERE invoice_id = 115;

-- Solution for exercise 7
UPDATE vendors
SET default_account_number = 403
WHERE vendor_id = 44;

-- Solution for exercise 8
UPDATE invoices
SET terms_id = 2
WHERE terms_id IN 
	(SELECT vendor_id
     FROM vendors
     WHERE default_terms_id = 2);
     
-- Solution for exercise 9
DELETE FROM invoice_line_items
WHERE invoice_id = 115;
DELETE FROM invoices
WHERE invoice_id = 115;