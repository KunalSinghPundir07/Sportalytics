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
        FROM Coaches
        WHERE COACH_YEARSOFEXPERIENCE > YearsOfExperienceThreshold;

    RETURN experienced_coaches;
END;
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
    FROM Players
    WHERE TEAM_ID = TeamID;

    RETURN TotalSalary;
END;
/



