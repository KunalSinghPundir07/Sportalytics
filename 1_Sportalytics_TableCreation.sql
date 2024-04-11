--This is the first script and this script will create tables 

-- Updating the Insertion Statements for all tables

--See if the table already exists, if yes then drop the table and if no then move on to the next block of code

DECLARE
  v_table_exists NUMBER;
BEGIN
  SELECT COUNT(*)
  INTO v_table_exists
  FROM user_tables
  WHERE table_name = 'COACHES'; 
  IF v_table_exists > 0 THEN
    EXECUTE IMMEDIATE 'DROP TABLE coaches CASCADE CONSTRAINTS';
    DBMS_OUTPUT.PUT_LINE('Table COACHES dropped successfully.');
  ELSE
    DBMS_OUTPUT.PUT_LINE('Table COACHES needs to be created.');
  END IF;
EXCEPTION
  WHEN OTHERS THEN
    -- Catch and display any error that occurs during the drop operation
    DBMS_OUTPUT.PUT_LINE('Table COACHES already exists');
END;
/
DECLARE
  v_table_exists NUMBER;
BEGIN
  SELECT COUNT(*)
  INTO v_table_exists
  FROM user_tables
  WHERE table_name = 'MANAGERS'; 
  IF v_table_exists > 0 THEN
    EXECUTE IMMEDIATE 'DROP TABLE managers CASCADE CONSTRAINTS';
    DBMS_OUTPUT.PUT_LINE('Table MANAGERS dropped successfully.');
  ELSE
    DBMS_OUTPUT.PUT_LINE('Table MANAGERS needs to be created.');
  END IF;
EXCEPTION
  WHEN OTHERS THEN
    -- Catch and display any error that occurs during the drop operation
    DBMS_OUTPUT.PUT_LINE('Table MANAGERS already exists');
END;
/
DECLARE
  v_table_exists NUMBER;
BEGIN
  SELECT COUNT(*)
  INTO v_table_exists
  FROM user_tables
  WHERE table_name = 'MATCHSCHEDULES'; 
  IF v_table_exists > 0 THEN
    EXECUTE IMMEDIATE 'DROP TABLE matchschedules CASCADE CONSTRAINTS';
    DBMS_OUTPUT.PUT_LINE('Table MATCHSCHEDULES dropped successfully.');
  ELSE
    DBMS_OUTPUT.PUT_LINE('Table MATCHSCHEDULES needs to be created.');
  END IF;
EXCEPTION
  WHEN OTHERS THEN
    -- Catch and display any error that occurs during the drop operation
    DBMS_OUTPUT.PUT_LINE('Table MATCHSCHEDULES already exists');
END;
/
DECLARE
  v_table_exists NUMBER;
BEGIN
  SELECT COUNT(*)
  INTO v_table_exists
  FROM user_tables
  WHERE table_name = 'MEDICALSTAFF'; 
  IF v_table_exists > 0 THEN
    EXECUTE IMMEDIATE 'DROP TABLE medicalstaff CASCADE CONSTRAINTS';
    DBMS_OUTPUT.PUT_LINE('Table MEDICALSTAFF dropped successfully.');
  ELSE
    DBMS_OUTPUT.PUT_LINE('Table MEDICALSTAFF needs to be created.');
  END IF;
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Table MEDICALSTAFF already exists');
END;
/
DECLARE
  v_table_exists NUMBER;
BEGIN
  SELECT COUNT(*)
  INTO v_table_exists
  FROM user_tables
  WHERE table_name = 'PLAYER_MEDICAL_SUPPORT'; 
  IF v_table_exists > 0 THEN
    EXECUTE IMMEDIATE 'DROP TABLE player_medical_support CASCADE CONSTRAINTS';
    DBMS_OUTPUT.PUT_LINE('Table PLAYER_MEDICAL_SUPPORT dropped successfully.');
  ELSE
    DBMS_OUTPUT.PUT_LINE('Table PLAYER_MEDICAL_SUPPORT needs to be created.');
  END IF;
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Table PLAYER_MEDICAL_SUPPORT already exists');
END;
/
DECLARE
  v_table_exists NUMBER;
BEGIN
  SELECT COUNT(*)
  INTO v_table_exists
  FROM user_tables
  WHERE table_name = 'PLAYERS'; 
  IF v_table_exists > 0 THEN
    EXECUTE IMMEDIATE 'DROP TABLE players CASCADE CONSTRAINTS';
    DBMS_OUTPUT.PUT_LINE('Table PLAYERS dropped successfully.');
  ELSE
    DBMS_OUTPUT.PUT_LINE('Table PLAYERS needs to be created.');
  END IF;
EXCEPTION
  WHEN OTHERS THEN
    -- Catch and display any error that occurs during the drop operation
    DBMS_OUTPUT.PUT_LINE('Table PLAYERS already exists');
END;
/
DECLARE
  v_table_exists NUMBER;
BEGIN
  SELECT COUNT(*)
  INTO v_table_exists
  FROM user_tables
  WHERE table_name = 'SPONSORSHIP'; 
  IF v_table_exists > 0 THEN
    EXECUTE IMMEDIATE 'DROP TABLE sponsorship CASCADE CONSTRAINTS';
    DBMS_OUTPUT.PUT_LINE('Table SPONSORSHIP dropped successfully.');
  ELSE
    DBMS_OUTPUT.PUT_LINE('Table SPONSORSHIP needs to be created.');
  END IF;
EXCEPTION
  WHEN OTHERS THEN
    -- Catch and display any error that occurs during the drop operation
    DBMS_OUTPUT.PUT_LINE('Table SPONSORSHIP already exists');
END;
/
DECLARE
  v_table_exists NUMBER;
BEGIN
  SELECT COUNT(*)
  INTO v_table_exists
  FROM user_tables
  WHERE table_name = 'SPORTS'; 
  IF v_table_exists > 0 THEN
    EXECUTE IMMEDIATE 'DROP TABLE sports CASCADE CONSTRAINTS';
    DBMS_OUTPUT.PUT_LINE('Table dropped successfully.');
  ELSE
    DBMS_OUTPUT.PUT_LINE('Table MEDICALSTAFF needs to be created.');
  END IF;
