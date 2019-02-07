-- Alexey Milovanov
-- Comp-269 Final Exam
-- 12.17.18
-- Instructor: Dr. Yin Bao

-- Problem 1
    

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema university
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema university
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `university` DEFAULT CHARACTER SET latin1 ;
USE `university` ;

-- -----------------------------------------------------
-- Table `university`.`faculty`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`faculty` ;

CREATE TABLE IF NOT EXISTS `university`.`faculty` (
  `facultyID` INT(11) NOT NULL AUTO_INCREMENT,
  `lastName` VARCHAR(50) NULL DEFAULT NULL,
  `department` VARCHAR(50) NULL DEFAULT NULL,
  `rank` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`facultyID`) );

-- -----------------------------------------------------
-- Table `university`.`class`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`class` ;

CREATE TABLE IF NOT EXISTS `university`.`class` (
  `classID` INT(11) NOT NULL AUTO_INCREMENT,
  `facultyID` INT(11) NULL DEFAULT NULL,
  `classSchedule` VARCHAR(50) NULL DEFAULT NULL,
  `room` INT NULL DEFAULT NULL,
  PRIMARY KEY (`classID`) ,
  INDEX `facultyID_fk_class` (`facultyID` ASC) ,
  CONSTRAINT `facultyID_fk_class`
    FOREIGN KEY (`facultyID`)
    REFERENCES `university`.`faculty` (`facultyID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `university`.`student`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`student` ;

CREATE TABLE IF NOT EXISTS `university`.`student` (
  `studentID` INT(11) NOT NULL AUTO_INCREMENT,
  `lastName` VARCHAR(50) NULL DEFAULT NULL,
  `firstName` VARCHAR(50) NULL DEFAULT NULL,
  `major` VARCHAR(50) NULL DEFAULT NULL,
  `credits` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`studentID`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `university`.`enroll`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`enroll` ;

CREATE TABLE IF NOT EXISTS `university`.`enroll` (
  `studentID` INT(11) NULL DEFAULT NULL,
  `classID` INT(11) NULL DEFAULT NULL,
  `grade` INT NULL DEFAULT NULL,
  INDEX `studentID_fk_enroll` (`studentID` ASC) ,
  INDEX `classID_fk_enroll` (`classID` ASC) ,
  CONSTRAINT `classID_fk_enroll`
    FOREIGN KEY (`classID`)
    REFERENCES `university`.`class` (`classID`),
  CONSTRAINT `studentID_fk_enroll`
    FOREIGN KEY (`studentID`)
    REFERENCES `university`.`student` (`studentID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
