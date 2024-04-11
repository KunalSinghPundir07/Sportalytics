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