EXCEPTION
  WHEN OTHERS THEN
    -- Catch and display any error that occurs during the drop operation
    DBMS_OUTPUT.PUT_LINE('Table SPORTS already exists');
END;
/
DECLARE
  v_table_exists NUMBER;
BEGIN
  SELECT COUNT(*)
  INTO v_table_exists
  FROM user_tables
  WHERE table_name = 'TEAMS'; 
  IF v_table_exists > 0 THEN
    EXECUTE IMMEDIATE 'DROP TABLE teams CASCADE CONSTRAINTS';
    DBMS_OUTPUT.PUT_LINE('Table TEAMS dropped successfully.');
  ELSE
    DBMS_OUTPUT.PUT_LINE('Table TEAMS needs to be created.');
  END IF;
EXCEPTION
  WHEN OTHERS THEN
    -- Catch and display any error that occurs during the drop operation
    DBMS_OUTPUT.PUT_LINE('Table TEAMS already exists');
END;
/
DECLARE
  v_table_exists NUMBER;
BEGIN
  SELECT COUNT(*)
  INTO v_table_exists
  FROM user_tables
  WHERE table_name = 'TRAININGSESSION'; 
  IF v_table_exists > 0 THEN
    EXECUTE IMMEDIATE 'DROP TABLE trainingsession CASCADE CONSTRAINTS';
    DBMS_OUTPUT.PUT_LINE('Table TRAININGSESSION dropped successfully.');
  ELSE
    DBMS_OUTPUT.PUT_LINE('Table TRAININGSESSION needs to be created.');
  END IF;
EXCEPTION
  WHEN OTHERS THEN
    -- Catch and display any error that occurs during the drop operation
    DBMS_OUTPUT.PUT_LINE('Table TRAININGSESSION already exists');
END;
/

CREATE TABLE coaches (
    coach_id           INTEGER NOT NULL,
    coach_name        VARCHAR2(100),
    coaches_dateofbirth       DATE,
    coach_nationality       VARCHAR2(100),
    coach_yearsofexperience INTEGER,
    specialization    VARCHAR2(100),
    coachsalary       NUMBER
);

ALTER TABLE coaches ADD CONSTRAINT coaches_pk PRIMARY KEY ( coach_id );

CREATE TABLE managers (
    manager_id       INTEGER NOT NULL,
    manager_name            VARCHAR2(100),
    manager_dateofbirth     DATE,
    nationality     VARCHAR2(100),
    experienceyears INTEGER,
    managersalary   NUMBER
);

ALTER TABLE managers ADD CONSTRAINT managers_pk PRIMARY KEY ( manager_id );

CREATE TABLE matchschedules (
    schedule_id    INTEGER NOT NULL,
    city          VARCHAR2(100),
    state         VARCHAR2(100),
    country       VARCHAR2(100),
    stadium_name   VARCHAR2(100),
    matchdatetime DATE,
    team_id        INTEGER
);

ALTER TABLE matchschedules ADD CONSTRAINT matchschedules_pk PRIMARY KEY ( schedule_id );

CREATE TABLE medicalstaff (
    staff_id                          INTEGER NOT NULL,
    med_firstname                        VARCHAR2(100),
    med_lastname                         VARCHAR2(100),
    specialisation                   VARCHAR2(100),
    player_id                         INTEGER,
    medicalstaffsalary               NUMBER,
    support_id                        INTEGER, 
    player_medical_support_support_id INTEGER NOT NULL
);

ALTER TABLE medicalstaff ADD CONSTRAINT medicalstaff_pk PRIMARY KEY ( staff_id );

CREATE TABLE player_medical_support (
    support_id   INTEGER NOT NULL,
    player_id    INTEGER,
    staff_id     INTEGER,
    supportdate DATE,
    supporttype VARCHAR2(100),
    duration    INTEGER,
    notes       VARCHAR2(100)
);

ALTER TABLE player_medical_support ADD CONSTRAINT player_medical_support_pk PRIMARY KEY ( support_id );

CREATE TABLE players (
    player_id                         INTEGER NOT NULL,
    player_firstname                        VARCHAR2(100),
    player_lastname                         VARCHAR2(100),
    dateofbirth                      DATE,
    nationality                      VARCHAR2(100),
    position                         VARCHAR2(100),
    team_id                           INTEGER,
    players_salary                    NUMBER,
    players_contract_startdate         DATE,
    players_contract_enddate           DATE,
    players_salarybonus               NUMBER,
    players_bonus_eligibility          CHAR(5),
    no_of_awards                       INTEGER,
    teams_team_id                     INTEGER NOT NULL,
    schedule_id                       INTEGER NOT NULL, 
    player_medical_support_support_id INTEGER
);

ALTER TABLE players ADD CONSTRAINT players_pk PRIMARY KEY ( player_id );

CREATE TABLE sponsorship (
    sponsorship_id INTEGER NOT NULL,
    sponsorname   VARCHAR2(100),
    dealvalue     NUMBER,
    startdate     DATE,
    enddate       DATE,
    team_id        INTEGER,
    teams_team_id  INTEGER NOT NULL,
    schedule_id    INTEGER NOT NULL
);

ALTER TABLE sponsorship ADD CONSTRAINT sponsorship_pk PRIMARY KEY ( sponsorship_id );

CREATE TABLE sports (
    sport_id         INTEGER NOT NULL,
    sport_name       VARCHAR2(100),
    rules_summary    VARCHAR2(255),
    equipment_needed VARCHAR2(100)
);

ALTER TABLE sports ADD CONSTRAINT sports_pk PRIMARY KEY ( sport_id );

CREATE TABLE teams (
    team_id                    INTEGER NOT NULL,
    teamname                  VARCHAR2(100),
    sport_id                   INTEGER,
    manager_id                 INTEGER,
    establishdate             DATE,
    homecity                  VARCHAR2(100),
    coach_id                   INTEGER,
    managers_manager_id        INTEGER NOT NULL,
    coaches_coach_id           INTEGER NOT NULL,
    schedule_id                INTEGER NOT NULL,
    sports_sport_id            INTEGER NOT NULL,
    matchschedules_schedule_id INTEGER
);

