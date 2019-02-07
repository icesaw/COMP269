-- Alexey Milovanov
-- COMP269
-- inClass Lab Ch6
-- 10/08/18

-- Solution for Exercise 1
SELECT vendor_id, SUM(invoice_total) AS invoice_total_sum
FROM invoices
GROUP BY vendor_id;

-- Solution for Exercise 2
SELECT vendor_name, SUM(payment_total) AS payment_total_sum
FROM vendors v JOIN invoices i
  ON v.vendor_id = i.vendor_id
GROUP BY vendor_name
ORDER BY payment_total_sum DESC;

-- Solution for Exercise 3
SELECT vendor_name, COUNT(*) AS invoice_count,
       SUM(invoice_total) AS invoice_total_sum
FROM vendors v JOIN invoices i
  ON v.vendor_id = i.vendor_id
GROUP BY vendor_name
ORDER BY invoice_count DESC;

-- Solution for Exercise 4
SELECT account_description, COUNT(*) AS line_item_count,
       SUM(line_item_amount) AS line_item_amount_sum
FROM general_ledger_accounts gl 
  JOIN invoice_line_items li
    ON gl.account_number = li.account_number
GROUP BY account_description
HAVING line_item_count > 1
ORDER BY line_item_amount_sum DESC;

-- Solution for Exercise 5
SELECT account_description, COUNT(*) AS line_item_count,
       SUM(line_item_amount) AS line_item_amount_sum
FROM general_ledger_accounts gl 
  JOIN invoice_line_items li
    ON gl.account_number = li.account_number
  JOIN invoices i
    ON li.invoice_id = i.invoice_id
WHERE invoice_date BETWEEN '2014-04-01' AND '2014-06-30'
GROUP BY account_description
HAVING line_item_count > 1
ORDER BY line_item_amount_sum DESC;

-- Solution for Exercise 6
SELECT account_number, SUM(line_item_amount) AS line_item_sum
FROM invoice_line_items
GROUP BY account_number WITH ROLLUP;

-- Solution for Exercise 7
SELECT vendor_name,
       COUNT(DISTINCT li.account_number) AS number_of_gl_accounts
FROM vendors v 
  JOIN invoices i
    ON v.vendor_id = i.vendor_id
  JOIN invoice_line_items li
    ON i.invoice_id = li.invoice_id
GROUP BY vendor_name
HAVING number_of_gl_accounts > 1
ORDER BY vendor_name;