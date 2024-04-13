CREATE OR REPLACE PROCEDURE UPDATE_COACH (
    C_COACH_ID IN NUMBER,
    C_COACH_NAME IN VARCHAR2,
    C_COACHES_DATEOFBIRTH IN DATE,
    C_COACH_NATIONALITY IN VARCHAR2,
    C_COACH_YEARSOFEXPERIENCE IN NUMBER,
    C_SPECIALIZATION IN VARCHAR2,
    C_COACHSALARY IN NUMBER
) AS
  v_count NUMBER;
BEGIN
  -- Check if coach ID exists
  SELECT COUNT(*) INTO v_count FROM ADMIN.COACHES WHERE COACH_ID = C_COACH_ID;
  IF v_count = 0 THEN
    RAISE_APPLICATION_ERROR(-20010, 'Coach ID does not exist.');
  END IF;

  -- Validate coach name
  IF C_COACH_NAME IS NULL THEN
    RAISE_APPLICATION_ERROR(-20011, 'Cannot enter null value for the name field; enter appropriate data for all attributes.');
  ELSIF C_COACH_NAME <> TRIM(C_COACH_NAME) OR NOT REGEXP_LIKE(C_COACH_NAME, '^[A-Z][a-zA-Z ]*$') THEN
    RAISE_APPLICATION_ERROR(-20011, 'Invalid input for coach name. Please enter only letters and spaces.');
  END IF;

  -- Validate date of birth
  IF C_COACHES_DATEOFBIRTH IS NULL THEN
    RAISE_APPLICATION_ERROR(-20016, 'Cannot enter null value for the date of birth field; enter appropriate data for all attributes.');
  END IF;

  -- Validate coach nationality
  IF C_COACH_NATIONALITY IS NULL THEN
    RAISE_APPLICATION_ERROR(-20012, 'Cannot enter null value for the nationality field; enter appropriate data for all attributes.');
  ELSIF C_COACH_NATIONALITY <> TRIM(C_COACH_NATIONALITY) OR NOT REGEXP_LIKE(C_COACH_NATIONALITY, '^[A-Z][a-zA-Z ]*$') THEN
    RAISE_APPLICATION_ERROR(-20012, 'Invalid input for coach nationality. Please enter only letters and spaces.');
  END IF;

  -- Validate specialization
  IF C_SPECIALIZATION IS NULL THEN
    RAISE_APPLICATION_ERROR(-20013, 'Cannot enter null value for the specialization field; enter appropriate data for all attributes.');
  ELSIF C_SPECIALIZATION <> TRIM(C_SPECIALIZATION) OR NOT REGEXP_LIKE(C_SPECIALIZATION, '^[A-Z][a-zA-Z ]*$') THEN
    RAISE_APPLICATION_ERROR(-20013, 'Invalid input for specialization. Please enter only letters and spaces.');
  END IF;

  -- Validate years of experience (positive integer, 0 <= experience <= 50)
  IF C_COACH_YEARSOFEXPERIENCE IS NULL THEN
    RAISE_APPLICATION_ERROR(-20014, 'Cannot enter null value for the years of experience field; enter appropriate data for all attributes.');
  ELSIF NOT REGEXP_LIKE(TO_CHAR(C_COACH_YEARSOFEXPERIENCE), '^\d+$') OR C_COACH_YEARSOFEXPERIENCE < 0 OR C_COACH_YEARSOFEXPERIENCE > 50 THEN
    RAISE_APPLICATION_ERROR(-20014, 'Years of experience should be a positive integer between 0 and 50.');
  END IF;

  -- Validate coach salary (positive integer)
  IF C_COACHSALARY IS NULL THEN
    RAISE_APPLICATION_ERROR(-20015, 'Cannot enter null value for the coach salary field; enter appropriate data for all attributes.');
  ELSIF C_COACHSALARY <= 0 THEN
    RAISE_APPLICATION_ERROR(-20015, 'Coach salary should be a positive integer.');
  END IF;

  -- Update coach information only if parameters are not null
  UPDATE ADMIN.COACHES
  SET
    COACH_NAME = NVL(C_COACH_NAME, COACH_NAME),
    COACHES_DATEOFBIRTH = NVL(C_COACHES_DATEOFBIRTH, COACHES_DATEOFBIRTH),
    COACH_NATIONALITY = NVL(C_COACH_NATIONALITY, COACH_NATIONALITY),
    COACH_YEARSOFEXPERIENCE = NVL(C_COACH_YEARSOFEXPERIENCE, COACH_YEARSOFEXPERIENCE),
    SPECIALIZATION = NVL(C_SPECIALIZATION, SPECIALIZATION),
    COACHSALARY = NVL(C_COACHSALARY, COACHSALARY)
  WHERE
    COACH_ID = C_COACH_ID;

  -- Commit is optional and should be used according to your transaction management policy
  COMMIT;
  DBMS_OUTPUT.PUT_LINE('Data updated successfully.');

