-- Error Handling for Creation of Users
DECLARE

    v_user_count NUMBER;


BEGIN

    -- Granting permissions for Creation of user Players

    SELECT COUNT(*)

    INTO v_user_count

    FROM dba_users

    WHERE username = 'PLAYERS';

    IF v_user_count = 0 THEN

        -- Creation of the user

        EXECUTE IMMEDIATE 'CREATE USER Players IDENTIFIED BY SportalyticsP2024#';

        EXECUTE IMMEDIATE 'GRANT CONNECT, RESOURCE TO Players';

    END IF;

     -- Granting permissions for Creation of user Managers

    SELECT COUNT(*)

    INTO v_user_count

    FROM dba_users

    WHERE username = 'MANAGERS';

    IF v_user_count = 0 THEN

        -- Creation of the user

        EXECUTE IMMEDIATE 'CREATE USER Managers IDENTIFIED BY SportalyticsM2024#';

        EXECUTE IMMEDIATE 'GRANT CONNECT, RESOURCE TO Managers';

    END IF;

     -- Granting permissions for Creation of user Coaches

    SELECT COUNT(*)

    INTO v_user_count

    FROM dba_users

    WHERE username = 'COACHES';

    IF v_user_count = 0 THEN

        -- Creation of the user

        EXECUTE IMMEDIATE 'CREATE USER Coaches IDENTIFIED BY SportalyticsC2024#';

        EXECUTE IMMEDIATE 'GRANT CONNECT, RESOURCE TO Coaches';

    END IF;

  -- Granting permissions for Creation of user MedicalStaffs

    SELECT COUNT(*)

    INTO v_user_count

    FROM dba_users

    WHERE username = 'MEDICALSTAFFS';

    IF v_user_count = 0 THEN

        -- Creation of the user

        EXECUTE IMMEDIATE 'CREATE USER MedicalStaffs IDENTIFIED BY SportalyticsMS2024#';

        EXECUTE IMMEDIATE 'GRANT CONNECT, RESOURCE TO MedicalStaffs';

    END IF;

    DBMS_OUTPUT.PUT_LINE('Users created/modified successfully.');

EXCEPTION

    WHEN OTHERS THEN

        -- Error Handling

        DBMS_OUTPUT.PUT_LINE('User already exists');

END;

/