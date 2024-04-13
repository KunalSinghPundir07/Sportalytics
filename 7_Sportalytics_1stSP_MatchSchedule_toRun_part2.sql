SET SERVEROUTPUT ON;
--Script to run the 1st created stored procedure
DECLARE
    v_cursor SYS_REFCURSOR;
    v_scheduleID MATCHSCHEDULES.Schedule_ID%TYPE;
    v_city MATCHSCHEDULES.City%TYPE;
    v_country MATCHSCHEDULES.Country%TYPE;
    v_stadiumName MATCHSCHEDULES.Stadium_Name%TYPE;
    v_matchDate MATCHSCHEDULES.MatchDateTime%TYPE;
    v_teamID MATCHSCHEDULES.Team_ID%TYPE;
BEGIN
    -- Call the stored procedure
    get_MATCH_SCHEDULES(
        p_start_date => TO_DATE('01-04-24', 'DD-MM-YY'),
        p_end_date => TO_DATE('01-09-24', 'DD-MM-YY'),
        p_cursor => v_cursor
    );
    
    -- Fetch the results
    LOOP
        BEGIN
            FETCH v_cursor INTO v_scheduleID, v_city, v_country, v_stadiumName, v_matchDate, v_teamID;
            EXIT WHEN v_cursor%NOTFOUND;
            
            DBMS_OUTPUT.PUT_LINE('Schedule ID: ' || v_scheduleID || ', City: ' || v_city ||
                                 ', Country: ' || v_country || ', Stadium: ' || v_stadiumName ||
                                 ', Match Date: ' || v_matchDate || ', Team ID: ' || v_teamID);
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                DBMS_OUTPUT.PUT_LINE('No data found in cursor.');
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('Invalid, Try Again' );
        END;
    END LOOP;
    
    -- Close the cursor
    CLOSE v_cursor;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Invalid, Try Again' );
END;




