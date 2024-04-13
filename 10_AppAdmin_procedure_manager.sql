--procedure to update already existing data
CREATE OR REPLACE PROCEDURE UPDATE_MANAGER (
    M_MANAGER_NAME IN VARCHAR2,
    M_MANAGER_DATEOFBIRTH IN VARCHAR2,
    M_NEW_NATIONALITY IN VARCHAR2,
    M_NEW_EXPERIENCEYEARS IN VARCHAR2,
    M_NEW_MANAGERSALARY IN VARCHAR2
) AS
    v_date_of_birth DATE;
    v_experience_years NUMBER; 
    v_count NUMBER;
    v_manager_salary NUMBER;

BEGIN
-- Validate input data for DOB
 IF M_MANAGER_DATEOFBIRTH IS NULL THEN
        DBMS_OUTPUT.PUT_LINE('Error: Date of birth cannot be null.');
        RETURN;
    END IF;
    
 BEGIN
  v_date_of_birth := TO_DATE(M_MANAGER_DATEOFBIRTH, 'DD-MON-YYYY');
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Error: Invalid date format. Please use DD-MON-YYYY format.');
      RETURN;
  END;
  
--  Validation for name
    IF M_MANAGER_NAME IS NULL OR TRIM(M_MANAGER_NAME) IS NULL THEN
    DBMS_OUTPUT.PUT_LINE('Validation Fail: Name cannot be null or empty.');
        ROLLBACK;
        RETURN;
--     Validate for nationality   
    ELSIF M_NEW_NATIONALITY IS NOT NULL AND NOT REGEXP_LIKE(M_NEW_NATIONALITY, '^^[A-Za-z ]+$') THEN
        DBMS_OUTPUT.PUT_LINE('Invalid input for nationality. Please enter a valid value containing only alphabetic characters and spaces.');
        RETURN;
    END IF;
    
    SELECT COUNT(*) INTO v_count FROM ADMIN.MANAGERS
    WHERE UPPER(TRIM(MANAGER_NAME)) = UPPER(TRIM(M_MANAGER_NAME))
      AND MANAGER_DATEOFBIRTH = v_date_of_birth;

    IF v_count > 0 THEN
        DBMS_OUTPUT.PUT_LINE('No update required: A manager with the same details already exists.');
        RETURN;
    END IF;
    
    --Input validation for M_EXPERIENCEYEARS
    IF M_NEW_EXPERIENCEYEARS is not null then
    IF NOT REGEXP_LIKE(M_NEW_EXPERIENCEYEARS, '^\d+$') THEN
      DBMS_OUTPUT.PUT_LINE('Validation Fail: Invalid input for experienceyears. Please enter only numbers.');
      ROLLBACK;
    RETURN;
    ELSE
            v_experience_years := TO_NUMBER(M_NEW_EXPERIENCEYEARS);
  END IF;
  end if;

