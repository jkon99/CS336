CREATE DATABASE  IF NOT EXISTS `trainReservation` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `trainReservation`;
-- MySQL dump 10.13  Distrib 8.0.22, for Win64 (x86_64)
--
-- Host: dbcs336.cuofhdbvefx8.us-east-2.rds.amazonaws.com    Database: trainReservation
-- ------------------------------------------------------
-- Server version	8.0.20

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ '';

--
-- Table structure for table `Customer`
--

DROP TABLE IF EXISTS `Customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Customer` (
  `username` varchar(20) NOT NULL,
  `password` varchar(20) DEFAULT NULL,
  `email` varchar(30) DEFAULT NULL,
  `firstname` varchar(20) DEFAULT NULL,
  `lastname` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Customer`
--

LOCK TABLES `Customer` WRITE;
/*!40000 ALTER TABLE `Customer` DISABLE KEYS */;
INSERT INTO `Customer` VALUES ('asd','asd','asd@gmail.com','John','Smith'),('BobbyPatel','asd','bobbyPatel@gmail.com','Bob','Patel'),('Customer1','asd','asdasd@gmail.com','Test','Test'),('jgc122','Problem?33','jchoucrallah22@gmail.com','jessie','choucrallah'),('jk1549','3aXbb7z0','jonathankonopka12@gmail.com','Jonathan','Konopka'),('jk15490','3aXbb7z0','jonathankonopka12@gmail.com','Jon','Konopka'),('testKu','testKu','ku@email.com','Nick','Ku');
/*!40000 ALTER TABLE `Customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Employee`
--

DROP TABLE IF EXISTS `Employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Employee` (
  `username` varchar(20) DEFAULT NULL,
  `password` varchar(20) DEFAULT NULL,
  `firstname` varchar(20) DEFAULT NULL,
  `lastname` varchar(20) DEFAULT NULL,
  `SSN` varchar(9) NOT NULL,
  PRIMARY KEY (`SSN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Employee`
--

LOCK TABLES `Employee` WRITE;
/*!40000 ALTER TABLE `Employee` DISABLE KEYS */;
INSERT INTO `Employee` VALUES ('TestUserAdd','asd','bob','smith','000000005'),('testKu','1234','Nick','Ku','1111111'),('bob','bob','bob','Smith','111111111'),('anon','Anon','Anon','Anon','123455555'),('TestUser1','asd','John','Smithy','123456789'),('emp','12345','employee','smith','192837465'),('jk1549','3aXbb7z0','Jon','Konopka','302139129'),('jc122','Problem?33','jessie','choucrallah','33333333'),('jesschouc','Problem?33','jessie','chouc','333333333'),('testKu','1234','Nick ','Ku','987654321');
/*!40000 ALTER TABLE `Employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Question`
--

DROP TABLE IF EXISTS `Question`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Question` (
  `question` varchar(100) NOT NULL,
  `answer` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`question`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Handle QA in database';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Question`
--

LOCK TABLES `Question` WRITE;
/*!40000 ALTER TABLE `Question` DISABLE KEYS */;
INSERT INTO `Question` VALUES ('TestAnswer','Good job!'),('TestQuestion',''),('This is testing a long question to fit into the table!',''),('What else?','Answer'),('Where to go?','Answer');
/*!40000 ALTER TABLE `Question` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Reservation`
--

DROP TABLE IF EXISTS `Reservation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Reservation` (
  `reservationNumber` int NOT NULL,
  `reservationDate` date DEFAULT NULL,
  `username` varchar(20) DEFAULT NULL,
  `transitLineName` varchar(30) NOT NULL,
  `trainID` int NOT NULL,
  `originStationID` int NOT NULL,
  `destinationStationID` int NOT NULL,
  `departureTime` time DEFAULT NULL,
  `departureDate` date DEFAULT NULL,
  `totalFare` double DEFAULT NULL,
  `active` tinyint DEFAULT NULL,
  PRIMARY KEY (`reservationNumber`),
  KEY `transitLineName` (`transitLineName`,`trainID`,`originStationID`,`destinationStationID`),
  KEY `username` (`username`),
  CONSTRAINT `Reservation_ibfk_1` FOREIGN KEY (`transitLineName`, `trainID`, `originStationID`, `destinationStationID`) REFERENCES `Schedule` (`transitLineName`, `trainID`, `originStationID`, `destinationStationID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Reservation_ibfk_2` FOREIGN KEY (`username`) REFERENCES `Customer` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Reservation`
--

LOCK TABLES `Reservation` WRITE;
/*!40000 ALTER TABLE `Reservation` DISABLE KEYS */;
INSERT INTO `Reservation` VALUES (0,'2020-11-19','asd','Cannonballrun',0,0,1,'18:30:00','2020-01-20',1500,1),(1,'2020-11-19','asd','Cannonballrun',0,0,1,'18:30:00','2020-01-20',525,0),(2,'2020-11-19','asd','Cannonballrun',0,0,1,'18:30:00','2020-01-20',375,0),(3,'2020-11-19','asd','Cannonballrun',0,0,1,'18:30:00','2020-01-20',1125,0),(4,'2020-11-19','asd','Cannonballrun',0,0,1,'18:30:00','2020-01-20',975,1),(5,'2020-11-19','asd','Cannonballrun',0,0,1,'18:30:00','2020-01-20',750,1),(6,'2020-11-19','asd','Cannonballrun',0,0,1,'18:30:00','2020-01-20',1500,1),(7,'2020-11-30','BobbyPatel','Cannonballrun',0,0,1,'18:30:00','2020-01-20',1500,1),(8,'2020-11-30','BobbyPatel','Cannonballrun',0,0,1,'18:30:00','2020-01-20',975,1),(9,'2020-11-30','BobbyPatel','Cannonballrun',0,0,1,'18:30:00','2020-01-20',1125,1),(10,'2020-11-30','BobbyPatel','Cannonballrun',0,0,1,'18:30:00','2020-01-20',750,1),(11,'2020-11-30','BobbyPatel','Cannonballrun',0,0,1,'18:30:00','2020-01-20',750,1),(12,'2020-11-30','BobbyPatel','Cannonballrun',0,0,1,'18:30:00','2020-01-20',1500,1),(13,'2020-11-30','BobbyPatel','Cannonballrun',0,0,1,'18:30:00','2020-01-20',1500,1),(14,'2020-11-30','BobbyPatel','OregonTrail',3,1,3,'13:00:00','2020-12-08',10000,1),(15,'2020-12-02','asd','Cardinal',1,0,3,'16:00:00','2020-01-15',3000,1),(16,'2020-12-02','asd','Aflack',2,1,2,'17:30:00','2020-02-20',975,1),(17,'2020-11-19','asd','Cannonballrun',0,0,1,'18:30:00','2020-01-20',1500,1),(18,'2020-11-19','BobbyPatel','Cannonballrun',0,0,1,'18:30:00','2020-01-20',1500,1),(19,'2020-11-19','testKu','Cannonballrun',0,0,1,'18:30:00','2020-01-20',1500,1),(20,'2020-12-04','jk15490','Aflack',2,1,2,'17:30:00','2020-02-20',1500,1),(21,'2020-12-02','BobbyPatel','Aflack',2,1,2,'17:30:00','2020-02-20',975,1),(22,'2020-12-08','asd','OregonTrail',3,1,3,'13:00:00','2020-04-11',10000,0),(23,'2020-12-08','asd','OregonTrail',3,1,3,'13:00:00','2020-04-11',6500,0),(24,'2020-12-08','asd','OregonTrail',3,1,3,'13:00:00','2020-04-11',7500,1),(25,'2020-12-08','asd','OregonTrail',3,1,3,'13:00:00','2020-04-11',5000,1);
/*!40000 ALTER TABLE `Reservation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Schedule`
--

DROP TABLE IF EXISTS `Schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Schedule` (
  `transitLineName` varchar(30) NOT NULL,
  `trainID` int NOT NULL,
  `originStationID` int NOT NULL,
  `destinationStationID` int NOT NULL,
  `arrivalDatetime` datetime DEFAULT NULL,
  `departDatetime` datetime DEFAULT NULL,
  `tripType` varchar(11) DEFAULT NULL,
  `fixedFare` double DEFAULT NULL,
  PRIMARY KEY (`transitLineName`,`trainID`,`originStationID`,`destinationStationID`),
  KEY `originStationID` (`originStationID`),
  KEY `destinationStationID` (`destinationStationID`),
  KEY `trainID` (`trainID`),
  CONSTRAINT `Schedule_ibfk_1` FOREIGN KEY (`originStationID`) REFERENCES `Station` (`stationID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Schedule_ibfk_2` FOREIGN KEY (`destinationStationID`) REFERENCES `Station` (`stationID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Schedule_ibfk_3` FOREIGN KEY (`trainID`) REFERENCES `Train` (`trainID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Schedule`
--

LOCK TABLES `Schedule` WRITE;
/*!40000 ALTER TABLE `Schedule` DISABLE KEYS */;
INSERT INTO `Schedule` VALUES ('Aflack',2,1,2,'2020-02-20 15:00:00','2020-02-20 17:30:00','One way',1500),('Cannonballrun',0,0,1,'2020-01-20 17:30:00','2020-01-20 18:30:00','One way',1500),('Cannonballrun',5,0,1,'2020-01-20 17:30:00','2020-01-20 18:30:00','Round Trip',2000),('Cardinal',1,0,3,'2020-01-15 10:00:00','2020-01-15 16:00:00','Round Trip',3000),('NJTransit',3,0,2,'2020-05-10 17:30:00','2020-05-11 18:30:00','One Way',60),('OregonTrail',3,1,3,'2020-04-10 09:00:00','2020-04-11 13:00:00','One Way',10000),('SilverStar',4,2,4,'2020-12-23 09:00:00','2020-12-23 22:00:00','One Way',9000),('Testschedule',7,2,5,'2020-05-10 16:30:00','2020-05-10 17:30:00','One Way',150);
/*!40000 ALTER TABLE `Schedule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Station`
--

DROP TABLE IF EXISTS `Station`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Station` (
  `stationID` int NOT NULL,
  `stationName` varchar(60) DEFAULT NULL,
  `state` varchar(20) DEFAULT NULL,
  `city` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`stationID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Station`
--

LOCK TABLES `Station` WRITE;
/*!40000 ALTER TABLE `Station` DISABLE KEYS */;
INSERT INTO `Station` VALUES (0,'Station1','New Jersey','New Brunswick'),(1,'Station2','California','Hollywood'),(2,'Station3','New York','New York City'),(3,'Station4','Alaska','Cold'),(4,'Station5','Texas','Austin'),(5,'Station6','Delaware','Washington'),(6,'Station7','Nevada','Las Vegas'),(7,'Witchita Station','Kansas','Wichita'),(8,'LouisVille Station','Kentucky','LouisVille'),(9,'Charleston station','West Virginia','Charleston'),(10,'Alaska Station','Alaska','Oil');
/*!40000 ALTER TABLE `Station` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Stop`
--

DROP TABLE IF EXISTS `Stop`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Stop` (
  `stopStationID` int NOT NULL,
  `transitLineName` varchar(30) NOT NULL,
  `trainID` int NOT NULL,
  `originStationID` int NOT NULL,
  `destinationStationID` int NOT NULL,
  `arrivalTime` time DEFAULT NULL,
  `departTime` time DEFAULT NULL,
  `stopNumber` int DEFAULT NULL,
  `fare` double DEFAULT NULL,
  PRIMARY KEY (`stopStationID`,`transitLineName`,`trainID`,`originStationID`,`destinationStationID`),
  KEY `transitLineName` (`transitLineName`,`trainID`,`originStationID`,`destinationStationID`),
  CONSTRAINT `Stop_ibfk_1` FOREIGN KEY (`stopStationID`) REFERENCES `Station` (`stationID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Stop_ibfk_2` FOREIGN KEY (`transitLineName`, `trainID`, `originStationID`, `destinationStationID`) REFERENCES `Schedule` (`transitLineName`, `trainID`, `originStationID`, `destinationStationID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Stop`
--

LOCK TABLES `Stop` WRITE;
/*!40000 ALTER TABLE `Stop` DISABLE KEYS */;
INSERT INTO `Stop` VALUES (2,'Cannonballrun',0,0,1,'21:00:00','21:30:00',1,150),(2,'Cannonballrun',5,0,1,'15:30:00','16:30:00',1,200),(2,'NJTransit',3,0,2,'17:30:00','19:00:00',1,150),(4,'Cannonballrun',0,0,1,'12:00:00','13:00:00',3,150),(5,'Cannonballrun',0,0,1,'16:00:00','16:30:00',2,150),(5,'Cannonballrun',5,0,1,'19:30:00','20:30:00',2,200),(7,'Cannonballrun',0,0,1,'13:45:00','14:00:00',5,150),(7,'Cannonballrun',5,0,1,'19:30:00','20:30:00',3,200),(8,'Cannonballrun',0,0,1,'15:15:00','18:00:00',6,150),(8,'Cannonballrun',5,0,1,'16:30:00','18:30:00',4,200),(9,'Cannonballrun',0,0,1,'09:00:00','10:00:00',4,150);
/*!40000 ALTER TABLE `Stop` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Train`
--

DROP TABLE IF EXISTS `Train`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Train` (
  `trainID` int NOT NULL,
  PRIMARY KEY (`trainID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Train`
--

LOCK TABLES `Train` WRITE;
/*!40000 ALTER TABLE `Train` DISABLE KEYS */;
INSERT INTO `Train` VALUES (0),(1),(2),(3),(4),(5),(6),(7),(8),(9),(10),(11),(12),(13),(14),(15),(16),(17),(18),(19),(20);
/*!40000 ALTER TABLE `Train` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin` (
  `username` varchar(20) NOT NULL,
  `password` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin`
--

LOCK TABLES `admin` WRITE;
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
INSERT INTO `admin` VALUES ('admin','theadmin');
/*!40000 ALTER TABLE `admin` ENABLE KEYS */;
UNLOCK TABLES;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-12-10 13:52:53
