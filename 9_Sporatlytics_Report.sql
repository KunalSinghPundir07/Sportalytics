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





