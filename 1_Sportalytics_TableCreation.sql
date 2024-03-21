--This is the first script and this script will create tables

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
