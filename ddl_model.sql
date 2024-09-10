-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema hospital
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema hospital
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `hospital` DEFAULT CHARACTER SET utf8 ;
USE `hospital` ;

-- -----------------------------------------------------
-- Table `hospital`.`Patients`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospital`.`Patients` (
  `patient_pesel` CHAR(11) NOT NULL,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `date_of_birth` DATE NOT NULL,
  `gender` CHAR(1) NOT NULL,
  `contact_number` VARCHAR(20) NOT NULL,
  `email` VARCHAR(60) NULL,
  `city` VARCHAR(45) NOT NULL,
  `street` VARCHAR(45) NULL,
  `address_number` VARCHAR(45) NOT NULL,
  `postal_code` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`patient_pesel`),
  UNIQUE INDEX `patient_pesel_UNIQUE` (`patient_pesel` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospital`.`Specializations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospital`.`Specializations` (
  `specialization_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`specialization_id`),
  UNIQUE INDEX `specialization_id_UNIQUE` (`specialization_id` ASC) VISIBLE,
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospital`.`Departments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospital`.`Departments` (
  `department_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`department_id`),
  UNIQUE INDEX `department_id_UNIQUE` (`department_id` ASC) VISIBLE,
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospital`.`Doctors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospital`.`Doctors` (
  `doctor_id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `date_of_birth` DATE NOT NULL,
  `contact_number` VARCHAR(20) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `street` VARCHAR(45) NULL,
  `postal_code` VARCHAR(45) NOT NULL,
  `address_number` VARCHAR(45) NOT NULL,
  `specialization_id` INT NOT NULL,
  `department_id` INT NOT NULL,
  PRIMARY KEY (`doctor_id`),
  UNIQUE INDEX `doctor_id_UNIQUE` (`doctor_id` ASC) VISIBLE,
  INDEX `department_id_idx` (`department_id` ASC) VISIBLE,
  INDEX `fk_specialization_id_idx` (`specialization_id` ASC) VISIBLE,
  CONSTRAINT `fk_specialization_id_doctor`
    FOREIGN KEY (`specialization_id`)
    REFERENCES `hospital`.`Specializations` (`specialization_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_department_id_doctor`
    FOREIGN KEY (`department_id`)
    REFERENCES `hospital`.`Departments` (`department_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospital`.`Appointments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospital`.`Appointments` (
  `appointment_id` INT NOT NULL AUTO_INCREMENT,
  `patient_pesel` CHAR(11) NOT NULL,
  `doctor_id` INT NOT NULL,
  `appointment_date` DATE NOT NULL,
  `description` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`appointment_id`),
  UNIQUE INDEX `appointments_id_UNIQUE` (`appointment_id` ASC) INVISIBLE,
  INDEX `fk_patient_pesel_idx` (`patient_pesel` ASC) VISIBLE,
  INDEX `fk_doctor_id_idx` (`doctor_id` ASC) VISIBLE,
  CONSTRAINT `fk_patient_pesel_appointment`
    FOREIGN KEY (`patient_pesel`)
    REFERENCES `hospital`.`Patients` (`patient_pesel`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_doctor_id_appointment`
    FOREIGN KEY (`doctor_id`)
    REFERENCES `hospital`.`Doctors` (`doctor_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospital`.`Prescriptions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospital`.`Prescriptions` (
  `prescription_id` INT NOT NULL AUTO_INCREMENT,
  `prescription_date` DATE NOT NULL,
  `medication_name` VARCHAR(45) NOT NULL,
  `dosage` VARCHAR(20) NOT NULL,
  `appointment_id` INT NOT NULL,
  PRIMARY KEY (`prescription_id`),
  INDEX `fk_Prescriptions_Appointments1_idx` (`appointment_id` ASC) VISIBLE,
  UNIQUE INDEX `prescriptions_id_UNIQUE` (`prescription_id` ASC) VISIBLE,
  CONSTRAINT `fk_appointment_id_prescription`
    FOREIGN KEY (`appointment_id`)
    REFERENCES `hospital`.`Appointments` (`appointment_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospital`.`Tests`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospital`.`Tests` (
  `test_id` INT NOT NULL AUTO_INCREMENT,
  `patient_pesel` CHAR(11) NOT NULL,
  `doctor_id` INT NOT NULL,
  `test_date` DATE NOT NULL,
  `description` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`test_id`),
  UNIQUE INDEX `test_id_UNIQUE` (`test_id` ASC) VISIBLE,
  INDEX `fk_patient_pesel_idx` (`patient_pesel` ASC) VISIBLE,
  INDEX `fk_doctor_id_idx` (`doctor_id` ASC) VISIBLE,
  CONSTRAINT `fk_patient_pesel_test`
    FOREIGN KEY (`patient_pesel`)
    REFERENCES `hospital`.`Patients` (`patient_pesel`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_doctor_id_test`
    FOREIGN KEY (`doctor_id`)
    REFERENCES `hospital`.`Doctors` (`doctor_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospital`.`Staff_Roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospital`.`Staff_Roles` (
  `staff_role_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`staff_role_id`),
  UNIQUE INDEX `staff_role_id_UNIQUE` (`staff_role_id` ASC) VISIBLE,
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospital`.`Staff`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospital`.`Staff` (
  `staff_id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `date_of_birth` DATE NOT NULL,
  `contact_number` VARCHAR(20) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `street` VARCHAR(45) NOT NULL,
  `postal_code` VARCHAR(45) NOT NULL,
  `address_number` VARCHAR(45) NOT NULL,
  `department_id` INT NULL,
  `staff_role_id` INT NOT NULL,
  PRIMARY KEY (`staff_id`),
  UNIQUE INDEX `staff_id_UNIQUE` (`staff_id` ASC) VISIBLE,
  INDEX `fk_department_id_idx` (`department_id` ASC) VISIBLE,
  INDEX `fk_staff_role_id_idx` (`staff_role_id` ASC) VISIBLE,
  CONSTRAINT `fk_department_id_staff`
    FOREIGN KEY (`department_id`)
    REFERENCES `hospital`.`Departments` (`department_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_staff_role_id_staff`
    FOREIGN KEY (`staff_role_id`)
    REFERENCES `hospital`.`Staff_Roles` (`staff_role_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospital`.`Surgeries`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospital`.`Surgeries` (
  `surgery_id` INT NOT NULL AUTO_INCREMENT,
  `patient_pesel` CHAR(11) NOT NULL,
  `doctor_id` INT NOT NULL,
  `date_surgery` DATE NOT NULL,
  `description` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`surgery_id`),
  UNIQUE INDEX `surgery_id_UNIQUE` (`surgery_id` ASC) VISIBLE,
  INDEX `fk_patient_pesel_idx` (`patient_pesel` ASC) VISIBLE,
  INDEX `fk_doctor_id_idx` (`doctor_id` ASC) VISIBLE,
  CONSTRAINT `fk_patient_pesel_surgery`
    FOREIGN KEY (`patient_pesel`)
    REFERENCES `hospital`.`Patients` (`patient_pesel`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_doctor_id_surgery`
    FOREIGN KEY (`doctor_id`)
    REFERENCES `hospital`.`Doctors` (`doctor_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
