--procedure to update already existing data
CREATE OR REPLACE PROCEDURE UPDATE_MANAGER (
    M_MANAGER_NAME IN VARCHAR2,
    M_MANAGER_DATEOFBIRTH IN DATE,
    M_NEW_NATIONALITY IN VARCHAR2,
    M_NEW_EXPERIENCEYEARS IN NUMBER,
    M_NEW_MANAGERSALARY IN NUMBER
) AS
BEGIN
-- Validate input data for Nationality
    IF M_NEW_NATIONALITY IS NOT NULL AND NOT REGEXP_LIKE(M_NEW_NATIONALITY, '^^[A-Za-z ]+$') THEN
        DBMS_OUTPUT.PUT_LINE('Invalid input for nationality. Please enter a valid value containing only alphabetic characters and spaces.');
        RETURN;
    END IF;

    UPDATE ADMIN.MANAGERS
    SET
        MANAGER_DATEOFBIRTH = COALESCE(M_MANAGER_DATEOFBIRTH, MANAGER_DATEOFBIRTH),
        NATIONALITY = COALESCE(M_NEW_NATIONALITY, NATIONALITY),
        EXPERIENCEYEARS = COALESCE(M_NEW_EXPERIENCEYEARS, EXPERIENCEYEARS),
        MANAGERSALARY = COALESCE(M_NEW_MANAGERSALARY, MANAGERSALARY)
    WHERE UPPER(MANAGER_NAME) = UPPER(M_MANAGER_NAME);
    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No such entry present to update');
        -- You can also optionally raise an application-specific error here
    ELSE
        DBMS_OUTPUT.PUT_LINE('Rows updated: ' || SQL%ROWCOUNT);
    END IF;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('No such entry present to update');
        -- Optionally, you might want to rollback or log the error
        ROLLBACK;
        RAISE;
END UPDATE_MANAGER;
/
-----------------------------------------------------------------------------------------------------------------------------------
--procedure to delete a manger using name
CREATE OR REPLACE PROCEDURE DELETE_MANAGER (
    M_MANAGER_NAME IN VARCHAR2
) AS
BEGIN
    -- Delete records matching the provided name
    DELETE FROM ADMIN.MANAGERS
    WHERE UPPER(MANAGER_NAME) = UPPER(M_MANAGER_NAME);
    DBMS_OUTPUT.PUT_LINE('Rows deleted: ' || SQL%ROWCOUNT);
    
    -- Note: You might choose to handle transactions outside the procedure
    -- based on your application's transaction management policy
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('No such Manager to delete');
        ROLLBACK;
        RAISE;
END DELETE_MANAGER;
/
---------------------------------------------------------------------------------------------------------------------------------
DECLARE
  v_max_id NUMBER;
BEGIN
  -- To find out the current maximum ID in the MANAGERS table
  SELECT COALESCE(MAX(MANAGER_ID), 0) INTO v_max_id FROM ADMIN.Managers;

  -- If there are no rows in the table, start with 1, otherwise start with max ID + 1
  v_max_id := v_max_id + 1;

  -- Drop the sequence if it already exists
  EXECUTE IMMEDIATE 'BEGIN EXECUTE IMMEDIATE ''DROP SEQUENCE manager_id_seq''; EXCEPTION WHEN OTHERS THEN IF SQLCODE != -2289 THEN RAISE; END IF; END;';

  -- Create a sequence starting with the next ID
  EXECUTE IMMEDIATE 'CREATE SEQUENCE manager_id_seq
                     START WITH ' || v_max_id || '
                     INCREMENT BY 1
                     NOCACHE
                     NOCYCLE';
END;
/
-------------------------------------------------------------------------------------------------------------------------------------------------
--procedure to insert data into managers table
CREATE OR REPLACE PROCEDURE INSERT_MANAGER (
    M_MANAGER_NAME IN VARCHAR2,
    M_MANAGER_DATEOFBIRTH IN DATE,
    M_NATIONALITY IN VARCHAR2,
    M_EXPERIENCEYEARS IN NUMBER,
    M_MANAGERSALARY IN NUMBER
) AS
  v_manager_id NUMBER;
  v_count NUMBER;
  
BEGIN
DBMS_OUTPUT.PUT_LINE('Starting procedure...');
  -- Input validation for Manager Name
  IF M_MANAGER_NAME IS NULL OR TRIM(M_MANAGER_NAME) IS NULL THEN
    DBMS_OUTPUT.PUT_LINE('Validation Fail: Name cannot be null or empty.');
    ROLLBACK;
    RETURN;
  ELSIF NOT REGEXP_LIKE(M_MANAGER_NAME, '^[A-Za-z ]+$') THEN
    DBMS_OUTPUT.PUT_LINE('Validation Fail: Invalid input for name. Please enter a valid value containing only alphabetic characters and spaces.');
    ROLLBACK;
    RETURN;
  END IF;

  -- Input validation for Nationality
  IF M_NATIONALITY IS NOT NULL THEN
    IF NOT REGEXP_LIKE(M_NATIONALITY, '^[A-Za-z ]+$') THEN
      DBMS_OUTPUT.PUT_LINE('Validation Fail: Invalid input for nationality. Please enter a valid value containing only alphabetic characters and spaces.');
      ROLLBACK;
      RETURN;
    END IF;
  END IF;

  -- Checking for existing manager
  SELECT COUNT(*) INTO v_count FROM ADMIN.MANAGERS
  WHERE UPPER(TRIM(MANAGER_NAME)) = UPPER(TRIM(M_MANAGER_NAME));
  IF v_count > 0 THEN
    DBMS_OUTPUT.PUT_LINE('Validation Fail: A manager with the name "' || M_MANAGER_NAME || '" already exists.');
    ROLLBACK;
  END IF;

  -- Sequence for new manager ID
  SELECT manager_id_seq.NEXTVAL INTO v_manager_id FROM DUAL;

  -- Inserting the new manager
  INSERT INTO ADMIN.MANAGERS (
    MANAGER_ID,
    MANAGER_NAME, 
    MANAGER_DATEOFBIRTH, 
    NATIONALITY, 
    EXPERIENCEYEARS, 
    MANAGERSALARY
  ) VALUES (
    V_MANAGER_ID,
    M_MANAGER_NAME,
    M_MANAGER_DATEOFBIRTH,
    M_NATIONALITY,
    M_EXPERIENCEYEARS,
    M_MANAGERSALARY
  );

  -- Commit after successful insertion
  COMMIT;
  DBMS_OUTPUT.PUT_LINE('Insertion Success: Manager successfully inserted.');

EXCEPTION
  WHEN VALUE_ERROR THEN
    DBMS_OUTPUT.PUT_LINE('Exception: Invalid data type encountered for one of the fields.');
    ROLLBACK;
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Exception: An unexpected error occurred');
    ROLLBACK;
    RAISE;
END INSERT_MANAGER;
/
-------------------------------------------------------------------------------------------------------------------------------------------------
--calling insert_manager to insert data
BEGIN
    INSERT_MANAGER('Gowri M G',TO_DATE('29-DEC-1999', 'DD-MON-YYYY'),'Nationality',10,50000);
END;
--calling update_manager to update an entry
BEGIN
    UPDATE_MANAGER('Gowri M G',TO_DATE('28-DEC-1999', 'DD-MON-YYYY'),'Indian',20,10000);
END;
--calling delete_manager to delete an entry
BEGIN
    DELETE_MANAGER('Gowri M G');
END;