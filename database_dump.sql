-- MySQL dump 10.13  Distrib 8.3.0, for Win64 (x86_64)
--
-- Host: localhost    Database: hospital
-- ------------------------------------------------------
-- Server version	8.3.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `appointments`
--

DROP TABLE IF EXISTS `appointments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appointments`
--

LOCK TABLES `appointments` WRITE;
/*!40000 ALTER TABLE `appointments` DISABLE KEYS */;
INSERT INTO `appointments` VALUES (1,'55050598000',1,'2024-03-03','Rest, monthly check-up'),(3,'78112233445',3,'2024-05-07','Rest, monthly check-up');
/*!40000 ALTER TABLE `appointments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `departments`
--

DROP TABLE IF EXISTS `departments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `departments` (
  `department_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`department_id`),
  UNIQUE KEY `department_id_UNIQUE` (`department_id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `departments`
--

LOCK TABLES `departments` WRITE;
/*!40000 ALTER TABLE `departments` DISABLE KEYS */;
INSERT INTO `departments` VALUES (2,'Cardiology'),(3,'Larynology'),(1,'Orthopedics');
/*!40000 ALTER TABLE `departments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doctors`
--

DROP TABLE IF EXISTS `doctors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctors`
--

LOCK TABLES `doctors` WRITE;
/*!40000 ALTER TABLE `doctors` DISABLE KEYS */;
INSERT INTO `doctors` VALUES (1,'Adam','Piston','1979-05-05','444000000','adam@piston.pl','Warszawa','Wolna','11-300','13',1,1),(2,'Piotr','Stonoga','1989-05-05','404556333','piotr@stonoga.pl','Poznań','Szybka','11-400','13W',2,2),(3,'Monika','Nowak','1988-05-07','505556493','monika@nowak.pl','Gdynia','Centralna','22-300','123',3,3);
/*!40000 ALTER TABLE `doctors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patients`
--

DROP TABLE IF EXISTS `patients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patients`
--

LOCK TABLES `patients` WRITE;
/*!40000 ALTER TABLE `patients` DISABLE KEYS */;
INSERT INTO `patients` VALUES ('55050598000','Jan','Brzechwa','1955-05-05','M','606556493','jan@brzechwa.pl','Lublin','Zabytkowa','123','22-150'),('78112233445','Rafał','Nowak','1978-11-22','F',' 500600100','peter@nowak.pl','Lublin','Kolorowa','15','22-111');
/*!40000 ALTER TABLE `patients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prescriptions`
--

DROP TABLE IF EXISTS `prescriptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prescriptions`
--

LOCK TABLES `prescriptions` WRITE;
/*!40000 ALTER TABLE `prescriptions` DISABLE KEYS */;
INSERT INTO `prescriptions` VALUES (1,'2024-03-03','APAP','Every morning',1),(3,'2024-05-07','KAJAK','Every morning',3);
/*!40000 ALTER TABLE `prescriptions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `specializations`
--

DROP TABLE IF EXISTS `specializations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `specializations` (
  `specialization_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`specialization_id`),
  UNIQUE KEY `specialization_id_UNIQUE` (`specialization_id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `specializations`
--

LOCK TABLES `specializations` WRITE;
/*!40000 ALTER TABLE `specializations` DISABLE KEYS */;
INSERT INTO `specializations` VALUES (2,'cardiologist'),(3,'laryngologist'),(1,'orthopaedist');
/*!40000 ALTER TABLE `specializations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `staff`
--

DROP TABLE IF EXISTS `staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff`
--

LOCK TABLES `staff` WRITE;
/*!40000 ALTER TABLE `staff` DISABLE KEYS */;
INSERT INTO `staff` VALUES (1,'Janina','Pogodna','1999-09-09','606667788','janina@pogodna.pl','Lublin','Modna','12-345','34',1,1),(2,'Jagoda','Nowak','2000-09-09','505667788','jagoda@nowak.pl','Lublin','Powolna','09-345','34C',2,2);
/*!40000 ALTER TABLE `staff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `staff_roles`
--

DROP TABLE IF EXISTS `staff_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `staff_roles` (
  `staff_role_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`staff_role_id`),
  UNIQUE KEY `staff_role_id_UNIQUE` (`staff_role_id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff_roles`
--

LOCK TABLES `staff_roles` WRITE;
/*!40000 ALTER TABLE `staff_roles` DISABLE KEYS */;
INSERT INTO `staff_roles` VALUES (2,'DOCTOR'),(1,'NURSE');
/*!40000 ALTER TABLE `staff_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `surgeries`
--

DROP TABLE IF EXISTS `surgeries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `surgeries`
--

LOCK TABLES `surgeries` WRITE;
/*!40000 ALTER TABLE `surgeries` DISABLE KEYS */;
INSERT INTO `surgeries` VALUES (1,'55050598000',1,'2022-03-05','rest'),(3,'78112233445',3,'2022-03-12','rest');
/*!40000 ALTER TABLE `surgeries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tests`
--

DROP TABLE IF EXISTS `tests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tests`
--

LOCK TABLES `tests` WRITE;
/*!40000 ALTER TABLE `tests` DISABLE KEYS */;
INSERT INTO `tests` VALUES (1,'55050598000',1,'2023-09-09','rest 3 month'),(3,'78112233445',3,'2023-12-09','rest 3 month');
/*!40000 ALTER TABLE `tests` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-06-17 17:35:42
