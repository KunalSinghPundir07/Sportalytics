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





