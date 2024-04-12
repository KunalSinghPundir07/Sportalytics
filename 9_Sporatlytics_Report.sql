--Report to print if the player is eligible for bonus or not
DECLARE
    player_id INT;
    is_eligible NUMBER;
    cursor players_cursor IS SELECT PLAYER_ID FROM PLAYERS;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Player ID | Eligible for Bonus');
    DBMS_OUTPUT.PUT_LINE('--------------------------------');
    -- Loop through all players
    FOR player_record IN players_cursor LOOP
        player_id := player_record.PLAYER_ID;
        -- Check if the player is eligible for bonus
        is_eligible := Checkplayersbonuseligibility(player_id);
        -- Output eligibility status
        IF is_eligible > 0 THEN
            DBMS_OUTPUT.PUT_LINE(player_id || ' | Yes');
        ELSE
            DBMS_OUTPUT.PUT_LINE(player_id || ' | No');
        END IF;
    END LOOP;
END;
/


--Report to print the list of experienced coaches
SET SERVEROUTPUT ON;

DECLARE
    v_coach_id Coaches.COACH_ID%TYPE;
    v_coach_name Coaches.COACH_NAME%TYPE;
    v_years_of_experience Coaches.COACH_YEARSOFEXPERIENCE%TYPE;
    experienced_coaches SYS_REFCURSOR;
BEGIN
    experienced_coaches := GetExperiencedCoaches(5); -- Change the threshold as needed

    -- Print column headers
    DBMS_OUTPUT.PUT_LINE('COACH_ID | COACH_NAME | YEARS_OF_EXPERIENCE');
    DBMS_OUTPUT.PUT_LINE('---------------------------------------');

    -- Fetch and print each row
    LOOP
        FETCH experienced_coaches INTO v_coach_id, v_coach_name, v_years_of_experience;
        EXIT WHEN experienced_coaches%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(v_coach_id || ' | ' || v_coach_name || ' | ' || v_years_of_experience);
    END LOOP;

    CLOSE experienced_coaches;
END;
/

-- Report to print the result of the function which is used to calculate the total salary for a given team based on the sum of the player's salaries and salary bonuses
SET SERVEROUTPUT ON;

DECLARE
    v_team_id Players.TEAM_ID%TYPE;
    v_total_salary DECIMAL(10,2);
BEGIN
    FOR team_rec IN (SELECT DISTINCT TEAM_ID FROM Players) LOOP
        v_team_id := team_rec.TEAM_ID;
        v_total_salary := CalculateTotalSalaryForTeam(v_team_id);
        DBMS_OUTPUT.PUT_LINE('Team ID: ' || v_team_id || ', Total Salary: ' || v_total_salary);
    END LOOP;
END;
/



-- report to create Top Player by Awards & Top Player by Earnings

DECLARE
    combined_info_cursor SYS_REFCURSOR;
    v_report_title VARCHAR2(100);
BEGIN
    -- Report title for combined information
    SELECT 'Report showing the top player based on the most awards won and by highest total earnings' 
    INTO v_report_title FROM dual;
    DBMS_OUTPUT.PUT_LINE('Report Title: ' || v_report_title);
    
    -- Assuming get_top_players_info is a function that returns a cursor with combined info
    combined_info_cursor := get_top_players_info;
    DBMS_SQL.RETURN_RESULT(combined_info_cursor);
END;
/

--report to get medical staff workload

SET SERVEROUTPUT ON;
DECLARE
  -- Declaring a cursor variable to hold the results
  workload_cursor SYS_REFCURSOR;
  -- Variables to hold the fetched data
  support_date DATE;
  support_type VARCHAR2(100);
  duration NUMBER;
BEGIN
  -- Execute the function with a specific staff_id
  workload_cursor := Get_Medical_Staff_Workload(staff_id => 1);  -- Change '1' to the desired staff ID

  -- Loop through the cursor to fetch each row
  LOOP
    FETCH workload_cursor INTO support_date, support_type, duration;
    EXIT WHEN workload_cursor%NOTFOUND;
    
    -- Print each row's data
    DBMS_OUTPUT.PUT_LINE('Date: ' || TO_CHAR(support_date, 'DD-MON-YYYY') || ', Support Type: ' || support_type || ', Duration: ' || duration || ' minutes');
  END LOOP;

  -- Close the cursor
  CLOSE workload_cursor;
END;
/




