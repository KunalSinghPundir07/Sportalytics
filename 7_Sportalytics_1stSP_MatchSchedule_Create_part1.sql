--Creating stored procedure to fetch data related to matches schedule in a particular date range 

CREATE OR REPLACE PROCEDURE get_match_schedules(
    p_start_date IN DATE,
    p_end_date IN DATE,
    p_cursor OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_cursor FOR
        SELECT Schedule_ID, City, Country, Stadium_Name, MatchDateTime,Team_ID
        FROM MATCHSCHEDULES
        WHERE MatchDateTime BETWEEN p_start_date AND p_end_date;
END get_match_schedules;



