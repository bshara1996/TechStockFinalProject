-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 26, 2025 at 02:22 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `techstock`
--
CREATE DATABASE IF NOT EXISTS `techstock` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `techstock`;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `category_id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `isActive` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`category_id`, `name`, `image`, `description`, `isActive`) VALUES
(1, 'Laptops', '/uploads/1761607742411-laptops.jpg', 'Powerful laptops for work, gaming, and creativity. From ultrabooks to gaming rigs, find the perfect portable computing solution.', 1),
(2, 'SmartPhones', '/uploads/1761608116549-smartphones.jpg', 'Stay connected with cutting-edge smartphones featuring advanced cameras, powerful processors, and stunning displays.', 1),
(3, 'Desktop Computers', '/uploads/1761608296417-Desktop Computers.png', 'High-performance desktop systems for gaming, content creation, and professional workloads. Build your dream setup.', 1),
(4, 'Monitors', '/uploads/1761607747208-monitors.jpg', 'Crystal-clear displays for gaming, design, and productivity. From 4K to ultrawide, enhance your visual experience.', 1),
(5, 'Keyboards', '/uploads/1761607437810-keyboards.jpg', 'Ergonomic and mechanical keyboards for comfortable typing.', 1),
(6, 'Mouse', '/uploads/1761607905505-mouse.png', 'Precision gaming mice with customizable DPI, programmable buttons, and ergonomic designs for a competitive advantage.', 1),
(7, 'Headphones', '/uploads/1762992809795-4aa56aab8e7a-headphone-comp.jpg', 'Immersive, high-quality headphones designed for crystal-clear sound, deep bass, and ultimate comfort. Perfect for gaming, music, and everyday use.', 1),
(8, 'Smart Watches', '/uploads/1762994740399-2024-FEB-PRODUCT-RANGE-1-1024x499.webp', 'Stylish and feature-packed smartwatches that keep you connected and on track. Monitor your health, stay updated, and elevate your lifestyle.', 0),
(9, 'Tablets', '/uploads/1762995626779-best-tablets-1-november-2024.avif', 'Powerful and portable tablets built for work, creativity, and entertainment. Enjoy smooth performance, vivid displays, and all-day productivity anywhere.', 1),
(10, 'Gaming Chairs', '/uploads/1763245711187-3518716_7_articleinlinemobile_VERTAGEAR_800.jpg', 'Ergonomic gaming chairs designed for maximum comfort and support during long sessions.', 1),
(11, 'Routers', '/uploads/1763247289030-Leonardo_Phoenix_10_A_collection_of_wireless_routers_in_variou_1.jpg', 'High-performance, reliable routers that deliver fast, stable, and secure internet for your entire home. Perfect for streaming, gaming, browsing, and remote work.', 1),
(12, 'WebCams', '/uploads/1763261763570-11-best-webcams-for-streaming_TW.jpg', 'High-quality webcams designed for clear video, sharp audio, and smooth streaming. Ideal for online meetings, gaming, content creation, and staying connected.', 1),
(13, 'Printers', '/uploads/1763264511978-bguide_3printers-sv-53596.jpg', 'Reliable printers that deliver sharp text, vibrant colors and efficient performance. Ideal for home and everyday printing needs.', 1);

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `shipping_address` text DEFAULT NULL,
  `payment_method` varchar(50) DEFAULT NULL,
  `promotion_id` int(11) DEFAULT NULL,
  `status` varchar(50) DEFAULT 'pending',
  `order_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `promotion_code` varchar(255) DEFAULT NULL,
  `discount_amount` decimal(10,2) DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`order_id`, `user_id`, `total_amount`, `shipping_address`, `payment_method`, `promotion_id`, `status`, `order_date`, `promotion_code`, `discount_amount`) VALUES
(1, 23, 14006.60, 'Ramat Gan', 'PayPal', NULL, 'Delivered', '2025-09-01 12:37:55', NULL, 0.00),
(2, 2, 46572.24, 'Haifa', 'PayPal', NULL, 'Delivered', '2025-09-04 10:31:14', NULL, 0.00),
(3, 19, 9829.40, 'Jerusalem', 'PayPal', NULL, 'Delivered', '2025-09-04 12:15:05', NULL, 0.00),
(4, 5, 13204.20, 'Nazareth', 'PayPal', NULL, 'Delivered', '2025-09-04 15:30:59', NULL, 0.00),
(5, 2, 6679.98, 'Haifa', 'PayPal', NULL, 'Delivered', '2025-09-05 10:10:50', NULL, 0.00),
(6, 3, 15611.36, 'Kafr Yasif', 'PayPal', NULL, 'Delivered', '2025-09-06 10:45:32', NULL, 0.00),
(7, 4, 16368.96, 'Jerusalem', 'PayPal', NULL, 'Delivered', '2025-09-06 12:36:40', NULL, 0.00),
(8, 3, 42533.10, 'Kafr Yasif', 'PayPal', NULL, 'Delivered', '2025-09-09 12:35:07', NULL, 0.00),
(9, 2, 4012.00, 'Haifa', 'PayPal', NULL, 'Delivered', '2025-09-11 07:14:20', NULL, 0.00),
(10, 8, 848.42, 'Ramat Gan', 'PayPal', NULL, 'Delivered', '2025-09-11 08:33:24', NULL, 0.00),
(11, 5, 37557.04, 'Nazareth', 'PayPal', NULL, 'Delivered', '2025-09-12 08:16:37', NULL, 0.00),
(12, 2, 5225.04, 'Haifa', 'PayPal', NULL, 'Delivered', '2025-09-12 10:32:45', NULL, 0.00),
(13, 12, 24541.64, 'Ramat Gan', 'PayPal', NULL, 'Delivered', '2025-09-14 12:47:03', NULL, 0.00),
(14, 3, 28468.67, 'Kafr Yasif', 'PayPal', NULL, 'Delivered', '2025-09-16 08:39:05', NULL, 0.00),
(15, 9, 15129.96, 'Tel Aviv', 'PayPal', NULL, 'Delivered', '2025-09-17 08:58:54', NULL, 0.00),
(16, 9, 36930.46, 'Tel Aviv', 'PayPal', NULL, 'Delivered', '2025-09-18 07:15:50', NULL, 0.00),
(17, 10, 18254.60, 'Haifa', 'PayPal', NULL, 'Delivered', '2025-09-18 08:33:59', NULL, 0.00),
(18, 15, 11318.56, 'Tel Aviv', 'PayPal', NULL, 'Delivered', '2025-09-20 09:39:42', NULL, 0.00),
(19, 9, 19776.80, 'Tel Aviv', 'PayPal', NULL, 'Delivered', '2025-09-22 09:59:54', NULL, 0.00),
(20, 8, 35695.00, 'Ramat Gan', 'PayPal', NULL, 'Delivered', '2025-09-23 07:45:02', NULL, 0.00),
(21, 3, 65422.74, 'Haifa', 'PayPal', NULL, 'Delivered', '2025-09-24 08:30:22', NULL, 0.00),
(22, 3, 1637.84, 'Kafr Yasif', 'PayPal', NULL, 'Delivered', '2025-09-27 11:15:37', NULL, 0.00),
(23, 16, 69582.24, 'Herzliya', 'PayPal', NULL, 'Delivered', '2025-09-27 15:45:20', NULL, 0.00),
(24, 16, 35210.02, 'Herzliya', 'PayPal', NULL, 'Delivered', '2025-09-29 10:25:20', NULL, 0.00),
(25, 10, 8543.20, 'Haifa', 'PayPal', NULL, 'Delivered', '2025-09-30 11:30:55', NULL, 0.00),
(26, 3, 50899.30, 'Kafr Yasif', 'PayPal', NULL, 'Delivered', '2025-09-30 15:45:50', NULL, 0.00),
(27, 2, 54678.84, 'Haifa', 'PayPal', NULL, 'Delivered', '2025-09-30 17:30:49', NULL, 0.00),
(28, 20, 32687.18, 'Nazareth', 'PayPal', NULL, 'Delivered', '2025-10-01 09:36:37', NULL, 0.00),
(29, 2, 11451.90, 'Haifa', 'PayPal', NULL, 'Delivered', '2025-10-01 09:58:04', NULL, 0.00),
(30, 21, 7655.84, 'Ashdod', 'PayPal', NULL, 'Delivered', '2025-10-01 10:16:18', NULL, 0.00),
(31, 22, 5950.74, 'Herzliya', 'PayPal', 1, 'Delivered', '2025-10-02 08:45:32', 'HALLOWEEN25', 107.38),
(32, 2, 41995.02, 'Haifa', 'PayPal', NULL, 'Delivered', '2025-10-02 09:00:54', NULL, 0.00),
(33, 2, 9180.40, 'Haifa', 'PayPal', NULL, 'Delivered', '2025-10-02 12:15:59', NULL, 0.00),
(34, 8, 6945.44, 'Ramat Gan', 'PayPal', 1, 'Delivered', '2025-10-02 15:32:50', 'HALLOWEEN25', 107.38),
(35, 21, 18962.60, 'Ashdod', 'PayPal', NULL, 'Delivered', '2025-10-03 08:28:54', NULL, 0.00),
(36, 7, 42679.42, 'Bat Yam', 'PayPal', NULL, 'Delivered', '2025-10-03 08:44:39', NULL, 0.00),
(37, 2, 24063.76, 'Haifa', 'PayPal', 2, 'Delivered', '2025-10-06 09:33:20', 'IPHONE16OCT', 400.00),
(38, 20, 55165.00, 'Nazareth', 'PayPal', 1, 'Delivered', '2025-10-06 09:48:50', 'HALLOWEEN25', 107.38),
(39, 3, 12678.49, 'Kafr Yasif', 'PayPal', 1, 'Delivered', '2025-10-06 09:50:12', 'HALLOWEEN25', 161.07),
(40, 8, 36790.04, 'Ramat Gan', 'PayPal', NULL, 'Delivered', '2025-10-06 15:05:21', NULL, 0.00),
(41, 2, 17250.44, 'Haifa', 'PayPal', 2, 'Delivered', '2025-10-08 11:33:18', 'IPHONE16OCT', 400.00),
(42, 13, 79550.88, 'Tel Aviv', 'PayPal', NULL, 'Delivered', '2025-10-09 07:15:22', NULL, 0.00),
(43, 2, 69046.54, 'Haifa', 'PayPal', 2, 'Delivered', '2025-10-14 10:48:54', 'IPHONE16OCT', 400.00),
(44, 3, 21247.67, 'Kafr Yasif', 'PayPal', 1, 'Delivered', '2025-10-15 07:32:47', 'HALLOWEEN25', 53.69),
(45, 11, 23702.66, 'Tel Aviv', 'PayPal', NULL, 'Delivered', '2025-10-16 09:45:35', NULL, 0.00),
(46, 17, 13661.15, 'Tel Aviv', 'PayPal', 1, 'Delivered', '2025-10-17 12:14:41', 'HALLOWEEN25', 171.98),
(47, 19, 47923.34, 'Jerusalem', 'PayPal', NULL, 'Delivered', '2025-10-18 08:30:33', NULL, 0.00),
(48, 17, 14545.40, 'Tel Aviv', 'PayPal', 1, 'Delivered', '2025-10-18 10:15:01', 'HALLOWEEN25', 42.77),
(49, 18, 24401.22, 'Eilat', 'PayPal', NULL, 'Delivered', '2025-10-18 11:48:25', NULL, 0.00),
(50, 3, 25599.21, 'Kafr Yasif', 'PayPal', 1, 'Delivered', '2025-10-18 12:30:51', 'HALLOWEEN25', 64.60),
(51, 7, 8727.28, 'Bat Yam', 'PayPal', NULL, 'Delivered', '2025-10-20 08:15:54', NULL, 0.00),
(52, 7, 16523.54, 'Bat Yam', 'PayPal', NULL, 'Delivered', '2025-10-22 11:38:54', NULL, 0.00),
(53, 2, 31405.99, 'Haifa', 'PayPal', 1, 'Delivered', '2025-10-23 10:16:54', 'HALLOWEEN25', 606.25),
(54, 5, 14147.02, 'Nazareth', 'PayPal', NULL, 'Delivered', '2025-10-27 09:44:50', NULL, 0.00),
(55, 13, 116713.80, 'Tel Aviv', 'PayPal', NULL, 'Shipped', '2025-10-28 11:02:31', NULL, 0.00),
(56, 8, 45739.16, 'Ramat Gan', 'PayPal', NULL, 'Shipped', '2025-10-30 09:07:50', NULL, 0.00),
(57, 22, 49241.40, 'Herzliya', 'PayPal', NULL, 'Shipped', '2025-11-02 10:32:32', NULL, 0.00),
(58, 10, 20473.00, 'Haifa', 'PayPal', NULL, 'Shipped', '2025-11-02 11:45:54', NULL, 0.00),
(59, 2, 8942.04, 'Ramat Gan', 'PayPal', NULL, 'Shipped', '2025-11-05 08:39:19', NULL, 0.00),
(60, 3, 2909.88, 'Kafr Yasif', 'PayPal', NULL, 'Shipped', '2025-11-05 09:54:05', NULL, 0.00),
(61, 12, 15435.58, 'Ramat Gan', 'PayPal', NULL, 'Shipped', '2025-11-08 09:32:20', NULL, 0.00),
(62, 17, 9135.56, 'Tel Aviv', 'PayPal', NULL, 'Processing', '2025-11-10 12:15:20', NULL, 0.00),
(63, 15, 3321.70, 'Tel Aviv', 'PayPal', NULL, 'Processing', '2025-11-12 10:05:56', NULL, 0.00),
(64, 2, 36803.01, 'Haifa', 'PayPal', NULL, 'Processing', '2025-11-15 08:41:02', NULL, 0.00),
(65, 2, 8543.20, 'Haifa', 'PayPal', NULL, 'Processing', '2025-11-16 10:20:07', NULL, 0.00),
(66, 2, 18216.84, 'Haifa', 'PayPal', NULL, 'Processing', '2025-11-17 13:05:08', NULL, 0.00),
(67, 9, 44627.60, 'Tel Aviv', 'PayPal', NULL, 'Pending', '2025-11-18 13:16:16', NULL, 0.00),
(68, 22, 7626.34, 'Herzliya', 'PayPal', NULL, 'Pending', '2025-11-18 13:30:30', NULL, 0.00),
(69, 20, 18998.00, 'Nazareth', 'PayPal', NULL, 'Pending', '2025-11-19 09:00:54', NULL, 0.00),
(70, 2, 78328.40, 'Haifa', 'PayPal', NULL, 'Pending', '2025-11-19 11:23:32', NULL, 0.00);

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `order_item_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `price` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `order_items`
--

INSERT INTO `order_items` (`order_item_id`, `order_id`, `product_id`, `quantity`, `price`) VALUES
(1, 1, 137, 1, 1262.60),
(2, 1, 63, 2, 6372.00),
(3, 2, 15, 2, 1414.82),
(4, 2, 59, 2, 13334.00),
(5, 2, 9, 2, 8537.30),
(6, 3, 128, 3, 2678.60),
(7, 3, 102, 2, 896.80),
(8, 4, 110, 1, 188.80),
(9, 4, 103, 1, 6997.40),
(10, 4, 93, 3, 2006.00),
(11, 5, 41, 3, 2063.82),
(12, 5, 109, 1, 488.52),
(13, 6, 142, 3, 4826.20),
(14, 6, 3, 3, 176.99),
(15, 6, 30, 2, 300.90),
(16, 7, 41, 3, 2063.82),
(17, 7, 117, 1, 398.84),
(18, 7, 1, 3, 942.82),
(19, 7, 68, 1, 6950.20),
(20, 8, 96, 3, 1203.60),
(21, 8, 42, 3, 12974.10),
(22, 9, 93, 2, 2006.00),
(23, 10, 125, 1, 848.42),
(24, 11, 68, 3, 6950.20),
(25, 11, 136, 2, 8353.22),
(26, 12, 96, 1, 1203.60),
(27, 12, 113, 1, 274.94),
(28, 12, 133, 1, 3298.10),
(29, 12, 111, 1, 448.40),
(30, 13, 57, 1, 165.20),
(31, 13, 144, 1, 12908.02),
(32, 13, 129, 1, 2028.42),
(33, 13, 36, 1, 7068.20),
(34, 13, 95, 1, 2371.80),
(35, 14, 5, 1, 1061.99),
(36, 14, 14, 1, 258.42),
(37, 14, 16, 3, 765.82),
(38, 14, 104, 1, 967.60),
(39, 14, 107, 2, 11941.60),
(40, 15, 115, 3, 267.86),
(41, 15, 123, 1, 5948.38),
(42, 15, 88, 1, 8378.00),
(43, 16, 71, 3, 116.82),
(44, 16, 56, 3, 3540.00),
(45, 16, 84, 2, 12980.00),
(46, 17, 38, 1, 15711.70),
(47, 17, 40, 3, 214.76),
(48, 17, 120, 1, 1898.62),
(49, 18, 57, 2, 165.20),
(50, 18, 127, 1, 4037.96),
(51, 18, 81, 1, 6950.20),
(52, 19, 11, 1, 2299.82),
(53, 19, 135, 1, 8486.56),
(54, 19, 47, 1, 116.82),
(55, 19, 134, 1, 8873.60),
(56, 20, 24, 3, 6547.82),
(57, 20, 9, 1, 8537.30),
(58, 20, 48, 1, 4216.14),
(59, 20, 133, 1, 3298.10),
(60, 21, 60, 2, 6018.00),
(61, 21, 52, 2, 24780.00),
(62, 21, 124, 2, 1598.90),
(63, 21, 78, 1, 628.94),
(64, 22, 34, 1, 1008.90),
(65, 22, 114, 1, 628.94),
(66, 23, 151, 3, 11208.82),
(67, 23, 145, 3, 9861.26),
(68, 23, 63, 1, 6372.00),
(69, 24, 145, 2, 9861.26),
(70, 24, 68, 1, 6950.20),
(71, 24, 9, 1, 8537.30),
(72, 25, 50, 2, 112.10),
(73, 25, 10, 2, 3522.30),
(74, 25, 64, 2, 637.20),
(75, 26, 83, 1, 1970.60),
(76, 26, 38, 3, 15711.70),
(77, 26, 102, 2, 896.80),
(78, 27, 99, 2, 3575.40),
(79, 27, 62, 3, 354.00),
(80, 27, 81, 2, 6950.20),
(81, 27, 22, 2, 16282.82),
(82, 28, 52, 1, 24780.00),
(83, 28, 133, 2, 3298.10),
(84, 28, 139, 1, 1310.98),
(85, 29, 39, 3, 1805.40),
(86, 29, 74, 3, 808.30),
(87, 29, 96, 3, 1203.60),
(88, 30, 73, 3, 218.30),
(89, 30, 114, 1, 628.94),
(90, 30, 63, 1, 6372.00),
(91, 31, 56, 1, 3540.00),
(92, 31, 40, 2, 214.76),
(93, 31, 112, 1, 295.00),
(94, 31, 97, 1, 1793.60),
(95, 32, 46, 3, 5959.00),
(96, 32, 119, 3, 687.94),
(97, 32, 133, 2, 3298.10),
(98, 32, 69, 2, 7729.00),
(99, 33, 86, 3, 2242.00),
(100, 33, 94, 1, 2454.40),
(101, 34, 40, 2, 214.76),
(102, 34, 7, 3, 2207.77),
(103, 35, 68, 2, 6950.20),
(104, 35, 97, 1, 1793.60),
(105, 35, 106, 1, 3268.60),
(106, 36, 10, 1, 3522.30),
(107, 36, 145, 2, 9861.26),
(108, 36, 81, 2, 6950.20),
(109, 36, 27, 1, 5534.20),
(110, 37, 28, 2, 5635.10),
(111, 37, 30, 2, 300.90),
(112, 37, 67, 3, 4063.92),
(113, 38, 95, 3, 2371.80),
(114, 38, 40, 2, 214.76),
(115, 38, 148, 1, 14101.00),
(116, 38, 151, 3, 11208.82),
(117, 39, 40, 3, 214.76),
(118, 39, 5, 2, 1061.99),
(119, 39, 131, 3, 678.50),
(120, 39, 128, 3, 2678.60),
(121, 40, 31, 1, 7464.68),
(122, 40, 92, 1, 22290.20),
(123, 40, 71, 2, 116.82),
(124, 40, 147, 1, 6801.52),
(125, 41, 28, 2, 5635.10),
(126, 41, 131, 1, 678.50),
(127, 41, 122, 1, 2607.80),
(128, 41, 44, 3, 897.98),
(129, 42, 11, 2, 2299.82),
(130, 42, 80, 3, 7998.04),
(131, 42, 8, 1, 3822.02),
(132, 42, 38, 3, 15711.70),
(133, 43, 26, 2, 4271.02),
(134, 43, 103, 1, 6997.40),
(135, 43, 63, 1, 6372.00),
(136, 43, 38, 3, 15711.70),
(137, 44, 46, 2, 5959.00),
(138, 44, 105, 1, 5876.40),
(139, 44, 131, 3, 678.50),
(140, 44, 82, 3, 418.90),
(141, 44, 40, 1, 214.76),
(142, 45, 66, 1, 5215.60),
(143, 45, 122, 1, 2607.80),
(144, 45, 143, 1, 3937.66),
(145, 45, 107, 1, 11941.60),
(146, 46, 152, 1, 6498.26),
(147, 46, 46, 1, 5959.00),
(148, 46, 119, 1, 687.94),
(149, 46, 40, 2, 214.76),
(150, 46, 4, 1, 258.42),
(151, 47, 120, 2, 1898.62),
(152, 47, 63, 1, 6372.00),
(153, 47, 41, 2, 2063.82),
(154, 47, 151, 3, 11208.82),
(155, 48, 66, 1, 5215.60),
(156, 48, 125, 3, 848.42),
(157, 48, 94, 3, 1751.42),
(158, 48, 139, 1, 1310.98),
(159, 48, 72, 1, 171.10),
(160, 49, 69, 1, 7729.00),
(161, 49, 122, 3, 2607.80),
(162, 49, 81, 1, 6950.20),
(163, 49, 120, 1, 1898.62),
(164, 50, 46, 3, 5959.00),
(165, 50, 89, 1, 5074.00),
(166, 50, 94, 1, 2454.40),
(167, 50, 4, 1, 258.42),
(168, 51, 47, 2, 116.82),
(169, 51, 153, 2, 4246.82),
(170, 52, 38, 1, 15711.70),
(171, 52, 62, 1, 354.00),
(172, 52, 116, 1, 457.84),
(173, 53, 41, 2, 2063.82),
(174, 53, 135, 3, 8486.56),
(175, 53, 74, 3, 808.30),
(176, 54, 144, 1, 12908.02),
(177, 54, 79, 1, 1239.00),
(178, 55, 98, 3, 30290.60),
(179, 55, 53, 1, 1062.00),
(180, 55, 52, 1, 24780.00),
(181, 56, 135, 1, 8486.56),
(182, 56, 37, 1, 2514.58),
(183, 56, 55, 1, 21830.00),
(184, 56, 144, 1, 12908.02),
(185, 57, 38, 2, 15711.70),
(186, 57, 59, 1, 13334.00),
(187, 57, 86, 2, 2242.00),
(188, 58, 54, 3, 6254.00),
(189, 58, 100, 1, 1711.00),
(190, 59, 26, 2, 4471.02),
(191, 60, 70, 2, 1454.94),
(192, 61, 51, 1, 7552.00),
(193, 61, 31, 1, 7464.68),
(194, 61, 82, 1, 418.90),
(195, 62, 75, 2, 536.90),
(196, 62, 132, 1, 698.56),
(197, 62, 36, 1, 7068.20),
(198, 62, 112, 1, 295.00),
(199, 63, 30, 3, 300.90),
(200, 63, 111, 1, 448.40),
(201, 63, 90, 1, 1970.60),
(202, 64, 143, 3, 3937.66),
(203, 64, 80, 1, 7998.04),
(204, 64, 56, 1, 3540.00),
(205, 64, 5, 1, 1061.99),
(206, 64, 65, 3, 4130.00),
(207, 65, 133, 2, 3298.10),
(208, 65, 12, 1, 1947.00),
(209, 66, 41, 1, 2063.82),
(210, 66, 57, 1, 165.20),
(211, 66, 85, 1, 4779.00),
(212, 66, 151, 1, 11208.82),
(213, 67, 54, 1, 6254.00),
(214, 67, 91, 3, 519.20),
(215, 67, 60, 2, 6018.00),
(216, 67, 52, 1, 24780.00),
(217, 68, 79, 3, 1239.00),
(218, 68, 70, 1, 1454.94),
(219, 68, 94, 1, 2454.40),
(220, 69, 93, 3, 2006.00),
(221, 69, 84, 1, 12980.00),
(222, 70, 134, 2, 8873.60),
(223, 70, 98, 2, 30290.60);

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `product_id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `stock` int(11) DEFAULT NULL,
  `supplier_id` int(11) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`product_id`, `name`, `description`, `image`, `price`, `stock`, `supplier_id`, `category_id`, `is_active`) VALUES
