
-- Store Procedure
-- INSERT
CREATE OR REPLACE PROCEDURE SP_INSERT_NEW_CARD_INFO(
    IN cif_id VARCHAR(255)
    , IN cust_name VARCHAR(255)
    , IN card_number VARCHAR(255)
    , IN card_type VARCHAR(255)
    , IN uuid VARCHAR(255)
    , IN created_date TIMESTAMP
    , IN modified_date TIMESTAMP
    , OUT last_id BIGINT
)
    LANGUAGE SQL
    MODIFIES SQL DATA
BEGIN
INSERT INTO
    CARD_INFORMATION(CREATED_DATE, MODIFIED_DATE, CARD_NUMBER, CARD_TYPE, CIF_ID, CUST_NAME, UUID)
VALUES (created_date, modified_date, card_number, card_type, cif_id, cust_name, uuid);
SET last_id = IDENTITY_VAL_LOCAL();
end;

-- SELECT
CREATE OR REPLACE PROCEDURE SP_GET_CARD_INFO_BY_ID ( IN card_id VARCHAR(255) )
    LANGUAGE SQL
	DYNAMIC RESULT SETS 1
    READS SQL DATA
P1: BEGIN
	-- Declare cursor
	DECLARE cursor1 CURSOR WITH RETURN for

SELECT ID, CIF_ID, CUST_NAME, CARD_NUMBER, CARD_TYPE, UUID, CREATED_DATE, MODIFIED_DATE
FROM CARD_INFORMATION
WHERE ID = card_id;

-- Cursor left open for client application
OPEN cursor1;
END P1;

-- SELECT ALL
 CREATE OR REPLACE PROCEDURE SP_GET_ALL_CARD_INFO
    DYNAMIC RESULT SETS 1
    LANGUAGE SQL
    READS SQL DATA
P1: BEGIN
	-- Declare cursor
	DECLARE cursor1 CURSOR WITH RETURN for
SELECT * FROM CARD_INFORMATION ;

-- Cursor left open for client application
OPEN cursor1;

END P1;

-- DELETE
CREATE OR REPLACE PROCEDURE DELETE_CARD_BY_CIFID(IN in_cif_id VARCHAR(255), OUT count_affected_row INT)
     LANGUAGE SQL
     MODIFIES SQL DATA
P1: BEGIN
DELETE FROM CARD_INFORMATION WHERE CIF_ID = in_cif_id;
GET DIAGNOSTICS count_affected_row = ROW_COUNT ;
END P1;

-- UPDATE
CREATE OR REPLACE PROCEDURE UPDATE_CARD(
    IN in_id BIGINT
    , IN in_cust_name VARCHAR(255)
    , IN in_card_number VARCHAR(255)
    , IN in_card_type VARCHAR(255)
    , OUT count_affected_row INT)

    LANGUAGE SQL
    MODIFIES SQL DATA
P1: BEGIN
UPDATE CARD_INFORMATION
SET CUST_NAME = in_cust_name, CARD_NUMBER = in_card_number, CARD_TYPE = in_card_type
WHERE ID = in_id;
GET DIAGNOSTICS count_affected_row = ROW_COUNT ;
END P1;
