--function to check if the player is eligible for the bonus 
CREATE OR REPLACE FUNCTION Checkplayersbonuseligibility(PlayerID INT)
RETURN NUMBER IS -- Changed BIT to NUMBER as Oracle doesn't have a BIT data type
    IsValid NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO IsValid
    FROM PLAYERS
    WHERE PLAYER_ID = PlayerID AND players_bonus_eligibility = 'Yes' AND NO_OF_AWARDS >= 2;

    RETURN IsValid; -- Returning the count of rows satisfying the condition
END;

-- function to create Top Player by Awards & Top Player by Earnings

SET SERVEROUTPUT ON;
CREATE OR REPLACE FUNCTION get_top_players_info RETURN SYS_REFCURSOR IS
    combined_info_cursor SYS_REFCURSOR;
BEGIN
    OPEN combined_info_cursor FOR
    SELECT 'Top Player by Awards' AS category, player_id, player_firstname, player_lastname, 
           nationality, position, team_id, no_of_awards AS metric
    FROM players
    WHERE no_of_awards = (SELECT MAX(no_of_awards) FROM players)
    UNION ALL
    SELECT 'Top Player by Earnings' AS category, player_id, player_firstname, player_lastname, 
           nationality, position, team_id, (players_salary + players_salarybonus) AS metric
    FROM players
    WHERE (players_salary + players_salarybonus) = (
        SELECT MAX(players_salary + players_salarybonus) FROM players
    );
    
    RETURN combined_info_cursor;
EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20002, 'Error retrieving combined top players info: ' || SQLERRM);
END get_top_players_info;
/