--Input validation for M_MANAGERSALARY
    IF M_NEW_MANAGERSALARY is not null then
    IF NOT REGEXP_LIKE(M_NEW_MANAGERSALARY, '^\d+$') THEN
      DBMS_OUTPUT.PUT_LINE('Validation Fail: Invalid input for experienceyears. Please enter only numbers.');
      ROLLBACK;
    RETURN;
    ELSE
            v_manager_salary := TO_NUMBER(M_NEW_MANAGERSALARY);
        END IF;
  END IF;

    UPDATE ADMIN.MANAGERS
    SET
        MANAGER_DATEOFBIRTH = COALESCE(v_date_of_birth, MANAGER_DATEOFBIRTH),
        NATIONALITY = COALESCE(M_NEW_NATIONALITY, NATIONALITY),
        EXPERIENCEYEARS = COALESCE(v_experience_years, EXPERIENCEYEARS),
        MANAGERSALARY = COALESCE(v_manager_salary, MANAGERSALARY)
    WHERE UPPER(MANAGER_NAME) = UPPER(M_MANAGER_NAME);
    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No such entry present to update');
        -- You can also optionally raise an application-specific error here
    ELSE
        DBMS_OUTPUT.PUT_LINE('Rows updated: ' || SQL%ROWCOUNT);
    END IF;
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Updation Success: Manager successfully updated.');
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
    M_MANAGER_NAME IN VARCHAR2,
    M_MANAGER_DATEOFBIRTH IN VARCHAR2
) AS
v_date_of_birth DATE;
BEGIN
    
 BEGIN
     v_date_of_birth := TO_DATE(M_MANAGER_DATEOFBIRTH, 'DD-MON-YYYY');
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Error: Invalid date format. Please use DD-MON-YYYY format.');
      RETURN;
  END;
    -- Delete records matching the provided name
    IF M_MANAGER_NAME IS NULL OR TRIM(M_MANAGER_NAME)IS NULL THEN
    DBMS_OUTPUT.PUT_LINE('Validation Fail: Name cannot be null or empty.');
        ROLLBACK;
        RETURN;
    ELSIF M_MANAGER_NAME IS NOT NULL AND NOT REGEXP_LIKE(M_MANAGER_NAME, '^[A-Za-z ]+$') THEN
        DBMS_OUTPUT.PUT_LINE('Invalid input for name. Please enter a valid value containing only alphabetic characters and spaces.');
        RETURN;
    END IF;
  
    DELETE FROM ADMIN.MANAGERS
    WHERE UPPER(MANAGER_NAME) = UPPER(M_MANAGER_NAME) AND MANAGER_DATEOFBIRTH = v_date_of_birth;
    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No such entry present to delete');
        -- You can also optionally raise an application-specific error here
    ELSE
        DBMS_OUTPUT.PUT_LINE('Rows updated: ' || SQL%ROWCOUNT);
    END IF;
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
    M_MANAGER_DATEOFBIRTH IN VARCHAR2,
    M_NATIONALITY IN VARCHAR2,
    M_EXPERIENCEYEARS IN VARCHAR2,
    M_MANAGERSALARY IN VARCHAR2
) AS
  v_manager_id NUMBER;
  v_count NUMBER;
  v_date_of_birth DATE;
BEGIN
DBMS_OUTPUT.PUT_LINE('Starting procedure...');
  -- Input validation for Manager dateofbirth
   IF M_MANAGER_DATEOFBIRTH IS NULL THEN
        DBMS_OUTPUT.PUT_LINE('Error: Date of birth cannot be null.');
        RETURN;
    END IF;
  BEGIN
  v_date_of_birth := TO_DATE(M_MANAGER_DATEOFBIRTH, 'DD-MON-YYYY');
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Error: Invalid date format. Please use DD-MON-YYYY format.');
      RETURN;
  END;
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

--Input validation for M_EXPERIENCEYEARS
    IF M_EXPERIENCEYEARS is not null then
    IF NOT REGEXP_LIKE(M_EXPERIENCEYEARS, '^\d+$') THEN
      DBMS_OUTPUT.PUT_LINE('Validation Fail: Invalid input for experienceyears. Please enter only numbers.');
      ROLLBACK;
    RETURN;
  END IF;
  end if;

--Input validation for M_MANAGERSALARY
    IF M_MANAGERSALARY is not null then
    IF NOT REGEXP_LIKE(M_MANAGERSALARY, '^\d+$') THEN
      DBMS_OUTPUT.PUT_LINE('Validation Fail: Invalid input for experienceyears. Please enter only numbers.');
      ROLLBACK;
    RETURN;
  END IF;
  end if;

  -- Checking for existing manager
  SELECT COUNT(*) INTO v_count FROM ADMIN.MANAGERS
  WHERE UPPER(TRIM(MANAGER_NAME)) = UPPER(TRIM(M_MANAGER_NAME))AND MANAGER_DATEOFBIRTH = v_date_of_birth;
  IF v_count > 0 THEN
    DBMS_OUTPUT.PUT_LINE('Validation Fail: A manager with the name "' || M_MANAGER_NAME || '" already exists.');
    ROLLBACK;
    RETURN;
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
--calling insert_manager to insert data (Happy paths)
BEGIN
    INSERT_MANAGER('Gowri M G',TO_DATE('29-DEC-1999', 'DD-MON-YYYY'),'Nationality',10,50000);
