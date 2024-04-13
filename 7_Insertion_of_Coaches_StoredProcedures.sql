-- Coaches Store Procedure - Insertion,Updation and Deletion

--*********************************************************************************************************************************************************--
--*********************************************************************************************************************************************************--


--To create a sequence by finding the current max value of id, and addigning the id 

DECLARE
  v_max_id NUMBER;
BEGIN
  -- To find out the current maximum ID in the MANAGERS table
  SELECT COALESCE(MAX(Coach_ID), 0) INTO v_max_id FROM admin.COACHES;

  -- If there are no rows in the table, start with 1, otherwise start with max ID + 1
  v_max_id := v_max_id + 1;

  -- Drop the sequence if it already exists
  EXECUTE IMMEDIATE 'BEGIN EXECUTE IMMEDIATE ''DROP SEQUENCE coach_id_seq''; EXCEPTION WHEN OTHERS THEN IF SQLCODE != -2289 THEN RAISE; END IF; END;';

  -- Create a sequence starting with the next ID
  EXECUTE IMMEDIATE 'CREATE SEQUENCE coach_id_seq
                     START WITH ' || v_max_id || '
                     INCREMENT BY 1
                     NOCACHE
                     NOCYCLE';
END;
/


-------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE INSERT_COACH (
    C_COACH_NAME IN VARCHAR2,
    C_COACHES_DATEOFBIRTH IN DATE,
    C_COACH_NATIONALITY IN VARCHAR2,
    C_COACH_YEARSOFEXPERIENCE IN NUMBER,
    C_SPECIALIZATION IN VARCHAR2,
    C_COACHSALARY IN NUMBER
) AS
  v_max_id NUMBER;
BEGIN
  -- Validate coach name
  IF NOT REGEXP_LIKE(C_COACH_NAME, '^[A-Z][a-zA-Z ]*$') THEN
    RAISE_APPLICATION_ERROR(-20001, 'Invalid input for coach name. Please enter only letters and spaces.');
  END IF;

  -- Validate coach nationality
  IF NOT REGEXP_LIKE(C_COACH_NATIONALITY, '^[A-Z][a-zA-Z ]*$') THEN
    RAISE_APPLICATION_ERROR(-20002, 'Invalid input for coach nationality. Please enter only letters and spaces.');
  END IF;

  -- Validate specialization
  IF NOT REGEXP_LIKE(C_SPECIALIZATION, '^[A-Z][a-zA-Z ]*$') THEN
    RAISE_APPLICATION_ERROR(-20003, 'Invalid input for specialization. Please enter only letters and spaces.');
  END IF;

  -- Validate years of experience (positive integer, 0 <= experience <= 50)
  IF NOT REGEXP_LIKE(TO_CHAR(C_COACH_YEARSOFEXPERIENCE), '^\d+$') OR C_COACH_YEARSOFEXPERIENCE < 0 OR C_COACH_YEARSOFEXPERIENCE > 50 THEN
    RAISE_APPLICATION_ERROR(-20005, 'Years of experience should be a positive integer between 0 and 50.');
  END IF;

  -- Validate coach salary (positive integer)
  IF C_COACHSALARY <= 0 THEN
    RAISE_APPLICATION_ERROR(-20006, 'Coach salary should be a positive integer.');
  END IF;

  -- Get next value from sequence
  SELECT coach_id_seq.NEXTVAL INTO v_max_id FROM DUAL;

  -- Insert new coach with unique ID
  INSERT INTO ADMIN.COACHES (
    COACH_ID,
    COACH_NAME,
    COACHES_DATEOFBIRTH,
    COACH_NATIONALITY,
    COACH_YEARSOFEXPERIENCE,
    SPECIALIZATION,
    COACHSALARY
  ) VALUES (
    V_MAX_ID,
    C_COACH_NAME,
    C_COACHES_DATEOFBIRTH,
    C_COACH_NATIONALITY,
    C_COACH_YEARSOFEXPERIENCE,
    C_SPECIALIZATION,
    C_COACHSALARY
  );

  -- Commit is optional and should be used according to your transaction management policy
  COMMIT;
  DBMS_OUTPUT.PUT_LINE('Data inserted successfully.');

EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    RAISE_APPLICATION_ERROR(-20007, 'Error: The data already exists.');
  WHEN VALUE_ERROR THEN
    DBMS_OUTPUT.PUT_LINE('Invalid input type. Please enter the correct data type.');
  WHEN OTHERS THEN
    IF SQLCODE = -20001 THEN
      NULL; -- Do nothing for the specific error handled by the trigger
    ELSIF SQLCODE = -20002 THEN
      NULL; -- Do nothing for the specific error handled by the trigger
    ELSIF SQLCODE = -20003 THEN
      DBMS_OUTPUT.PUT_LINE('Invalid input for specialization. Please enter only letters and spaces.');
    ELSIF SQLCODE = -20005 THEN
      DBMS_OUTPUT.PUT_LINE('Years of experience should be a positive integer between 0 and 50.');
    ELSIF SQLCODE = -20006 THEN
      DBMS_OUTPUT.PUT_LINE('Coach salary should be a positive integer.');
    ELSE
      DBMS_OUTPUT.PUT_LINE('Invalid input, please try again.');
    END IF;
