############ CREATING THE SCHEMA  ##############################
create schema NHL;
use NHL;
############ CREATING THE TABLES  ##############################
CREATE TABLE Teams (
    Team_Name VARCHAR(40),
    City VARCHAR(40),
    Coach_name VARCHAR(40),
    Captain_name VARCHAR(40),
    Captain_id INT NOT NULL,
    PRIMARY KEY (Team_Name)
);
select * from teams;

CREATE TABLE Players (
    Player_id INT NOT NULL,
    Player_name VARCHAR(255),
    Team_Name VARCHAR(40),
    Position VARCHAR(40),
    skill_level VARCHAR(255),
    injury_record VARCHAR(255),
    PRIMARY KEY (player_id)
);

CREATE TABLE Games (
    Game_no INT AUTO_INCREMENT,
    host_team VARCHAR(40),
    guest_team VARCHAR(40),
    match_date DATE,
    score INT,
    Winner VARCHAR(40),
    PRIMARY KEY (Game_no)
);

###################### INSERTING DATA IN TABLES ##################################

-- -------------Inserting data into teams table
insert into Teams(Team_Name, City, Coach_name, Captain_name, Captain_id)
Values ('Boston Bruins', 'Massachusetts', 'Jim Montgomery', 'Brad Marchand', 1),
('Buffalo Sabres', 'New York', 'Don Granato', 'Kyle Okposo', 2),
('Detroit Red Wings', 'Michigan', 'Derek Lalonde', 'Dylan Larkin', 3),
('Florida Panthers','Florida', 'Paul Maurice', ' Aleksander Barkov', 4),
('Montreal Canadiens', 'Quebec', ' Martin St. Louis', 'Nick Suzuki', 5),
('Ottawa Senators', 'Ontario', 'D.J. Smith', 'Brady Tkachuk', 6),
('Edmonton Oilers', 'Alberta', 'Jay Woodcroft', 'Connor McDavid', 7),
('Seattle Kraken', 'Washington', 'Dave Hakstol', 'William', 8),
('Washington Capitals','D.C.', 'Spencer Carbery', 'Ovechkin', 9),
('Dallas Stars', 'Texas', 'Peter DeBoer', 'Jamie Benn', 10);
select * from Teams;
drop table teams;


--  -------------Inserting data into players table
INSERT INTO Players (Player_id, Player_name, Team_Name, Position, skill_level, injury_record)
WITH NumberSeries AS (
    SELECT ROW_NUMBER() OVER () AS Player_id
    FROM information_schema.columns
    LIMIT 100
)
SELECT
    ns.Player_id,
    CONCAT('Player', ns.Player_id) AS Player_name,
    CASE
        WHEN ns.Player_id % 10 = 1 THEN 'Boston Bruins'
        WHEN ns.Player_id % 10 = 2 THEN 'Buffalo Sabres'
        WHEN ns.Player_id % 10 = 3 THEN 'Detroit Red Wings'
        WHEN ns.Player_id % 10 = 4 THEN 'Florida Panthers'
        WHEN ns.Player_id % 10 = 5 THEN 'Montreal Canadiens'
        WHEN ns.Player_id % 10 = 6 THEN 'Ottawa Senators'
        WHEN ns.Player_id % 10 = 7 THEN 'Edmonton Oilers'
        WHEN ns.Player_id % 10 = 8 THEN 'Seattle Kraken'
        WHEN ns.Player_id % 10 = 9 THEN 'Washington Capitals'
        WHEN ns.Player_id % 10 = 0 THEN 'Dallas Star'
    END AS Team_Name,
    CASE
        WHEN ns.Player_id % 3 = 0 THEN 'Forward'
        WHEN ns.Player_id % 3 = 1 THEN 'Midfielder'
        WHEN ns.Player_id % 3 = 2 THEN 'Defender'
    END AS Position,
    CASE
        WHEN ns.Player_id % 3 = 0 THEN 'High'
        WHEN ns.Player_id % 3 = 1 THEN 'Medium'
        WHEN ns.Player_id % 3 = 2 THEN 'Low'
    END AS skill_level,
    CASE
        WHEN ns.Player_id % 2 = 0 THEN 'No injuries'
        WHEN ns.Player_id % 2 = 1 THEN '1 injury'
    END AS injury_record
FROM NumberSeries ns;

select * from players;


-- Insert Player data with specified team names
INSERT INTO Players (Player_id, Player_name, Team_Name, Position, skill_level, injury_record)
VALUES
    (101, 'Brad Marchand', 'Boston Bruins', 'Forward', 'High', 'No injuries'),
    (102, 'Kyle Okposo', 'Buffalo Sabres', 'Midfielder', 'Medium', '1 injury'),
    (103, 'Dylan Larkin', 'Detroit Red Wings', 'Defender', 'Low', 'No injuries'),
    (104, 'Aleksander Barkov', 'Florida Panthers', 'Forward', 'High', '1 injury'),
    (105, 'Nick Suzuki', 'Montreal Canadiens', 'Midfielder', 'Medium', 'No injuries'),
    (106, 'Brady Tkachuk', 'Ottawa Senators', 'Defender', 'Low', 'No injuries'),
    (107, 'Connor McDavid', 'Edmonton Oilers', 'Forward', 'High', 'No injuries'),
    (108, 'William', 'Seattle Kraken', 'Midfielder', 'Medium', '1 injury'),
    (109, 'Ovechkin', 'Washington Capitals', 'Defender', 'Low', 'No injuries'),
    (110, 'Jamie Benn', 'Dallas Star', 'Forward', 'High', 'No injuries');


-- -------------------INSERTING DATA INTO Games table