CREATE UNIQUE INDEX teams__idx ON
    teams (
        coaches_coach_id
    ASC );

ALTER TABLE teams ADD CONSTRAINT teams_pk PRIMARY KEY ( team_id );

CREATE TABLE trainingsession (
    session_id       INTEGER NOT NULL,
    session_time     DATE,
    durationinhours INTEGER,
    team_id          INTEGER,
    coach_id         INTEGER,
    teams_team_id    INTEGER NOT NULL,
    schedule_id      INTEGER NOT NULL
);

ALTER TABLE trainingsession ADD CONSTRAINT trainingsession_pk PRIMARY KEY ( session_id );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE medicalstaff
    ADD CONSTRAINT medicalstaff_player_medical_support_fk FOREIGN KEY ( player_medical_support_support_id )
        REFERENCES player_medical_support ( support_id );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE players
    ADD CONSTRAINT players_player_medical_support_fk FOREIGN KEY ( player_medical_support_support_id )
        REFERENCES player_medical_support ( support_id );

ALTER TABLE players
    ADD CONSTRAINT players_teams_fk FOREIGN KEY ( teams_team_id )
        REFERENCES teams ( team_id );

ALTER TABLE sponsorship
    ADD CONSTRAINT sponsorship_teams_fk FOREIGN KEY ( teams_team_id )
        REFERENCES teams ( team_id );

ALTER TABLE teams
    ADD CONSTRAINT teams_coaches_fk FOREIGN KEY ( coaches_coach_id )
        REFERENCES coaches ( coach_id );

ALTER TABLE teams
    ADD CONSTRAINT teams_managers_fk FOREIGN KEY ( managers_manager_id )
        REFERENCES managers ( manager_id );

ALTER TABLE teams
    ADD CONSTRAINT teams_matchschedules_fk FOREIGN KEY ( matchschedules_schedule_id )
        REFERENCES matchschedules ( schedule_id );

ALTER TABLE teams
    ADD CONSTRAINT teams_sports_fk FOREIGN KEY ( sports_sport_id )
        REFERENCES sports ( sport_id );

ALTER TABLE trainingsession
    ADD CONSTRAINT trainingsession_teams_fk FOREIGN KEY ( teams_team_id )
        REFERENCES teams ( team_id );

--  Inserting data into COACHES table      
INSERT INTO coaches (coach_id, coach_name, coaches_dateofbirth, coach_nationality, coach_yearsofexperience, specialization, coachsalary) VALUES (1, 'John Smith', TO_DATE('1980-05-15', 'YYYY-MM-DD'), 'American', 12, 'Basketball', 70000);
INSERT INTO coaches (coach_id, coach_name, coaches_dateofbirth, coach_nationality, coach_yearsofexperience, specialization, coachsalary) VALUES (2, 'Maria Garcia', TO_DATE('1975-11-20', 'YYYY-MM-DD'), 'Spanish', 15, 'Soccer', 80000);
INSERT INTO coaches (coach_id, coach_name, coaches_dateofbirth, coach_nationality, coach_yearsofexperience, specialization, coachsalary) VALUES (3, 'Chang Lee', TO_DATE('1983-09-10', 'YYYY-MM-DD'), 'South Korean', 8, 'Swimming', 60000);
INSERT INTO coaches (coach_id, coach_name, coaches_dateofbirth, coach_nationality, coach_yearsofexperience, specialization, coachsalary) VALUES (4, 'Emily Johnson', TO_DATE('1990-03-25', 'YYYY-MM-DD'), 'Canadian', 5, 'Track and Field', 55000);
INSERT INTO coaches (coach_id, coach_name, coaches_dateofbirth, coach_nationality, coach_yearsofexperience, specialization, coachsalary) VALUES (5, 'Ahmed Hassan', TO_DATE('1978-07-08', 'YYYY-MM-DD'), 'Egyptian', 18, 'Boxing', 90000);
INSERT INTO coaches (coach_id, coach_name, coaches_dateofbirth, coach_nationality, coach_yearsofexperience, specialization, coachsalary) VALUES (6, 'Anna Petrov', TO_DATE('1987-02-12', 'YYYY-MM-DD'), 'Russian', 10, 'Gymnastics', 75000);
INSERT INTO coaches (coach_id, coach_name, coaches_dateofbirth, coach_nationality, coach_yearsofexperience, specialization, coachsalary) VALUES (7, 'Miguel Hernandez', TO_DATE('1972-12-30', 'YYYY-MM-DD'), 'Mexican', 20, 'Tennis', 100000);
INSERT INTO coaches (coach_id, coach_name, coaches_dateofbirth, coach_nationality, coach_yearsofexperience, specialization, coachsalary) VALUES (8, 'Sophie Dubois', TO_DATE('1985-06-18', 'YYYY-MM-DD'), 'French', 14, 'Volleyball', 85000);
INSERT INTO coaches (coach_id, coach_name, coaches_dateofbirth, coach_nationality, coach_yearsofexperience, specialization, coachsalary) VALUES (9, 'David Wilson', TO_DATE('1976-04-03', 'YYYY-MM-DD'), 'British', 16, 'Rugby', 95000);
INSERT INTO coaches (coach_id, coach_name, coaches_dateofbirth, coach_nationality, coach_yearsofexperience, specialization, coachsalary) VALUES (10, 'Li Wei', TO_DATE('1981-08-20', 'YYYY-MM-DD'), 'Chinese', 11, 'Badminton', 65000);

