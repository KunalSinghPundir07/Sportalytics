--function to check if the player is eligible for the bonus 
CREATE OR REPLACE FUNCTION Checkplayersbonuseligibility(PlayerID INT)
RETURN NUMBER IS -- Changed BIT to NUMBER as Oracle doesn't have a BIT data type
    IsValid NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO IsValid
    FROM ADMIN.PLAYERS
    WHERE PLAYER_ID = PlayerID AND players_bonus_eligibility = 'Yes' AND NO_OF_AWARDS >= 2;

    RETURN IsValid; -- Returning the count of rows satisfying the condition
END;
/


--function to give the list of experienced coaches:
CREATE OR REPLACE FUNCTION GetExperiencedCoaches(
    YearsOfExperienceThreshold INT
)
RETURN SYS_REFCURSOR
AS
    experienced_coaches SYS_REFCURSOR;
BEGIN
    OPEN experienced_coaches FOR
        SELECT COACH_ID, COACH_NAME, COACH_YEARSOFEXPERIENCE
        FROM ADMIN.Coaches
        WHERE COACH_YEARSOFEXPERIENCE > YearsOfExperienceThreshold;

    RETURN experienced_coaches;
END;
/

-- function to create Top Player by Awards & Top Player by Earnings

SET SERVEROUTPUT ON;
CREATE OR REPLACE FUNCTION get_top_players_info RETURN SYS_REFCURSOR IS
    combined_info_cursor SYS_REFCURSOR;
BEGIN
    OPEN combined_info_cursor FOR
    SELECT 'Top Player by Awards' AS category, player_id, player_firstname, player_lastname, 
           nationality, position, team_id, no_of_awards AS metric
    FROM ADMIN.players
    WHERE no_of_awards = (SELECT MAX(no_of_awards) FROM ADMIN.players)
    UNION ALL
    SELECT 'Top Player by Earnings' AS category, player_id, player_firstname, player_lastname, 
           nationality, position, team_id, (players_salary + players_salarybonus) AS metric
    FROM ADMIN.players
    WHERE (players_salary + players_salarybonus) = (
        SELECT MAX(players_salary + players_salarybonus) FROM ADMIN.players
    );
    
    RETURN combined_info_cursor;
EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20002, 'Error retrieving combined top players info: ' || SQLERRM);
END get_top_players_info;
/




--function to calculate the total salary for a given team based on the sum of the player's salaries and salary bonuses
CREATE OR REPLACE FUNCTION CalculateTotalSalaryForTeam(
    TeamID INT
)
RETURN DECIMAL
IS
  TotalSalary DECIMAL(10,2);
BEGIN
    SELECT SUM(PLAYERS_SALARY + PLAYERS_SALARYBONUS) INTO TotalSalary
    FROM ADMIN.Players
    WHERE TEAM_ID = TeamID;

    RETURN TotalSalary;
END;
/

-- function to get medical staff workload 

SET SERVEROUTPUT ON;
CREATE OR REPLACE FUNCTION Get_Medical_Staff_Workload(staff_id IN INTEGER)
RETURN SYS_REFCURSOR IS
  workload_cursor SYS_REFCURSOR;
BEGIN
  OPEN workload_cursor FOR
    SELECT pms.supportdate, pms.supporttype, pms.duration
    FROM ADMIN.player_medical_support pms
    WHERE pms.staff_id = staff_id
    ORDER BY pms.supportdate DESC;

  RETURN workload_cursor;
END;
/