(1, 'Razer Basilisk V3 Pro', 'azer Basilisk V3 Pro wireless gaming mouse with ergonomic design and Razer™ HyperScroll scroll wheel, 13-zone Chroma lighting including ambient lighting, and 11 programmable buttons for full customization', '/uploads/1760722477355-1754343209171-1749600602401.jpg', 799.00, 80, 8, 6, 1),
(2, 'Logitech G502X PLUS', 'Logitech G502X PLUS Wireless Gaming Mouse with 13 Programmable Controls, Lightspeed Wireless Technology, Black', '/uploads/1760722223408-1754343127359-1749600401028.jpg', 655.00, 140, 7, 6, 1),
(3, 'Corsair M55 RGB PRO Ambidextrous', 'Corsair M55 RGB PRO gaming mouse with ambidextrous design that fits any grip or hand, and a highly accurate 12,400 DPI optical sensor', '/uploads/1760722453829-1754343168255-1749600498329.jpg', 149.99, 200, 9, 6, 1),
(4, 'Corsair KATAR PRO Wireless', 'Enjoy lightweight design and heavyweight performance with the Corsair KATAR PRO wireless gaming mouse, which connects via ultra-fast Bluetooth or with the SLIPSTREAM Wireless adapter.', '/uploads/1761609090608-1718781991k91Pl.jpg', 219.00, 31, 9, 6, 1),
(5, 'Dell UltraSharp 24 U2424H IPS', 'Experience optimal viewing comfort with vivid colors and impressive calibration accuracy. The screen is equipped with an ambient light sensor that automatically adjusts brightness and color temperature to ambient conditions, and a 120Hz refresh rate that ensures smooth motion and flicker-free scrolling. With a built-in 10Gbps USB hub, and an elegant design in a platinum silver finish - this is the perfect monitor for productivity and comfortable work!', '/uploads/1760722673144-1754343328304-1749600801151.jpg', 899.99, 20, 5, 4, 1),
(6, 'Asus TUF Gaming VG27VQ3B', 'Asus TUF Gaming 27-inch curved gaming monitor, VA panel, 1920x1080 Full HD resolution at 180Hz refresh rate, 2xHDMI / 1xDisplayPort display connections', '/uploads/1760722763337-1754343363506-1749600866966.jpg', 1199.99, 280, 3, 4, 1),
(7, 'Dell UltraSharp 27 U2724DE IPS 2K', 'Dell UltraSharp 27 computer monitor, 27-inch, IPS panel, 2560x1440 2K WQHD resolution, 120Hz refresh rate, DisplayPort / HDMI / Thunderbolt display connections, includes a built-in USB hub with USB-C and USB-A ports and a wired network connection', '/uploads/1760722814536-1754343397207-1749600923709.jpg', 1870.99, 25, 5, 4, 1),
(8, 'Lenovo Legion R45w', 'Lenovo 44.5\\\" R45W-30 gaming computer monitor with VA panel, 170Hz refresh rate, 5120x1440 Dual QHD resolution, 1ms response time, HDMI / DisplayPort / USB-C connections, with USB splitter and built-in speakers', '/uploads/1760722866174-1754343438568-1749601022451.jpg', 3239.00, 29, 1, 4, 1),
(9, 'LG UltraGear OLED', 'Immerse yourself in the ultimate gaming world – With a 45-inch curved OLED display, a blazing 240Hz refresh rate, and a 0.03ms response time, the LG UltraGear monitor puts you at the center of the action. Breathtaking visuals, vivid colors, and a mesmerizing design with RGB lighting – everything a gamer needs to dominate the arena.', '/uploads/1760722930437-1754343485946-1749601077977.jpg', 7235.00, 160, 4, 4, 1),
(10, 'Asus ROG Strix XG27AQMR 300Hz', 'Asus ROG Strix gaming monitor, 27-inch, IPS panel, 2560x1440 2K WQHD resolution at 300Hz refresh rate, supports G-Sync and VESA DisplayHDR 600 technologies, 2xHDMI / 1xDisplayPort display connections, includes a built-in USB 3.2 splitter', '/uploads/1760723054983-1754343535127-1749601139939.jpg', 2985.00, 7, 3, 4, 1),
(11, 'LG 32UR550-B HDR10 4K UHD', 'LG 32 computer monitor, model 32UR550-B, with a VA panel, 3840x2160 4K UHD resolution, 60Hz refresh rate, 4ms response time, includes 2 HDMI connections, a DisplayPort connection, and built-in speakers.', '/uploads/1760723118103-1754343630061-1749601237183.jpg', 1949.00, 22, 4, 4, 1),
(12, 'Asus ROG Strix', 'Asus 31.5-inch curved gaming computer monitor, model ROG Strix XG32WCS, VA panel, 2560x1440 2K WQHD resolution, 1ms response time, 180Hz refresh rate, and VESA DisplayHDR 400, including HDMI connections, DisplayPort connection, and USB-C connection for display and charging (7.5W', '/uploads/1760723183837-1754343662586-1749601310885.jpg', 1650.00, 11, 3, 4, 1),
(13, 'Dell P2725HE IPS', 'Dell 27-inch computer monitor, model P2725HE, IPS panel, Full HD resolution, HDMI / USB-C / DisplayPort display connections, USB-C display input supports charging up to 90W, includes wired network input, built-in USB splitter and additional USB-C port with 15W charging (does not transmit display)', '/uploads/1760723232195-1754343710112-1749601381226.jpg', 1199.00, 35, 5, 4, 1),
(14, 'Logitech G213 Prodigy RGB Gaming', 'Logitech G213 Prodigy RGB Gaming Keyboard with RGB lighting and multimedia keys - Hebrew letters are not illuminated, Hebrew and English languages.', '/uploads/1760723266784-1754343743970-1749601481928.jpg', 219.00, 32, 7, 5, 1),
(15, 'CORSAIR K70 MAX MGX MAGNETIC PBT', 'Enjoy a powerful gaming experience with a keyboard featuring stunning RGB lighting and individually adjustable CORSAIR MGX magnetic switches for exceptional gaming performance.', '/uploads/1760723460754-1749601565497.jpg', 1199.00, 200, 9, 5, 1),
(16, 'Logitech G515 Lightspeed', 'The Logitech G515 LIGHTSPEED TKL delivers speed, precision, and customization in a sleek, low-profile design. A wireless gaming keyboard featuring triple connectivity, GL mechanical switches, dual-layer PBT keycaps, sound-dampening construction, and LIGHTSYNC RGB.', '/uploads/1760723519358-1754344036430-1749601610387.jpg', 649.00, 23, 7, 5, 1),
(17, 'Razer Ornata V3 Mecha', 'Razer Ornata V3 Mecha-Membrane Switch Keyboard features LED lighting, a low profile, and UV-coated keys for increased durability', '/uploads/1760723604464-1754344069612-1749601654068.jpg', 399.00, 130, 8, 5, 1),
(18, 'Razer BlackWidow V4 X Yellow', 'Razer BlackWidow V4 X Fortnite Edition Blue Mechanical Gaming Keyboard with RGB Lighting and Razer Yellow Linear Switches', '/uploads/1760723694083-1754344097503-1749601734215.jpg', 999.00, 200, 8, 5, 1),
(19, 'Asus Vivobook X1404VA', 'Asus Vivobook X1404VA-EB084W 14\" Laptop i7-1355U 512GB SSD 16GB RAM Intel Iris Xᵉ Graphics Terra Cotta', '/uploads/1760723756569-1754344125121-1749601952692.jpg', 3039.00, 11, 3, 1, 1),
(20, 'Dell Vostro 15 3520', 'Dell Vostro 15 Laptop 15.6\" Screen Intel Core i5-1235U Processor 1TB SSD 16GB DDR4 Memory Intel Iris Xe Graphics', '/uploads/1760723834519-1754344152663-1749602002967.jpg', 3279.00, 70, 5, 1, 1),
(21, 'Lenovo IdeaPad Slim', 'enovo IdeaPad Slim 5 laptop, 14-inch OLED screen with WUXGA resolution (1920x1200), Intel Core 7 240H 2nd generation Core Series processor, 1TB SSD, 32GB DDR5 memory, Intel Graphics accelerator.', '/uploads/1760723898763-1754344191359-1749602059707.jpg', 5184.00, 21, 5, 1, 1),
(22, 'Apple MacBook Pro 14', 'Apple MacBook Pro 14 laptop, Apple M4 Max chip, 1TB SSD, 36GB memory, 32-core graphics, Silver color, launch year 2024.', '/uploads/1760724058255-1754344215328-1749602137920.jpg', 13799.00, 32, 6, 1, 1),
(23, 'HP Omen Transcend', 'HP Omen Transcend gaming laptop, 14-inch screen, OLED panel with 3K resolution (2880x1800) and dynamic refresh rate up to 120Hz, Intel Core Ultra 9 185H processor, Core Ultra Series 1 generation, 32GB DDR5 memory, 1TB SSD drive, NVIDIA GeForce RTX 4070 8GB GDDR6 graphics accelerator.', '/uploads/1760724175053-1754344249290-1749602180449.jpg', 9849.00, 50, 2, 1, 1),
(24, 'Lenovo LOQ', 'Lenovo Gaming Laptop 15.6\" Screen 13th Generation Intel Core i7-13650HX Processor 1TB SSD M.2 24GB DDR5 4800MHz Memory NVIDIA GeForce RTX 4050 6GB GDDR6 Graphics Accelerator.', '/uploads/1760724255084-1754344289981-1749602233130.jpg', 5549.00, 54, 1, 1, 1),
(25, 'Asus TUF Gaming F16', 'Asus TUF Gaming F16 gaming laptop, 13th generation Intel Core i7-13620H processor, 1TB SSD, 32GB DDR5 memory, WUXGA (1920 x 1200) IPS screen with 144Hz refresh rate, Nvidia GeForce RTX 4050 6GB GDDR6 graphics card.', '/uploads/1760724388003-1754344342056-1749602285549.png', 5773.00, 45, 3, 1, 1),
(26, 'Apple iPhone 16', 'Apple iPhone 16, 256GB, pink, USB-C connection, with the new camera button and Action Button', '/uploads/1760726040331-1754344406429-1749602748389.jpg', 3789.00, 54, 6, 2, 1),
(27, 'Apple iPhone 16 Pro', 'Apple iPhone 16 Pro, 256GB, Titanium Black, USB-C connection, with the new camera button and Action Button', '/uploads/1760726087970-1754344436721-1749602804260.jpg', 4690.00, 14, 6, 2, 1),
(28, 'Apple iPhone 16 Pro Max', 'Apple iPhone 16 Pro Max, 256GB, Titanium Desert, USB-C connection, with new camera button and Action Button.', '/uploads/1760726128336-1754344462262-1749602857033.jpg', 4945.00, 38, 6, 2, 1),
(29, 'Lenovo Legion Tower', 'Lenovo Legion Tower 7i Gen 10 – Unstoppable power for true gamers. A powerful gaming PC with the latest 9th generation Intel Core Ultra processor, 64GB RAM, GeForce RTX 5080 16GB graphics card and a 360mm liquid cooling system – built for extreme performance, even in the most demanding games, with a mesmerizing design and future-proof capabilities. Get ready for a smooth, quiet and uncompromising experience.', '/uploads/1760726278381-1754346237885-1754214193x93Dt.webp', 14980.00, 18, 1, 3, 1),
(30, 'Razer Cobra - Pokemon Kanto Edition', 'A lightweight gaming mouse that combines elegant design with advanced performance. It features a high-precision 8500 DPI optical sensor, 3rd generation optical switches for exceptional durability and speed, and Razer Chroma™ RGB lighting with a stunning graduated glow effect. With a flexible Speedflex cable and high-quality PTFE feet, it provides smooth, comfortable movement on any surface.', '/uploads/1761692782995-b_2.jpg', 255.00, 11, 8, 6, 1),
(31, 'Samsung Galaxy Z Fold 6', 'The Samsung Galaxy Z Fold6 smartphone with 256GB and 12GB RAM gives you an immersive viewing experience with a huge, high-quality screen in a foldable experience, a professional camera with AI smart photo editing, powerful performance with a Snapdragon 8 Gen3 processor, long battery life with an advanced 4,400mAh battery, and increased durability with an aluminum frame', '/uploads/1754344380871-1749602686347.jpg', 6326.00, 54, 10, 2, 1),
(32, 'Samsung Galaxy S25 Ultra', 'The Galaxy S25 Ultra smartphone offers powerful performance thanks to the Snapdragon 8 Elite processor, a 6.9-inch Dynamic AMOLED 2X screen with QHD+ (3120x1440) resolution, a powerful 5,000mAh battery, a main camera with a 200-megapixel sensor in a square photo array, a luxurious design with a reinforced titanium frame and Gorilla Glass Armor, and advanced artificial intelligence capabilities.', '/uploads/1754344494887-1749602985251.jpg', 5449.00, 14, 10, 2, 1),
(33, 'Samsung Galaxy A06', 'Samsung Galaxy A06 smartphone with 128GB and 4GB RAM with 6.7-inch screen, 50MP professional camera, 5,000mAh battery with fast charging, Samsung Knox Vault security, and slim design', '/uploads/1754344528011-1749603037881.jpg', 409.00, 22, 10, 2, 1),
(34, 'Lenovo Legion R25f', 'Lenovo 24.5\" gaming computer monitor, model R25F-30, with VA LED panel, 280Hz refresh rate, 1920x1080 resolution, 0.5ms response time, HDMI and DisplayPort connections', '/uploads/1761686770670-1702900149i49YM.webp', 855.00, 25, 1, 4, 1),
(35, 'Dell Alienware 27 AW2725Q 4K UHD', 'A 27-inch QD-OLED gaming monitor with stunning 4K resolution and an ultra-high pixel density of 166PPI – the highest in the world for this type of display. Offers accurate colors, impressive contrast and Dolby Vision HDR technology – for an immersive and detailed gaming experience.', '/uploads/1761686853478-1751892287l87Pe.webp', 3390.00, 11, 5, 4, 1),
(36, 'Apple iPhone 17 Pro Max ', 'iPhone 17 Pro Max – Experience the power: With a reinforced unibody design, the A19 Pro chip for lightning-fast performance, and next-generation battery life. Triple 48MP Pro Fusion cameras give you unprecedented 8x zoom, cinematic 4K Dolby Vision photography, and sharp, stunning photos in any light.', '/uploads/1761687064400-1759668391l91VF.webp', 5990.00, 33, 6, 2, 1),
(37, 'Dell Alienware AW2524HF IPS', 'Dell Alienware 24.5\" gaming monitor, model AW2524HF, IPS panel, 1920x1080 Full HD resolution, 0.5ms response time, 500Hz refresh rate, HDMI / 2xDisplayPort display connections, includes a built-in USB splitter', '/uploads/1761687129232-1716884659u59Fj.webp', 2131.00, 27, 5, 4, 1),
(38, 'ASUS ROG Strix G18', 'The new ROG Strix G18 gaming laptop from ASUS offers an extreme gaming experience with a new generation Intel Core Ultra 9 processor, GeForce RTX 5080 graphics card, a breathtaking 18-inch 240Hz display, and groundbreaking cooling technologies — because when speed, power, and style meet, victory is already in your pocket.', '/uploads/1761687219133-1748769627b27Pm.webp', 13315.00, 14, 3, 1, 1),
(39, 'Dell Alienware 27 IPS 360Hz', 'Dell Alienware 27-inch gaming computer monitor, model AW2724HF, matte IPS panel, 1920x1080 FHD resolution. 1ms response time, 360Hz refresh rate and support for AMD FreeSync Premium technologies for a smooth display for action games, including 2xDisplayPort connections, an HDMI connection and four USB 3.2 inputs for connecting a variety of peripherals directly to the screen. Includes a removable headphone stand.', '/uploads/1761687291025-1726737186m86Qh.webp', 1530.00, 33, 5, 4, 1),
(40, 'Corsair K55 CORE RGB', 'The CORSAIR K55 CORE gaming keyboard puts you on top with dynamic RGB backlighting, fully customizable, dedicated media buttons, and quiet, responsive switches.', '/uploads/1761687463103-1718778518l18Yg.webp', 182.00, 170, 9, 5, 1),
(41, 'Samsung Odyssey G5', 'Samsung Odyssey G5 Series Ultra 34-inch curved gaming monitor, VA LED panel, 3440x1440 Ultra WQHD resolution, 165Hz refresh rate, 1ms response time, HDMI and DisplayPort display connection', '/uploads/1761687565553-1626865218m18Zs.jpg', 1749.00, 32, 10, 4, 1),
(42, 'HP OMEN MAX 16-inch', 'HP OMEN MAX – Mobile gaming at the top of performance. HP’s new gaming PC delivers a powerful gaming experience thanks to an Intel Core Ultra 9 processor, GeForce RTX 5080 graphics card, a stunning 240Hz OLED display and 32GB DDR5 memory – everything you need to win in the arena or create content, anywhere, anytime.', '/uploads/1761687713001-1752491241b41OL.webp', 10995.00, 14, 2, 1, 1),
(43, 'iPhone SE (3rd generation)', 'Apple iPhone SE (3rd generation), 64GB, black, Lightning connector, with Touch ID fingerprint sensor built into the home button', '/uploads/1761687764351-1756819866A66XC.webp', 1351.00, 5, 6, 2, 1),
(44, 'Logitech G915 X Low Profile', 'The Logitech G915 X Low Profile Wired Gaming Keyboard in Hebrew and English offers iconic speed, exceptional precision, and advanced customization in a sleek, ultra-thin design. With KEYCONTROL, GL mechanical switches, and custom LIGHTSYNC RGB lighting, it delivers a smooth, stylish gaming experience designed for gamers seeking ultimate control and high performance.', '/uploads/1761687860731-1732270921x21Gp.webp', 761.00, 27, 7, 5, 1),
(45, 'Samsung Odyssey OLED G9', 'Samsung 48.7\" curved gaming computer monitor from the Odyssey series, model S49CG954EM, VA LED panel, 5120x1440 Dual QHD resolution, 1ms response time, 240Hz refresh rate, DisplayHDR 1000 support, including Display Port / 2xHDMI connections', '/uploads/1761687975932-1702905079g79XP.webp', 4500.00, 7, 10, 4, 1),
(46, 'HP Victus', 'HP Victus 15 – Your mobile monster for immersive gaming! With a powerful 13th generation Intel Core i7 processor, NVIDIA GeForce RTX 5060 graphics card, and a 15.6-inch FHD screen with a 144Hz refresh rate – this is the laptop that will boost your performance levels, blur the line between reality and gaming, and accompany you on every mission – from FPS battles to advanced graphics.', '/uploads/1761688117106-1761658035w35DC.webp', 5050.00, 54, 2, 1, 1),
(47, 'Corsair HARPOON RGB PRO', 'The Corsair HARPOON RGB PRO gaming mouse with a sporty, comfortably shaped design, a 12,000 DPI sensor, and an incredibly light 85g weight is ideal for endless hours of effortless gaming.', '/uploads/1761688257107-1718717158e58Os.webp', 99.00, 54, 9, 6, 1),
(48, 'Asus TUF Gaming T500 (2025)', 'A pre-built mini desktop computer from Asus, with an Intel® Core™ i7-13620H processor, NVIDIA® GeForce RTX™ 3050 6GB graphics card, 16GB memory, 1TB SSD, and no operating system.', '/uploads/1761688516251-b_7.jpg', 3573.00, 18, 3, 3, 1),
(49, 'CORSAIR K70 CORE TKL Compact', 'Enjoy more desk space with a compact TKL key layout that provides one-stop access to all your important keys and shortcuts. Also, advanced Macro programming via iCUE and a massive 1000Hz polling response, smooth and stable response, pleasant clicks and feel for a perfect gaming experience with the next-generation MLX RED v2 switches! In addition, the keyboard has stunning RGB lighting per key that includes a unique Fresnel lens.', '/uploads/1761688595230-1747816777u77QD.webp', 499.00, 44, 9, 5, 1),
(50, 'Logitech G102 Lightsync', 'Logitech G102 Lightsync Wired Gaming Mouse in Black with RGB LED lighting. High-performance gaming, six customizable buttons, including a DPI Cycle button that allows you to adjust the sensitivity of the mouse sensor. Includes built-in memory that allows you to move it from computer to computer using the Logitech G HUB app and use your personal settings anywhere.', '/uploads/1761689003082-1593706233p33Pu.jpg', 95.00, 31, 7, 6, 1),
(51, ' LG UltraGear 34GS95QE-B', 'LG 34\" UltraGear 34GS95QE-B gaming computer monitor with a curved OLED panel, 3440x1440 UWQHD resolution, 240Hz refresh rate, 0.03ms response time, 2xHDMI / DisplayPort connections and a built-in USB 3.0 splitter', '/uploads/1761689086648-1716204429r29Wg.webp', 6400.00, 30, 4, 4, 1),
(52, 'HP Omen 45L BG2G6EA', 'Pre-built gaming desktop computer from HP, with Intel® Core™ Ultra 9 285K processor, NVIDIA® GeForce RTX™ 5090 32GB graphics card, 64GB memory, 4TB SSD in 2TB + 2TB configuration and no operating system', '/uploads/1761689158284-b_2.jpg', 21000.00, 18, 2, 3, 1),
(53, 'Acer Nitro KG272 M3', 'Acer Nitro 27-inch gaming computer monitor, IPS panel, 1920x1080 Full HD resolution with a refresh rate of up to 180Hz, includes built-in speakers, 2xHDMI / 1xDisplayPort ports', '/uploads/1761689226713-1732789914v14MF.webp', 900.00, 28, 11, 4, 1),
(54, 'Lenovo LOQ 15IRX10', 'Lenovo LOQ 15IRX10 Gaming Laptop – Designed to Win. A powerful gaming laptop with a winning combination of smart performance, advanced cooling, and an immersive display. With a new generation Intel Core processor, RTX 50 Series graphics, intelligent RGB lighting, and HyperChamber cooling system – this is your tool to dominate the arena, play without compromise, and conquer every goal.', '/uploads/1761689296630-1749122830w30Uu.webp', 5300.00, 24, 1, 1, 1),
(55, 'Acer Predator Orion 7000', 'A pre-built gaming desktop computer from Acer, featuring an Intel® Core™ Ultra9 285KF processor, NVIDIA® GeForce RTX™ 5090 32GB graphics card, 32GB memory, 1TB SSD, and includes an operating system', '/uploads/1761689414420-b_12.jpg', 18500.00, 17, 11, 3, 1),
(56, 'LG Curved UltraWide™', 'LG 34\'\' curved computer monitor, model 34WQ75C-B, with IPS panel, 3440x1440 resolution, 5ms response time, with HDMI, DP, USB-C connections', '/uploads/1761689477620-1672237969i69NF.jpg', 3000.00, 44, 4, 4, 1),
(57, 'Logitech G402', 'A high-quality gaming mouse from Logitech, with 8 programmable buttons and DPI level control.', '/uploads/1761689689955-b_2 (1).jpg', 140.00, 34, 7, 6, 1),
(58, 'Lenovo Legion T5', 'A pre-built gaming desktop computer from Lenovo, featuring an Intel® Core™ Ultra7 265K processor, NVIDIA® GeForce RTX™ 5070 Ti graphics card, 32GB of memory, a 2TB SSD, and an operating system.', '/uploads/1761689928140-b_3.jpg', 11000.00, 31, 1, 3, 1),
(59, 'Asus ROG G700 ', 'A pre-built desktop computer from Asus, with an Intel® Core™ Ultra 7 265KF processor, an NVIDIA® GeForce RTX™ 5080 16GB graphics card, 32GB of memory, a 2TB SSD drive, and no operating system.', '/uploads/1761689993693-b_2 (2).jpg', 11300.00, 28, 3, 3, 1),
(60, 'Asus ROG Phone 9 Pro', 'ASUS gaming mobile phone with a 6.78-inch screen, 3 rear cameras 50+13+32 megapixels and a 32 megapixel selfie camera, 8-core chipset, supports 5G network and has a fingerprint reader. Transparent cover included in the package.', '/uploads/1761690093920-b_4.jpg', 5100.00, 13, 3, 2, 1),
(61, 'Corsair K65 PLUS', 'Corsair mechanical gaming keyboard featuring MLX RED switches and customizable per-key RGB backlighting!', '/uploads/1761690345910-b_1.jpg', 550.00, 18, 9, 5, 1),
(62, 'Acer EK251Q G FHD', 'Acer computer monitor with FHD resolution (1920x1080), 24.5\'\', IPS panel, HDMI, VGA connections, and can be hung on the wall. No speakers.', '/uploads/1761690424301-b_1 (1).jpg', 300.00, 16, 11, 4, 1),
(63, 'Apple MacBook Air 13', 'Meet the new MacBook Air from Apple—thinner, faster than ever, and incredibly powerful, thanks to a new, advanced chip from Apple. With breakthrough performance, unprecedented battery life, and a sleek, ultra-light design, it’s perfect for working, learning, and creating without limits. Everything you love about Mac, now faster and more efficient than ever.', '/uploads/1761690517465-b_1 (2).jpg', 5400.00, 13, 6, 1, 1),
(64, 'LG UltraGear 24GS50F-B', 'LG gaming screen with Full HD resolution (1920x1080) in size 23.7\'\' with VA panel, includes HDMI, DP and headphone connections, AMD FreeSync technology and wall-mounting option.', '/uploads/1761690913957-b_1 (3).jpg', 540.00, 18, 4, 4, 1),
(65, 'Asus V16 V3607VJ-RP101', 'Asus gaming laptop with a 16-inch WUXGA (1920x1200) resolution screen, Intel® Core™ 7 240H processor, NVIDIA® GeForce RTX™ 3050 6GB graphics accelerator, 16GB internal memory, 1TB SSD drive and no operating system.', '/uploads/1761691039304-b_2 (3).jpg', 3500.00, 22, 3, 1, 1),
(66, 'Samsung Odyssey G8', 'A 27\'\' Samsung gaming computer monitor, supporting 4K UHD resolution (3,840x2,160) and featuring an OLED panel and an extremely high refresh rate.', '/uploads/1761691143960-b_16.jpg', 4420.00, 32, 10, 4, 1),
(67, 'Acer Nitro V15', 'Acer gaming laptop with a 15.6\'\' screen with FHD 1920x1080 resolution, Intel® Core i5-13420H processor, NVIDIA® GeForce® RTX 3050 6GB graphics accelerator, 16GB internal memory, 1TB SSD drive, and includes an operating system.', '/uploads/1761691335011-b_5.jpg', 3444.00, 19, 11, 1, 1),
(68, 'Lenovo Yoga Slim', 'A 14\'\' Lenovo laptop with WUXGA (1920x1200) OLED resolution, Intel® Core™ Ultra 7 258V processor, 32GB internal memory, 1TB SSD drive, and includes an operating system.', '/uploads/1761691751403-b_7 (1).jpg', 5890.00, 33, 1, 1, 1),
(69, 'Asus ROG Swift', 'ASUS gaming computer monitor with a 31.5\'\' OLED panel, 4K resolution (3840 x 2160), 240Hz refresh rate, HDMI, DisplayPort and USB ports, wall mount option, NVIDIA G-SYNC compatibility and AMD FreeSync technology.', '/uploads/1761691862654-b_1 (4).jpg', 6550.00, 29, 3, 4, 1),
(70, 'Lenovo Legion R34w', 'A high-quality curved computer monitor from Lenovo that provides a 34-inch UWQHD resolution with a high-quality VA panel, a 180Hz refresh rate, diverse connectivity, and includes FreeSync support.', '/uploads/1761692005825-b_4 (1).jpg', 1233.00, 43, 1, 4, 1),
(71, 'Lenovo Legion M300s', 'Lenovo\'s gaming mouse is designed for speed and durability, weighing an extremely light 61 grams, with 6 programmable buttons, RGB LED lighting in 16.8 million colors, and an optical sensor with a resolution of 8000DPI.', '/uploads/1761692337314-b_2 (4).jpg', 99.00, 54, 1, 6, 1),
(72, 'Asus KW100', 'ASUS Marshmallow KW100 offers a minimalist design that fits perfectly into your home or office. Compatible with Windows, ChromeOS, MacOS, iOS, and iPadOS devices, the ASUS Marshmallow KW100 offers exceptional connectivity flexibility for easy everyday use.', '/uploads/1761692998868-b_1.jpg', 145.00, 18, 3, 5, 1),
(73, 'Acer Cestus 335', 'The Predator Cestus 315 gaming mouse from Acer gives you the perfect gaming experience using a high-quality sensor capable of providing up to 19,000 DPI and has 10 built-in buttons, giving you full control over every game.', '/uploads/1761693125881-b_2 (1).jpg', 185.00, 23, 11, 6, 1),
(74, ' Razer V4X - Pokemon Kanto Edition', 'The Razer Pokémon Edition mechanical gaming keyboard combines robust design with precise performance and complete control. Equipped with advanced mechanical switches, stunning Chroma RGB lighting and dedicated macro keys - for a smooth, powerful and personalized gaming experience.', '/uploads/1761693197793-b_1 (1).jpg', 685.00, 14, 8, 5, 1),
(75, 'Acer Aethon 700', 'A high-quality mechanical gaming keyboard from Acer with an innovative structure and mechanical switches developed by Acer for extremely fast response and a durable aluminum structure.', '/uploads/1761693314791-b_5.jpg', 455.00, 23, 11, 5, 1),
(76, 'Razer BlackWidow V4', 'A sleek and impressive wireless gaming keyboard from Razer that combines premium design with high usability and smart features. It offers a smooth typing experience, full control and perfect fit for long hours of gaming and working – all in a sleek and lightweight design that fits any gaming environment.', '/uploads/1761693429407-b_1 (2).jpg', 685.00, 19, 8, 5, 1),
(77, 'Lenovo LOQ 26ADR10', 'A pre-built desktop computer from Lenovo, featuring an AMD Ryzen™ 7 8745HX processor, an NVIDIA® GeForce RTX™ 5070 12GB graphics accelerator, 64GB of memory, a pair of 1TB SSD drives each, and an operating system.', '/uploads/1762800490454-b_3.jpg', 7500.00, 19, 1, 3, 1),
(78, 'OnePlus Nord N30 SE 5G', 'A quality cell phone from OnePlus, with a 6.72-inch screen, a pair of 50+2 megapixel rear cameras and an 8 megapixel selfie camera, an advanced Android system, a fingerprint reader, a powerful battery, and supports the fifth-generation 5G network.\r\n', '/uploads/1762801766546-b_1.jpg', 533.00, 44, 14, 2, 1),
(79, 'Xiaomi G34WQi WQHD', 'High-quality gaming computer monitor from Xiaomi - 34-inch WQHD Ultrawide curved gaming screen (VA panel) with a 21:9 aspect ratio - ideal for gaming and multitasking - borderless on the sides and top. Colorful LED ring (RGB) on the back of the screen - provides E-Sport ambient lighting tailored for gaming.', '/uploads/1762801996283-b_1 (1).jpg', 1050.00, 14, 13, 4, 1),
(80, 'MSI MPG Trident AS AI', 'A pre-built desktop computer from MSI, featuring an Intel® Core™ Ultra 7 265F processor, NVIDIA® GeForce® RTX™ 5060 Ti 16G graphics accelerator, 16GB of memory, a 1TB SSD drive, and includes an operating system.', '/uploads/1762802107216-b_2.jpg', 6778.00, 33, 12, 3, 1),
(81, 'MSI Optix MEG381CQR', 'A high-quality curved computer monitor from MSI with UWQHD+ resolution, a 37.5-inch IPS panel, DisplayPort, HDMI and USB 3.2 ports, wide color gamut and G-SYNC ULTIMATE technology.', '/uploads/1762802163696-b_1 (2).jpg', 5890.00, 22, 12, 4, 1),
(82, 'Xiaomi Poco C71', 'A high-quality mobile phone from Xiaomi with a 6.88-inch screen, two 32MP + 2MP rear cameras and an 8MP selfie camera, an 8-core chipset, supports the fourth-generation 4G LTE network, and has a fingerprint reader.', '/uploads/1762802239039-b_1 (3).jpg', 355.00, 33, 13, 2, 1),
(83, 'OnePlus Nord 5', 'A quality cell phone from OnePlus, with a 6.83\" screen, two 50+8 megapixel rear cameras and a 50 megapixel selfie camera, an advanced Android-based operating system, a fingerprint reader, a powerful battery, and supports the fifth-generation 5G network.', '/uploads/1762802321620-b_1 (4).jpg', 1670.00, 22, 14, 2, 1),
(84, 'MSI Stealth A16', 'MSI gaming laptop with a 16\'\' screen with an OLED panel with QHD+ resolution (2560x1600), AMD Ryzen™ AI 9 HX 370 processor, NVIDIA® GeForce® RTX 5070 8GB graphics accelerator, 32GB internal memory, 1TB SSD drive, and includes an operating system.', '/uploads/1762802395537-b_2 (1).jpg', 11000.00, 22, 12, 1, 1),
(85, 'MSI MAG Infinite E1', 'A pre-built desktop computer from MSI, featuring an Intel® Core™ i5-14400F processor, GeForce RTX™ 4060 graphics card, 16GB of memory, a 1TB SSD drive, and an operating system.', '/uploads/1762802471092-b_1 (5).jpg', 4050.00, 34, 12, 3, 1),
(86, 'MSI MAG401QR', 'A high-quality computer monitor from MSI with a 40-inch IPS panel, 155Hz refresh rate, Adaptive-Sync support, and HDMI and DisplayPort ports.', '/uploads/1762802566199-b_1 (6).jpg', 1900.00, 22, 12, 4, 1),
(87, 'Xiaomi Poco C75', 'A high-quality mobile phone from Xiaomi with a 6.88-inch screen, 3 rear cameras and a 13-megapixel selfie camera, an 8-core chipset. Supports NFC.', '/uploads/1762802815806-1741335722e22Sw.webp', 450.00, 23, 13, 2, 1),
(88, 'MSI Prestige 16', 'A laptop from MSI with a 16\'\' screen with QHD+ resolution (2560x1600), an Intel® Core™ Ultra 7 258V processor, 32GB of internal memory, a 1TB SSD drive, and includes an operating system.', '/uploads/1762802867933-b_2 (3).jpg', 7100.00, 35, 12, 1, 1),
(89, 'MSI MPG 321URX', 'The MPG 321URX QD-OLED gaming monitor delivers the highest level of visual performance. The monitor features a QD-OLED panel with a resolution of 3840x2160 (UHD), an impressive refresh rate of 240Hz, and an ultra-fast response time of 0.03ms (GtG) – for a sharp, fluid and smooth gaming experience. The monitor is also suitable for consoles and includes HDMI 2.1 connections with 48Gbps bandwidth, support for a refresh rate of 120Hz, as well as VRR and ALLM.', '/uploads/1762802908956-b_5.jpg', 4300.00, 21, 12, 4, 1),
(90, 'Xiaomi Redmi Note 14 Pro', 'A high-quality cell phone from Xiaomi with a 6.67-inch screen, a triple camera array of 200MP + 8MP + 2MP and a 20MP selfie camera, an 8-core chipset, supports the fifth-generation 5G network, and has a fingerprint reader.', '/uploads/1762802997875-357968.jpg', 1670.00, 18, 13, 2, 1),
(91, 'Xiaomi G27i', 'A high-quality 27-inch gaming computer screen from Xiaomi displays a sharp image with FHD resolution and a 178° viewing angle with a high-quality IPS panel.', '/uploads/1762803141610-324414.jpg', 440.00, 7, 13, 4, 1),
(92, 'MSI MPG Infinite X3', 'A pre-built desktop computer from MSI, featuring an Intel® Core™ Ultra 9 285K processor, an MSI GeForce RTX 5090 VENTUS 3X 32GB graphics accelerator, 32GB of memory, a 1TB SSD drive, and includes an operating system.', '/uploads/1762803211611-msi-mpg-infinite-x3-ai-2nd.jpg', 18890.00, 22, 12, 3, 1),
(93, 'Xiaomi Poco F7', 'A high-quality cell phone from Xiaomi with a 6.83-inch screen, two 50MP + 8MP rear cameras and a 20MP selfie camera, an 8-core chipset, supports the fifth-generation 5G network, and has a fingerprint reader.', '/uploads/1762803268357-393977.jpg', 1700.00, 34, 13, 2, 1),
(94, 'MSI MAG 274UPF', 'A high-quality computer monitor from MSI with a 27-inch Rapid IPS panel, 144Hz refresh rate, HDR support, USB-C, HDMI, and DisplayPort ports, and the option to hang it on the wall.', '/uploads/1762803369484-a484e2e5d3db671f7d067299568daae2.jpg', 2080.00, 18, 12, 4, 1),
(95, 'Xiaomi Poco F7 Pro', 'A high-quality cell phone from Xiaomi with a 6.67-inch screen, two 50MP + 8MP rear cameras and a 20MP selfie camera, an 8-core chipset, supports the fifth-generation 5G network, and has a fingerprint reader.', '/uploads/1762803423800-379455.jpg', 2010.00, 74, 13, 2, 1),
(96, 'MSI Modern MD272UPHG', 'MSI computer monitor with a 27\'\' IPS panel, 3840x2160 (UHD) resolution, 60Hz refresh rate, Type-C, HDMI and DisplayPort ports. Wall-mountable and with a variety of adjustment options. A great screen for business and productivity.', '/uploads/1762803479992-397177.jpg', 1020.00, 28, 12, 4, 1),
(97, 'Xiaomi Poco X7 Pro', 'A high-quality cell phone from Xiaomi with a 6.67-inch screen, a pair of 50MP + 8MP rear cameras and a 20MP selfie camera, an 8-core chipset, supports the fifth-generation 5G network, and has a fingerprint reader.', '/uploads/1762803545841-fc61f9b6-daf6-4ece-80cf-08f45490fa30.avif', 1520.00, 41, 13, 2, 1),
(98, 'MSI Titan 18 HX ', 'MSI gaming laptop with an 18\" screen with UHD+ resolution (3840x2400), Intel® Core™ Ultra 9 285HX processor, NVIDIA® GeForce® RTX 5090 24GB graphics accelerator, 96GB internal memory, 4TB SSD drive, and includes an operating system.', '/uploads/1762803613538-600.png', 25670.00, 29, 12, 1, 1),
(99, 'OnePlus 13 5G', 'A cell phone from OnePlus, with a 6.82-inch screen, a 3-camera system on the back and a front camera, an advanced Android system, a fingerprint reader, a powerful battery, and supports the fifth-generation 5G network.', '/uploads/1762803681858-356834.jpg', 3030.00, 18, 14, 2, 1),
(100, 'Xiaomi G Pro 27i ', 'A high-quality 27-inch gaming computer screen from Xiaomi displays a sharp image with 2K resolution and a 178° viewing angle with a high-quality Fast IPS panel.', '/uploads/1762803755495-340153.jpg', 1450.00, 24, 13, 4, 1),
(101, 'MSI Vector 17 HX', 'MSI gaming laptop with a 17\'\' screen with QHD+ resolution (2560x1600), Intel® Core™ Ultra 9 275HX processor, NVIDIA® GeForce RTX™ 5070 Ti 12GB graphics accelerator, 64GB internal memory, 2TB SSD drive, and includes an operating system.', '/uploads/1762803864392-8452c0640ba6e75b-l.webp', 12880.00, 38, 12, 1, 1),
(102, 'OnePlus Nord CE 4', 'A quality cell phone from OnePlus, with a 6.77\" screen, a dual 50+2 megapixel rear camera array and a 16 megapixel selfie camera, an advanced Android operating system, a fingerprint reader, a powerful battery, and supports the fifth-generation 5G network.', '/uploads/1762803930282-ad3a7ab482ea9ba7fa0975c775769e7c.avif', 760.00, 54, 14, 2, 1),
(103, 'MSI MAG Infinite S3', 'A pre-built desktop computer from MSI, featuring an Intel® Core™ i7-14700F processor, NVIDIA® GeForce® RTX™ 5060 Ti 16G graphics accelerator, 16GB of memory, a 1TB SSD drive, and includes an operating system.', '/uploads/1762804048482-kv-dt.png', 5930.00, 44, 12, 3, 1),
(104, 'Xiaomi Poco M7 Pro', 'A high-quality cell phone from Xiaomi with a 6.67-inch screen, a pair of 50MP + 2MP rear cameras and a 20MP selfie camera, an 8-core chipset, supports the fifth-generation 5G network, and has a fingerprint reader.', '/uploads/1762804092035-403393.jpg', 820.00, 33, 13, 2, 1),
(105, 'MSI MPG 491CQPX', 'A wide, curved computer monitor from MSI featuring a 49-inch QD-OLED panel, with an ultra-high refresh rate of 240Hz. The ultimate monitor for gamers.', '/uploads/1762804188686-600 (1).png', 4980.00, 23, 12, 4, 1),
(106, 'Xiaomi 15T Pro', 'A high-quality cell phone from Xiaomi with a 6.83\" screen, a 3-camera Leica rear array, a 32MP selfie camera, an 8-core processor, supports the fifth-generation 5G network, facial recognition, and a fingerprint reader integrated into the screen.', '/uploads/1762804254998-b07a95c9-075c-454b-ad29-2d0649a07560.avif', 2770.00, 5, 13, 2, 1),
(107, 'MSI CreatorPro 16 A1VJG', 'MSI laptop with a 16\'\' screen with QHD+ resolution (2560x1600), Intel® Core™ Ultra 7 155H processor, NVIDIA® RTX™ 2000 Ada Generation 8GB graphics accelerator, 32GB internal memory, 2TB SSD drive, and includes an operating system.', '/uploads/1762804365004-msi-creator-pro-m16-gallery03.png', 10120.00, 38, 12, 1, 1),
(108, 'MSI MAG Infinite E1 14NTA5', 'A pre-built desktop computer from MSI, featuring an Intel® Core™ i5-14400F processor, GeForce RTX™ 3050 graphics card, 16GB of memory, a 1TB SSD drive, and an operating system.', '/uploads/1762804471823-kv-dt (1).png', 3304.00, 40, 12, 3, 1),
(109, 'Sony Over-Ear WHULT900NB', 'ULT Wear ULT Power Sound ULT Power Sound ULT ULT Wear ULT Power Sound ULT Power Sound ULT Power Sound ULT Power Sound ULT Power Sound ULT Power Sound ULT Power Sound ULT Power Sound Sound Please don\'t worry about it. Here\'s what\'s going on here Please wear ULT Wear.', '/uploads/1762993249056-1748950468j68ZB.webp', 414.00, 18, 15, 7, 0),
(110, 'Lenovo Legion H300', 'Read more about the latest version of Lenovo I\'m sorry, I don\'t know, I don\'t know, I don\'t know Please contact us for more information 50 מ\'\'מ', '/uploads/1762993539222-779300701-1.jpg', 160.00, 22, 1, 7, 1),
(111, 'Xiaomi Buds 5', 'High-quality wireless headphones from Xiaomi that give you wireless freedom to listen to music and make calls from your mobile phone from anywhere, anytime with a powerful battery and charging case.', '/uploads/1762993634107-376963.jpg', 380.00, 32, 13, 7, 1),
(112, 'Samsung Galaxy Buds3', 'Samsung\'s Galaxy Buds3 wireless headphones give you a 360-degree quality listening experience with 24bit Hi-Fi, the highest level of background noise cancellation with three microphones, and an ergonomic design for maximum comfort.', '/uploads/1762993730516-C000001039_0-17206989503507308.jpg', 250.00, 15, 10, 7, 1),
(113, 'Lenovo Legion H600', 'High-quality gaming headset from Lenovo with exceptional audio quality, a noise-canceling microphone, provides lightweight comfort, and cushioned ear cups with 50mm drivers.', '/uploads/1762993797511-172641.jpg', 233.00, 77, 1, 7, 1),
(114, 'OnePlus Buds 3 Pro', 'OnePlus Buds 3 Pro wireless headphones feature dual 11mm drivers for powerful and accurate sound, adaptive noise cancellation, and an IP55 rating against water and sweat for worry-free listening.', '/uploads/1762993849493-329579.jpg', 533.00, 37, 14, 7, 1),
(115, 'Xiaomi Redmi Buds 6', 'High-quality wireless headphones from Xiaomi that give you wireless freedom to listen to music and make calls from your mobile phone from anywhere, anytime with a powerful battery and charging case.', '/uploads/1762993906199-366974.jpg', 227.00, 15, 13, 7, 1),
(116, 'MSI Immerse GH50', 'Acer wireless gaming headset Hear it all with powerful audio, from the softest footsteps to the loudest explosions thanks to high-density 50mm neodymium drivers with an extended frequency range.', '/uploads/1762993963531-284504.jpg', 388.00, 17, 12, 7, 1),
(117, 'Acer Predator Galea 550', 'Acer wireless gaming headset Hear it all with powerful audio, from the softest footsteps to the loudest explosions thanks to high-density 50mm neodymium drivers with an extended frequency range.', '/uploads/1762994034471-312972.jpg', 338.00, 44, 11, 7, 1),
(118, 'Sony WF-1000XM5B TWS ', 'SONY WF-1000XM5B Bluetooth wireless headphones with microphone in silver color including charging case with a frequency range of 20 Hz - 20,000 Hz', '/uploads/1762994517538-1690725607l07JG.jpg', 694.00, 30, 15, 7, 0),
(119, 'Xiaomi Watch S4 AUG', 'Xiaomi\'s smart sports watch includes SpO2 (blood oxygen percentage), heart rate, and GPS that allows you to monitor your health around the clock. It has a 1.43-inch AMOLED touchscreen with always-on display (AOD) for the watch, full Hebrew support, and Bluetooth calling support.', '/uploads/1762994836867-f3d5e6c4-dc8f-4b9e-9d5b-2ec519633ee6_1_.avif', 583.00, 33, 13, 8, 0),
(120, 'Samsung Galaxy Watch8 ', 'Samsung\'s Galaxy Watch8 LTE Classic smartwatch features a classic and luxurious design, powerful performance, and the One UI 8 interface. The watch has a variety of smart functions, such as personalized sleep tracking, daily health monitoring, voice commands, and more.', '/uploads/1762994906686-395581.jpg', 1609.00, 18, 10, 8, 0),
(121, 'OnePlus Watch 2R', 'A high-quality smartwatch from OnePlus that provides life documentation on your wrist and allows you to track all your activities. It has an elegant design with sapphire glass, long battery life, IP68 water resistance and includes a wide range of workout types.', '/uploads/1762995027008-61lui6u8NtL._AC_UF350,350_QL80_.jpg', 575.00, 29, 14, 8, 0),
(122, 'Apple Watch Ultra 2', 'A smartwatch for measuring fitness data from Apple that provides life documentation on the wrist and allows you to accurately track all your activities, has a color screen with a Retina LTPO2 OLED display and includes GPS and eSIM support.', '/uploads/1762995148022-MYQ53ref_VW_34FRwatch-case-49-titanium-black-ultra2_VW_34FRwatch-face-49-trail-ultra2_VW_34FR-scaled.jpeg', 2210.00, 17, 6, 8, 0),
(123, 'Apple iPad Pro 13-inch (M4)', 'The Apple iPad Pro is powerful and fast, with an Ultra Retina XDR display, a powerful Apple M4 processor, a LiDAR sensor and a facial recognition sensor, a wide range of advanced features and broad connectivity support for the ultimate iPad experience.', '/uploads/1762996092874-61G6WfvA9vL._AC_UL210_SR210,210_.jpg', 5041.00, 14, 6, 9, 1),
(124, 'Xiaomi Redmi Pad 2 Pro', 'A tablet from Xiaomi that provides an excellent combination of size, portability, and power. With a wide screen that is also suitable for watching series and creating content, and a modern, slim design that makes it easy to hold and carry - it is the ideal choice for those looking for a smart solution for work, study, or leisure.', '/uploads/1762996201677-417496.jpg', 1355.00, 35, 13, 9, 1),
(125, 'OnePlus Pad Lite', 'A tablet from OnePlus with a color screen, quality sound, and a battery that lasts with you all day – a precise multimedia experience and peace of mind, all the time.', '/uploads/1762996291802-6921815629092.png', 719.00, 19, 14, 9, 1),
(126, 'Lenovo TAB K11 Plus', 'Lenovo tablet with an 11.45\" screen, Qualcomm® Snapdragon® SDM685 processor, 8GB RAM, 256GB storage, WiFi, Bluetooth, and 4G cellular connectivity. Includes Lenovo Tab Pen Plus stylus in the package.', '/uploads/1762996348122-395801.jpg', 1270.00, 30, 1, 9, 1),
(127, 'Apple iPad mini (A17 Pro)', 'The Apple iPad is powerful and lightweight, with an 8.3-inch Liquid Retina IPS display, a powerful A17 Pro processor, a 12-megapixel rear and front camera, and a wide range of other advanced features such as 5G cellular connectivity.', '/uploads/1762996416957-339468.jpg', 3422.00, 22, 6, 9, 1),
(128, 'Xiaomi Pad 7 Pro', 'A tablet from Xiaomi with an 11.2\" screen, Qualcomm® Snapdragon™ 8s Gen 3 processor, 12GB RAM, 512GB storage, WiFi and Bluetooth connectivity.', '/uploads/1762996474667-372248.jpg', 2270.00, 23, 13, 9, 1),
(129, 'Lenovo Legion TAB TB321FU', 'Lenovo tablet with an 8.8\" screen, Qualcomm Snapdragon® 8 Gen 3 processor, 12GB RAM, 256GB storage, WiFi and Bluetooth connectivity. Includes a screen protector and folio cover in the package.', '/uploads/1762996531417-legion_tab_8_8_3_ct2_001.avif', 1719.00, 19, 1, 9, 1),
(130, 'Samsung Galaxy Tab S11 Ultra', 'A thin and light tablet from Samsung – elegant and powerful, designed to take you further. With an immersive display, fast performance and advanced capabilities for work, creation and entertainment, it makes every moment an impressive experience.', '/uploads/1762996618435-409023.jpg', 4855.00, 35, 10, 9, 1),
(131, 'Xiaomi Redmi Pad SE', 'A tablet from Xiaomi with an 8.7-inch screen, a powerful MediaTek® HelioTM G85 processor, 6GB of RAM, 128GB of storage, Bluetooth wireless connectivity, and WIFI connectivity.', '/uploads/1762996675325-327723.jpg', 575.00, 25, 13, 9, 1),
(132, 'Acer Iconia Tab V11', 'A quality tablet from Acer with an 11\'\' screen, a powerful 8-core processor, 6GB of RAM and 256GB of storage, a front and rear camera, and an Android operating system. Includes Bluetooth and WiFi connectivity. Includes a transparent cover.', '/uploads/1762996778420-372828.jpg', 592.00, 32, 11, 9, 1),
(133, 'REDMAGIC Astra', 'A gaming tablet from REDMAGIC that combines power, precision, and an immersive user experience. With a high-quality screen, advanced cooling system, and performance that allows you to easily run demanding games and content, it sets a new standard for the world of gaming tablets. Its elegant design and impressive portability make it the perfect tool for entertainment, creation, and gaming anywhere.', '/uploads/1762997065919-RedMagic-Astra-1.webp', 2795.00, 35, 16, 9, 1),
(134, 'Acer Predator Z5', 'The Acer Predator Z57 is a 57-inch Super Ultrawide gaming monitor with a stunning 7680×2160 resolution. With a curved VA panel, 120Hz refresh rate, 1ms response time, and HDR1000 support with 1000nits peak brightness – this is a monitor built for a colossal, cinematic, and professional gaming experience.', '/uploads/1763167234019-predator-monitor-z57-wallpaper-black-logo-01.webp', 7520.00, 54, 11, 4, 1),
(135, 'LG 40WP95C-W', 'LG curved computer monitor with a 39.7\'\' IPS panel, 5120x2160 WUHD resolution, HDMI, DP, USB-C, Thunderbolt and USB 3.0 connections, built-in speakers, wall mount option and FreeSync support.', '/uploads/1763167466805-40wp95c-w1.jpg', 7192.00, 47, 4, 4, 1),
(136, 'TCL 57R94 G', '57-inch computer monitor with 32:9 Horizon Vision, dual 4K resolution, 1000R gold curve, 2304-zone precision dimming, 98% DCI-P3 ultra-wide color gamut, VESA HDR 1400 certified display, Rheinland Low Blue Light certification, and dual-channel speakers', '/uploads/1763167806240-57r94-11.avif', 7079.00, 55, 17, 4, 1),
(137, 'LG 27GR75Q-B', 'Gaming monitor offering a 165Hz refresh rate with a 1ms response time (gray to gray) IPS panel with QHD resolution G-Sync compatibility HDR10 display AMD Freesync Premium support Adjustable ergonomic stand', '/uploads/1763168280166-ucvfbtled.avif', 1070.00, 28, 4, 4, 1),
(138, 'Xiaomi GPro27i QHD', 'Computer monitor with a 27-inch Fast IPS Mini LED panel in a 16:9 aspect ratio - ideal for intensive gaming applications and a professional viewing experience, in a unique E-sports design that combines a colorful RGB LED backlight ring and extremely narrow bezels.\r\nMini LED backlight technology with full-array - 1152 zones and 4608 beads provides precise control over the image display and provides excellent details and light and shadow effects, combined with 4 dynamic lighting control modes for each scenario.\r\nSupport for AMD FreeSyncTM and Adaptive Sync technologies that ensure smooth synchronization of frame rate output between the graphics card and the screen, preventing frame tearing and image lag.', '/uploads/1763168468165-d9cfd8e7-b415-49aa-9efa-d13244252dff_1_.avif', 979.00, 67, 13, 4, 1),
(139, 'LG 32GP750', 'This monitor supports a wide color spectrum, 99% of the sRGB color gamut, expressing highly accurate color reproduction with VESA DisplayHDR™ 400, enabling a realistic and immersive visual experience.\r\nRegardless of the battlefield, it can help gamers see dramatic colors as game developers originally intended.', '/uploads/1763168685088-fgdgfddgfg.avif', 1111.00, 54, 4, 4, 1),
(140, 'TCL 27R83U G-Sync', 'TCL\'s QD-Mini LED technology combines the advantages of QLED and OLED technologies, transforming traditional backlighting into near-pixel-level precision lighting.\r\nThe technology combines the advantages of the world\'s most advanced QLED, with contrast and color gamut comparable to OLED, with additional advantages such as higher peak brightness and longer lifespan.', '/uploads/1763168883109-27r83u-111.avif', 1819.00, 77, 17, 4, 1),
(141, 'Philips 346E2LAE FreeSync', 'This Philips monitor features a USB Type-C port with power delivery.\r\nWith smart and flexible power management, you can charge your compatible device directly.\r\nThe slim USB-C port allows for easy connection with a single cable.\r\nYou can also watch high-resolution video and transfer data at super high speeds, while simultaneously powering and charging your compatible device.', '/uploads/1763169030345-2452324.jpg', 1154.00, 52, 18, 4, 1),
(142, 'Philips 499P9H', 'This Philips monitor features a built-in USB Type-C docking station with power delivery.\r\nThe slim, reversible USB-C connection allows for easy docking with a single cable.\r\nSimplicity is achieved by connecting all your peripherals like a keyboard, mouse, and RJ-45 Ethernet cable to the monitor\'s docking station.\r\nSimply connect your notebook and its monitor with a single USB-C cable to watch high-resolution video and transfer data at super high speeds, while simultaneously powering and charging your laptop.', '/uploads/1763169305557-36205-499-49-1.webp', 4090.00, 140, 18, 4, 1),
(143, 'HP Victus 15-fa2010nj', 'The computer is equipped with an Intel Core i5 processor, a 15.6-inch FHD (1920 x 1080) screen with a 144Hz refresh rate and IPS technology, 512GB SSD storage, 16GB RAM, GeForce RTX 4050 graphics processor and Windows 11 Home operating system.', '/uploads/1763169818825-hpvictus15fa2010black_1_.avif', 3337.00, 97, 2, 1, 1),
(144, 'Lenovo Yoga Pro 9 16IAH10', 'The computer is equipped with an Intel® Core Ultra 7 255H processor, a 16-inch 2.8K WQXGA+ (2880x1800) OLED screen, an NVIDIA® GeForce RTX™ 5070 graphics card, 32GB of soldered LPDDR5x-8400 memory, 1TB SSD storage, and the Windows® 11 Pro operating system, in Hebrew or English, which completes the package and offers a modern and easy-to-use user interface.', '/uploads/1763169950098-yoga_pro_9_16iah10_ct2_05_3.avif', 10939.00, 87, 1, 1, 1),
(145, 'Acer Predator Helios Neo 16S', 'Acer gaming laptop with a 16\'\' WQXGA (2560x1600) resolution screen, Intel® Core™ Ultra 9 275HX processor, NVIDIA® GeForce RTX™ 5070 Ti 12GB graphics accelerator, 32GB internal memory, 1TB SSD drive, and includes an operating system.', '/uploads/1763170105261-download_5__1_1.avif', 8357.00, 72, 11, 1, 1),
(146, 'HP Envy 17-DA0003NJ', 'HP Envy laptop with 17-inch touchscreen, Intel Core Ultra 7 155H processor, 16GB DDR5 memory, 1TB PCIe Gen4 SSD drive, IPS panel, FHD resolution (1920 x 1080), Wi-Fi 7 and Bluetooth 5.4 wireless connectivity, Thunderbolt 4 and USB 10Gbps connections', '/uploads/1763170336544-c08944381_1.avif', 4533.00, 111, 2, 1, 1),
(147, 'Asus TUF Gaming A16', 'An Asus gaming laptop with a 16-inch WUXGA (1920x1200) resolution screen, AMD Ryzen™ 9 8940HX processor, NVIDIA® GeForce RTX™ 5060 8GB graphics accelerator, 32GB internal memory, 1TB SSD drive, and includes an operating system.', '/uploads/1763170469271-e7d844f2-a3f6-4490-ba73-71e596b19d1f_1.avif', 5764.00, 47, 3, 1, 1);
INSERT INTO `products` (`product_id`, `name`, `description`, `image`, `price`, `stock`, `supplier_id`, `category_id`, `is_active`) VALUES
(148, ' Acer Predator Orion', 'Acer\'s Predator Orion 7000 series gaming and graphics work computer, with a powerful Intel Core i9-285K processor from the new Ultra Series 2 generation, including 40MB cache and a base frequency of 3.7GHz. Equipped with 32GB DDR5 memory with the option to expand up to 128GB, and a 1TB PCIe SSD drive for extremely fast storage. Includes an NVIDIA GeForce RTX 5080 graphics card with 16GB GDDR7, ideal for gamers, video editors, graphic designers and professionals in the field of VR and artificial intelligence. The computer includes a wide range of modern connections such as Thunderbolt 4, USB-C, USB 3.2, audio connections, and Wi-Fi 7 and Bluetooth 5.3 wireless communication.', '/uploads/1763170933582-predorion7000_5_.avif', 11950.00, 54, 11, 3, 1),
(149, 'HP Omen 35L-GT16', 'HP Omen 35L GT16-0012nj Gaming Desktop PC - Intel Core Ultra 9-285K RTX 5080 2TB SSD 64GB RAM Windows 11 NVIDIA® GeForce RTX™ series graphics cards are fast in a different way.\r\nThey are powered by the NVIDIA Ada Lovelace architecture, which boosts performance and AI-based graphics.\r\nExperience realistic virtual worlds with advanced RayTracing capabilities and ultra-high FPS gaming.', '/uploads/1763171074674-0022762_hp-omen-35l-gaming-desktop-gt16-0006nj-ultra7-265kkfury32gb1t-ssdrtx-5070-12gbwin11h3yos_1__1.avif', 11999.00, 43, 2, 3, 1),
(150, 'HP Victus 15L TG02-9U5N8EA', 'Get one machine to do it all with the Victus by HP 15L Desktop Gaming PC. Play for real with a powerful AMD processor and impressive graphics. Seamlessly switch over to work or streaming with the latest Windows 11 OS, Bluetooth® connectivity, 9 USB ports, and plenty of storage. Plus control RGB lighting and other performance features with the OMEN Gaming Hub.\r\n\r\n', '/uploads/1763171249575-079baf9eb22ab94c8f22ae2fc67855f9281d1c00.png.webp', 4034.00, 32, 2, 3, 1),
(151, 'Lenovo Legion T7', 'NVIDIA® GeForce RTX™ 40 Series GPUs are beyond fast for gamers and creators.\r\nPowered by the ultra-efficient NVIDIA Ada Lovelace architecture, they deliver a leap in performance and AI-powered graphics.\r\nExperience lifelike virtual worlds with ray tracing and ultra-high FPS gaming with the lowest latency.\r\nDiscover revolutionary new ways to create unprecedented workflow acceleration.', '/uploads/1763171363225-350356-3_2.avif', 9499.00, 21, 1, 3, 1),
(152, 'Asus ROG Strix G13CHR', 'ASUS ROG Strix G13CHR Desktop PC with i7-14700F Processor, 16GB RAM, 1TB SSD and Nvidia GeForce RTX 4060 Dual Graphics. Includes Windows 11 Home.\r\nDiscover the full Windows 11 gaming experience with the ROG Strix G13CHR.\r\nPowered by a 14th Gen Intel® Core™ i7 14700F processor and NVIDIA® GeForce RTX™ 4060 graphics, you’re truly ready for battle.\r\nThe PC also boasts 16GB of 5600MHz DDR5 RAM and 1TB SSD storage.\r\nGame, stream and keep all your tabs open without worry thanks to the power of the Strix G13CHR.', '/uploads/1763171569388-3f39c13d-df5d-4a29-bb6f-b46b39c55723.png', 5507.00, 45, 9, 3, 1),
(153, 'HP OmniDesk M03', 'HP OmniDesk Desktop AI M03-0008nj / C93H7EA - Core Ultra 5 1TB SSD 16GB RAM Windows 11. Easily perform everyday tasks with an Intel® Core™ Ultra processor with built-in artificial intelligence 2, technology and plenty of storage.', '/uploads/1763171785697-rarategshgdjyj_3_.avif', 3599.00, 2, 2, 3, 1),
(154, 'HP Slim S01-pF3009', 'HP Slim Desktop S01-pF3009 desktop computer, with an i7-13700 processor, 16GB memory, a fast 512GB SSD hard drive, Intel770 graphics accelerator. Includes Windows 11 Home operating system.\r\nThe powerful processor allows you to handle any task easily and efficiently, whether you are working.', '/uploads/1763172012089-c06426171_2.avif', 2745.00, 44, 2, 3, 1),
(155, 'Razer Cobra Pro', 'Win games and dazzle everyone with the Razer Cobra Pro - a wireless gaming mouse with Razer Chroma RGB lighting. Razer HyperSpeed ​​technology and 11 individually programmable lighting zones allow you to color your games with a new level of freedom.', '/uploads/1763172709927-razer-cobra-pro-gfghy.avif', 278.00, 174, 8, 6, 1),
(156, 'Asus Marshmallow MD100', 'The compact ASUS Marshmallow with its quick-release magnetic covers, and a handy strap that makes it easy to carry.\r\nFor better safety and hygiene, the covers feature ASUS Antimicrobial Guard treatment to inhibit the growth of harmful bacteria.\r\nThe ASUS Marshmallow Mouse MD100 also offers easily adjustable DPI levels for varying degrees of precision, plus 100% PTFE mouse feet for smooth gliding on any flat surface.', '/uploads/1763172831877-gadsfawqwf.webp', 85.00, 5, 3, 6, 1),
(157, 'Razer BlackWidow V2', 'Featuring advanced mechanical switches with optimal actuation distance, ultra-fast response time, and a lifespan of up to 80 million keystrokes per key.\r\nRazer Chroma lighting in 16.8 million customizable colors\r\nThe fastest-responding keyboard ever. When you\'re in the middle of an intense game, every hundredth of a second counts, in order to catch up with your opponent. With this keyboard, you can now win easily.', '/uploads/1763173105405-t_main_1.jpg', 455.00, 41, 8, 5, 1),
(158, 'Razer Pro Click V2', 'Increase your comfort and productivity with our ergonomic vertical wireless mouse.\r\nWork and play all day effortlessly, thanks to its natural fit and shortcuts to AI tools.\r\nBoost your productivity.\r\nSummarize text, draft emails, and more with just one click.\r\nDevelop powerful shortcuts with Razer Synapse 4, save them to your mouse, and instantly streamline your workflow for AI tools.\r\nOne-touch access: Press and hold the scroll wheel to instantly display them.', '/uploads/1763173290099-Razer_proclick2_vertical (1).png', 255.00, 15, 8, 6, 1),
(159, 'Razer Huntsman V2', 'Unrivaled responsiveness has never looked so slim.\r\nMeet the Razer Huntsman V2 TKL - a noiseless optical gaming keyboard with enhanced acoustics, near-zero input lag, and other advanced features to ensure a compact form factor designed for full-size performance.', '/uploads/1763173392258-6475701_sd.jpg', 689.00, 23, 8, 5, 1),
(160, 'HP Pavillion 200', 'Your next gaming session is about to be much more controlled, comfortable, and colorful. The HP Pavilion Gaming Mouse 200 is optimized for precise control and features an ergonomic design with RGB lighting.', '/uploads/1763173552433-g2.png', 24.00, 76, 2, 6, 1),
(161, 'Corsair CORS VOID V2', 'Stay connected to premium audio with cross-platform compatibility. Easily switch between low-latency 2.4GHz wireless for gaming and Bluetooth® with the touch of a button.', '/uploads/1763174057641-gfhfjhjhgkghk_2_.avif', 541.00, 47, 9, 7, 1),
(162, 'Razer Kraken V4 Pro ', 'Experience next-generation control with the Razer Kraken V4 Pro.\r\nA wireless RGB headset powered by Razer Sensa HD Haptics.\r\nEquipped with a dedicated OLED control center for maximum control at your fingertips.\r\nSend your gaming into overdrive with the ultimate Battlestation headset that can do it all.', '/uploads/1763174118069-gg_1.avif', 1099.00, 54, 8, 7, 1),
(163, 'Logitech G432', '50mm drivers for detailed sound.\r\nDTS Headphone: X 2.0 immersive surround sound.\r\nLarge 6mm microphone with volume control and tilt-up mute.\r\nMulti-platform compatibility - Hours of comfort for long gaming sessions.', '/uploads/1763174218457-g432-gallery-3.avif', 156.00, 41, 7, 7, 1),
(164, 'Razer Kraken Kitty V2 Pro RGB', 'The headset features 50mm Razer™ TriForce Titanium drivers. With titanium-coated diaphragms for added sound clarity, Razer\'s innovative design divides the driver into 3 sections for individual tuning of high, mid and low tones, taking your in-game audio to new levels.', '/uploads/1763174319524-razer-kraken-kitty-v2-pro-dsdeee.avif', 653.00, 7, 8, 7, 1),
(165, 'HP X1000', 'Wireless Freedom With wireless connectivity via USB and up to 20 hours of battery life, you can stay connected and immersed in the game for longer.\r\nHear Everything 7.1 - Virtual surround sound delivers more precision, depth, and clarity to your gaming experience. Large 50mm drivers deliver superior sound quality.', '/uploads/1763174394503-1613732009t09Pt.jpg', 255.00, 54, 2, 7, 1),
(166, 'Razer Kaira Pro - PS5', 'The Razer Kaira Pro HyperSpeed ​​Wireless Gaming Headset is a cross-platform headset powered by Razer™ HyperSense.\r\nWith the ability to feel what you hear and dual wireless connectivity, you\'ll have no problem losing yourself in your game, no matter where you play.', '/uploads/1763174513267-sss_1__2.avif', 881.00, 18, 8, 7, 1),
(167, 'Philips TAT5506BK', 'These true wireless headphones don\'t just look great - they also help you focus.\r\nAdvanced noise cancellation filters out unwanted sounds, and Awareness Mode lets you hear the world around you.\r\nTurn on Enhanced Voice Mode in the Philips Headphones app to chat with someone nearby without removing your headphones.', '/uploads/1763174619920-tat5506bk_main_1.jpg', 284.00, 38, 18, 7, 1),
(168, 'Razer Barracuda X', 'Whether you\'re at home or on the go, experience true audio flexibility and anywhere-anywhere flair with the Razer Barracuda X Chroma.\r\nFeaturing Razer SmartSwitch Dual Wireless, instantly switch between gaming and mobile use with a lightweight wireless gaming headset that offers the best of both worlds.', '/uploads/1763174698630-90903-001-48_1_.avif', 441.00, 57, 8, 7, 1),
(169, 'Apple AirPods Max ANC', 'AirPods Max deliver incredibly detailed, high-quality audio for an unparalleled listening experience.\r\nEvery part of the custom driver works to produce sound with ultra-low distortion so you hear every note with a new sense of clarity.\r\nCustom spatial audio with dynamic head tracking gives you a theater-like experience with sound that surrounds you for movies, TV shows, and games.', '/uploads/1763174858695-airpods_max_2024_blue_pdp_image_position_03__wwen.avif', 1949.00, 77, 6, 7, 1),
(170, 'Razer Nari Ultimate - xbox', 'When Razer HyperSense was first introduced in collaboration with the Razer Nari Ultimate, what it meant to be immersed in games for gamers was redefined. The next-generation gaming headset allowed gamers to experience sound not just as something they heard, but also as something they felt.\r\nNow Razer is bringing this experience to even more gamers with the Razer Nari Ultimate for Xbox One\r\nThe world’s first Xbox One headset with a high-definition sensory interface developed by Lofelt.', '/uploads/1763175255965-fvcdgbdfgeed.avif', 589.00, 12, 8, 7, 1),
(171, 'Philips Fidelio L3 ANC Pro', 'Engineered by the audio perfectionists at Philips Fidelio, the L3\'s bass is tight and impactful without being overpowering.\r\nThe midrange is full and smooth. The highs sparkle with detail. These are not your typical wireless headphones.\r\nThe perfectly tuned drivers in these Hi-Res Audio certified headphones deliver beautifully balanced sound - whether ANC is on or off.', '/uploads/1763175042712-fidelio_l3_main_1.jpg', 828.00, 27, 18, 7, 1),
(172, 'Logitech G335', 'Features a headband design with an adjustable strap so you can choose your most comfortable fit.\r\nPlug-and-play and built-in controls let you quickly connect and jump into the game.\r\nSimply choose your favorite color to match your awesome style.', '/uploads/1763175112627-g335-black-gallery-1.webp', 157.00, 27, 7, 7, 1),
(173, 'Corsair HS55', 'A Discord-standard omnidirectional microphone with tilt-mute function picks up your voice with impressive clarity for quality communication and sound.', '/uploads/1763175402883-product16632_image1_2023-03-07_13-56-29.webp', 281.00, 42, 9, 7, 1),
(174, 'Apple iPad Pro 2022 ', 'The M2 chip is the next generation of Apple silicon\r\nWith an 8-core processor that delivers up to 15 percent faster performance and a 10-core GPU that delivers up to 35 percent faster graphics performance.\r\nWith a 40 percent faster Neural Engine to accelerate machine learning tasks and 50 percent more memory bandwidth, the M2 brings incredible performance and new capabilities to iPad Pro.\r\nSo you can create photorealistic 3D designs.', '/uploads/1763175921969-ipad_pro_wi-fi_12-9_in_6th_generation_silver_pdp_image_position-1b__wwen_1.jpg', 3672.00, 84, 6, 9, 1),
(175, 'TCL Tab 10 Gen 2', 'The Tab 10 Gen2 redefines visual enjoyment with an immersive 2K resolution display.\r\nWhether you\'re working, studying, or enjoying family time, the 10.36-inch NXTVISION display enhances everything around you with vibrant, refreshing colors.', '/uploads/1763176010968-tcl-tab-10-gen-2-1.avif', 503.00, 18, 17, 9, 1),
(176, 'Samsung Galaxy Tab S6 Lite', 'Galaxy Tab S6 Lite is a lightweight companion for taking notes and getting things done.\r\nIt features a large 10.4-inch display in a thin and light body, with One UI 2 for Android and an S Pen ready to go.\r\nWhether you\'re drawing, studying, or gaming, this is the tablet for living in the moment.', '/uploads/1763176082038-e010061500_3_1_6.jpg', 1540.00, 24, 10, 9, 1),
(177, 'Lenovo Tab M8', 'The Lenovo Tab M8 Gen 4 tablet features a slim and slim body with a lightweight design, making it perfect for on-the-go use, gaming in bed, and streaming movies at home.\r\nThe 8-inch HD display is also the perfect size for your little ones to learn and play.\r\nPlus, the tablet comes with a case and screen protector for maximum protection.', '/uploads/1763176300165-44ab812d2f54d5d1d8c381ad8166cc1dc40e41cc_1741278254.jpg', 421.00, 21, 1, 9, 1),
(178, 'Xiaomi Pad 6', 'Qualcomm® SnapdragonTM 870 (7nm) octa-core processor, 3.2GHz high frequency\r\nAdrenoTM 650 graphics processor\r\nOperating system: Android 13 & MIUI14 for Pad interface (the system will be updated with periodic OTA updates)', '/uploads/1763176431824-24ce89dd-7984-4c86-8b93-807928d9065e.avif', 1480.00, 0, 13, 9, 1),
(179, 'Apple iPad A16 (2025)', 'Now with the super-fast A16 chip and starting at 128GB of storage, iPad is more powerful and advanced than ever.\r\nGet things done, express yourself, and immerse yourself in the things you love, all on a stunning 11-inch Liquid Retina display.\r\nAnd with essential accessories designed specifically for iPad, you can enjoy ultimate flexibility for everything you do every day.', '/uploads/1763176590170-ipad_a16_cellular_blue_pdp_image_position_1__wwen_1_1.avif', 2099.00, 74, 6, 9, 1),
(180, 'Razer Kraken V4 X - Pokémon', 'Razer\'s exclusive Pokémon Edition wired gaming headset combines a colorful Pokémon-inspired design with powerful sound and stunning Razer Chroma RGB lighting. It delivers an immersive and accurate audio experience in every scene, with soft, comfortable ear cushions, a high-quality HyperClear microphone, and a Type-C cable with a Type-A adapter for maximum convenience and flexibility on any platform.', '/uploads/1763244781033-90903-001-50__main.webp', 1174.76, 24, 8, 7, 1),
(181, 'Asus ROG Destrier Ergo', 'The ROG Destrier Ergo gaming chair envelops you in comfort and futuristic aesthetics and provides a variety of customization options to ensure maximum comfort during gameplay.', '/uploads/1763245946593-rog_destrier_core_01.jpg', 2081.00, 54, 3, 10, 1),
(182, 'Asus ROG Chariot X', 'The ROG Aethon ensures that you will feel comfortable even during the most intense gaming marathon. Its seat is covered in leather-like PU material and features dual-density padding. The ROG Aethon also features built-in lumbar support, padded armrests with two-way adjustment, a steel frame, a CLASS 4 gas piston, and PU-coated wheels for added durability.', '/uploads/1763246159603-h732.png', 1288.00, 43, 3, 10, 1),
(183, 'Asus ROG Aethon', 'The ROG Aethon ensures that you will feel comfortable even during the most intense gaming marathon. Its seat is covered in leather-like PU material and features dual-density padding. The ROG Aethon also features built-in lumbar support, padded armrests with two-way adjustment, a steel frame, a CLASS 4 gas piston, and PU-coated wheels for added durability.', '/uploads/1763246343135-h732 (1).png', 1072.00, 26, 3, 10, 1),
(184, 'Corsair Rush  T3', 'The CORSAIR T3 RUSH gaming chair combines racing-inspired design with engineered comfort, including soft, breathable fabric upholstery, a padded neck pillow, and memory foam lumbar support.', '/uploads/1763246460456-fdgdgfgfg.avif', 1075.00, 14, 9, 10, 1),
(185, 'Corsair Rush TC100', 'The CORSAIR TC100 RELAXED gaming chair is the ultimate combination of luxury executive design and gaming. Inspired by racing seats, it features a wide seat, high-quality breathable fabric, and perfect ergonomic support – for an exceptionally comfortable seating experience while working or playing for extended periods.', '/uploads/1763246551897-11559_28012024115304_large.jpg', 879.00, 31, 9, 10, 1),
(186, 'Razer Enki X Essential', 'The Razer Enki X Gaming Chair delivers an ultra-comfortable seating experience all day long, so your gaming marathons can go on and on without a break. The chair has been carefully designed to ensure balanced weight distribution and perfect body support, creating the perfect balance between comfort and stability.', '/uploads/1763246751631-8254_10082022160319.jpg', 1319.00, 24, 8, 10, 1),
(187, 'Razer  Iskur V2 X', 'Unleash the full comfort and ergonomics needed for extended support with the Razer Iskur V2 X Gaming Chair. With a built-in lumbar curve, high-density foam cushions, and a 152° adjustable backrest, the chair delivers an advanced, balanced seating experience that combines precise support, lasting comfort, and all the essential functions for a perfect gaming experience.', '/uploads/1763246923914-90903-007-16.webp', 777.00, 8, 8, 10, 1),
(188, 'Razer Enki Quartz ', 'The Razer Enki Gaming Chair is designed to give you a limitless gaming experience – whether you want to relax in comfort or get into the action. With balanced weight distribution and a perfect balance between support and comfort, the chair lets you immerse yourself in an exceptional seating experience that redefines all-day comfort.', '/uploads/1763247013370-90903-007-07.webp', 1287.00, 12, 8, 10, 1),
(189, 'Asus ROG Rapture GT-BE98', 'WiFi 7 in the 802.11be standard features new 320MHz channels in the 6GHz band and 4096-level QAM, which results in a significant increase in network capacity and speed, with speeds of up to 25 Gbps.', '/uploads/1763247738642-gtbe98_payngo_1_.avif', 2545.00, 34, 3, 11, 1),
(190, 'Asus RT-AX89X', 'The growing number of connected personal and IoT devices has led to an overall increase in network density that is pushing the limits of the current WiFi standard.\r\nThe latest 802.11ax standard delivers future-proof technologies, higher network efficiency, faster WiFi speeds, greater coverage, and improved battery life for connected devices, delivering a significantly better network experience for users.', '/uploads/1763247803048-0b5a937c-9298-4a6f-a49d.avif', 1261.00, 43, 3, 11, 1),
(191, 'Xiaomi Router AX9000', 'Xiaomi Router AX9000 delivers ultra-fast Wi-Fi 6 speeds up to 9000 Mbps, ideal for gaming and 4K streaming.\r\nEquipped with a 6-core processor and advanced multi-device support for stable, seamless connectivity.', '/uploads/1763247903559-4c8762cb-f5b9-47e2-bbbe-df4d85bd67d2.jpg', 1101.00, 41, 13, 11, 1),
(192, 'Asus ROG Rapture GT6', 'Asus ROG Rapture GT6 offers blazing Wi-Fi 6E speeds with low latency, perfect for gaming and streaming.\r\nFeatures robust security, multiple gaming optimizations, and powerful multi-device management.', '/uploads/1763248002922-ROG-RAPTURE-GT6.png', 761.00, 17, 3, 11, 1),
(193, 'Asus 4G-AC86U', 'Asus 4G-AC86U is a dual-band router with 4G LTE backup, ensuring uninterrupted internet connectivity.\r\nIt delivers high-speed Wi-Fi for gaming, streaming, and multiple device support.', '/uploads/1763248081264-d5b38419-90f6-4697-a7bd-8fdf7f6d5018.avif', 934.00, 47, 3, 11, 1),
(194, 'Asus RT-AX82U', 'Asus RT-AX82U is a Wi-Fi 6 router designed for gaming and high-speed streaming.\r\nIt offers low-latency performance, AiMesh support, and enhanced security for multiple devices.', '/uploads/1763248191530-8f7bf416-8816-4aa2-ac3a-69f6d010f2ef.avif', 592.00, 32, 3, 11, 1),
(195, 'Xiaomi Router AX3200', 'Xiaomi Router AX3200 is a Wi-Fi 6 router delivering fast, stable connections for multiple devices.\r\nIt features OFDMA technology, dual-band support, and easy setup for home networking.', '/uploads/1763248245286-1bc09d19-5d99-46a4-9848-da306b4591bf.jpg', 338.00, 17, 13, 11, 1),
(196, 'Asus TUF Gaming BE3600', 'ASUS TUF Gaming BE3600 brings advanced WiFi 7 connectivity and AiMesh smart system, offering more than just range extension.\r\nIt’s a stable, secure, and feature-rich network under a single SSID, working with compatible ASUS routers for easy management, advanced security, and smart home integration across your entire network. With 4096-QAM technology, the network offers 20% more efficient data transmission compared to 1024-QAM on WiFi 6/6E, allowing each signal to carry more data over greater distances.', '/uploads/1763248333545-asus_346368_1_.avif', 641.00, 21, 3, 11, 1),
(197, 'Xiaomi Router AX3000', 'Xiaomi Router AX3000 — Wi‑Fi 6 (802.11ax) dual‑band router with combined speeds up to 2,976 Mbps (2.4 GHz: 574 Mbps, 5 GHz: 2,402 Mbps) \r\nPowered by a Qualcomm IPQ5000 1.0 GHz dual-core CPU, supports OFDMA, WPA3 encryption, and can handle up to ~128–250 connected devices depending on version.', '/uploads/1763248449314-xiaomi-mesh-system-ax3000-1-pack-1.avif', 592.00, 41, 13, 11, 1),
(198, 'Asus RT-AX59U ', 'Enjoy fast, reliable WiFi throughout your home with the RT-AX59U WiFi 6 router. It\'s fully backward compatible with previous WiFi standards and devices, so you can stay connected without worry for all your internet activities.', '/uploads/1763248537301-613a1770-d923-4386-839f.avif', 546.00, 71, 3, 11, 1),
(199, 'Asus ZenWiFi XD4 Plus', 'The ZenWiFi XD4 Plus system consists of the Asus AX1800 WiFi 6 router, which includes unique technologies that give you ultra-fast, reliable, and secure WiFi connections - indoors or out!', '/uploads/1763248646992-3-zenwifi-xd4-plus-1pk-photo-left-1-black-282883698-90ig07m0-mo3c10-webp_1752139442.webp', 313.00, 52, 3, 11, 1),
(200, 'Asus RT-AX52 AX1800', 'RT-AX52 is designed to give you the widest possible WiFi coverage.\r\nThe router uses OFDMA, a new technology in WiFi 6 that allows signals to travel further than they could with WiFi 5.\r\nThe 2x2 MIMO configuration also helps, as do other improvements like beamforming, which focuses the WiFi signal to each device.', '/uploads/1763248756907-fsdfrrgfgfg.avif', 180.00, 81, 3, 11, 1),
(201, 'Xiaomi Router AC1200', 'Xiaomi RouterAC1200 — Dual-band Wi-Fi (2.4GHz & 5GHz) router with up to 1,167 Mbps throughput.\r\nHas 4 high-gain external antennas, a dual-core 880MHz CPU, 128MB RAM, supports up to 128 devices, and includes gigabit WAN/LAN ports.', '/uploads/1763248967508-xiaomi-router-ac1200-1.avif', 194.00, 105, 13, 11, 1),
(202, 'HP 320 FHD', 'A high-quality webcam from HP, with Full HD resolution and a built-in microphone. Enjoy a sharp image and clear sound that will make you look and sound good.', '/uploads/1763261990686-c08051358_1_copy.avif', 109.00, 74, 2, 12, 1),
(203, 'Lenovo Select Gen2', 'The Lenovo Select FHD Webcam Gen2 is a flexible and affordable Full HD webcam designed for conferencing. With high-resolution video quality, stereo audio, flexible mounting options, and a physical privacy shutter, it makes every video call simple and highly effective.', '/uploads/1763262088661-27176038744_G_202504100448571744305014712.avif', 134.00, 43, 1, 12, 1),
(204, 'Logitech Brio 100', 'Logitech Full HD 1080p Webcam - A stylish, high-resolution webcam with automatic lighting correction that will help you look your best in every video call. Compatible with most calling platforms and includes a privacy shutter.', '/uploads/1763262150819-1721134379b79LF___D!400X!.webp', 141.00, 14, 7, 12, 1),
(205, 'Lenovo LC50', 'Lenovo webcam, with a 90° wide angle, 1080P Full HD quality, and includes PT adjustment.', '/uploads/1763262209293-Lenovo-LC50-2.webp', 211.00, 21, 1, 12, 1),
(206, 'Logitech C920s Pro', '', '/uploads/1763262280194-61LSj0LF9gL._UF894,1000_QL80_.jpg', 236.00, 35, 7, 12, 1),
(207, 'Logitech Brio 300', 'Logitech Full HD 1080p Webcam - A stylish, high-resolution webcam with automatic lighting correction that will help you look your best in every video call. Compatible with most calling platforms and includes a privacy shutter.', '/uploads/1763262331381-dc45b021-1c47-4ac3-9cb6-f2bdb11e9917.jpg', 253.00, 53, 7, 12, 1),
(208, 'Logitech C922 Pro', 'A high-quality and advanced webcam from Logitech that includes stereo recording, changing backgrounds while recording, and is capable of recording in full HD 1080p resolution.', '/uploads/1763262395733-image1_16733_2025-05-14_14-30-02.png', 321.00, 31, 7, 12, 1),
(209, 'Logitech Streamcam FHD', 'A high-quality and advanced webcam from Logitech, with an ultra-wide angle in 1080P Full HD quality and 60 frames per second, includes a pair of front microphones and a variety of installation solutions.', '/uploads/1763262468720-97876.jpg', 338.00, 38, 7, 12, 1),
(210, 'Logitech Brio 500', 'Logitech\'s Full HD 1080p webcam provides a variety of features for high-quality image and sound, including light correction, auto-framing, and Show Mode for showcasing your work. Compatible with most chat platforms and includes a privacy shutter.', '/uploads/1763262553739-9599b05b-5651-4968-b061-3c776a764ae5.png', 402.00, 3, 7, 12, 1),
(211, 'Logitech MX BRIO 4K', 'The Logitech Brio Stream 4K webcam is the perfect choice for live streaming, video meetings, and recording in stunning quality. With 4K Ultra HD recording, RightLight 3 with HDR for automatic lighting adjustment, three adjustable viewing angles, and dual noise-cancelling microphones, you’ll get a sharp image and clear sound in any environment. Make a professional impression on the go, on Zoom, or in a meeting—every time.', '/uploads/1763262663833-1550059969m69IC.jpg', 634.00, 34, 7, 12, 1),
(212, 'Razer KIYO Ring Light', 'A high-quality network camera from Razer with a lighting ring that allows you to dim or illuminate the object with the ability to stream at 60 frames per second in 720p HD quality or 30 frames per second in 1080p FULL HD quality for full fidelity in games, includes a built-in microphone, eliminates heavy sounds and provides flattering lighting.', '/uploads/1763262826682-jgyjkky.avif', 409.00, 45, 8, 12, 1),
(213, 'HP Officejet Pro 8133', 'A combined wireless printer from HP, which includes a copier, scanner and fax, black printing up to 20 pages per minute, color printing up to 10 pages per minute, the printer comes without a USB cable (necessary to connect the printer to a computer), a cable can be purchased separately for 10 shekels at the time of purchase.', '/uploads/1763264623845-c08740749.avif', 304.00, 19, 2, 13, 1),
(214, 'HP Smart Tank 580', 'A wireless, integrated color bottle printer from HP, which includes a copier and scanner.', '/uploads/1763264697887-20230802163843_60798_287_1.jpg', 572.00, 72, 2, 13, 0),
(215, 'HP LaserJet Pro MFP', 'HP Laser Printer, get accurate color and boost productivity. High-quality color and fast two-sided printing speeds. Save time with the HP Smart app to print and scan from your phone. HP Personal Laser Printer gives you the performance you deserve.', '/uploads/1763264835735-Euthenia_CLJ_ProMFP_LightBasalt_Catalog_WhiteBG_FrontRight_M1556098.png', 1516.00, 14, 2, 13, 0),
(216, 'HP Sprocket 3x4', 'Get it all and more with the HP Sprocket Printer. An all-in-one printer and the perfect device for printing all the amazing photos you have on your phone. Set up the printer in seconds, download the HP Sprocket app, and connect your smartphone to the printer over Wi-Fi. Now you\'re all set: take photos, edit them in the photo editing app, and print. The camera creates sharp, detailed prints you\'ll want to share with friends.', '/uploads/1763265100504-81ZEJ-++P-L.jpg', 558.00, 58, 2, 13, 0),
(217, 'Xiaomi 1S Set', 'Sublimation technology for professional printing using an advanced thermal head, this technology uses solid ink sheets.\r\nHeat-sensitive in three primary colors that turns into a gas during the printing process and solidifies back onto the printing paper.\r\nThe final product is high resolution with vivid colors, is very durable and lasts for many years.', '/uploads/1763265263154-61e7ae81-7ea8-451f-ba5b-8e81b7b52eb1.jpg', 572.00, 27, 13, 13, 0);