END;
--calling update_manager to update an entry
BEGIN
    UPDATE_MANAGER('Gowri M G',TO_DATE('28-DEC-1999', 'DD-MON-YYYY'),'Indian',20,10000);
END;
--calling delete_manager to delete an entry
BEGIN
    DELETE_MANAGER('Gowri M G',TO_DATE('28-DEC-1999', 'DD-MON-YYYY'));
END;
-------------------------------------------------------------------------------------------------------------------------------------------------
--test cases for insertion
--inserting null for manger_name
BEGIN
    INSERT_MANAGER('',TO_DATE('29-DEC-1999', 'DD-MON-YYYY'),'Nationality',10,50000);
END;
--inserting special characters to the name
BEGIN
    INSERT_MANAGER('Gowri M G#',TO_DATE('29-DEC-1999', 'DD-MON-YYYY'),'Nationality',10,50000);
END;
--inserting number for name
BEGIN
    INSERT_MANAGER('9',TO_DATE('29-DEC-1999', 'DD-MON-YYYY'),'Nationality',10,50000);
END;
--inserting null for date (insertion of null is allowed for date)
BEGIN
    INSERT_MANAGER('Gowri M G','','Nationality',10,50000);
END; 
--inserting special characters for date (Failing)
BEGIN
    INSERT_MANAGER('Gowri M G',$#,'Nationality',10,50000);
END;
--inserting special characters to nationality
BEGIN
    INSERT_MANAGER('Gowri M',TO_DATE('29-DEC-1999', 'DD-MON-YYYY'),'$$$',10,50000);
END;
--inserting null to nationality(null is allowed)
BEGIN
    INSERT_MANAGER('Gowri M G',TO_DATE('29-DEC-1999', 'DD-MON-YYYY'),'',10,50000);
END;
--inserting special characters into yersofexperience
BEGIN
    INSERT_MANAGER('Gowri',TO_DATE('29-DEC-1999', 'DD-MON-YYYY'),'Nationality','$',50000);
END;
--inserting null into all the fields except for name(insertion should be allowed)
BEGIN
    INSERT_MANAGER('','','','','');
END;
--inserting string into date
BEGIN
    INSERT_MANAGER('Abbel','Hi','Nationality',10,50000);   
END;
--insert two same name dat wih different date of birth
BEGIN
    INSERT_MANAGER('Apple',TO_DATE('29-DEC-1999', 'DD-MON-YYYY'),'Indian',10,50000);   
    INSERT_MANAGER('Apple',TO_DATE('28-DEC-1999', 'DD-MON-YYYY'),'Indian',10,50000); 
END;
BEGIN
    INSERT_MANAGER('Alexa','29-DEC-1999','Indian',10,50000);   
    INSERT_MANAGER('Alexa','29-DEC-1999','Indian',10,50000); 
END;
BEGIN
    INSERT_MANAGER('Alexa','29-DEC-1999','Indian',10,50000);    
END;
--------------------------------------------------------------------------------------------------------------------------------------------
--deletion by passing null value
BEGIN
    DELETE_MANAGER('','');
END;
--deletion by entering a string
BEGIN
    DELETE_MANAGER('*#$','');
END;
--deletion by numbers
BEGIN
    DELETE_MANAGER('Alexa','02-FEB-1999');
END;
--------------------------------------------------------------------------------------------------------------------------------------------
--updating by not passing name
BEGIN
    UPDATE_MANAGER('',TO_DATE('28-DEC-1999', 'DD-MON-YYYY'),'Indian',20,10000);
END;
--updating by giving wrong date 
BEGIN
    UPDATE_MANAGER('Gowri M G','Hi','Indian',20,10000);
END;
--UPDATING string in experience
BEGIN
    UPDATE_MANAGER('Gowri M G','28-DEC-1999','Indian','Hi',10000);
END;
--UPDATING string in experience
BEGIN
    UPDATE_MANAGER('Gowri M G',TO_DATE('28-DEC-1999', 'DD-MON-YYYY'),'Indian',20,10000);
END;