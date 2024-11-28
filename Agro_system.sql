-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: localhost    Database: agro_system
-- ------------------------------------------------------
-- Server version	8.0.39

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
-- Table structure for table `buyers`
--

DROP TABLE IF EXISTS `buyers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `buyers` (
  `buyer_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone_no` varchar(15) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`buyer_id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `buyers`
--

LOCK TABLES `buyers` WRITE;
/*!40000 ALTER TABLE `buyers` DISABLE KEYS */;
INSERT INTO `buyers` VALUES (1,'Suhas','phsuhas90@gmail.com','9845847500','$2b$12$WEsKdBzSG9THHZHxXUcaSefPx.5eHr2fi566rzqafH99/w14WOspi','2024-11-19 04:43:25'),(3,'Suhas10','phsuhas190@gmail.com','98487500','$2b$12$AlYYTF4wfRemUhAvUM.jh.hGJwLRGaXum.CMYo4yWsi/r6SJzm0xG','2024-11-19 05:38:50'),(4,'ayushhh',' phsuhas905@gmail.com ','9845847500','$2b$12$eKzwU8nBTcQMj4dujB3Sde.bmJPDhwGUakkodAMr9qeU/MdWaq1qW','2024-11-19 06:14:33'),(6,'joao felix','phsuhas9066@gmail.com','9845847500','$2b$12$CT.skt97/x5I59j1t5eWdeNj9mbRtwXvGeJtoSxHvnLHpHnBQtrxu','2024-11-19 06:22:54'),(7,'Suhaassss','SUhas@gmail.com','856300283','$2b$12$ugRKpigpnGUFNv8GeT50LeM3oD8fLe1AiL/99w805BPnznOLg.DYq','2024-11-19 08:54:16'),(8,'John Doe','john.doe@example.com','1234567890','password123','2024-11-28 09:34:32'),(9,'Jane Smith','jane.smith@example.com','9876543210','securepass','2024-11-28 09:34:32'),(10,'Alice Brown','alice.brown@example.com','5554443322','alice123','2024-11-28 09:34:32'),(11,'Bob Johnson','bob.johnson@example.com','7778889990','bobpassword','2024-11-28 09:34:32'),(12,'Charlie Davis','charlie.davis@example.com','6665554443','charliepass','2024-11-28 09:34:32'),(13,'Suhas ','Phsuhas9012@gmail.com','9845847500','$2b$12$Xq00CznUJWIN12cckJzrieJiyNcMAUX1mDXFtiQpI5XSdKLKg0X1G','2024-11-28 10:19:22');
/*!40000 ALTER TABLE `buyers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `farmers`
--

DROP TABLE IF EXISTS `farmers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `farmers` (
  `farmer_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone_no` varchar(15) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`farmer_id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `farmers`
--

LOCK TABLES `farmers` WRITE;
/*!40000 ALTER TABLE `farmers` DISABLE KEYS */;
INSERT INTO `farmers` VALUES (1,'Suhas','phsuhas905@gmail.com','9845847500','$2b$12$MeAdZ.cxE8Xfvagz61T7Du/6Mw7lR.5qtfUnEZ97U3vH1bSJ/T3Da','2024-11-19 05:34:34'),(2,'ayush','ayush@gmail.com','9632688333','$2b$12$jcoMpiBwrFrzWqHzU1HjD.tU..Syi3gUti9z27SSCwWur0oiK18mu','2024-11-19 05:35:50'),(3,'joaxxxx felix','phsuhas9067@gmail.com','9087485888','$2b$12$CNvx88xgJC.RnDyYL4SqzOL666uaLaSFa.z03ZRNt61YtaWC0TKKK','2024-11-19 06:23:29'),(4,'Chandan','Chandan@gmail.com','98485700','$2b$12$H/YdBvPFu8oO.CPf.r4TqebRwqqDMV0VlVmh6.sRUgvHueciRoT6K','2024-11-19 08:52:35'),(5,'Ayush','ayush@example.com','9876541230','ayush123','2024-11-28 09:34:39'),(6,'Ramesh Kumar','ramesh.kumar@example.com','1231231234','rameshpass','2024-11-28 09:34:39'),(7,'Sita Devi','sita.devi@example.com','9876543212','sitapass','2024-11-28 09:34:39'),(8,'Manoj Patil','manoj.patil@example.com','5678901234','manoj123','2024-11-28 09:34:39'),(9,'Rohit Sharma','rohit.sharma@example.com','9988776655','rohitpass','2024-11-28 09:34:39'),(10,'Chadan','Chandan12@gmail.com','98485700','$2b$12$aGu6.ixb32xikvu/mzcvDuBK.swjLwod5lP5f7FXhF.oGYgDqnCeW','2024-11-28 10:54:58');
/*!40000 ALTER TABLE `farmers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_items`
--

DROP TABLE IF EXISTS `order_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_items` (
  `order_item_id` int NOT NULL AUTO_INCREMENT,
  `order_id` int DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  `price_at_time` decimal(10,2) DEFAULT NULL,
  `item_total` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`order_item_id`),
  KEY `order_id` (`order_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE,
  CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_items`
--

LOCK TABLES `order_items` WRITE;
/*!40000 ALTER TABLE `order_items` DISABLE KEYS */;
INSERT INTO `order_items` VALUES (1,1,1,6,90.00,540.00),(2,2,1,4,90.00,360.00),(3,3,2,1,900.00,900.00),(4,4,1,3,90.00,270.00),(5,5,2,3,900.00,2700.00),(13,13,1,97,90.00,8730.00),(19,14,7,1,25.00,25.00),(20,15,8,1,40.00,40.00),(21,16,5,1,50.00,50.00),(22,17,9,1,35.00,35.00),(23,18,5,1,50.00,50.00),(24,19,10,3,90.00,270.00);
/*!40000 ALTER TABLE `order_items` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `calculate_order_total` AFTER INSERT ON `order_items` FOR EACH ROW BEGIN
    UPDATE orders 
    SET total_amount = (
        SELECT SUM(item_total)
        FROM order_items
        WHERE order_id = NEW.order_id
    )
    WHERE order_id = NEW.order_id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `order_id` int NOT NULL AUTO_INCREMENT,
  `buyer_id` int DEFAULT NULL,
  `order_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `total_amount` decimal(10,2) DEFAULT '0.00',
  PRIMARY KEY (`order_id`),
  KEY `idx_orders_buyer_id` (`buyer_id`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`buyer_id`) REFERENCES `buyers` (`buyer_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,3,'2024-11-19 05:39:34',540.00),(2,4,'2024-11-19 06:15:12',360.00),(3,6,'2024-11-19 06:30:17',900.00),(4,6,'2024-11-19 08:35:04',270.00),(5,6,'2024-11-19 08:35:12',2700.00),(6,7,'2024-11-19 08:55:29',500.00),(12,7,'2024-11-19 09:23:57',1000.00),(13,7,'2024-11-19 09:33:06',8730.00),(14,13,'2024-11-28 10:23:06',25.00),(15,13,'2024-11-28 10:23:10',40.00),(16,13,'2024-11-28 10:23:20',50.00),(17,13,'2024-11-28 10:45:38',35.00),(18,13,'2024-11-28 10:49:46',50.00),(19,13,'2024-11-28 10:58:24',270.00);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `product_reviews_view`
--

DROP TABLE IF EXISTS `product_reviews_view`;
/*!50001 DROP VIEW IF EXISTS `product_reviews_view`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `product_reviews_view` AS SELECT 
 1 AS `product_id`,
 1 AS `product_name`,
 1 AS `farmer_id`,
 1 AS `farmer_name`,
 1 AS `avg_rating`,
 1 AS `total_reviews`,
 1 AS `reviews`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `product_id` int NOT NULL AUTO_INCREMENT,
  `farmer_id` int DEFAULT NULL,
  `product_name` varchar(255) NOT NULL,
  `product_description` text,
  `unit_price` decimal(10,2) NOT NULL,
  `quantity` int NOT NULL,
  `status` enum('In Stock','Out of Stock') DEFAULT 'In Stock',
  PRIMARY KEY (`product_id`),
  KEY `farmer_id` (`farmer_id`),
  KEY `idx_products_name` (`product_name`),
  CONSTRAINT `products_ibfk_1` FOREIGN KEY (`farmer_id`) REFERENCES `farmers` (`farmer_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,2,'rice','',90.00,0,'Out of Stock'),(2,3,'ccccccgrg','eefedf',900.00,97,'In Stock'),(5,1,'Rice','High-quality basmati rice',50.00,98,'In Stock'),(6,2,'Wheat','Organic wheat grains',30.00,200,'In Stock'),(7,3,'Corn','Fresh sweet corn',25.00,149,'In Stock'),(8,4,'Soybeans','Nutritious soybeans',40.00,79,'In Stock'),(9,5,'Barley','Premium barley',35.00,119,'In Stock'),(10,10,'Dal','Very Good For Health',90.00,97,'In Stock');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `before_update_status` BEFORE UPDATE ON `products` FOR EACH ROW BEGIN
    IF NEW.quantity = 0 THEN
        SET NEW.status = 'Out of Stock';
    ELSE
        SET NEW.status = 'In Stock';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `reviews`
--

DROP TABLE IF EXISTS `reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reviews` (
  `review_id` int NOT NULL AUTO_INCREMENT,
  `buyer_id` int DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  `rating` int DEFAULT NULL,
  `review_text` text,
  `review_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`review_id`),
  KEY `buyer_id` (`buyer_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `reviews_ibfk_1` FOREIGN KEY (`buyer_id`) REFERENCES `buyers` (`buyer_id`) ON DELETE CASCADE,
  CONSTRAINT `reviews_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE CASCADE,
  CONSTRAINT `reviews_chk_1` CHECK (((`rating` >= 1) and (`rating` <= 5)))
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reviews`
--

LOCK TABLES `reviews` WRITE;
/*!40000 ALTER TABLE `reviews` DISABLE KEYS */;
INSERT INTO `reviews` VALUES (1,6,2,2,'very good product','2024-11-19 06:31:52'),(2,6,1,3,'io34jo43','2024-11-19 08:35:37'),(4,7,1,3,'VERY GOOD','2024-11-19 09:24:38'),(5,7,1,3,'VERY GOOD','2024-11-19 09:24:44'),(16,13,5,5,'Very Good Quality Rice','2024-11-28 10:51:28');
/*!40000 ALTER TABLE `reviews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'agro_system'
--

--
-- Dumping routines for database 'agro_system'
--
/*!50003 DROP PROCEDURE IF EXISTS `update_stock_quantity` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_stock_quantity`(
    IN prod_id INT, 
    IN quantity_to_deduct INT
)
BEGIN
    UPDATE products 
    SET quantity = quantity - quantity_to_deduct
    WHERE product_id = prod_id AND quantity >= quantity_to_deduct;
    
    IF ROW_COUNT() = 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Insufficient stock to fulfill the order.';
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `product_reviews_view`
--

/*!50001 DROP VIEW IF EXISTS `product_reviews_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = cp850 */;
/*!50001 SET character_set_results     = cp850 */;
/*!50001 SET collation_connection      = cp850_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `product_reviews_view` AS select `p`.`product_id` AS `product_id`,`p`.`product_name` AS `product_name`,`p`.`farmer_id` AS `farmer_id`,`f`.`name` AS `farmer_name`,avg(`r`.`rating`) AS `avg_rating`,count(`r`.`rating`) AS `total_reviews`,group_concat(`r`.`review_text` separator '; ') AS `reviews` from ((`products` `p` left join `reviews` `r` on((`p`.`product_id` = `r`.`product_id`))) join `farmers` `f` on((`p`.`farmer_id` = `f`.`farmer_id`))) group by `p`.`product_id`,`p`.`product_name`,`p`.`farmer_id`,`f`.`name` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-11-28 17:37:58
