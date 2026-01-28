CREATE DATABASE  IF NOT EXISTS `lyft` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `lyft`;
-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: localhost    Database: lyft
-- ------------------------------------------------------
-- Server version	5.7.19-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customers` (
  `CustomerName` varchar(45) NOT NULL,
  `Age` int(11) DEFAULT NULL,
  `Gender` varchar(6) DEFAULT NULL,
  `Address` varchar(45) DEFAULT NULL,
  `PastTrips` int(11) DEFAULT NULL,
  PRIMARY KEY (`CustomerName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` VALUES ('Athena Dennis',29,'F','St. Louis',7),('Ayden Mendoza',39,'M',NULL,1),('Barrett Calderon',36,'M',NULL,4),('Carleigh Garrett',35,'M','Ballwin',NULL),('Dominic Bryan',36,'M','Ballwin',NULL),('Emerson Gilbert',28,'M','Florissant',7),('Gemma Chavez',31,'M','St. Louis',1),('Jaslene Donaldson',30,'F','St. Louis',1),('Jesse Mckee',35,'F','Florissant',1),('Jose Hess',37,'M',NULL,1),('Lennon Hunt',39,'M','St. Louis',5),('Mariana Schwartz',35,'F','St. Louis',4),('Mariela Meyer',34,'F','Clayton',7),('Milton Wu',35,'M','St. Louis',7),('Miranda Jennings',36,'F',NULL,6),('Mya Nash',29,'F',NULL,3),('Rylee King',34,'F','Chesterfield',7),('Saniyah Powell',28,'M',NULL,2),('Sidney Wheeler',24,'M','Chesterfield',NULL),('Todd Vaughn',38,'M','St. Louis',2),('Tyrell Humphrey',30,'M','Clayton',NULL);
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `drivers`
--

DROP TABLE IF EXISTS `drivers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `drivers` (
  `DriverName` varchar(45) NOT NULL,
  `Model` varchar(45) DEFAULT NULL,
  `Color` varchar(45) DEFAULT NULL,
  `Year` int(11) DEFAULT NULL,
  PRIMARY KEY (`DriverName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `drivers`
--

LOCK TABLES `drivers` WRITE;
/*!40000 ALTER TABLE `drivers` DISABLE KEYS */;
INSERT INTO `drivers` VALUES ('Allison','Toyota','Silver',NULL),('Barbara',NULL,NULL,NULL),('Chris','Toyota','Black',2017),('Daniel','Ford','White',2016),('Frank','Ford',NULL,NULL),('James','Toyota','White',2017),('Jane','Toyota',NULL,2015),('Michael','Honda','Silver',NULL),('Nathan','Ford','Black',2014),('Phil','Ford','White',2017),('Tracey','Honda','Black',2016);
/*!40000 ALTER TABLE `drivers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `requests`
--

DROP TABLE IF EXISTS `requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `requests` (
  `RequestID` int(11) NOT NULL,
  `DriverName` varchar(45) NOT NULL,
  `CustomerName` varchar(45) NOT NULL,
  `DayOfWeek` varchar(45) DEFAULT NULL,
  `TimeOfDay` varchar(45) DEFAULT NULL,
  `Destination` varchar(45) DEFAULT NULL,
  `Distance` int(11) DEFAULT NULL,
  PRIMARY KEY (`RequestID`,`DriverName`,`CustomerName`),
  KEY `fk_Drivers_has_Customers1_idx` (`CustomerName`),
  KEY `fk_Drivers_has_Drivers_idx` (`DriverName`),
  CONSTRAINT `fk_Drivers_has_Customers1` FOREIGN KEY (`CustomerName`) REFERENCES `customers` (`CustomerName`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Drivers_has_Drivers` FOREIGN KEY (`DriverName`) REFERENCES `drivers` (`DriverName`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `requests`
--

LOCK TABLES `requests` WRITE;
/*!40000 ALTER TABLE `requests` DISABLE KEYS */;
INSERT INTO `requests` VALUES (1,'James','Miranda Jennings','Monday','afternoon','Arch',21),(2,'Daniel','Lennon Hunt','Monday','afternoon','WashU',23),(3,'Jane','Sidney Wheeler','Monday','afternoon','City Museum',13),(4,'Frank','Lennon Hunt','Monday','evening','Stadium',23),(5,'Daniel','Rylee King','Monday','evening','Grants Farm',20),(6,'Michael','Dominic Bryan','Monday','evening',NULL,NULL),(7,'Chris','Todd Vaughn','Tuesday','evening',NULL,NULL),(8,'Jane','Sidney Wheeler','Tuesday','evening',NULL,NULL),(9,'Barbara','Lennon Hunt','Tuesday','afternoon','Park',1),(10,'Allison','Mariela Meyer','Tuesday','afternoon','Zoo',10),(11,'Frank','Lennon Hunt','Tuesday','evening','Arch',19),(12,'Daniel','Barrett Calderon','Tuesday','evening','WashU',5),(14,'Jane','Saniyah Powell','Tuesday','evening','Stadium',9),(15,'Frank','Sidney Wheeler','Wednesday','evening','Grants Farm',10),(16,'Jane','Tyrell Humphrey','Wednesday','afternoon','Opera',4),(18,'Jane','Lennon Hunt','Wednesday','afternoon','Gardens',10),(19,'James','Todd Vaughn','Wednesday','afternoon',NULL,NULL),(20,'Barbara','Milton Wu','Wednesday','evening',NULL,NULL),(21,'Jane','Rylee King','Wednesday','evening',NULL,NULL),(22,'Frank','Miranda Jennings','Wednesday','evening','WashU',8),(23,'Allison','Gemma Chavez','Wednesday','evening','City Museum',12),(24,'Allison','Mariana Schwartz','Wednesday','evening','Stadium',18),(25,'James','Gemma Chavez','Thursday','evening','Grants Farm',9),(26,'Frank','Sidney Wheeler','Thursday','evening','Opera',6),(27,'Tracey','Todd Vaughn','Thursday','afternoon','Theater',9),(28,'Chris','Emerson Gilbert','Thursday','afternoon','Gardens',4),(29,'Daniel','Miranda Jennings','Thursday','afternoon',NULL,NULL),(30,'Tracey','Rylee King','Thursday','evening',NULL,NULL),(33,'Frank','Mariela Meyer','Friday','evening','City Museum',15),(34,'James','Mariana Schwartz','Friday','evening','Stadium',17),(35,'Jane','Saniyah Powell','Friday','evening','Grants Farm',8),(36,'Jane','Todd Vaughn','Friday','evening','Opera',9),(37,'Barbara','Jesse Mckee','Friday','afternoon','Theater',4),(38,'Tracey','Sidney Wheeler','Friday','afternoon','Gardens',10),(39,'Barbara','Mariana Schwartz','Friday','evening','Park',2),(40,'Jane','Rylee King','Friday','evening','Zoo',21),(41,'Chris','Barrett Calderon','Friday','evening',NULL,NULL),(42,'Daniel','Athena Dennis','Friday','evening',NULL,NULL),(43,'James','Emerson Gilbert','Friday','evening',NULL,NULL),(44,'James','Mariela Meyer','Friday','evening','Stadium',4),(47,'Allison','Mariela Meyer','Saturday','afternoon','Theater',24),(48,'Daniel','Saniyah Powell','Saturday','afternoon','Gardens',20),(49,'Chris','Sidney Wheeler','Saturday','afternoon','Park',19),(50,'Chris','Sidney Wheeler','Saturday','afternoon','Zoo',21),(51,'Allison','Milton Wu','Saturday','afternoon','Arch',20),(52,'Allison','Lennon Hunt','Saturday','afternoon','WashU',5),(53,'Frank','Sidney Wheeler','Saturday','afternoon','City Museum',19),(54,'Frank','Rylee King','Saturday','afternoon','Stadium',15),(55,'Barbara','Tyrell Humphrey','Saturday','evening','Grants Farm',17),(56,'Jane','Mya Nash','Saturday','evening',NULL,NULL),(57,'Frank','Sidney Wheeler','Saturday','evening',NULL,NULL),(58,'Jane','Barrett Calderon','Sunday','evening',NULL,NULL),(59,'Chris','Mariela Meyer','Monday','evening','Park',19),(60,'Tracey','Sidney Wheeler','Sunday','afternoon','Zoo',17),(61,'Frank','Jesse Mckee','Sunday','afternoon','Arch',2),(62,'Michael','Todd Vaughn','Sunday','afternoon','WashU',17),(63,'Michael','Mariana Schwartz','Sunday','evening','City Museum',22),(64,'Chris','Mariela Meyer','Sunday','evening','Stadium',12),(65,'Daniel','Todd Vaughn','Sunday','evening',NULL,NULL),(66,'Chris','Mariana Schwartz','Sunday','evening',NULL,NULL),(67,'Barbara','Gemma Chavez','Sunday','evening','Theater',2),(68,'Frank','Barrett Calderon','Sunday','evening','Gardens',1),(69,'Barbara','Saniyah Powell','Sunday','evening','Park',14),(70,'Allison','Tyrell Humphrey','Sunday','evening','Zoo',3);
/*!40000 ALTER TABLE `requests` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-01-11 23:03:50
