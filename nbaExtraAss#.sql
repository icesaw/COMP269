/*
NBA Extra Ass
Alexey Milovanov
COMP269
Instructor: Dr. Yin Bao
*/


SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema nba_db
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `nba_db` ;

-- -----------------------------------------------------
-- Schema nba_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `nba_db` DEFAULT CHARACTER SET utf8 ;
USE `nba_db` ;

-- -----------------------------------------------------
-- Table `nba_db`.`positions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nba_db`.`positions` ;

CREATE TABLE IF NOT EXISTS `nba_db`.`positions` (
  `position_id` INT NOT NULL AUTO_INCREMENT,
  `position_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`position_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nba_db`.`universities`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nba_db`.`universities` ;

CREATE TABLE IF NOT EXISTS `nba_db`.`universities` (
  `university_id` INT NOT NULL AUTO_INCREMENT,
  `university_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`university_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nba_db`.`arenas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nba_db`.`arenas` ;

CREATE TABLE IF NOT EXISTS `nba_db`.`arenas` (
  `arena_id` INT NOT NULL AUTO_INCREMENT,
  `arena_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`arena_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nba_db`.`teams`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nba_db`.`teams` ;

CREATE TABLE IF NOT EXISTS `nba_db`.`teams` (
  `team_id` INT NOT NULL AUTO_INCREMENT,
  `team_name` VARCHAR(45) NOT NULL,
  `team_arena_id` INT NOT NULL,
  PRIMARY KEY (`team_id`),
  CONSTRAINT `team_arena_fk_id`
    FOREIGN KEY (`team_arena_id`)
    REFERENCES `nba_db`.`arenas` (`arena_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nba_db`.`countries`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nba_db`.`countries` ;

CREATE TABLE IF NOT EXISTS `nba_db`.`countries` (
  `country_id` INT NOT NULL AUTO_INCREMENT,
  `country_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`country_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nba_db`.`players`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nba_db`.`players` ;

CREATE TABLE IF NOT EXISTS `nba_db`.`players` (
  `player_id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(20) NOT NULL,
  `last_name` VARCHAR(20) NOT NULL,
  `height` VARCHAR(6) NOT NULL,
  `weight` INT NOT NULL,
  `date_of_birth` DATE NOT NULL,
  `position_id` INT NOT NULL,
  `university_id` INT NOT NULL,
  `team_id` INT NOT NULL,
  `country_id` INT NOT NULL,
  PRIMARY KEY (`player_id`),
  CONSTRAINT `position_fk_id`
    FOREIGN KEY (`position_id`)
    REFERENCES `nba_db`.`positions` (`position_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `university_fk_id`
    FOREIGN KEY (`university_id`)
    REFERENCES `nba_db`.`universities` (`university_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `team_fk_id`
    FOREIGN KEY (`team_id`)
    REFERENCES `nba_db`.`teams` (`team_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `country_fk_id`
    FOREIGN KEY (`country_id`)
    REFERENCES `nba_db`.`countries` (`country_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nba_db`.`matches`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nba_db`.`matches` ;

CREATE TABLE IF NOT EXISTS `nba_db`.`matches` (
  `match_id` INT NOT NULL AUTO_INCREMENT,
  `away_team_id` INT NOT NULL,
  `home_team_id` INT NOT NULL,
  `match_date` DATE NOT NULL,
  PRIMARY KEY (`match_id`),
  CONSTRAINT `away_team_fk_id`
    FOREIGN KEY (`away_team_id`)
    REFERENCES `nba_db`.`teams` (`team_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `home_team_fk_id`
    FOREIGN KEY (`home_team_id`)
    REFERENCES `nba_db`.`teams` (`team_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


INSERT INTO universities
(university_name)
VALUES
('Duke'),
('UCLA'),
('Kentuky'),
('UNLV'),
('Florida St'),
('Kansas');

INSERT INTO arenas
(arena_name)
VALUES
('Stapes Center'),
('United Center'),
('American Airlines Center'),
('Wells Fargo Center'),
('Rockets Test Arena'), -- just for query
('Quicken Loans Arena');

INSERT INTO teams
(team_name, team_arena_id)
VALUES
('Lakers', 1),
('Celtics', 2),
('Bulls', 3),
('Magic', 4),
('Rockets', 5),
('Knicks', 6);

INSERT INTO countries
(country_name)
VALUES
('USA'),
('Germany'),
('Croatia'),
('Serbai');

INSERT INTO positions
(position_name)
VALUES
('Center'),
('Point Guard'),
('Shooting Guard'),
('Small Forward'),
('Power Forward');

INSERT INTO matches
(away_team_id, home_team_id, match_date)
VALUES
(6, 4, '2018-12-07'),
(1, 3, '2018-12-08'),
(6, 1, '2018-12-08'),
(1, 3, '2018-12-09'),
(3, 1, '2018-12-09'),
(3, 4, '2018-12-10'),
(4, 6, '2018-12-10'),
(5, 2, '2018-12-11'),
(2, 6, '2018-12-11');

INSERT INTO players
(first_name, last_name, height, weight, date_of_birth, position_id, university_id, team_id, country_id)
VALUES
('Giannis', 'Antetokoumoo', '6 11', 242, '1995-07-01', 3, 1, 1, 2),
('Mike', 'Conlev', '6 1', 175, '1993-06-27', 4, 2, 3, 4),
('DeMar', 'DeRozan', '6 7', 230, '1991-02-15', 1, 4, 2, 1),
('Kyrie', 'Irvina', '6 5', 225, '1989-08-05', 4, 2, 1, 2),
('Stephen', 'Curry', '6 3', 190, '1988-05-23', 2, 3, 2, 3),
('John', 'Wall', '6 4', 210, '1989-12-17', 2, 5, 3, 4),
('Thaddeus', 'Youna', '6 8', 221, '1988-03-15', 2, 6, 1, 2);

-- 1
SELECT first_name AS 'First Name', last_name AS 'Last Name', team_name AS 'Team', height AS 'Height', 
	weight AS 'Weight', LEFT((CAST(NOW() AS DATE)) - date_of_birth, 2) AS 'Age', 
	position_name AS 'Position', country_name AS 'Country', university_name AS 'University'
FROM players pl JOIN teams t JOIN positions pos JOIN countries c JOIN universities u
	ON pl.team_id = t.team_id
		AND pl.position_id = pos.position_id
		AND pl.country_id = c.country_id
		AND pl.university_id = u.university_id
ORDER BY last_name;

-- 2
SELECT t1.team_name AS 'Visiting Team', t2.team_name AS 'Home Team', match_date AS 'Date', arena_name AS 'Arena'
FROM teams t1 JOIN teams t2 JOIN matches m JOIN arenas a
	ON t1.team_id = m.away_team_id
		AND t2.team_id = m.home_team_id
        AND t2.team_arena_id = a.arena_id; 