-- --------------------------------------------------------

--
-- Table structure for table `promotions`
--

CREATE TABLE `promotions` (
  `promotion_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `type` enum('percentage','fixed') NOT NULL,
  `value` varchar(50) NOT NULL,
  `min_quantity` int(11) DEFAULT 1,
  `max_quantity` int(11) DEFAULT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `applicable_products` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `applicable_categories` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `code` varchar(50) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `promotions`
--

INSERT INTO `promotions` (`promotion_id`, `name`, `description`, `type`, `value`, `min_quantity`, `max_quantity`, `start_date`, `end_date`, `is_active`, `applicable_products`, `applicable_categories`, `code`, `created_at`, `updated_at`) VALUES
(1, 'Halloween Spooky Deals', 'Discounton selected keyboards and mice during the Halloween spooky sale.', 'percentage', '25', 1, 3, '2025-10-01', '2025-10-31', 0, '[]', '[5,6]', 'HALLOWEEN25', '2025-11-17 23:37:58', '2025-11-21 19:48:36'),
(2, 'October iPhone 16 Deal', 'Get a price discount on selected iPhone 16 models in early October.', 'fixed', '200', 1, 2, '2025-10-01', '2025-10-16', 1, '[26,27,28]', '[]', 'IPHONE16OCT', '2025-11-17 23:37:58', '2025-11-21 19:52:14'),
(3, 'Black Friday Blowout', 'Biggest Sale of the Year! Enjoy massive savings on all our products for one week only. \nStock is limited, so grab your favorites before they’re gone!', 'percentage', '40', 1, NULL, '2025-11-22', '2025-11-29', 1, '[]', '[13,12,11,10,9,7,6,5,4,3,2,1]', 'BLACK25', '2025-11-21 19:56:09', '2025-11-21 19:57:29'),
(4, 'TechStock Winter Special', 'Warm up your winter with hot deals on laptops and tablets at TechStock!', 'fixed', '300', 1, 3, '2025-11-22', '2025-12-21', 1, '[]', '[1,9]', 'WINTER25', '2025-11-21 20:08:00', '2025-11-21 20:08:00'),
(5, 'Christmas Mega Sale', 'Gift the latest gadgets this holiday season! Save on headphones, smartphones.', 'percentage', '35', 1, 4, '2025-12-01', '2025-12-21', 1, '[]', '[2,7]', 'XMAS25', '2025-11-21 20:14:48', '2025-11-21 20:14:48'),
(6, 'Winter Gaming Madness', 'Gamers rejoice! Enjoy huge percentage discounts on gaming chairs, and keyboards this winter.', 'fixed', '250', 1, 4, '2025-11-20', '2025-12-31', 0, '[]', '[10,5]', 'GAMING25', '2025-11-23 02:04:30', '2025-11-23 02:05:36');

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `id` int(11) NOT NULL,
  `storeName` varchar(255) NOT NULL DEFAULT 'My Store',
  `contactEmail` varchar(255) NOT NULL DEFAULT 'contact@example.com',
  `contactPhone` varchar(50) NOT NULL DEFAULT '123-456-7890',
  `taxRate` decimal(5,2) NOT NULL DEFAULT 0.00,
  `emailNotifications` tinyint(1) NOT NULL DEFAULT 1,
  `createdAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `updatedAt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `currency` varchar(10) DEFAULT 'ILS'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`id`, `storeName`, `contactEmail`, `contactPhone`, `taxRate`, `emailNotifications`, `createdAt`, `updatedAt`, `currency`) VALUES
(1, 'TechStock', '', '', 18.00, 1, '2025-06-07 01:48:02', '2025-11-23 02:11:57', 'ILS');

-- --------------------------------------------------------

--
-- Table structure for table `suppliers`
--

CREATE TABLE `suppliers` (
  `supplier_id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `contact` varchar(255) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `isActive` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `suppliers`
--

INSERT INTO `suppliers` (`supplier_id`, `name`, `email`, `phone`, `contact`, `address`, `isActive`) VALUES
(1, 'Lenove', 'contact@lenovo.com', '(039) 204-455', NULL, '11 HaTaasiya St, Petah Tikva', 1),
(2, 'HP', 'support@hp.com', '(036) 138-888', NULL, '8 Maskit St, Herzliya', 1),
(3, 'Asus', 'support@asus.com', '(035) 751-234', NULL, '94 Yigal Alon St, Tel Aviv', 1),
(4, 'LG', 'support@lg.com', '(039) 535-555', NULL, '16 HaRokmim St, Holon', 1),
(5, 'Dell', 'support@dell.com', '(097) 624-222', NULL, 'Herzliya Pituach, Herzliya', 1),
(6, 'Apple', 'support@apple.com', '(039) 005-555', NULL, 'Ramat HaHayal, Tel Aviv', 1),
(7, 'Logitech', 'support@logitech.com', '(049) 806-677', NULL, 'Kibbutz Yehiam Industrial Zone', 1),
(8, 'Razer', 'support@razer.com', '(037) 654-499', NULL, '5 HaMelacha St, Rishon LeZion', 1),
(9, 'Corsair', 'support@corsair.com', '(049) 984-567', NULL, '20 HaHistadrut Blvd, Haifa', 1),
(10, 'Samsung', 'support@samsung.com', '(099) 609-999', NULL, '32 HaBarzel St, Tel Aviv', 1),
(11, 'Acer', 'support@acer.com', '(037) 378-888', NULL, '22 Kiryat Arie, Petah Tikva', 1),
(12, 'MSI', 'support@msi.com', '(039) 874-321', NULL, '45 HaMasger St, Tel Aviv', 1),
(13, 'Xiaomi', 'support@xiaomi.com', '(039) 112-889', NULL, '19 HaMasger St, Tel Aviv', 1),
(14, 'OnePlus', 'support@oneplus.com', '(037) 993-400', NULL, '6 HaTidhar St, Ra’anana', 1),
(15, 'Sony', 'support@sony.com', '(037) 778-221', NULL, '22 HaSivim St, Petah Tikva', 0),
(16, 'REDMAGIC', 'support@redmagic.com', '(038) 665-442', NULL, '10 HaHaroshet St, Ramat Gan', 1),
(17, 'TCL', 'support@tcl.com', '(036) 442-998', NULL, '7 HaBarzel St, Tel Aviv', 1),
(18, 'Philips ', 'support@philips.com', '(039) 557-331', NULL, '12 Derech HaShalom St, Tel Aviv', 1);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `role` varchar(10) DEFAULT 'client',
  `profile_image` varchar(255) DEFAULT NULL,
  `resetPasswordToken` varchar(255) DEFAULT NULL,
  `resetPasswordExpires` bigint(20) DEFAULT NULL,
  `isActive` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `email`, `password`, `name`, `phone`, `city`, `role`, `profile_image`, `resetPasswordToken`, `resetPasswordExpires`, `isActive`) VALUES