EXCEPTION
  WHEN VALUE_ERROR THEN
    DBMS_OUTPUT.PUT_LINE('Invalid input type. Please enter the correct data type.');
  WHEN OTHERS THEN
    IF SQLCODE = -20010 THEN
      DBMS_OUTPUT.PUT_LINE('Error: Coach ID does not exist.');
    ELSIF SQLCODE = -20011 THEN
      DBMS_OUTPUT.PUT_LINE('Invalid input for coach name. Please enter only letters and spaces.');
    ELSIF SQLCODE = -20012 THEN
      DBMS_OUTPUT.PUT_LINE('Invalid input for coach nationality. Please enter only letters and spaces.');
    ELSIF SQLCODE = -20013 THEN
      DBMS_OUTPUT.PUT_LINE('Invalid input for specialization. Please enter only letters and spaces.');
    ELSIF SQLCODE = -20014 THEN
      DBMS_OUTPUT.PUT_LINE('Years of experience should be a positive integer between 0 and 50.');
    ELSIF SQLCODE = -20015 THEN
      DBMS_OUTPUT.PUT_LINE('Coach salary should be a positive integer.');
    ELSIF SQLCODE = -20016 THEN
      DBMS_OUTPUT.PUT_LINE('Date of birth cannot be NULL. Please provide a valid date of birth.');
    ELSE
      DBMS_OUTPUT.PUT_LINE('Invalid input, please try again.');
    END IF;
END UPDATE_COACH;

--****************************************************--
--****************************************************--



-- Test cases for UPDATE_COACH procedure

-- Update statement with coach ID that does not exist
BEGIN
    UPDATE_COACH(9999, 'John Doe', TO_DATE('1980-05-15', 'YYYY-MM-DD'), 'American', 12, 'Basketball', 70000);
END;

-- Update statement with coach name not matching the pattern
BEGIN
    UPDATE_COACH(1, '123john', TO_DATE('09-DEC-1995', 'DD-MON-YYYY'), 'Indian', 5, 'Boxing', 50000);
END;

-- Update statement with coach nationality not matching the pattern
BEGIN
    UPDATE_COACH(1, 'Khushi', TO_DATE('09-DEC-1995', 'DD-MON-YYYY'), 'indian', 5, 'Boxing', 50000);
END;

-- Update statement with specialization not matching the pattern
BEGIN
    UPDATE_COACH(1, 'Khushi', TO_DATE('09-DEC-1995', 'DD-MON-YYYY'), 'Indian', 5, 'boxing', 50000);
END;

-- Update statement with negative years of experience:
BEGIN
    UPDATE_COACH(1, 'Alice', TO_DATE('09-DEC-1995', 'DD-MON-YYYY'), 'American', -5, 'Football', 60000);
END;

-- Update statement with negative coach salary:
BEGIN
    UPDATE_COACH(1, 'Michael', TO_DATE('09-DEC-1995', 'DD-MON-YYYY'), 'British', 15, 'Swimming', -70000);
END;

-- Update statement to check if the stored procedure is working
BEGIN
    UPDATE_COACH(1, 'John', TO_DATE('09-DEC-1995', 'DD-MON-YYYY'), 'Indian', 5, 'Boxing', 50000);
END;

-- Update statement to test giving NULL for other values (working of trigger)
BEGIN
    UPDATE_COACH(1, 'Alice', NULL, 'Indian', 5, 'Boxing', 50000);
END;

