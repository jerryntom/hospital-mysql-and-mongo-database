CREATE DATABASE `hospital` /*!40100 DEFAULT CHARACTER SET utf8mb3 */ /*!80016 DEFAULT ENCRYPTION='N' */;

CREATE TABLE `appointments` (
  `appointment_id` int NOT NULL AUTO_INCREMENT,
  `patient_pesel` char(11) NOT NULL,
  `doctor_id` int NOT NULL,
  `appointment_date` date NOT NULL,
  `description` varchar(200) NOT NULL,
  PRIMARY KEY (`appointment_id`),
  UNIQUE KEY `appointments_id_UNIQUE` (`appointment_id`) /*!80000 INVISIBLE */,
  KEY `fk_patient_pesel_idx` (`patient_pesel`),
  KEY `fk_doctor_id_idx` (`doctor_id`),
  CONSTRAINT `fk_doctor_id_appointment` FOREIGN KEY (`doctor_id`) REFERENCES `doctors` (`doctor_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_patient_pesel_appointment` FOREIGN KEY (`patient_pesel`) REFERENCES `patients` (`patient_pesel`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;

CREATE TABLE `departments` (
  `department_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`department_id`),
  UNIQUE KEY `department_id_UNIQUE` (`department_id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3;

CREATE TABLE `doctors` (
  `doctor_id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(45) NOT NULL,
  `last_name` varchar(45) NOT NULL,
  `date_of_birth` date NOT NULL,
  `contact_number` varchar(20) NOT NULL,
  `email` varchar(45) NOT NULL,
  `city` varchar(45) NOT NULL,
  `street` varchar(45) DEFAULT NULL,
  `postal_code` varchar(45) NOT NULL,
  `address_number` varchar(45) NOT NULL,
  `specialization_id` int NOT NULL,
  `department_id` int NOT NULL,
  PRIMARY KEY (`doctor_id`),
  UNIQUE KEY `doctor_id_UNIQUE` (`doctor_id`),
  KEY `department_id_idx` (`department_id`),
  KEY `fk_specialization_id_idx` (`specialization_id`),
  CONSTRAINT `fk_department_id_doctor` FOREIGN KEY (`department_id`) REFERENCES `departments` (`department_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_specialization_id_doctor` FOREIGN KEY (`specialization_id`) REFERENCES `specializations` (`specialization_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;

CREATE TABLE `patients` (
  `patient_pesel` char(11) NOT NULL,
  `first_name` varchar(45) NOT NULL,
  `last_name` varchar(45) NOT NULL,
  `date_of_birth` date NOT NULL,
  `gender` char(1) NOT NULL,
  `contact_number` varchar(20) NOT NULL,
  `email` varchar(60) DEFAULT NULL,
  `city` varchar(45) NOT NULL,
  `street` varchar(45) DEFAULT NULL,
  `address_number` varchar(45) NOT NULL,
  `postal_code` varchar(45) NOT NULL,
  PRIMARY KEY (`patient_pesel`),
  UNIQUE KEY `patient_pesel_UNIQUE` (`patient_pesel`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

CREATE TABLE `prescriptions` (
  `prescription_id` int NOT NULL AUTO_INCREMENT,
  `prescription_date` date NOT NULL,
  `medication_name` varchar(45) NOT NULL,
  `dosage` varchar(20) NOT NULL,
  `appointment_id` int NOT NULL,
  PRIMARY KEY (`prescription_id`),
  UNIQUE KEY `prescriptions_id_UNIQUE` (`prescription_id`),
  KEY `fk_Prescriptions_Appointments1_idx` (`appointment_id`),
  CONSTRAINT `fk_appointment_id_prescription` FOREIGN KEY (`appointment_id`) REFERENCES `appointments` (`appointment_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;

CREATE TABLE `specializations` (
  `specialization_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`specialization_id`),
  UNIQUE KEY `specialization_id_UNIQUE` (`specialization_id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;

CREATE TABLE `staff` (
  `staff_id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(45) NOT NULL,
  `last_name` varchar(45) NOT NULL,
  `date_of_birth` date NOT NULL,
  `contact_number` varchar(20) NOT NULL,
  `email` varchar(45) NOT NULL,
  `city` varchar(45) NOT NULL,
  `street` varchar(45) NOT NULL,
  `postal_code` varchar(45) NOT NULL,
  `address_number` varchar(45) NOT NULL,
  `department_id` int DEFAULT NULL,
  `staff_role_id` int NOT NULL,
  PRIMARY KEY (`staff_id`),
  UNIQUE KEY `staff_id_UNIQUE` (`staff_id`),
  KEY `fk_department_id_idx` (`department_id`),
  KEY `fk_staff_role_id_idx` (`staff_role_id`),
  CONSTRAINT `fk_department_id_staff` FOREIGN KEY (`department_id`) REFERENCES `departments` (`department_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_staff_role_id_staff` FOREIGN KEY (`staff_role_id`) REFERENCES `staff_roles` (`staff_role_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;

CREATE TABLE `staff_roles` (
  `staff_role_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`staff_role_id`),
  UNIQUE KEY `staff_role_id_UNIQUE` (`staff_role_id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;

CREATE TABLE `surgeries` (
  `surgery_id` int NOT NULL AUTO_INCREMENT,
  `patient_pesel` char(11) NOT NULL,
  `doctor_id` int NOT NULL,
  `date_surgery` date NOT NULL,
  `description` varchar(200) NOT NULL,
  PRIMARY KEY (`surgery_id`),
  UNIQUE KEY `surgery_id_UNIQUE` (`surgery_id`),
  KEY `fk_patient_pesel_idx` (`patient_pesel`),
  KEY `fk_doctor_id_idx` (`doctor_id`),
  CONSTRAINT `fk_doctor_id_surgery` FOREIGN KEY (`doctor_id`) REFERENCES `doctors` (`doctor_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_patient_pesel_surgery` FOREIGN KEY (`patient_pesel`) REFERENCES `patients` (`patient_pesel`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;

CREATE TABLE `tests` (
  `test_id` int NOT NULL AUTO_INCREMENT,
  `patient_pesel` char(11) NOT NULL,
  `doctor_id` int NOT NULL,
  `test_date` date NOT NULL,
  `description` varchar(200) NOT NULL,
  PRIMARY KEY (`test_id`),
  UNIQUE KEY `test_id_UNIQUE` (`test_id`),
  KEY `fk_patient_pesel_idx` (`patient_pesel`),
  KEY `fk_doctor_id_idx` (`doctor_id`),
  CONSTRAINT `fk_doctor_id_test` FOREIGN KEY (`doctor_id`) REFERENCES `doctors` (`doctor_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_patient_pesel_test` FOREIGN KEY (`patient_pesel`) REFERENCES `patients` (`patient_pesel`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