INSERT INTO Games (host_team, guest_team, match_date, score, Winner)
VALUES
    ('Boston Bruins', 'Buffalo Sabres', '2023-01-01', 4, 'Boston Bruins'),
    ('Detroit Red Wings', 'Montreal Canadiens', '2023-01-10', 2, 'Montreal Canadiens'),
    ('Florida Panthers', 'Ottawa Senators', '2023-01-15', 5, 'Florida Panthers'),
    ('Edmonton Oilers', 'Seattle Kraken', '2023-02-03', 3, 'Edmonton Oilers'),
    ('Washington Capitals', 'Dallas Star', '2023-02-13', 4, 'Washington Capitals'),
    ('Boston Bruins', 'Montreal Canadeins', '2023-02-18', 4, 'Boston Bruins'),
    ('Florida Panthers', 'Washington Capitals', '2023-02-23', 5, 'Washington Capitals'),
    ('Edmonton Oilers',  'Washington Capitals', '2023-02-28', 4, 'Washington Capitals');
    
 ################ UPDATE TABLE ##################
 
 
# mistake while correcting for spelling
update games set Guest_team = 'Montreal Canadiens' where score = 4;   
delete from games;  
select * from games;
# run insert code again 
update games set Guest_team = 'Montreal Canadiens' where match_date = '2023-02-18'; 

########## ALTER TABLE ###########
Alter table Games add column Man_Of_the_Match varchar(40);

insert into Games (Man_Of_the_Match)
Values ('Player32'), ('Player25'), ('Brady Tkachuk'), ('Player37'), ('Player30'), ('Player91'), ('Player49'), ('Connor McDavid');

delete from Games where Game_no >= 17;

select * from Games;

-- Update the "Man_of_the_Match" column for multiple games in the "Games" table
UPDATE Games
SET Man_of_the_Match = 
    CASE
        WHEN Game_no = 9 THEN 'Player32'  -- Man of the Match for Game 9
        WHEN Game_no = 10 THEN 'Player25'  -- Man of the Match for Game 10
        WHEN Game_no = 11 THEN 'Brady Tkachuk'  -- Man of the Match for Game 11
        WHEN Game_no = 12 THEN 'Player37'  -- Man of the Match for Game 12
        WHEN Game_no = 13 THEN 'Player30'  -- Man of the Match for Game 13
        WHEN Game_no = 14 THEN 'Player91'  -- Man of the Match for Game 14
        WHEN Game_no = 15 THEN 'Player49'  -- Man of the Match for Game 15
        WHEN Game_no = 16 THEN 'Connor McDavid'  -- Man of the Match for Game 16
    END;
select * from Games;

Alter table games add column Match_no numeric;
Alter table games drop column Match_no ;    # as Game_no already exists
Update Players set injury_record = '2 injury' where player_id in  (5, 10, 40, 60, 75);
select injury_record from Players;

#################### ANALYSIS  ##################################


# 1) Display all the players in team "Edmonton Oilers".
SELECT 
    player_id, player_name
FROM
    Players
WHERE
    Team_name = 'Edmonton Oilers';
    
# 2) How many teams played in the tournament?
SELECT 
    COUNT(Team_name)
FROM
    teams;
    
# 3) How many matches happened in the tournament?
SELECT 
    COUNT(game_no)
FROM
    Games;

# 4) How many players participated?
SELECT 
    COUNT(player_id)
FROM
    Players;
# 5) How many players have 1 injury?
SELECT 
    COUNT(player_id)
FROM
    players
WHERE
    injury_record = '1 injury';
    
# 6) Which team has the highest number of injured players?
SELECT 
    team_name, COUNT(player_id)
FROM
    Players
WHERE
    injury_record IN ('1 injury' , '2 injury')
GROUP BY team_name
ORDER BY COUNT(Player_id) DESC;

# 7) Which team won the maximum number of matches?
select * from games;
SELECT 
    Winner, COUNT(Winner)
FROM
    games
GROUP BY Winner
ORDER BY COUNT(Winner) DESC;

# 8) Display the players who play at a "forward" position?
SELECT 
    player_name, position
FROM
    players
WHERE
    position = 'Forward';

# 9) Find the players in team "Florida Panthers" having "high" level skills?
SELECT 
    player_id, player_name, team_name, skill_level
FROM
    players
WHERE
    team_name = 'Florida Panthers'
        AND skill_level = 'High';

# 10) Count the number of players having "low" level of skills team wise.
SELECT 
    team_name, COUNT(player_id)
FROM
    players
WHERE
    skill_level = 'low'
GROUP BY team_name
ORDER BY COUNT(player_id) DESC;

# 11) What are the maximum and minimum scores in the matches?
SELECT 
    MAX(score), MIN(score)
FROM
    Games;

# 12) Display the injury record for all the captains.

SELECT P.Player_name, P.injury_record
FROM Players AS P
JOIN Teams AS T ON P.Team_Name = T.Team_Name
WHERE T.Captain_Name = P.Player_name;

# 13) Display captains of the winning teams.

SELECT T.Captain_Name, G.Winner
FROM Games AS G
JOIN Teams AS T ON G.Winner = T.Team_Name;

# 14) Display skill level of all the captains.

SELECT P.Player_name, P.Skill_level
FROM Players AS P
JOIN Teams AS T ON P.Team_Name = T.Team_Name
WHERE T.Captain_Name = P.Player_name;

# 15) Display the Games where host teams won the match.

SELECT 
    *
FROM
    Games
WHERE
    host_team = winner;

# 16) Display the Games where guest teams won the match.
 
 SELECT 
    *
FROM
    Games
WHERE
    guest_team = winner;
  
  # 17) Display position of all the captains.

SELECT P.Player_name, P.Position
FROM Players AS P
JOIN Teams AS T ON P.Team_Name = T.Team_Name
WHERE T.Captain_Name = P.Player_name
ORDER BY Position;
 