END INSERT_COACH;
/



--*********************************************************************************************************************************************************--
--*********************************************************************************************************************************************************--

--Trigger


CREATE OR REPLACE TRIGGER check_null_values
BEFORE INSERT ON ADMIN.COACHES
FOR EACH ROW
BEGIN
  IF (:NEW.COACH_NATIONALITY IS NULL OR :NEW.COACH_YEARSOFEXPERIENCE IS NULL OR :NEW.SPECIALIZATION IS NULL OR :NEW.COACHSALARY IS NULL) AND
     (:NEW.COACH_NAME IS NOT NULL AND :NEW.COACHES_DATEOFBIRTH IS NOT NULL) THEN
    DBMS_OUTPUT.PUT_LINE('Error: Please enter a value for all fields except COACH_ID.');
    RAISE_APPLICATION_ERROR(-20001, 'Error: Please enter a value for all fields except COACH_ID.');
  END IF;
  
  IF :NEW.COACH_NAME IS NULL OR :NEW.COACHES_DATEOFBIRTH IS NULL THEN
    DBMS_OUTPUT.PUT_LINE('Error: Name and Date of Birth cannot be NULL.');
    RAISE_APPLICATION_ERROR(-20002, 'Error: Name and Date of Birth cannot be NULL.');
  END IF;
END;
/

-- Trying to give Null for the name[Working of trigger]
BEGIN
  INSERT_COACH(NULL, TO_DATE('1980-05-15', 'YYYY-MM-DD'), 'American', 06, 'Basketball', 70000);
END;
/

--Trying to give Null for other values[Working of trigger]
BEGIN
  INSERT_COACH('Mia Swan', TO_DATE('1980-05-15', 'YYYY-MM-DD'), 'American', NULL, 'Basketball', 70000);
END;
/
--*********************************************************************************************************************************************************--
--*********************************************************************************************************************************************************--


--Inserting the data to check if the stored procedure is working or no

BEGIN
    INSERT_COACH('Bia ',TO_DATE('09-DEC-1995', 'DD-MON-YYYY'),'Indian',05,'Boxing',50000);
END;

--Inserting the same value again

BEGIN
  INSERT_COACH('John Smith', TO_DATE('1980-05-15', 'YYYY-MM-DD'), 'American', 12, 'Basketball', 70000);
END;
/


-- Trying to give Null for the values
BEGIN
  INSERT_COACH('Tony Stark', TO_DATE('1980-05-15', 'YYYY-MM-DD'), 'American', NULL, 'Basketball', 70000);
END;
/

--Inserting the data to check if the stored procedure is working or no

BEGIN
    INSERT_COACH('Hiiiiii ',TO_DATE('09-DEC-1995', 'DD-MON-YYYY'),'Indian',05,'Boxing',50000);
END;


-------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------

--To check for other cases 

 SET SERVEROUTPUT ON;

-- Insert statement with coach name not matching the pattern
BEGIN
    INSERT_COACH('123john', TO_DATE('09-DEC-1995', 'DD-MON-YYYY'), 'Indian', 5, 'Boxing', 50000);
END;

-- Insert statement with coach nationality not matching the pattern
BEGIN
    INSERT_COACH('Khushi', TO_DATE('09-DEC-1995', 'DD-MON-YYYY'), 'indian', 5, 'Boxing', 50000);
END;

-- Insert statement with specialization not matching the pattern
BEGIN
    INSERT_COACH('Khushi', TO_DATE('09-DEC-1995', 'DD-MON-YYYY'), 'Indian', 5, 'boxing', 50000);
END;


--Insert statement with negative years of experience:
BEGIN
    INSERT_COACH('Alice', TO_DATE('09-DEC-1995', 'DD-MON-YYYY'), 'American', -5, 'Football', 60000);
END;

--Insert statement with negative coach salary:
BEGIN
    INSERT_COACH('Michael', TO_DATE('09-DEC-1995', 'DD-MON-YYYY'), 'British', 15, 'Swimming', -70000);
END;

-------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Insert statement to check if the stored procedure is working
BEGIN
    INSERT_COACH('John', TO_DATE('09-DEC-1995', 'DD-MON-YYYY'), 'Indian', 5, 'Boxing', 50000);
END;

-- Insert statement to test inserting the same value again
BEGIN
    INSERT_COACH('John', TO_DATE('09-DEC-1995', 'DD-MON-YYYY'), 'Indian', 5, 'Boxing', 50000);
END;

-- Insert statement to test giving NULL for the name (working of trigger)
BEGIN
    INSERT_COACH(NULL, TO_DATE('09-DEC-1995', 'DD-MON-YYYY'), 'Indian', 5, 'Boxing', 50000);
END;

-- Insert statement to test giving NULL for other values (working of trigger)
BEGIN
    INSERT_COACH('Alice', NULL, 'Indian', 5, 'Boxing', 50000);
END;
