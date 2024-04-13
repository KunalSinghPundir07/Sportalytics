CREATE OR REPLACE PACKAGE sports_management AS

    -- Declare the procedure
    PROCEDURE get_match_schedules(
        p_start_date IN DATE,
        p_end_date IN DATE,
        p_cursor OUT SYS_REFCURSOR
    );

    -- Declare the function
    FUNCTION Checkplayersbonuseligibility(PlayerID INT) RETURN NUMBER;

END sports_management;
/
--package body
CREATE OR REPLACE PACKAGE BODY sports_management AS

    -- Implementation of the procedure
    PROCEDURE get_match_schedules(
        p_start_date IN DATE,
        p_end_date IN DATE,
        p_cursor OUT SYS_REFCURSOR
    ) AS
    BEGIN
        OPEN p_cursor FOR
            SELECT Schedule_ID, City, Country, Stadium_Name, MatchDateTime, Team_ID
            FROM MATCHSCHEDULES
            WHERE MatchDateTime BETWEEN p_start_date AND p_end_date;
    END get_match_schedules;

    -- Implementation of the function
    FUNCTION Checkplayersbonuseligibility(PlayerID INT) RETURN NUMBER IS
        IsValid NUMBER;
    BEGIN
        SELECT COUNT(*)
        INTO IsValid
        FROM ADMIN.PLAYERS
        WHERE PLAYER_ID = PlayerID AND players_bonus_eligibility = 'Yes' AND NO_OF_AWARDS >= 2;

        RETURN IsValid; -- Returning the count of rows satisfying the condition
    END Checkplayersbonuseligibility;

END sports_management;
/

--Using the above package
DECLARE
    v_cursor SYS_REFCURSOR;
BEGIN
    -- Calling the procedure
    sports_management.get_match_schedules( TO_DATE('01-04-24', 'DD-MM-YY'), TO_DATE('01-09-24', 'DD-MM-YY'),v_cursor);
    
     -- Calling the function
    DBMS_OUTPUT.PUT_LINE('Eligibility: ' || sports_management.Checkplayersbonuseligibility(1234));
END;








    