--  Inserting data into MANAGERS table      
INSERT INTO managers (manager_id, manager_name, manager_dateofbirth, nationality, experienceyears, managersalary) VALUES (1, 'Sarah Johnson', TO_DATE('1978-03-12', 'YYYY-MM-DD'), 'American', 15, 100000);
INSERT INTO managers (manager_id, manager_name, manager_dateofbirth, nationality, experienceyears, managersalary) VALUES (2, 'Carlos Martinez', TO_DATE('1975-09-25', 'YYYY-MM-DD'), 'Spanish', 20, 120000);
INSERT INTO managers (manager_id, manager_name, manager_dateofbirth, nationality, experienceyears, managersalary) VALUES (3, 'Emily Wong', TO_DATE('1982-06-18', 'YYYY-MM-DD'), 'Canadian', 12, 95000);
INSERT INTO managers (manager_id, manager_name, manager_dateofbirth, nationality, experienceyears, managersalary) VALUES (4, 'Ahmed Hassan', TO_DATE('1970-11-30', 'YYYY-MM-DD'), 'Egyptian', 25, 150000);
INSERT INTO managers (manager_id, manager_name, manager_dateofbirth, nationality, experienceyears, managersalary) VALUES (5, 'Maria Lopez', TO_DATE('1985-04-20', 'YYYY-MM-DD'), 'Mexican', 10, 85000);
INSERT INTO managers (manager_id, manager_name, manager_dateofbirth, nationality, experienceyears, managersalary) VALUES (6, 'Sergey Ivanov', TO_DATE('1973-08-08', 'YYYY-MM-DD'), 'Russian', 18, 110000);
INSERT INTO managers (manager_id, manager_name, manager_dateofbirth, nationality, experienceyears, managersalary) VALUES (7, 'Sophie Dubois', TO_DATE('1977-01-15', 'YYYY-MM-DD'), 'French', 14, 105000);
INSERT INTO managers (manager_id, manager_name, manager_dateofbirth, nationality, experienceyears, managersalary) VALUES (8, 'David Wilson', TO_DATE('1980-05-05', 'YYYY-MM-DD'), 'British', 17, 115000);
INSERT INTO managers (manager_id, manager_name, manager_dateofbirth, nationality, experienceyears, managersalary) VALUES (9, 'Li Wei', TO_DATE('1976-10-10', 'YYYY-MM-DD'), 'Chinese', 22, 125000);
INSERT INTO managers (manager_id, manager_name, manager_dateofbirth, nationality, experienceyears, managersalary) VALUES (10, 'Anna Petrov', TO_DATE('1988-12-22', 'YYYY-MM-DD'), 'Russian', 8, 90000);

--  Inserting data into SPORTS table      
INSERT INTO sports (sport_id, sport_name, rules_summary, equipment_needed) VALUES(001, 'Basketball', 'Basketball is played with two teams of five players each, aiming to score points by shooting the ball through the opponent''s hoop.', 'Basketball, basketball hoop, basketball court, basketball shoes');
INSERT INTO sports (sport_id, sport_name, rules_summary, equipment_needed) VALUES(002, 'Soccer', 'Soccer is played with two teams of eleven players each, aiming to score goals by kicking the ball into the opponent''s net.', 'Soccer ball, soccer field, soccer goals, soccer cleats');
INSERT INTO sports (sport_id, sport_name, rules_summary, equipment_needed) VALUES(003, 'Tennis', 'Tennis is played with two players or two teams of two players each, aiming to hit the ball over the net and into the opponent''s court.', 'Tennis racket, tennis ball, tennis court, tennis shoes');
INSERT INTO sports (sport_id, sport_name, rules_summary, equipment_needed) VALUES(004, 'Swimming', 'Swimming involves various strokes and distances, with swimmers competing to complete the designated course in the fastest time.', 'Swimsuit, swim cap, goggles, swimming pool');
INSERT INTO sports (sport_id, sport_name, rules_summary, equipment_needed) VALUES(005, 'Track and Field', 'Track and field includes various events such as sprints, long jumps, high jumps, and throwing events, with athletes competing individually or in teams.', 'Running shoes, appropriate attire, starting blocks, throwing implements');
INSERT INTO sports (sport_id, sport_name, rules_summary, equipment_needed) VALUES(006, 'Gymnastics', 'Gymnastics involves performing various acrobatic and artistic routines on apparatus such as the balance beam, uneven bars, and vault.', 'Leotard, chalk, grips (for bars), apparatus mats');
INSERT INTO sports (sport_id, sport_name, rules_summary, equipment_needed) VALUES(007, 'Volleyball', 'Volleyball is played with two teams of six players each, aiming to score points by hitting the ball over the net and into the opponent''s court.', 'Volleyball, volleyball net, volleyball court, knee pads');
INSERT INTO sports (sport_id, sport_name, rules_summary, equipment_needed) VALUES(008, 'Rugby', 'Rugby is played with two teams of fifteen players each, aiming to score points by carrying, passing, or kicking the ball into the opponent''s goal area.', 'Rugby ball, rugby field, rugby posts, mouthguard');
INSERT INTO sports (sport_id, sport_name, rules_summary, equipment_needed) VALUES(009, 'Badminton', 'Badminton is played with two players or two teams of two players each, aiming to hit the shuttlecock over the net and into the opponent''s court.', 'Badminton racket, shuttlecock, badminton court, badminton shoes');
INSERT INTO sports (sport_id, sport_name, rules_summary, equipment_needed) VALUES(010, 'Boxing', 'Boxing involves two opponents fighting with their fists, aiming to land punches on the opponent while avoiding punches themselves.', 'Boxing gloves, boxing ring, mouthguard, boxing shorts');

