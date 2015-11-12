-- MySQL dump 10.13  Distrib 5.5.43, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: ffg
-- ------------------------------------------------------
-- Server version	5.5.43-0ubuntu0.14.04.1

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
-- Table structure for table `AccountInfo`
--

DROP TABLE IF EXISTS `AccountInfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `AccountInfo` (
  `UserID` int(11) NOT NULL AUTO_INCREMENT,
  `EMail` varchar(255) NOT NULL,
  `Password` varchar(255) NOT NULL,
  `Role` varchar(255) NOT NULL,
  PRIMARY KEY (`UserID`),
  UNIQUE KEY `EMail` (`EMail`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AccountInfo`
--

LOCK TABLES `AccountInfo` WRITE;
/*!40000 ALTER TABLE `AccountInfo` DISABLE KEYS */;
INSERT INTO `AccountInfo` VALUES (1,'abc@gmail.com','12345','mentor');
/*!40000 ALTER TABLE `AccountInfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `MENTOR_MENTEE_MATCH`
--

DROP TABLE IF EXISTS `MENTOR_MENTEE_MATCH`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `MENTOR_MENTEE_MATCH` (
  `match_id` int(11) NOT NULL AUTO_INCREMENT,
  `mentor_id` int(11) NOT NULL,
  `mentee_id` int(11) NOT NULL,
  PRIMARY KEY (`match_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MENTOR_MENTEE_MATCH`
--

LOCK TABLES `MENTOR_MENTEE_MATCH` WRITE;
/*!40000 ALTER TABLE `MENTOR_MENTEE_MATCH` DISABLE KEYS */;
INSERT INTO `MENTOR_MENTEE_MATCH` VALUES (1,1,1),(2,2,2),(3,4,4);
/*!40000 ALTER TABLE `MENTOR_MENTEE_MATCH` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Matching`
--

DROP TABLE IF EXISTS `Matching`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Matching` (
  `MatchID` int(11) NOT NULL AUTO_INCREMENT,
  `UserID` int(11) NOT NULL,
  `MentorID` int(11) NOT NULL,
  `MenteeID` int(11) NOT NULL,
  `ApproverID` int(11) NOT NULL,
  PRIMARY KEY (`MatchID`),
  KEY `UserID` (`UserID`),
  CONSTRAINT `Matching_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `AccountInfo` (`UserID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Matching`
--

LOCK TABLES `Matching` WRITE;
/*!40000 ALTER TABLE `Matching` DISABLE KEYS */;
/*!40000 ALTER TABLE `Matching` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Mentees`
--

DROP TABLE IF EXISTS `Mentees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Mentees` (
  `mentee_id` int(11) NOT NULL AUTO_INCREMENT,
  `mentee_name` varchar(100) NOT NULL,
  PRIMARY KEY (`mentee_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Mentees`
--

LOCK TABLES `Mentees` WRITE;
/*!40000 ALTER TABLE `Mentees` DISABLE KEYS */;
INSERT INTO `Mentees` VALUES (1,'Arvind'),(2,'Gagan'),(3,'Sheela');
/*!40000 ALTER TABLE `Mentees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `MentorList`
--

DROP TABLE IF EXISTS `MentorList`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `MentorList` (
  `UserID` int(11) NOT NULL,
  `Mentor1` int(11) DEFAULT NULL,
  `Mentor2` int(11) DEFAULT NULL,
  `Mentor3` int(11) DEFAULT NULL,
  `MentorApproved` int(11) DEFAULT NULL,
  `Approver` int(11) DEFAULT NULL,
  `MatchID` int(11) NOT NULL,
  `MenteeName` varchar(255) NOT NULL,
  `Mentor1Name` varchar(255) NOT NULL,
  `Mentor2Name` varchar(255) NOT NULL,
  `Mentor3Name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MentorList`
--

LOCK TABLES `MentorList` WRITE;
/*!40000 ALTER TABLE `MentorList` DISABLE KEYS */;
INSERT INTO `MentorList` VALUES (18,31,14,15,31,3,3,'aaa','bbb','ccc','ddd'),(19,31,14,0,31,3,4,'eee','bbb','ccc','ddd'),(20,31,0,0,31,3,1,'fff','bbb','ccc','ddd'),(21,0,0,0,0,0,0,'fff','bbb','ccc','ddd'),(26,31,0,0,31,3,2,'ri','abc','0','0'),(29,28,25,0,0,0,0,'richa','ae','ri','0');
/*!40000 ALTER TABLE `MentorList` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Mentor_MenteeMatching`
--

DROP TABLE IF EXISTS `Mentor_MenteeMatching`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Mentor_MenteeMatching` (
  `MatchID` int(11) NOT NULL DEFAULT '0',
  `ApprovalType` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`MatchID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Mentor_MenteeMatching`
--

LOCK TABLES `Mentor_MenteeMatching` WRITE;
/*!40000 ALTER TABLE `Mentor_MenteeMatching` DISABLE KEYS */;
INSERT INTO `Mentor_MenteeMatching` VALUES (1,'Accepted'),(2,'Accepted'),(3,'Accepted'),(4,'Rejected');
/*!40000 ALTER TABLE `Mentor_MenteeMatching` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Mentors`
--

DROP TABLE IF EXISTS `Mentors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Mentors` (
  `mentor_id` int(11) NOT NULL AUTO_INCREMENT,
  `mentor_name` varchar(100) NOT NULL,
  PRIMARY KEY (`mentor_id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Mentors`
--

LOCK TABLES `Mentors` WRITE;
/*!40000 ALTER TABLE `Mentors` DISABLE KEYS */;
INSERT INTO `Mentors` VALUES (1,'Ganesh'),(2,'Lohith'),(3,'Amith'),(10,'Subba'),(20,'Fakruddin'),(22,'Ganesha'),(23,'Ganeshi'),(24,'vinni');
/*!40000 ALTER TABLE `Mentors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Milestone`
--

DROP TABLE IF EXISTS `Milestone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Milestone` (
  `MatchId` int(11) DEFAULT NULL,
  `Date_Entered` varchar(255) DEFAULT NULL,
  `Date_Updated` varchar(255) DEFAULT NULL,
  `Deadline` varchar(255) DEFAULT NULL,
  `Description` varchar(255) DEFAULT NULL,
  `Comment` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Milestone`
--

LOCK TABLES `Milestone` WRITE;
/*!40000 ALTER TABLE `Milestone` DISABLE KEYS */;
INSERT INTO `Milestone` VALUES (1,'24-3-14','26-3-15','29-3-15','milestone1','just do it');
/*!40000 ALTER TABLE `Milestone` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PROGRESS`
--

DROP TABLE IF EXISTS `PROGRESS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PROGRESS` (
  `match_id` int(11) NOT NULL,
  `task_id` int(11) NOT NULL AUTO_INCREMENT,
  `task_name` varchar(200) NOT NULL,
  `task_description` varchar(10000) NOT NULL,
  `task_status` varchar(50) NOT NULL,
  `task_percentage` int(11) NOT NULL,
  PRIMARY KEY (`task_id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PROGRESS`
--

LOCK TABLES `PROGRESS` WRITE;
/*!40000 ALTER TABLE `PROGRESS` DISABLE KEYS */;
INSERT INTO `PROGRESS` VALUES (1,5,'Obtaining permission for setting up ABC','hoo','complete',15),(1,6,'Wait for Mentor feedback','Task On Hold Example','complete',15),(1,7,'test','hello','complete',15),(1,8,'do blah blah','do it','complete',15),(1,9,'test','test','complete',15),(1,10,'','','complete',15),(1,11,'goo','goo','complete',15),(1,12,'test','test','complete',15),(1,13,'test','test','complete',15),(1,14,'test','test','complete',15),(1,15,'dai','dai','complete',15),(1,16,'dai','dai','complete',15),(1,17,'dai','dai','complete',15),(1,18,'dai','dai','complete',15),(1,19,'test','test','complete',15),(1,20,'test','test','complete',15),(1,21,'test','test','complete',15),(2,22,'create db','Create ','complete',15),(2,23,'writing essay','Writing essay ','complete',15),(2,24,'test','test','complete',15),(2,25,'test ganesh','ganesh','complete',15),(2,26,'test','test','complete',15),(2,27,'test','test','complete',15),(2,28,'test','test','complete',15),(2,29,'test','testadf','complete',15),(2,30,'test','testaafaef','complete',15),(2,31,'gasd','gasdga','complete',15),(2,32,'asdfa','afdas','complete',15),(2,33,'test ganesh','test','complete',15),(2,34,'test ganesh','test','complete',15),(2,35,'testasdfasdf','afdafsda','complete',15),(2,36,'testasdfasdf','afdafsda','In Progress',15);
/*!40000 ALTER TABLE `PROGRESS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Registration`
--

DROP TABLE IF EXISTS `Registration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Registration` (
  `ID` int(11) NOT NULL DEFAULT '0',
  `Type` varchar(255) DEFAULT NULL,
  `Email` varchar(255) DEFAULT NULL,
  `Password` varchar(255) DEFAULT NULL,
  `Name` varchar(255) DEFAULT NULL,
  `Disability_Type` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Registration`
--

LOCK TABLES `Registration` WRITE;
/*!40000 ALTER TABLE `Registration` DISABLE KEYS */;
INSERT INTO `Registration` VALUES (1,'Mentee','john@doe.com','password','Chris','Blind'),(2,'Mentor','A@gmail.com','4rew2','Stark','Blind'),(3,'Moderator','b@gmail.com','4rew2','Tony','Deaf');
/*!40000 ALTER TABLE `Registration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Test`
--

DROP TABLE IF EXISTS `Test`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Test` (
  `MatchID` int(11) NOT NULL DEFAULT '0',
  `Test_Description` varchar(255) DEFAULT NULL,
  `Score` int(11) DEFAULT NULL,
  `Date_created` varchar(255) DEFAULT NULL,
  `Comment` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`MatchID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Test`
--

LOCK TABLES `Test` WRITE;
/*!40000 ALTER TABLE `Test` DISABLE KEYS */;
INSERT INTO `Test` VALUES (1,'Test Module 1',46,'31-4-2015','Passedd');
/*!40000 ALTER TABLE `Test` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `User`
--

DROP TABLE IF EXISTS `User`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `User` (
  `userId` int(11) NOT NULL AUTO_INCREMENT,
  `userName` varchar(100) NOT NULL,
  `password` varchar(40) NOT NULL,
  PRIMARY KEY (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `User`
--

LOCK TABLES `User` WRITE;
/*!40000 ALTER TABLE `User` DISABLE KEYS */;
/*!40000 ALTER TABLE `User` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accountinfo`
--

DROP TABLE IF EXISTS `accountinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accountinfo` (
  `UserID` int(11) NOT NULL AUTO_INCREMENT,
  `EMail` varchar(255) NOT NULL,
  `Password` varchar(255) NOT NULL,
  `Role` varchar(255) NOT NULL,
  `MentorApproved` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`UserID`),
  UNIQUE KEY `EMail` (`EMail`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accountinfo`
--

LOCK TABLES `accountinfo` WRITE;
/*!40000 ALTER TABLE `accountinfo` DISABLE KEYS */;
INSERT INTO `accountinfo` VALUES (1,'asd','asd','Mentee',NULL),(2,'Akash','asd','Admin',NULL),(3,'Amith','qwe','Moderator',NULL),(4,'Akash M','asd','Mentee',NULL),(6,'sam','456','Mentee',NULL),(7,'','','Mentor',NULL),(9,'Richa','12345678','Mentee',NULL),(11,'richa.j.shetty@tsgforce.com','123456','Mentee',NULL),(12,'ganesh','ganesh','Mentor','y'),(14,'jerry','jerry','Mentee',NULL),(15,'tom','tom','Mentor',NULL),(17,'abc1@gmail.com','12345','mentee',NULL),(18,'a@gmail.com','12345','Mentee',NULL),(19,'richa20@gmail.com','123','Mentee',NULL),(20,'ganeshhegde@outlook.com','1234','mentee',NULL),(22,'richa20q@gmail.com ','123','Moderator',NULL),(23,'richa20@mail.com','123','Mentee',NULL),(24,'richaq20@mail.com','123','Mentee',NULL),(25,'ri@Gmail.com','123','Mentor','y'),(26,'ri@email.com','123','Mentee',NULL),(27,'a@email.com','123','Mentor','y'),(28,'a@email.net','123','Mentor','y'),(29,'ri@email.net','123','Mentee',NULL),(31,'e@email.com','123','Mentor','y');
/*!40000 ALTER TABLE `accountinfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `conversations`
--

DROP TABLE IF EXISTS `conversations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `conversations` (
  `message_id` int(11) NOT NULL AUTO_INCREMENT,
  `match_id` int(11) NOT NULL,
  `role` varchar(100) NOT NULL,
  `message` varchar(10000) NOT NULL,
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `title` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`message_id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `conversations`
--

LOCK TABLES `conversations` WRITE;
/*!40000 ALTER TABLE `conversations` DISABLE KEYS */;
INSERT INTO `conversations` VALUES (19,1,'Mentee','I will need some help regarding the following topics....','2015-05-03 16:08:48','Need assistance'),(20,1,'Mentee','Mentee Messages go here','2015-05-03 16:09:24','Mentee Messages'),(21,1,'','hi','2015-05-11 11:02:46','tell'),(22,1,'Mentee','heloo','2015-05-13 07:50:20','hello'),(23,1,'Mentee','hello','2015-05-28 07:36:58','hi'),(24,1,'Mentee','hi','2015-06-05 11:11:23','hello'),(25,1,'Mentee','','2015-06-06 09:39:33',''),(26,0,'','xyz\r\n','2015-06-22 21:13:55','need help '),(27,0,'','test','2015-06-22 21:16:12','test'),(28,2,'','test2','2015-06-22 21:18:15','test'),(29,2,'Mentee','lmao','2015-06-22 21:23:47','aye');
/*!40000 ALTER TABLE `conversations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ffg.mentor`
--

DROP TABLE IF EXISTS `ffg.mentor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ffg.mentor` (
  `name` varchar(20) DEFAULT NULL,
  `status` varchar(3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ffg.mentor`
--

LOCK TABLES `ffg.mentor` WRITE;
/*!40000 ALTER TABLE `ffg.mentor` DISABLE KEYS */;
/*!40000 ALTER TABLE `ffg.mentor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `forum_answer`
--

DROP TABLE IF EXISTS `forum_answer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `forum_answer` (
  `question_id` int(4) NOT NULL DEFAULT '0',
  `answer_id` int(11) NOT NULL AUTO_INCREMENT,
  `answer_name` varchar(65) NOT NULL DEFAULT '',
  `answer_user_email` varchar(65) NOT NULL DEFAULT '',
  `answer_content` longtext NOT NULL,
  `answer_create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY `answer_id` (`answer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `forum_answer`
--

LOCK TABLES `forum_answer` WRITE;
/*!40000 ALTER TABLE `forum_answer` DISABLE KEYS */;
INSERT INTO `forum_answer` VALUES (1,1,'answer 1','user email 1','answer content 1','2015-02-17 07:23:41'),(2,2,'answer 2','user email 2','answer content 2','2015-02-17 07:23:41'),(3,3,'answer 3','user email 3','answer content 3','2015-02-17 07:23:41'),(4,4,'answer 4','user email 4','answer content 4','2015-02-17 07:23:41'),(5,5,'answer 5','user email 5','answer content 5','2015-02-17 07:23:42'),(31,12,'','Akash','test response','2015-04-22 14:30:56'),(31,13,'','Akash','response 2','2015-04-22 14:38:42'),(19,14,'','asd','test response','2015-04-25 12:12:08'),(19,15,'','asd','how will this work','2015-05-07 09:29:49'),(31,16,'','richa.j.shetty@tsgforce.com','test message','2015-05-28 07:45:48'),(1,17,'','asd','test response','2015-05-28 08:25:17'),(33,18,'','asd','what?\r\n','2015-06-05 11:30:07');
/*!40000 ALTER TABLE `forum_answer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `forum_question`
--

DROP TABLE IF EXISTS `forum_question`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `forum_question` (
  `topic_id` int(4) NOT NULL AUTO_INCREMENT,
  `topic_name` varchar(255) NOT NULL DEFAULT '',
  `topic_desc` varchar(2000) NOT NULL,
  `user_name` varchar(65) NOT NULL DEFAULT '',
  `email` varchar(65) NOT NULL DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `views` int(4) NOT NULL DEFAULT '0',
  `reply` int(4) NOT NULL DEFAULT '0',
  `topic_status` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`topic_id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `forum_question`
--

LOCK TABLES `forum_question` WRITE;
/*!40000 ALTER TABLE `forum_question` DISABLE KEYS */;
INSERT INTO `forum_question` VALUES (1,'topic 1','topic desc 1','user 1','','2015-03-29 10:33:17',1,1,'Y'),(2,'topic 2','topic desc 2','user 2','','2015-03-29 10:33:17',2,2,'Y'),(3,'topic 3','topic desc 3','user 3','','2015-03-29 10:33:17',3,3,'Y'),(4,'topic 4','topic desc 4','user 4','','2015-03-29 10:33:17',4,4,'Y'),(5,'topic 5','topic desc 5','user 5','','2015-03-29 10:33:17',5,5,'Y'),(19,'asd ','asdasdasd','','','2015-03-29 10:33:17',0,0,'Y'),(27,'new topic blahh','blah blah','','','2015-03-29 10:33:17',0,0,'Y'),(28,'Temp topic','Temp topic','','','2015-04-22 12:56:48',0,0,NULL),(29,'qwe','qwe','Akash','','2015-04-22 12:57:43',0,0,NULL),(30,'rty','rty','Akash','','2015-04-22 13:58:41',0,0,'N'),(31,'latest topic','latest desc','Akash','','2015-04-22 13:59:02',0,0,'Y'),(32,'test','test','asd','','2015-05-02 16:27:26',0,0,'N'),(33,'discussion on test','hello','asd','','2015-06-05 11:29:29',0,0,'Y');
/*!40000 ALTER TABLE `forum_question` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `matching`
--

DROP TABLE IF EXISTS `matching`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `matching` (
  `matchingid` varchar(10) DEFAULT NULL,
  `mentee` varchar(30) DEFAULT NULL,
  `mentor1` varchar(30) DEFAULT NULL,
  `mentor2` varchar(30) DEFAULT NULL,
  `mentor3` varchar(30) DEFAULT NULL,
  `selment` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `matching`
--

LOCK TABLES `matching` WRITE;
/*!40000 ALTER TABLE `matching` DISABLE KEYS */;
INSERT INTO `matching` VALUES ('enmat2','abcd','cvfg','adfe','aefd','cvfg'),('enmat3','afc','kdtwef','sdfgr','bdssg','bdssg'),('enmat4','aesad','jdt','qwer','vnj','qwer'),('enmat5','xcvse','xcvb','rttt','sdfgsg','xcvb'),('enmat7','cxewiyu','artth','bjs','rwt','bjs'),('enmat1','lwer','fgg','jusa','bs','fgg'),('enmat6','ertj','wy','cvb','dsrw','cvb');
/*!40000 ALTER TABLE `matching` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mentee_details`
--

DROP TABLE IF EXISTS `mentee_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mentee_details` (
  `mentee_id` int(11) NOT NULL AUTO_INCREMENT,
  `mentee_name` varchar(100) NOT NULL,
  `mentee_email` varchar(100) NOT NULL,
  `mentee_company` varchar(50) NOT NULL,
  `mentee_phone` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`mentee_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mentee_details`
--

LOCK TABLES `mentee_details` WRITE;
/*!40000 ALTER TABLE `mentee_details` DISABLE KEYS */;
INSERT INTO `mentee_details` VALUES (1,'Arvind','arvind@hotmail.com','Accenture','9800120123'),(3,'Sheela','sheela@gmail.com','TurtleSoft','9900101333');
/*!40000 ALTER TABLE `mentee_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mentor`
--

DROP TABLE IF EXISTS `mentor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mentor` (
  `name` varchar(20) DEFAULT NULL,
  `status` varchar(3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mentor`
--

LOCK TABLES `mentor` WRITE;
/*!40000 ALTER TABLE `mentor` DISABLE KEYS */;
INSERT INTO `mentor` VALUES ('amith','yes'),('abhijit','yes'),('ganesh','yes'),('komal','yes'),('neha','yes'),('neha','yes'),('tom','yes');
/*!40000 ALTER TABLE `mentor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mentor_details`
--

DROP TABLE IF EXISTS `mentor_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mentor_details` (
  `mentor_id` int(11) NOT NULL AUTO_INCREMENT,
  `mentor_name` varchar(100) NOT NULL,
  `mentor_email` varchar(100) NOT NULL,
  `mentor_company` varchar(50) NOT NULL,
  `mentor_phone` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`mentor_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mentor_details`
--

LOCK TABLES `mentor_details` WRITE;
/*!40000 ALTER TABLE `mentor_details` DISABLE KEYS */;
INSERT INTO `mentor_details` VALUES (1,'Ganesh','xgt008@gmail.com','JP Morgan','9008169748');
/*!40000 ALTER TABLE `mentor_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mentor_mentee_match`
--

DROP TABLE IF EXISTS `mentor_mentee_match`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mentor_mentee_match` (
  `match_id` int(11) NOT NULL AUTO_INCREMENT,
  `mentor_id` int(11) NOT NULL,
  `mentee_id` int(11) NOT NULL,
  PRIMARY KEY (`match_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mentor_mentee_match`
--

LOCK TABLES `mentor_mentee_match` WRITE;
/*!40000 ALTER TABLE `mentor_mentee_match` DISABLE KEYS */;
/*!40000 ALTER TABLE `mentor_mentee_match` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `moderator`
--

DROP TABLE IF EXISTS `moderator`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `moderator` (
  `name` varchar(20) DEFAULT NULL,
  `pwd` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `moderator`
--

LOCK TABLES `moderator` WRITE;
/*!40000 ALTER TABLE `moderator` DISABLE KEYS */;
INSERT INTO `moderator` VALUES ('amith','pass');
/*!40000 ALTER TABLE `moderator` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personalinfo`
--

DROP TABLE IF EXISTS `personalinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `personalinfo` (
  `UserID` int(11) NOT NULL,
  `Name` varchar(255) NOT NULL,
  `Phone` int(11) DEFAULT NULL,
  `Address` varchar(255) DEFAULT NULL,
  `Gender` varchar(255) DEFAULT NULL,
  `BirthDate` date DEFAULT NULL,
  `Qualification` varchar(255) NOT NULL,
  `InterestedArea` varchar(255) NOT NULL,
  `DisabilityArea` varchar(255) DEFAULT NULL,
  `Disability` varchar(255) DEFAULT NULL,
  `role` varchar(255) DEFAULT NULL,
  KEY `UserID` (`UserID`),
  CONSTRAINT `personalinfo_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `accountinfo` (`UserID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personalinfo`
--

LOCK TABLES `personalinfo` WRITE;
/*!40000 ALTER TABLE `personalinfo` DISABLE KEYS */;
INSERT INTO `personalinfo` VALUES (1,'asd',80,'Bangalore','Male','0000-00-00','Engineer','Social Science',NULL,'EYE',NULL),(12,'ganesh',80,'Bangalore','Male','0000-00-00','Engineer','Psychology',NULL,'EYE',NULL),(3,'Amith',80,'Mysore','Male','0000-00-00','Politician','Engineering',NULL,'EYE',NULL),(17,'abc1',1234567891,'abc, qwe','male','1990-03-03','10','chemistry','Eyes','Eyes','mentee'),(18,'q',1234567890,'q','male','1990-01-02','10','fgff','Eyes','Eyes','Mentee'),(19,'richa',2147483647,'mumbai','female','1999-04-06','10','science','Eyes','Eyes','Mentee'),(20,'Ganesh',2147483647,'Mathikere','male','1992-08-20','B','Tech','Eyes','Eyes','Role'),(22,'fg',1111111111,'mumbai','male','1989-05-04','12','chemistry ','Eyes','Eyes','Moderator'),(23,'ric',1111111111,'mumbai','male','1999-03-06','12','science','Legs','Legs','Mentee'),(24,'ric',1111111111,'mumbai','male','1880-06-21','B','science','Eyes','Eyes','Mentee'),(25,'ri',1111111111,'mumbai','female','1990-05-05','B','science ','Eyes','Eyes','Mentor'),(26,'ri',1111111111,'mumbai','female','1990-01-10','10','science','Eyes','Eyes','Mentee'),(27,'a',1111111111,'mumbai','male','1989-04-12','12','science','Eyes','Eyes','Mentor'),(28,'ae',1111111111,'mumbai','female','1980-10-18','B','science','Eyes','Eyes','Mentor'),(29,'richa',1111111111,'mumbai','female','1990-11-14','B','science','Eyes','Eyes','Mentee'),(31,'e',1111111111,'mumbai','male','1909-01-18','B','maths','Eyes','Eyes','Mentor');
/*!40000 ALTER TABLE `personalinfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `progress`
--

DROP TABLE IF EXISTS `progress`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `progress` (
  `matchingid` int(11) NOT NULL AUTO_INCREMENT,
  `mentor` varchar(30) DEFAULT NULL,
  `mentee` varchar(30) DEFAULT NULL,
  `progress` int(11) DEFAULT NULL,
  PRIMARY KEY (`matchingid`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `progress`
--

LOCK TABLES `progress` WRITE;
/*!40000 ALTER TABLE `progress` DISABLE KEYS */;
INSERT INTO `progress` VALUES (1,'abc','pqr',27),(2,'gfj','yyu',77),(3,'bhh','fyfu',42),(4,'suy','cvc',19),(5,'ipo','trw',55);
/*!40000 ALTER TABLE `progress` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `report`
--

DROP TABLE IF EXISTS `report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `report` (
  `username` varchar(100) NOT NULL,
  `userId` int(11) NOT NULL AUTO_INCREMENT,
  `mentor` varchar(100) NOT NULL,
  `joined` varchar(100) NOT NULL,
  `totalCoursesTaken` int(11) DEFAULT NULL,
  `totalCoursesCompleted` int(11) DEFAULT NULL,
  PRIMARY KEY (`userId`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `report`
--

LOCK TABLES `report` WRITE;
/*!40000 ALTER TABLE `report` DISABLE KEYS */;
INSERT INTO `report` VALUES ('John',1,'Matthew','25/10/2013',23,10);
/*!40000 ALTER TABLE `report` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `signup`
--

DROP TABLE IF EXISTS `signup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `signup` (
  `username` varchar(20) DEFAULT NULL,
  `message` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `signup`
--

LOCK TABLES `signup` WRITE;
/*!40000 ALTER TABLE `signup` DISABLE KEYS */;
INSERT INTO `signup` VALUES ('asd','asd'),('Akash','asd'),('qwe','qwe');
/*!40000 ALTER TABLE `signup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` int(11) DEFAULT NULL,
  `nickname` varchar(64) DEFAULT NULL,
  `email` varchar(120) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `user_id` int(11) DEFAULT NULL,
  `username` varchar(20) DEFAULT NULL,
  `password` varchar(20) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `registered_on` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (NULL,'qwe','qwe','qwe@gmail.com',NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-06-23 16:19:56
