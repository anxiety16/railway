-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema preserved
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema preserved
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `preserved` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `preserved` ;

-- -----------------------------------------------------
-- Table `preserved`.`classes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `preserved`.`classes` (
  `class_code` VARCHAR(10) NOT NULL,
  `class_description` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`class_code`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `preserved`.`origins`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `preserved`.`origins` (
  `origin_code` VARCHAR(10) NOT NULL,
  `origin_description` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`origin_code`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `preserved`.`types`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `preserved`.`types` (
  `type_code` VARCHAR(10) NOT NULL,
  `type_description` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`type_code`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `preserved`.`railway_lines`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `preserved`.`railway_lines` (
  `line_number` INT NOT NULL,
  `class_code` VARCHAR(10) NULL DEFAULT NULL,
  `origin_code` VARCHAR(10) NULL DEFAULT NULL,
  `type_code` VARCHAR(10) NULL DEFAULT NULL,
  `steam_or_diesel` VARCHAR(50) NULL DEFAULT NULL,
  `line_name` VARCHAR(255) NULL DEFAULT NULL,
  `address` TEXT NULL DEFAULT NULL,
  `phone_number` VARCHAR(15) NULL DEFAULT NULL,
  `fax_number` VARCHAR(15) NULL DEFAULT NULL,
  `nearest_mainline_station` VARCHAR(255) NULL DEFAULT NULL,
  `resident_locos_url` TEXT NULL DEFAULT NULL,
  `route_map_url` TEXT NULL DEFAULT NULL,
  `website_url` TEXT NULL DEFAULT NULL,
  `total_miles` DECIMAL(5,2) NULL DEFAULT NULL,
  `year_opened` INT NULL DEFAULT NULL,
  `membership_prices` DECIMAL(10,2) NULL DEFAULT NULL,
  `year_built` INT NULL DEFAULT NULL,
  `other_details` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`line_number`),
  INDEX `class_code` (`class_code` ASC) VISIBLE,
  INDEX `origin_code` (`origin_code` ASC) VISIBLE,
  INDEX `type_code` (`type_code` ASC) VISIBLE,
  CONSTRAINT `railway_lines_ibfk_1`
    FOREIGN KEY (`class_code`)
    REFERENCES `preserved`.`classes` (`class_code`),
  CONSTRAINT `railway_lines_ibfk_2`
    FOREIGN KEY (`origin_code`)
    REFERENCES `preserved`.`origins` (`origin_code`),
  CONSTRAINT `railway_lines_ibfk_3`
    FOREIGN KEY (`type_code`)
    REFERENCES `preserved`.`types` (`type_code`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `preserved`.`station_stops`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `preserved`.`station_stops` (
  `station_id` INT NOT NULL,
  `line_id` INT NULL DEFAULT NULL,
  `next_station_id` INT NULL DEFAULT NULL,
  `station_name` VARCHAR(255) NULL DEFAULT NULL,
  `first_stop_yn` TINYINT(1) NULL DEFAULT NULL,
  `last_stop_yn` TINYINT(1) NULL DEFAULT NULL,
  `other_details` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`station_id`),
  INDEX `line_id` (`line_id` ASC) VISIBLE,
  INDEX `next_station_id` (`next_station_id` ASC) VISIBLE,
  CONSTRAINT `station_stops_ibfk_1`
    FOREIGN KEY (`line_id`)
    REFERENCES `preserved`.`railway_lines` (`line_number`),
  CONSTRAINT `station_stops_ibfk_2`
    FOREIGN KEY (`next_station_id`)
    REFERENCES `preserved`.`station_stops` (`station_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
