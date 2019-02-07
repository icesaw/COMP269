-- Alexey Milovanov
-- Comp-269 Final Exam
-- 12.17.18
-- Instructor: Dr. Yin Bao

-- Problem 3

USE ap; 
CREATE OR REPLACE VIEW vendors_invoices_500 AS
	SELECT vendor_name, vendor_state, invoice_id, invoice_date, 
    invoice_total
    FROM vendors v JOIN invoices i
		ON v.vendor_id = i.vendor_id
	WHERE invoice_total > 500; 
SELECT *
FROM vendors_invoices_500
WHERE invoice_date > '2014-07-21';

-- Problem 4
use ap;
DROP PROCEDURE IF EXISTS vendorInsert; 
DELIMITER //
CREATE PROCEDURE vendorInsert(
	vendor_id_param INT,
    vendor_name_param VARCHAR(50)
    )
BEGIN
	DECLARE sql_error INT DEFAULT FALSE;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
		SET sql_error = true;
        
	INSERT INTO vendors VALUES(vendor_id_param,  vendor_name_param, 'Route 520', 
		DEFAULT, 'Lincroft', 'NJ', '07738', NULL, NULL, NULL, 3, 570); 
        
	IF sql_error = FALSE THEN 
    COMMIT; 
    SELECT 'Can commit the transaction.';
    ELSE ROLLBACK; 
    SELECT 'Transaction is rolled back.';
    END IF; 
    
END //

DELIMITER ; 

CALL vendorInsert(124, 'Rocky Mountain');
CALL vendorInsert(125, NULL);
CALL vendorInsert(1, 'New vendor');


-- Problem 5

DROP TRIGGER IF EXISTS invTotalUpdate;

DELIMITER //
CREATE TRIGGER invTotalUpdate
	AFTER INSERT ON invoice_line_items
    FOR EACH ROW
BEGIN
	
    UPDATE invoices
    SET invoice_total = invoice_total + NEW.line_item_amount;
    END//
DELIMITER ; 

-- testing
INSERT INTO invoice_line_items VALUES(78, 150,  200, 1000, 'Apple');