--  Inserting data into MATCHSCHEDULES table      
INSERT INTO matchschedules (schedule_id, city, state, country, stadium_name, matchdatetime, team_id) VALUES (1, 'New York', 'New York', 'USA', 'Madison Square Garden', TO_DATE('2024-04-15 15:00:00', 'YYYY-MM-DD HH24:MI:SS'), 101);
INSERT INTO matchschedules (schedule_id, city, state, country, stadium_name, matchdatetime, team_id) VALUES (2, 'Los Angeles', 'California', 'USA', 'Staples Center', TO_DATE('2024-05-02 18:30:00', 'YYYY-MM-DD HH24:MI:SS'), 102);
INSERT INTO matchschedules (schedule_id, city, state, country, stadium_name, matchdatetime, team_id) VALUES (3, 'London', 'England', 'UK', 'Wembley Stadium', TO_DATE('2024-06-10 20:00:00', 'YYYY-MM-DD HH24:MI:SS'), 103);
INSERT INTO matchschedules (schedule_id, city, state, country, stadium_name, matchdatetime, team_id) VALUES (4, 'Paris', '�le-de-France', 'France', 'Parc des Princes', TO_DATE('2024-07-05 21:45:00', 'YYYY-MM-DD HH24:MI:SS'), 104);
INSERT INTO matchschedules (schedule_id, city, state, country, stadium_name, matchdatetime, team_id) VALUES (5, 'Berlin', 'Berlin', 'Germany', 'Olympiastadion Berlin', TO_DATE('2024-08-20 19:00:00', 'YYYY-MM-DD HH24:MI:SS'), 105);
INSERT INTO matchschedules (schedule_id, city, state, country, stadium_name, matchdatetime, team_id) VALUES (6, 'Tokyo', 'Tokyo', 'Japan', 'Tokyo Dome', TO_DATE('2024-09-12 16:30:00', 'YYYY-MM-DD HH24:MI:SS'), 106);
INSERT INTO matchschedules (schedule_id, city, state, country, stadium_name, matchdatetime, team_id) VALUES (7, 'Sydney', 'New South Wales', 'Australia', 'ANZ Stadium', TO_DATE('2024-10-03 17:15:00', 'YYYY-MM-DD HH24:MI:SS'), 107);
INSERT INTO matchschedules (schedule_id, city, state, country, stadium_name, matchdatetime, team_id) VALUES (8, 'Sao Paulo', 'Sao Paulo', 'Brazil', 'Est�dio do Morumbi', TO_DATE('2024-11-18 20:30:00', 'YYYY-MM-DD HH24:MI:SS'), 108);
INSERT INTO matchschedules (schedule_id, city, state, country, stadium_name, matchdatetime, team_id) VALUES (9, 'Moscow', 'Moscow', 'Russia', 'Luzhniki Stadium', TO_DATE('2024-12-09 19:45:00', 'YYYY-MM-DD HH24:MI:SS'), 109);
INSERT INTO matchschedules (schedule_id, city, state, country, stadium_name, matchdatetime, team_id) VALUES (10, 'Beijing', 'Beijing', 'China', 'Beijing National Stadium', TO_DATE('2025-01-25 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), 110);

INSERT INTO player_medical_support (support_id, player_id, staff_id, supportdate, supporttype, duration, notes) VALUES (1, 1001, 1, TO_DATE('2024-01-10', 'YYYY-MM-DD'), 'Physiotherapy Session', '60', 'Routine session to address minor muscle strain');
INSERT INTO player_medical_support (support_id, player_id, staff_id, supportdate, supporttype, duration, notes) VALUES (2, 1002, 2, TO_DATE('2024-02-15', 'YYYY-MM-DD'), 'Injury Assessment', '30', 'Evaluating player''s knee injury sustained during practice');
INSERT INTO player_medical_support (support_id, player_id, staff_id, supportdate, supporttype, duration, notes) VALUES (3, 1003, 3, TO_DATE('2024-03-20', 'YYYY-MM-DD'), 'Nutritional Consultation', '45', 'Creating a personalized meal plan for optimal performance');
INSERT INTO player_medical_support (support_id, player_id, staff_id, supportdate, supporttype, duration, notes) VALUES (4, 1004, 4, TO_DATE('2024-04-05', 'YYYY-MM-DD'), 'Chiropractic Adjustment', '20', 'Alleviating lower back pain before the upcoming game');
INSERT INTO player_medical_support (support_id, player_id, staff_id, supportdate, supporttype, duration, notes) VALUES (5, 1005, 5, TO_DATE('2024-05-12', 'YYYY-MM-DD'), 'Massage Therapy Session', '40', 'Relaxing muscles and improving circulation for recovery');
INSERT INTO player_medical_support (support_id, player_id, staff_id, supportdate, supporttype, duration, notes) VALUES (6, 1006, 6, TO_DATE('2024-06-25', 'YYYY-MM-DD'), 'Sports Psychology Session', '60', 'Addressing performance anxiety and mental preparation');
INSERT INTO player_medical_support (support_id, player_id, staff_id, supportdate, supporttype, duration, notes) VALUES (7, 1007, 7, TO_DATE('2024-07-08', 'YYYY-MM-DD'), 'Exercise Physiology Assessment', '45', 'Evaluating player''s cardiovascular fitness and endurance');
INSERT INTO player_medical_support (support_id, player_id, staff_id, supportdate, supporttype, duration, notes) VALUES (8, 1008, 8, TO_DATE('2024-08-19', 'YYYY-MM-DD'), 'Podiatry Examination', '30', 'Checking for any foot abnormalities or issues affecting performance');
INSERT INTO player_medical_support (support_id, player_id, staff_id, supportdate, supporttype, duration, notes) VALUES (9, 1009, 9, TO_DATE('2024-09-30', 'YYYY-MM-DD'), 'Performance Analysis Review', '60', 'Analyzing player''s recent game footage for tactical improvements');
INSERT INTO player_medical_support (support_id, player_id, staff_id, supportdate, supporttype, duration, notes) VALUES (10, 1010, 10, TO_DATE('2024-10-10', 'YYYY-MM-DD'), 'Athletic Training Session', '60', 'Focusing on strength and conditioning exercises tailored to player''s position');

--  Inserting data into TEAMS table      
INSERT INTO teams (team_id, teamname, sport_id, manager_id, establishdate, homecity, coach_id, managers_manager_id, coaches_coach_id, schedule_id, sports_sport_id, matchschedules_schedule_id) VALUES
(101, 'New York Knicks', 001, 001, DATE '1946-06-06', 'New York', 1, 1, 1, 1, 1, 1);
INSERT INTO teams (team_id, teamname, sport_id, manager_id, establishdate, homecity, coach_id, managers_manager_id, coaches_coach_id, schedule_id, sports_sport_id, matchschedules_schedule_id) VALUES
(102, 'Los Angeles Lakers', 001, 002, DATE '1947-08-26', 'Los Angeles', 2, 2, 2, 2, 002, 2);
INSERT INTO teams (team_id, teamname, sport_id, manager_id, establishdate, homecity, coach_id, managers_manager_id, coaches_coach_id, schedule_id, sports_sport_id, matchschedules_schedule_id) VALUES
(103, 'Manchester United', 002, 003, DATE '1878-01-01', 'Manchester', 3, 3, 3, 3, 003, 3);
INSERT INTO teams (team_id, teamname, sport_id, manager_id, establishdate, homecity, coach_id, managers_manager_id, coaches_coach_id, schedule_id, sports_sport_id, matchschedules_schedule_id) VALUES
(104, 'Paris Saint-Germain', 002, 004, DATE '1970-08-12', 'Paris', 4, 4, 4, 1, 004, 4);
INSERT INTO teams (team_id, teamname, sport_id, manager_id, establishdate, homecity, coach_id, managers_manager_id, coaches_coach_id, schedule_id, sports_sport_id, matchschedules_schedule_id) VALUES
(105, 'Bayern Munich', 002, 005, DATE '1900-02-27', 'Munich', 5, 5, 5, 1, 005, 5);
INSERT INTO teams (team_id, teamname, sport_id, manager_id, establishdate, homecity, coach_id, managers_manager_id, coaches_coach_id, schedule_id, sports_sport_id, matchschedules_schedule_id) VALUES
(106, 'Tokyo Giants', 001, 006, DATE '1934-05-01', 'Tokyo', 6, 6, 6, 1, 006, 6);
INSERT INTO teams (team_id, teamname, sport_id, manager_id, establishdate, homecity, coach_id, managers_manager_id, coaches_coach_id, schedule_id, sports_sport_id, matchschedules_schedule_id) VALUES
(107, 'Sydney Swans', 003, 007, DATE '1874-07-19', 'Sydney', 7, 7, 7, 1, 007, 7);
INSERT INTO teams (team_id, teamname, sport_id, manager_id, establishdate, homecity, coach_id, managers_manager_id, coaches_coach_id, schedule_id, sports_sport_id, matchschedules_schedule_id) VALUES
(108, 'Sao Paulo FC', 002, 008, DATE '1930-12-16', 'Sao Paulo', 8, 8, 8, 1, 008, 8);
INSERT INTO teams (team_id, teamname, sport_id, manager_id, establishdate, homecity, coach_id, managers_manager_id, coaches_coach_id, schedule_id, sports_sport_id, matchschedules_schedule_id) VALUES
(109, 'CSKA Moscow', 002, 009, DATE '1911-04-27', 'Moscow', 9, 9, 9, 1, 009, 9);
INSERT INTO teams (team_id, teamname, sport_id, manager_id, establishdate, homecity, coach_id, managers_manager_id, coaches_coach_id, schedule_id, sports_sport_id, matchschedules_schedule_id) VALUES
(110, 'Beijing Guoan', 002, 010, DATE '1951-03-10', 'Beijing', 10, 10, 10, 1, 010, 10);

--  Inserting data into SPONSORSHIP table      
INSERT INTO sponsorship (sponsorship_id, sponsorname, dealvalue, startdate, enddate, team_id, teams_team_id, schedule_id)
VALUES(1, 'XYZ Corporation', 150000, TO_DATE('2024-01-01', 'YYYY-MM-DD'), TO_DATE('2025-01-01', 'YYYY-MM-DD'), 101, 101, 1);
INSERT INTO sponsorship (sponsorship_id, sponsorname, dealvalue, startdate, enddate, team_id, teams_team_id, schedule_id)
VALUES(2, 'ABC Industries', 200000, TO_DATE('2024-03-15', 'YYYY-MM-DD'), TO_DATE('2025-03-15', 'YYYY-MM-DD'), 102, 102, 2);
INSERT INTO sponsorship (sponsorship_id, sponsorname, dealvalue, startdate, enddate, team_id, teams_team_id, schedule_id)
VALUES(3, 'SportsGear Inc.', 100000, TO_DATE('2024-02-01', 'YYYY-MM-DD'), TO_DATE('2025-02-01', 'YYYY-MM-DD'), 103, 103, 3);
INSERT INTO sponsorship (sponsorship_id, sponsorname, dealvalue, startdate, enddate, team_id, teams_team_id, schedule_id)
VALUES(4, 'FitnessFirst Gym', 80000, TO_DATE('2024-04-01', 'YYYY-MM-DD'), TO_DATE('2025-04-01', 'YYYY-MM-DD'), 104, 104, 4);
INSERT INTO sponsorship (sponsorship_id, sponsorname, dealvalue, startdate, enddate, team_id, teams_team_id, schedule_id)
VALUES(5, 'TechCom Solutions', 300000, TO_DATE('2024-05-10', 'YYYY-MM-DD'), TO_DATE('2025-05-10', 'YYYY-MM-DD'), 105, 105, 5);
INSERT INTO sponsorship (sponsorship_id, sponsorname, dealvalue, startdate, enddate, team_id, teams_team_id, schedule_id)
VALUES(6, 'HealthNut Nutrition', 50000, TO_DATE('2024-06-20', 'YYYY-MM-DD'), TO_DATE('2025-06-20', 'YYYY-MM-DD'), 106, 106, 6);
INSERT INTO sponsorship (sponsorship_id, sponsorname, dealvalue, startdate, enddate, team_id, teams_team_id, schedule_id)
VALUES(7, 'Global Bank', 180000, TO_DATE('2024-07-01', 'YYYY-MM-DD'), TO_DATE('2025-07-01', 'YYYY-MM-DD'), 107, 107, 7);
INSERT INTO sponsorship (sponsorship_id, sponsorname, dealvalue, startdate, enddate, team_id, teams_team_id, schedule_id)
VALUES(8, 'FashionFiesta Clothing', 120000, TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2025-08-15', 'YYYY-MM-DD'), 108, 108, 8);
INSERT INTO sponsorship (sponsorship_id, sponsorname, dealvalue, startdate, enddate, team_id, teams_team_id, schedule_id)
VALUES(9, 'TravelWorld Agency', 250000, TO_DATE('2024-09-05', 'YYYY-MM-DD'), TO_DATE('2025-09-05', 'YYYY-MM-DD'), 109, 109, 9);
INSERT INTO sponsorship (sponsorship_id, sponsorname, dealvalue, startdate, enddate, team_id, teams_team_id, schedule_id)
VALUES(10, 'EnergyBoost Drinks', 70000, TO_DATE('2024-10-20', 'YYYY-MM-DD'), TO_DATE('2025-10-20', 'YYYY-MM-DD'), 110, 110, 10);

--  Inserting data into MEDICALSTAFF table      
INSERT INTO medicalstaff (staff_id, med_firstname, med_lastname, specialisation, player_id, medicalstaffsalary, player_medical_support_support_id) VALUES (1, 'Emily', 'Johnson', 'Physiotherapy', 101, 60000, 1);
INSERT INTO medicalstaff (staff_id, med_firstname, med_lastname, specialisation, player_id, medicalstaffsalary, player_medical_support_support_id) VALUES (2, 'Michael', 'Lee', 'Sports Medicine', 102, 70000, 2);
INSERT INTO medicalstaff (staff_id, med_firstname, med_lastname, specialisation, player_id, medicalstaffsalary, player_medical_support_support_id) VALUES (3, 'Sarah', 'Patel', 'Nutritionist', 103, 65000, 3);
INSERT INTO medicalstaff (staff_id, med_firstname, med_lastname, specialisation, player_id, medicalstaffsalary, player_medical_support_support_id) VALUES (4, 'David', 'Martinez', 'Chiropractic', 104, 75000, 4);
INSERT INTO medicalstaff (staff_id, med_firstname, med_lastname, specialisation, player_id, medicalstaffsalary, player_medical_support_support_id) VALUES (5, 'Jessica', 'Wang', 'Massage Therapy', 105, 55000, 5);
INSERT INTO medicalstaff (staff_id, med_firstname, med_lastname, specialisation, player_id, medicalstaffsalary, player_medical_support_support_id) VALUES (6, 'Ryan', 'Kim', 'Sports Psychology', 106, 80000, 6);
INSERT INTO medicalstaff (staff_id, med_firstname, med_lastname, specialisation, player_id, medicalstaffsalary, player_medical_support_support_id) VALUES (7, 'Maria', 'Rodriguez', 'Exercise Physiology', 107, 68000, 7);
INSERT INTO medicalstaff (staff_id, med_firstname, med_lastname, specialisation, player_id, medicalstaffsalary, player_medical_support_support_id) VALUES (8, 'Daniel', 'Sullivan', 'Podiatry', 108, 72000, 8);
INSERT INTO medicalstaff (staff_id, med_firstname, med_lastname, specialisation, player_id, medicalstaffsalary, player_medical_support_support_id) VALUES (9, 'Laura', 'Nguyen', 'Performance Analysis', 109, 63000, 9);
INSERT INTO medicalstaff (staff_id, med_firstname, med_lastname, specialisation, player_id, medicalstaffsalary, player_medical_support_support_id) VALUES (10, 'Alex', 'Garcia', 'Athletic Training', 110, 67000, 10);

--  Inserting data into PLAYERS table      
INSERT INTO players (player_id, player_firstname, player_lastname, dateofbirth, nationality, position, team_id, players_salary, players_contract_startdate, players_contract_enddate, players_salarybonus, players_bonus_eligibility, no_of_awards, teams_team_id, schedule_id, player_medical_support_support_id)
VALUES(1001, 'James','Smith', TO_DATE('1990-05-15', 'YYYY-MM-DD'), 'England', 'Forward', 101, 100000, TO_DATE('2023-07-01', 'YYYY-MM-DD'), TO_DATE('2025-06-30', 'YYYY-MM-DD'), 10000, 'Yes', 2, 101, 1, 1);
INSERT INTO players (player_id, player_firstname, player_lastname, dateofbirth, nationality, position, team_id, players_salary, players_contract_startdate, players_contract_enddate, players_salarybonus, players_bonus_eligibility, no_of_awards, teams_team_id, schedule_id, player_medical_support_support_id)
VALUES(1002, 'Emma','Johnson', TO_DATE('1995-09-22', 'YYYY-MM-DD'), 'USA', 'Midfielder', 102, 80000, TO_DATE('2022-12-15', 'YYYY-MM-DD'), TO_DATE('2024-12-14', 'YYYY-MM-DD'), 5000, 'No', 1, 102, 2, 2);
INSERT INTO players (player_id, player_firstname, player_lastname, dateofbirth, nationality, position, team_id, players_salary, players_contract_startdate, players_contract_enddate, players_salarybonus, players_bonus_eligibility, no_of_awards, teams_team_id, schedule_id, player_medical_support_support_id)
VALUES(1003, 'David','Williams', TO_DATE('1992-03-10', 'YYYY-MM-DD'), 'Brazil', 'Defender', 103, 120000, TO_DATE('2024-01-20', 'YYYY-MM-DD'), TO_DATE('2026-01-19', 'YYYY-MM-DD'), 15000, 'Yes', 3, 103, 3, 3);
INSERT INTO players (player_id, player_firstname, player_lastname, dateofbirth, nationality, position, team_id, players_salary, players_contract_startdate, players_contract_enddate, players_salarybonus, players_bonus_eligibility, no_of_awards, teams_team_id, schedule_id, player_medical_support_support_id)
VALUES(1004, 'Sophia','Garcia', TO_DATE('1988-11-30', 'YYYY-MM-DD'), 'Spain', 'Goalkeeper', 101, 150000, TO_DATE('2021-06-10', 'YYYY-MM-DD'), TO_DATE('2023-06-09', 'YYYY-MM-DD'), 20000, 'Yes', 4, 104, 4, 4);
INSERT INTO players (player_id, player_firstname, player_lastname, dateofbirth, nationality, position, team_id, players_salary, players_contract_startdate, players_contract_enddate, players_salarybonus, players_bonus_eligibility, no_of_awards, teams_team_id, schedule_id, player_medical_support_support_id)
VALUES(1005, 'Michael','Lee', TO_DATE('1993-07-08', 'YYYY-MM-DD'), 'England', 'Forward', 104, 90000, TO_DATE('2023-03-05', 'YYYY-MM-DD'), TO_DATE('2025-03-04', 'YYYY-MM-DD'), 7000, 'No', 0, 105, 5, 5);
INSERT INTO players (player_id, player_firstname, player_lastname, dateofbirth, nationality, position, team_id, players_salary, players_contract_startdate, players_contract_enddate, players_salarybonus, players_bonus_eligibility, no_of_awards, teams_team_id, schedule_id, player_medical_support_support_id)
VALUES(1006, 'Isabella','Martinez', TO_DATE('1996-02-18', 'YYYY-MM-DD'), 'Argentina', 'Midfielder', 102, 85000, TO_DATE('2023-09-30', 'YYYY-MM-DD'), TO_DATE('2025-09-29', 'YYYY-MM-DD'), 6000, 'Yes', 2, 106, 6, 6);
INSERT INTO players (player_id, player_firstname, player_lastname, dateofbirth, nationality, position, team_id, players_salary, players_contract_startdate, players_contract_enddate, players_salarybonus, players_bonus_eligibility, no_of_awards, teams_team_id, schedule_id, player_medical_support_support_id)
VALUES(1007, 'William','Gonzalez', TO_DATE('1991-04-25', 'YYYY-MM-DD'), 'Colombia', 'Defender', 103, 110000, TO_DATE('2022-11-11', 'YYYY-MM-DD'), TO_DATE('2024-11-10', 'YYYY-MM-DD'), 12000, 'No', 1, 107, 7, 7);
INSERT INTO players (player_id, player_firstname, player_lastname, dateofbirth, nationality, position, team_id, players_salary, players_contract_startdate, players_contract_enddate, players_salarybonus, players_bonus_eligibility, no_of_awards, teams_team_id, schedule_id, player_medical_support_support_id)
VALUES(1008, 'Olivia','Lopez', TO_DATE('1989-08-12', 'YYYY-MM-DD'), 'USA', 'Midfielder', 104, 95000, TO_DATE('2022-08-20', 'YYYY-MM-DD'), TO_DATE('2024-08-19', 'YYYY-MM-DD'), 8000, 'Yes', 3, 108, 8, 8);
INSERT INTO players (player_id, player_firstname, player_lastname, dateofbirth, nationality, position, team_id, players_salary, players_contract_startdate, players_contract_enddate, players_salarybonus, players_bonus_eligibility, no_of_awards, teams_team_id, schedule_id, player_medical_support_support_id)
VALUES(1009, 'Ethan','Kim', TO_DATE('1994-06-29', 'YYYY-MM-DD'), 'South Korea', 'Forward', 105, 105000, TO_DATE('2023-05-04', 'YYYY-MM-DD'), TO_DATE('2025-05-03', 'YYYY-MM-DD'), 9000, 'No', 2, 109, 9, 9);
INSERT INTO players (player_id, player_firstname, player_lastname, dateofbirth, nationality, position, team_id, players_salary, players_contract_startdate, players_contract_enddate, players_salarybonus, players_bonus_eligibility, no_of_awards, teams_team_id, schedule_id, player_medical_support_support_id)
VALUES(1010, 'Ava','Chen', TO_DATE('1997-01-05', 'YYYY-MM-DD'), 'China', 'Goalkeeper', 105, 130000, TO_DATE('2024-02-15', 'YYYY-MM-DD'), TO_DATE('2026-02-14', 'YYYY-MM-DD'), 18000, 'Yes', 1, 110, 10, 10);

--  Inserting data into TRAININGSESSION table      
INSERT INTO trainingsession (session_id, session_time, durationinhours, team_id, coach_id, teams_team_id, schedule_id) VALUES (1001, TO_TIMESTAMP('2024-03-15 10:00:00','YYYY-MM-DD HH24:MI:SS'), 2, 101, 1, 101, 1);
INSERT INTO trainingsession (session_id, session_time, durationinhours, team_id, coach_id, teams_team_id, schedule_id) VALUES (1002, TO_TIMESTAMP('2024-03-16 14:00:00','YYYY-MM-DD HH24:MI:SS'), 1.5, 102, 2, 102, 2);
INSERT INTO trainingsession (session_id, session_time, durationinhours, team_id, coach_id, teams_team_id, schedule_id) VALUES (1003, TO_TIMESTAMP('2024-03-17 09:30:00','YYYY-MM-DD HH24:MI:SS'), 2.5, 103, 3, 103, 3);
INSERT INTO trainingsession (session_id, session_time, durationinhours, team_id, coach_id, teams_team_id, schedule_id) VALUES (1004, TO_TIMESTAMP( '2024-03-18 11:00:00','YYYY-MM-DD HH24:MI:SS'), 2, 104, 4, 104, 4);
INSERT INTO trainingsession (session_id, session_time, durationinhours, team_id, coach_id, teams_team_id, schedule_id) VALUES (1005, TO_TIMESTAMP('2024-03-19 13:00:00','YYYY-MM-DD HH24:MI:SS'), 1, 105, 5, 105, 5);
INSERT INTO trainingsession (session_id, session_time, durationinhours, team_id, coach_id, teams_team_id, schedule_id) VALUES (1006, TO_TIMESTAMP( '2024-03-20 15:30:00','YYYY-MM-DD HH24:MI:SS'), 2.5, 106, 6, 106, 6);
INSERT INTO trainingsession (session_id, session_time, durationinhours, team_id, coach_id, teams_team_id, schedule_id) VALUES (1007, TO_TIMESTAMP('2024-03-21 12:00:00','YYYY-MM-DD HH24:MI:SS'), 2, 107, 7, 107, 7);
INSERT INTO trainingsession (session_id, session_time, durationinhours, team_id, coach_id, teams_team_id, schedule_id) VALUES (1008, TO_TIMESTAMP('2024-03-22 10:30:00','YYYY-MM-DD HH24:MI:SS'), 1.5, 108, 8, 108, 8);
INSERT INTO trainingsession (session_id, session_time, durationinhours, team_id, coach_id, teams_team_id, schedule_id) VALUES (1009, TO_TIMESTAMP('2024-03-23 14:00:00','YYYY-MM-DD HH24:MI:SS'), 2.5, 109, 9, 109, 9);
INSERT INTO trainingsession (session_id, session_time, durationinhours, team_id, coach_id, teams_team_id, schedule_id) VALUES (1010, TO_TIMESTAMP('2024-03-24 09:00:00','YYYY-MM-DD HH24:MI:SS'), 2, 110, 10, 110, 10);
