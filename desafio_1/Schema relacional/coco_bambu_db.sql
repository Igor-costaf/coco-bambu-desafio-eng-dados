-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: localhost    Database: coco_bambu_db
-- ------------------------------------------------------
-- Server version	8.0.42

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

--
-- Table structure for table `detail_lines`
--

DROP TABLE IF EXISTS `detail_lines`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `detail_lines` (
  `guest_check_line_item_id` bigint NOT NULL,
  `guest_check_id` bigint DEFAULT NULL,
  `rvc_num` int DEFAULT NULL,
  `dtl_ot_num` int DEFAULT NULL,
  `dtl_oc_num` int DEFAULT NULL,
  `line_num` int DEFAULT NULL,
  `dtl_id` int DEFAULT NULL,
  `detail_utc` datetime DEFAULT NULL,
  `detail_lcl` datetime DEFAULT NULL,
  `last_update_utc` datetime DEFAULT NULL,
  `last_update_lcl` datetime DEFAULT NULL,
  `bus_dt` date DEFAULT NULL,
  `ws_num` int DEFAULT NULL,
  `display_total` decimal(10,2) DEFAULT NULL,
  `display_qty` int DEFAULT NULL,
  `agg_total` decimal(10,2) DEFAULT NULL,
  `agg_qty` int DEFAULT NULL,
  `chk_emp_id` int DEFAULT NULL,
  `chk_emp_num` int DEFAULT NULL,
  `svc_round_num` int DEFAULT NULL,
  `seat_num` int DEFAULT NULL,
  PRIMARY KEY (`guest_check_line_item_id`),
  KEY `guest_check_id` (`guest_check_id`),
  CONSTRAINT `detail_lines_ibfk_1` FOREIGN KEY (`guest_check_id`) REFERENCES `guest_checks` (`guest_check_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detail_lines`
--

LOCK TABLES `detail_lines` WRITE;
/*!40000 ALTER TABLE `detail_lines` DISABLE KEYS */;
INSERT INTO `detail_lines` VALUES (2000000001,1000000001,10,1,NULL,1,1,'2024-07-24 18:10:00','2024-07-24 15:10:00','2024-07-24 19:40:00','2024-07-24 16:40:00','2024-07-24',5,119.90,1,119.90,1,8888,777,1,1),(2000000002,1000000002,10,1,NULL,1,1,'2024-07-25 12:30:00','2024-07-25 09:30:00','2024-07-25 13:01:00','2024-07-25 10:01:00','2024-07-25',6,79.90,1,79.90,1,7777,101,1,1),(2000000003,1000000003,10,1,NULL,1,1,'2024-07-26 19:15:00','2024-07-26 16:15:00','2024-07-26 20:46:00','2024-07-26 17:46:00','2024-07-26',6,160.00,1,160.00,1,7778,222,1,1),(2000000004,1000000003,10,1,NULL,2,2,'2024-07-26 19:45:00','2024-07-26 16:45:00','2024-07-26 20:46:00','2024-07-26 17:46:00','2024-07-26',7,160.00,2,160.00,2,7778,222,1,2),(2000000005,1000000004,11,1,NULL,1,1,'2024-07-27 14:45:00','2024-07-27 11:45:00','2024-07-27 15:11:00','2024-07-27 12:11:00','2024-07-27',5,124.50,2,124.50,2,8888,303,1,1),(2000000006,1000000005,12,1,NULL,1,1,'2024-07-28 21:15:00','2024-07-28 18:15:00','2024-07-28 22:31:00','2024-07-28 19:31:00','2024-07-28',6,452.70,4,452.70,4,9999,444,1,1);
/*!40000 ALTER TABLE `detail_lines` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `discounts`
--

DROP TABLE IF EXISTS `discounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `discounts` (
  `guest_check_line_item_id` bigint NOT NULL,
  `description` varchar(100) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `value` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`guest_check_line_item_id`),
  CONSTRAINT `discounts_ibfk_1` FOREIGN KEY (`guest_check_line_item_id`) REFERENCES `detail_lines` (`guest_check_line_item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `discounts`
--

LOCK TABLES `discounts` WRITE;
/*!40000 ALTER TABLE `discounts` DISABLE KEYS */;
INSERT INTO `discounts` VALUES (2000000001,'Desconto cliente VIP',10.00),(2000000002,'Desconto estudante',5.00),(2000000003,'Desconto fidelidade',10.00),(2000000004,'Desconto família',5.00),(2000000005,'Desconto Happy Hour',7.50),(2000000006,'Desconto cliente VIP',11.00);
/*!40000 ALTER TABLE `discounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `error_codes`
--

DROP TABLE IF EXISTS `error_codes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `error_codes` (
  `guest_check_line_item_id` bigint NOT NULL,
  `error_code` varchar(20) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`guest_check_line_item_id`),
  CONSTRAINT `error_codes_ibfk_1` FOREIGN KEY (`guest_check_line_item_id`) REFERENCES `detail_lines` (`guest_check_line_item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `error_codes`
--

LOCK TABLES `error_codes` WRITE;
/*!40000 ALTER TABLE `error_codes` DISABLE KEYS */;
INSERT INTO `error_codes` VALUES (2000000001,NULL),(2000000002,NULL),(2000000003,NULL),(2000000004,NULL),(2000000005,NULL),(2000000006,NULL);
/*!40000 ALTER TABLE `error_codes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `guest_check_taxes`
--

DROP TABLE IF EXISTS `guest_check_taxes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `guest_check_taxes` (
  `guest_check_id` bigint NOT NULL,
  `tax_num` int NOT NULL,
  `taxable_sales_total` decimal(10,2) DEFAULT NULL,
  `tax_collected_total` decimal(10,2) DEFAULT NULL,
  `tax_rate` decimal(5,2) DEFAULT NULL,
  `type` int DEFAULT NULL,
  PRIMARY KEY (`guest_check_id`,`tax_num`),
  CONSTRAINT `guest_check_taxes_ibfk_1` FOREIGN KEY (`guest_check_id`) REFERENCES `guest_checks` (`guest_check_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guest_check_taxes`
--

LOCK TABLES `guest_check_taxes` WRITE;
/*!40000 ALTER TABLE `guest_check_taxes` DISABLE KEYS */;
INSERT INTO `guest_check_taxes` VALUES (1000000001,28,199.90,21.00,10.50,3),(1000000002,28,79.90,10.00,12.50,3),(1000000003,28,320.00,32.00,10.00,3),(1000000004,28,124.50,12.45,10.00,3),(1000000005,28,452.70,45.27,10.00,3),(1000000006,28,210.00,21.00,10.00,3);
/*!40000 ALTER TABLE `guest_check_taxes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `guest_checks`
--

DROP TABLE IF EXISTS `guest_checks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `guest_checks` (
  `guest_check_id` bigint NOT NULL,
  `chk_num` int DEFAULT NULL,
  `opn_bus_dt` date DEFAULT NULL,
  `opn_utc` datetime DEFAULT NULL,
  `clsd_bus_dt` date DEFAULT NULL,
  `clsd_utc` datetime DEFAULT NULL,
  `clsd_flag` tinyint(1) DEFAULT NULL,
  `gst_cnt` int DEFAULT NULL,
  `sub_total` decimal(10,2) DEFAULT NULL,
  `non_taxable_sales_total` decimal(10,2) DEFAULT NULL,
  `check_total` decimal(10,2) DEFAULT NULL,
  `discount_total` decimal(10,2) DEFAULT NULL,
  `pay_total` decimal(10,2) DEFAULT NULL,
  `balance_due_total` decimal(10,2) DEFAULT NULL,
  `rvc_num` int DEFAULT NULL,
  `ot_num` int DEFAULT NULL,
  `oc_num` int DEFAULT NULL,
  `tbl_num` int DEFAULT NULL,
  `tbl_name` varchar(100) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `emp_num` int DEFAULT NULL,
  `num_service_rounds` int DEFAULT NULL,
  `num_check_printed` int DEFAULT NULL,
  `last_trans_utc` datetime DEFAULT NULL,
  `last_trans_lcl` datetime DEFAULT NULL,
  `last_updated_utc` datetime DEFAULT NULL,
  `last_updated_lcl` datetime DEFAULT NULL,
  PRIMARY KEY (`guest_check_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guest_checks`
--

LOCK TABLES `guest_checks` WRITE;
/*!40000 ALTER TABLE `guest_checks` DISABLE KEYS */;
INSERT INTO `guest_checks` VALUES (1000000001,3210,'2024-07-24','2024-07-24 18:00:00','2024-07-24','2024-07-24 19:30:00',1,2,199.90,NULL,189.90,-10.00,189.90,NULL,10,1,NULL,12,'Mar Azul',777,2,1,'2024-07-24 19:30:00','2024-07-24 16:30:00','2024-07-24 19:45:00','2024-07-24 16:45:00'),(1000000002,3211,'2024-07-25','2024-07-25 12:15:00','2024-07-25','2024-07-25 13:00:00',1,1,79.90,NULL,79.90,0.00,79.90,0.00,10,1,NULL,8,'Terraço DF',101,1,1,'2024-07-25 13:00:00','2024-07-25 10:00:00','2024-07-25 13:05:00','2024-07-25 10:05:00'),(1000000003,3212,'2024-07-26','2024-07-26 19:00:00','2024-07-26','2024-07-26 20:45:00',1,3,320.00,NULL,305.00,-15.00,305.00,0.00,10,1,NULL,21,'Varanda Sunset',222,3,2,'2024-07-26 20:45:00','2024-07-26 17:45:00','2024-07-26 20:50:00','2024-07-26 17:50:00'),(1000000004,3213,'2024-07-27','2024-07-27 14:30:00','2024-07-27','2024-07-27 15:10:00',1,2,124.50,NULL,124.50,0.00,124.50,0.00,11,1,NULL,16,'Bistrô Lago',303,1,1,'2024-07-27 15:10:00','2024-07-27 12:10:00','2024-07-27 15:15:00','2024-07-27 12:15:00'),(1000000005,3214,'2024-07-28','2024-07-28 21:00:00','2024-07-28','2024-07-28 22:30:00',1,4,452.70,NULL,452.70,0.00,452.70,0.00,12,1,NULL,27,'Mirante 360',444,2,2,'2024-07-28 22:30:00','2024-07-28 19:30:00','2024-07-28 22:35:00','2024-07-28 19:35:00'),(1000000006,3215,'2024-07-29','2024-07-29 18:45:00','2024-07-29','2024-07-29 20:00:00',1,2,210.00,NULL,199.00,-11.00,199.00,0.00,12,1,NULL,19,'Deck Tropical',555,2,1,'2024-07-29 20:00:00','2024-07-29 17:00:00','2024-07-29 20:05:00','2024-07-29 17:05:00');
/*!40000 ALTER TABLE `guest_checks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu_items`
--

DROP TABLE IF EXISTS `menu_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menu_items` (
  `guest_check_line_item_id` bigint NOT NULL,
  `menu_item_num` int DEFAULT NULL,
  `mod_flag` tinyint(1) DEFAULT NULL,
  `tax_included` decimal(10,2) DEFAULT NULL,
  `active_taxes` varchar(20) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `price_level` int DEFAULT NULL,
  PRIMARY KEY (`guest_check_line_item_id`),
  CONSTRAINT `menu_items_ibfk_1` FOREIGN KEY (`guest_check_line_item_id`) REFERENCES `detail_lines` (`guest_check_line_item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu_items`
--

LOCK TABLES `menu_items` WRITE;
/*!40000 ALTER TABLE `menu_items` DISABLE KEYS */;
INSERT INTO `menu_items` VALUES (2000000001,9001,0,21.00,'TX001',2),(2000000002,9002,0,10.00,'TX002',1),(2000000003,9003,1,15.00,'TX001',2),(2000000004,9004,0,18.00,'TX003',3),(2000000005,9005,0,13.50,'TX001',1),(2000000006,9006,1,20.00,'TX002',2);
/*!40000 ALTER TABLE `menu_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service_charges`
--

DROP TABLE IF EXISTS `service_charges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `service_charges` (
  `guest_check_line_item_id` bigint NOT NULL,
  `description` varchar(100) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `value` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`guest_check_line_item_id`),
  CONSTRAINT `service_charges_ibfk_1` FOREIGN KEY (`guest_check_line_item_id`) REFERENCES `detail_lines` (`guest_check_line_item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service_charges`
--

LOCK TABLES `service_charges` WRITE;
/*!40000 ALTER TABLE `service_charges` DISABLE KEYS */;
INSERT INTO `service_charges` VALUES (2000000001,'Taxa de serviço 10%',11.99),(2000000002,'Serviço 10%',7.99),(2000000003,'Taxa de serviço 10%',16.00),(2000000004,'Serviço especial',12.45),(2000000005,'Serviço 10%',45.27),(2000000006,'Serviço padrão',21.00);
/*!40000 ALTER TABLE `service_charges` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tender_media`
--

DROP TABLE IF EXISTS `tender_media`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tender_media` (
  `guest_check_line_item_id` bigint NOT NULL,
  `type` varchar(20) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `amount` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`guest_check_line_item_id`),
  CONSTRAINT `tender_media_ibfk_1` FOREIGN KEY (`guest_check_line_item_id`) REFERENCES `detail_lines` (`guest_check_line_item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tender_media`
--

LOCK TABLES `tender_media` WRITE;
/*!40000 ALTER TABLE `tender_media` DISABLE KEYS */;
INSERT INTO `tender_media` VALUES (2000000001,'PIX',189.90),(2000000002,'Cartão Débito',79.90),(2000000003,'PIX',305.00),(2000000004,'Dinheiro',124.50),(2000000005,'Cartão Crédito',452.70),(2000000006,'PIX',199.00);
/*!40000 ALTER TABLE `tender_media` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-07-27 23:50:45