(1, 'admin@gmail.com', '$2b$10$KrVgaxxkr/mk7lT.qaMGKOnyhYsY.MdVxx8F8TRJ6GJme8AUW0Z4G', 'Admin Admin', '(052) 589-2825', 'Haifa', 'admin', '/uploads/image-1760716955647-985002538.png', NULL, NULL, 1),
(2, 'bshara.karkaby@gmail.com', '$2b$10$9M8b2jiZNScXDsaWKwNXyurjlpd9SC.FQeZPVUx.N212hbIOobjei', 'Bshara Karkaby', '(052) 589-2825', 'Haifa', 'user', '/uploads/image-1760718196048-988044511.jpeg', NULL, NULL, 1),
(3, 'monermahkouly@gmail.com', '$2b$10$WfjccXDwwIuRSZkiDsnND.twn9Wgm4NeZuYInb8k57UF9Uf3YrsIa', 'Moner Kakhouly', '(054) 601-9717', 'Kafr Yasif', 'user', '/uploads/image-1760718143226-287842135.jpeg', NULL, NULL, 1),
(4, 'ryan.gosling@gmail.com', '$2b$10$magChfnE2H11R5mAj2bKCOwL72gmqF7HxojpFb.PP4fBa7ScxaIxO', 'Ryan Gosling', '(052) 888-9990', 'Jerusalem', 'user', '/uploads/image-1760718123861-633023717.jpg', NULL, NULL, 1),
(5, 'robert.downey@gmail.com', '$2b$10$d.aH7aOH5sWzUoRX98kV2eMtGtiJ/PoNxecV1XhbxxqUol6CjXF6i', 'Robert Downey Jr', '(053) 111-2223', 'Nazareth', 'user', '/uploads/image-1760718069173-239590466.jpg', NULL, NULL, 1),
(6, 'scarlett.johansson@gmail.com', '$2b$10$476lcpEPJnscAOQ11A7VKe.13UfC1l9ND7kWa4VtG/4H/0rVn.KrK', 'Scarlett Johansson', '(054) 444-3332', 'Jerusalem', 'user', '/uploads/image-1760718054576-309487827.jpg', NULL, NULL, 1),
(7, 'chris.evans@gmail.com', '$2b$10$OHfoyYA3OJrLuIh9PUfv.uw9S9SgQasYDzuANsuoBoadn0X/E3Yq.', 'Chris Evans', '(052) 665-5433', 'Bat Yam', 'user', '/uploads/image-1760718034113-947110372.jpg', NULL, NULL, 1),
(8, 'keanu.reeves@gmail.com', '$2b$10$4zqKOMBoIeIdMjxwQWy6FeUYOcoHXOs/XSd4Cdzaw2ANoF9oWevBi', 'Keanu Reeves', '(050) 667-7889', 'Ramat Gan', 'user', '/uploads/image-1760718014351-677756800.jpeg', NULL, NULL, 1),
(9, 'gal.gadot@gmail.com', '$2b$10$cVEQJteqFF6QcKmeqbieI.nyCZtBY4pnnl1L6HHF0Ph.uTQgQRibC', 'Gal Gadot', '(050) 555-1011', 'Tel Aviv', 'user', '/uploads/image-1760718265334-773775154.jpg', NULL, NULL, 1),
(10, 'leonardo.dicaprio@gmail.com', '$2b$10$CVrPXkPR1.41hMROQKqrjOo8dPrdbeP/ZvooBwRiC4BjGW6EisXXG', 'Leonardo DiCaprio', '(054) 202-2020', 'Haifa', 'user', '/uploads/image-1762804874680-122628342.webp', NULL, NULL, 1),
(11, 'elon.musk@gmail.com', '$2b$10$TT5WZYdQcCisacBxiKQ4MuKktXe8bFCszgxSL5V/POZmPTeA/vQEC', 'Elon Musk', '(053) 999-7777', 'Tel Aviv', 'user', '/uploads/image-1762807410063-380090142.jpg', NULL, NULL, 1),
(12, 'bill.gates@gmail.com', '$2b$10$5TGq7hXZzdmVerKdnBHD9.SI9IHaJIKDimNIyzc9NMR9iUM0B4fwO', 'Bill Gates', '(052) 878-1111', 'Ramat Gan', 'user', '/uploads/image-1762807514360-392605913.webp', NULL, NULL, 1),
(13, 'tom.cruise@gmail.com', '$2b$10$iIAbWpaFSUfxoQFy0pU3IOTSD3GnG0Qp1AU9.TKlz2Pv3YX6BQ7/u', 'Tom Cruise', '(053) 700-1234', 'Tel Aviv', 'user', '/uploads/image-1762807690400-183640023.webp', NULL, NULL, 1),
(14, 'dwayne.johnson@gmail.com', '$2b$10$IQjhJmvok.KgECoMFczRpOavCsBvZ8CnmjnpdQnskHo2qgrnZoAMa', 'Dwayne Johnson', '(052) 555-9090', 'Ramat Gan', 'user', '/uploads/image-1762809719693-570142013.webp', NULL, NULL, 1),
(15, 'margot.robbie@gmail.com', '$2b$10$GLz80CqZ7yuE46o0oGOEpeB2H/L/7htoQgYDKPtHl10fgEgv.v.PC', 'Margot Robbie', '(054) 888-1001', 'Tel Aviv', 'user', '/uploads/image-1762809906631-466748451.webp', NULL, NULL, 1),
(16, 'adam.sandler@gmail.com', '$2b$10$Nb02fGBjG8W.bUEwDft8dOdVHJJd3qSM4C3A4SS.gOrnOun7zR1Va', 'Adam Sandler', '(054) 666-7878', 'Herzliya', 'user', '/uploads/image-1762810895278-228928430.jpg', NULL, NULL, 1),
(17, 'sacha.cohen@gmail.com', '$2b$10$F/lIr22.gCyjYWbuQejTNeU5oe2X9QWYVvzQ6WZOFPdHqCcRIXpRW', 'Sacha Baron Cohen', '(050) 434-1122', 'Tel Aviv', 'user', '/uploads/image-1762811125800-773426358.jpg', NULL, NULL, 1),
(18, 'steve.carell@gmail.com', '$2b$10$ASOVng3ZKn5ZoRR5IEQn.uhxI/nrIo4XF6lrMwQ9CcRfQLEJhtr6a', 'Steve Carell', '(052) 909-5544', 'Eilat', 'user', '/uploads/image-1762812073233-834321400.avif', NULL, NULL, 1),
(19, 'ben.stiller@gmail.com', '$2b$10$XmqlUWHaRH87tQBpo3341e.pbC8BSZM8XoqYJtPvDIsfZb8/Cmrsy', 'Ben Stiller', '(052) 888-6767', 'Jerusalem', 'user', '/uploads/image-1762814017344-35100233.jpg', NULL, NULL, 1),
(20, 'kevin.hart@gmail.com', '$2b$10$dz/J8mo2qmYjEyhmm3tJEuHY6SCDIX4zHiJLp31P9IIB1rNPOFxye', 'Kevin Hart', '(050) 606-8989', 'Nazareth', 'user', '/uploads/image-1762814362334-557609359.jpg', NULL, NULL, 1),
(21, 'will.smith@gmail.com', '$2b$10$eZf3pbosQXZucEQMCGG8BOsEkHYBE/JlNq40S..rf7dA4Gr.Hl5/W', 'Will Smith', '(052) 777-5656', 'Ashdod', 'user', '/uploads/image-1762814464075-584422955.jpg', NULL, NULL, 1),
(22, 'brad.pitt@gmail.com', '$2b$10$9hLV9i7Alut3SM5JuKb9vewQSS/EYRSA.YmJ34ctloRCI3IGul34K', 'Brad Pitt', '(050) 919-2828', 'Herzliya', 'user', '/uploads/image-1762814666663-70576672.jpg', NULL, NULL, 1),
(23, 'johnny.depp@gmail.com', '$2b$10$.dw9J2iyvDDvSHhg2kU4Ru.BYogKs/5z9S5xtpft6mGlHyNJrA/KW', 'Johnny Depp', '(050) 222-4040', 'Ramat Gan', 'user', '/uploads/image-1762814892445-775427849.jpg', NULL, NULL, 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`category_id`),
  ADD UNIQUE KEY `unique_category_name` (`name`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `idx_orders_promotion_code` (`promotion_code`(50));

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`order_item_id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`product_id`),
  ADD KEY `supplier_id` (`supplier_id`),
  ADD KEY `category_id` (`category_id`),
  ADD KEY `idx_products_active` (`is_active`);

--
-- Indexes for table `promotions`
--
ALTER TABLE `promotions`
  ADD PRIMARY KEY (`promotion_id`),
  ADD UNIQUE KEY `code` (`code`),
  ADD KEY `idx_active_date` (`is_active`,`start_date`,`end_date`),
  ADD KEY `idx_code` (`code`),
  ADD KEY `idx_type` (`type`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `suppliers`
--
ALTER TABLE `suppliers`
  ADD PRIMARY KEY (`supplier_id`),
  ADD UNIQUE KEY `unique_supplier_name` (`name`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `category_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=71;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `order_item_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=224;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `product_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=218;

--
-- AUTO_INCREMENT for table `promotions`
--
ALTER TABLE `promotions`
  MODIFY `promotion_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `suppliers`
--
ALTER TABLE `suppliers`
  MODIFY `supplier_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`),
  ADD CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`);

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`supplier_id`),
  ADD CONSTRAINT `products_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
