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






