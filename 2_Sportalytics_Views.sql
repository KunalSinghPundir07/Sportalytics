-- creating Training_view --

CREATE OR REPLACE VIEW Training_view AS
SELECT 
    c.coach_id AS "Coach_ID",
    c.coach_name AS "Coach_Name",
    p.player_id AS "Player_ID",
    p.player_firstname AS "Player_First_Name",
    p.player_lastname AS "Player_Last_Name",
    t.session_id AS "Session_ID",
    t.session_time AS "SessionTime",
    t.durationinhours AS "Duration_In_Hours",
    t.team_id AS "Team_ID"
FROM 
    TRAININGSESSION t
JOIN 
    COACHES c ON t.coach_id = c.coach_id
JOIN 
    players p ON t.team_id = p.team_id;
    
-- creating Player_Health_Record view --

CREATE OR REPLACE VIEW Player_Health_Record_view AS
SELECT 
    p.player_id AS "Player_ID",
    p.player_firstname AS "Player_First_Name",
    p.player_lastname AS "Player_Last_Name",
    ms.staff_id AS "StaffID",
    ms.med_firstname AS "Medical_Staff_First_Name",
    ms.med_lastname AS "Medical_Staff_Last_Name",
    pms.support_id AS "SupportID",
    pms.supporttype AS "SupportType",
    pms.notes AS "Notes"
FROM 
    PLAYERS p
JOIN 
    PLAYER_MEDICAL_SUPPORT pms ON p.player_id = pms.player_id
JOIN 
    MEDICALSTAFF ms ON pms.staff_id = ms.staff_id;
    
-- creating Team_Player_Schedule_view --

CREATE OR REPLACE VIEW Team_Player_Schedule_view AS
SELECT 
    t.team_id AS "Team_ID",
    t.teamname AS "Team_Name",
    p.player_id AS "PlayerID",
    p.player_firstname AS "Player_First_Name",
    p.player_lastname AS "Player_Last_Name",
    ms.schedule_id AS "ScheduleID",
    ms.city AS "City",
    ms.state AS "State",
    ms.country AS "Country",
    ms.stadium_name AS "StadiumName",
    ms.matchdatetime AS "MatchDateTime"
FROM 
    TEAMS t
JOIN 
    PLAYERS p ON t.team_id = p.team_id
JOIN 
    MATCHSCHEDULEs ms ON t.team_id = ms.team_id;
    
-- creating Team_Player_Schedule_view --

CREATE OR REPLACE VIEW Sponsorships_Sports_Team_view AS
SELECT
    S.Sponsorship_ID AS "SponsorshipID",
    S.SponsorName AS "SponsorName",
    S.DealValue AS "DealValue",
    S.StartDate AS "StartDate",
    S.EndDate AS "EndDate",
    SP.Sport_ID AS "SportID",
    SP.Sport_Name AS "SportName",
    T.Team_ID AS "TeamID",
    T.TeamName AS "TeamName"
FROM SPONSORSHIP S
JOIN TEAMS T ON S.Team_ID = T.Team_ID
JOIN SPORTS SP ON T.Sport_ID = SP.Sport_ID;
 
 





