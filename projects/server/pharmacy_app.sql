-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Oct 12, 2022 at 12:26 PM
-- Server version: 8.0.28
-- PHP Version: 7.4.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `pharmacy_app`
--

-- --------------------------------------------------------

--
-- Table structure for table `addresses`
--

CREATE TABLE `addresses` (
  `id` int NOT NULL,
  `user_id` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `addresses`
--

INSERT INTO `addresses` (`id`, `user_id`, `name`, `address`, `is_deleted`, `createdAt`, `updatedAt`) VALUES
(1, 1, 'home', 'House #65, 4328 Marion Street', 0, '2022-09-11 13:43:38', '2022-09-11 13:43:38'),
(2, 2, 'home', '703 Blue Jay Way, Malibu, CA', 0, '2022-09-23 13:43:38', '2022-09-23 13:43:38'),
(3, 3, 'home', '28415 Springbrook Dr, Lawton, MI 49065', 0, '2022-09-23 13:43:38', '2022-09-23 13:43:38'),
(4, 4, 'Home', 'Jl. Kalimantan no. 03', 0, '2022-10-12 09:53:11', '2022-10-12 09:53:11');

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `id` int NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL DEFAULT '',
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `is_verified` tinyint(1) NOT NULL DEFAULT '0',
  `role` varchar(255) NOT NULL DEFAULT 'Admin',
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`id`, `first_name`, `last_name`, `email`, `password`, `is_verified`, `role`, `createdAt`, `updatedAt`) VALUES
(1, 'Handiani', '', 'handi@mail.com', '@Monday123', 1, 'Super Admin', '2022-09-13 01:49:01', '2022-09-13 01:49:01'),
(2, 'Felonious', 'Gru', 'felon.gru1@gmail.com', '9ec38496cdfd155e7b6d185c1ff86db6e3d3981d', 1, 'Admin', '2022-09-13 01:49:01', '2022-09-16 10:28:12');

-- --------------------------------------------------------

--
-- Table structure for table `carts`
--

CREATE TABLE `carts` (
  `id` int NOT NULL,
  `user_id` int NOT NULL,
  `product_id` int NOT NULL,
  `qty` int NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int NOT NULL,
  `category` varchar(255) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `category`, `createdAt`, `updatedAt`) VALUES
(1, 'Reagent', '2022-09-13 01:49:01', '2022-09-13 01:49:01'),
(2, 'Enzyme', '2022-09-13 01:49:07', '2022-09-13 01:49:07'),
(3, 'Technical Chemistry', '2022-09-13 01:49:12', '2022-09-13 01:49:12'),
(4, 'Food Chemistry', '2022-09-13 01:49:16', '2022-09-13 01:49:16'),
(5, 'Cosmetic Chemistry', '2022-09-13 11:36:33', '2022-09-13 11:36:33');

-- --------------------------------------------------------

--
-- Table structure for table `invoice_details`
--

CREATE TABLE `invoice_details` (
  `id` int NOT NULL,
  `invoice_id` varchar(45) NOT NULL,
  `product_id` int NOT NULL,
  `price` int NOT NULL,
  `qty` int NOT NULL,
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `invoice_details`
--

INSERT INTO `invoice_details` (`id`, `invoice_id`, `product_id`, `price`, `qty`, `createdAt`, `updatedAt`) VALUES
(1, 'INV-2217461', 8, 50000, 15, '2022-08-09 15:17:46', '2022-10-11 15:17:46'),
(2, 'INV-2217461', 12, 40000, 10, '2022-08-09 15:17:46', '2022-10-11 15:17:46'),
(3, 'INV-2222322', 11, 25000, 6, '2022-09-10 15:22:32', '2022-10-11 15:22:32'),
(4, 'INV-2222322', 15, 80000, 13, '2022-09-10 15:22:32', '2022-10-11 15:22:32'),
(5, 'INV-2222322', 12, 40000, 9, '2022-09-10 15:22:32', '2022-10-11 15:22:32'),
(6, 'INV-2224242', 23, 60000, 4, '2022-09-10 15:24:24', '2022-10-11 15:24:24'),
(7, 'INV-2224242', 8, 50000, 8, '2022-09-10 15:24:24', '2022-10-11 15:24:24'),
(8, 'INV-2224242', 18, 25000, 7, '2022-09-10 15:24:24', '2022-10-11 15:24:24'),
(9, 'INV-2225582', 4, 45000, 9, '2022-09-11 15:25:58', '2022-10-11 15:25:58'),
(10, 'INV-2225582', 19, 27000, 6, '2022-09-11 15:25:58', '2022-10-11 15:25:58'),
(11, 'INV-2227363', 18, 25000, 6, '2022-09-12 15:27:36', '2022-10-11 15:27:36'),
(12, 'INV-2227363', 12, 40000, 8, '2022-09-12 15:27:36', '2022-10-11 15:27:36'),
(13, 'INV-2227363', 20, 25000, 3, '2022-09-12 15:27:36', '2022-10-11 15:27:36'),
(14, 'INV-2228503', 22, 60000, 7, '2022-09-12 15:28:50', '2022-10-11 15:28:50'),
(15, 'INV-2228503', 9, 45000, 7, '2022-09-12 15:28:50', '2022-10-11 15:28:50'),
(16, 'INV-0704592', 15, 80000, 5, '2022-09-13 00:04:59', '2022-10-12 00:04:59'),
(17, 'INV-0704592', 22, 60000, 8, '2022-09-13 00:04:59', '2022-10-12 00:04:59'),
(18, 'INV-0708332', 5, 37000, 3, '2022-09-14 00:08:33', '2022-10-12 00:08:33'),
(19, 'INV-0713163', 17, 20000, 3, '2022-09-14 00:13:16', '2022-10-12 00:13:16'),
(20, 'INV-0713163', 11, 25000, 6, '2022-09-14 00:13:16', '2022-10-12 00:13:16'),
(21, 'INV-0717251', 7, 73600, 8, '2022-09-15 00:17:26', '2022-10-12 00:17:26'),
(22, 'INV-0717251', 13, 35000, 7, '2022-09-15 00:17:26', '2022-10-12 00:17:26'),
(23, 'INV-0720422', 4, 45000, 3, '2022-09-16 00:20:42', '2022-10-12 00:20:42'),
(24, 'INV-0720422', 16, 20000, 6, '2022-09-16 00:20:42', '2022-10-12 00:20:42'),
(25, 'INV-0723222', 22, 60000, 3, '2022-09-17 00:23:22', '2022-10-12 00:23:22'),
(26, 'INV-0724112', 20, 25000, 6, '2022-09-18 00:24:12', '2022-10-12 00:24:12'),
(27, 'INV-0725151', 16, 20000, 10, '2022-09-19 00:25:15', '2022-10-12 00:25:15'),
(28, 'INV-0726352', 20, 25000, 4, '2022-09-20 00:26:35', '2022-10-12 00:26:35'),
(29, 'INV-0727361', 21, 20000, 9, '2022-09-21 00:27:36', '2022-10-12 00:27:36'),
(30, 'INV-0728541', 4, 45000, 5, '2022-09-22 00:28:54', '2022-10-12 00:28:54'),
(31, 'INV-0735063', 12, 40000, 3, '2022-09-23 00:35:06', '2022-10-12 00:35:06'),
(32, 'INV-0736013', 20, 25000, 5, '2022-09-24 00:36:01', '2022-10-12 00:36:01'),
(33, 'INV-0737211', 3, 45000, 5, '2022-09-25 00:37:21', '2022-10-12 00:37:21'),
(34, 'INV-0738141', 10, 75000, 6, '2022-09-26 00:38:14', '2022-10-12 00:38:14'),
(35, 'INV-0739173', 22, 60000, 4, '2022-09-27 00:39:17', '2022-10-12 00:39:17'),
(36, 'INV-0751302', 22, 60000, 4, '2022-09-28 00:51:31', '2022-10-12 00:51:31'),
(37, 'INV-0752252', 15, 80000, 4, '2022-09-29 00:52:25', '2022-10-12 00:52:25'),
(38, 'INV-0753231', 8, 50000, 5, '2022-09-30 00:53:23', '2022-10-12 00:53:23'),
(39, 'INV-0754212', 20, 25000, 9, '2022-10-01 00:54:21', '2022-10-12 00:54:21'),
(40, 'INV-0755181', 17, 20000, 15, '2022-10-02 00:55:18', '2022-10-12 00:55:18'),
(41, 'INV-0756311', 19, 27000, 4, '2022-10-03 00:56:31', '2022-10-12 00:56:31'),
(42, 'INV-0756311', 22, 60000, 2, '2022-10-03 00:56:31', '2022-10-12 00:56:31'),
(43, 'INV-0800343', 5, 37000, 4, '2022-10-04 01:00:35', '2022-10-12 01:00:35'),
(44, 'INV-0800343', 17, 20000, 10, '2022-10-04 01:00:35', '2022-10-12 01:00:35'),
(45, 'INV-0801492', 7, 73600, 3, '2022-10-04 01:01:49', '2022-10-12 01:01:49'),
(46, 'INV-0801492', 8, 50000, 3, '2022-10-04 01:01:49', '2022-10-12 01:01:49'),
(47, 'INV-0802532', 19, 27000, 5, '2022-10-05 01:02:53', '2022-10-12 01:02:53'),
(48, 'INV-0802532', 12, 40000, 3, '2022-10-05 01:02:53', '2022-10-12 01:02:53'),
(49, 'INV-0804263', 9, 45000, 3, '2022-10-06 01:04:26', '2022-10-12 01:04:26'),
(50, 'INV-0804263', 22, 60000, 3, '2022-10-06 01:04:26', '2022-10-12 01:04:26'),
(51, 'INV-0805272', 12, 40000, 4, '2022-10-07 01:05:27', '2022-10-12 01:05:27'),
(52, 'INV-0806461', 8, 50000, 3, '2022-10-08 01:06:46', '2022-10-12 01:06:46'),
(53, 'INV-0817041', 7, 73600, 3, '2022-10-09 01:17:04', '2022-10-12 01:17:04'),
(54, 'INV-0817041', 11, 25000, 5, '2022-10-09 01:17:04', '2022-10-12 01:17:04'),
(55, 'INV-0817041', 16, 20000, 5, '2022-10-09 01:17:04', '2022-10-12 01:17:04'),
(56, 'INV-0818203', 7, 73600, 2, '2022-10-09 01:18:21', '2022-10-12 01:18:21'),
(57, 'INV-0818203', 3, 45000, 3, '2022-10-09 01:18:21', '2022-10-12 01:18:21'),
(58, 'INV-0819583', 15, 80000, 1, '2022-10-10 01:19:58', '2022-10-12 01:19:58'),
(59, 'INV-0819583', 5, 37000, 5, '2022-10-10 01:19:58', '2022-10-12 01:19:58'),
(60, 'INV-0819583', 20, 25000, 2, '2022-10-10 01:19:58', '2022-10-12 01:19:58'),
(61, 'INV-0819583', 22, 60000, 3, '2022-10-10 01:19:58', '2022-10-12 01:19:58'),
(62, 'INV-0821321', 7, 73600, 4, '2022-10-10 01:21:32', '2022-10-12 01:21:32'),
(63, 'INV-0821321', 23, 60000, 4, '2022-10-10 01:21:32', '2022-10-12 01:21:32'),
(64, 'INV-0821321', 22, 60000, 3, '2022-10-10 01:21:32', '2022-10-12 01:21:32'),
(65, 'INV-0905112', 22, 60000, 3, '2022-10-11 02:05:11', '2022-10-12 02:05:11'),
(66, 'INV-0905112', 15, 80000, 3, '2022-10-11 02:05:11', '2022-10-12 02:05:11'),
(67, 'INV-0905112', 7, 73600, 5, '2022-10-11 02:05:11', '2022-10-12 02:05:11'),
(68, 'INV-0909433', 3, 45000, 3, '2022-10-11 02:09:43', '2022-10-12 02:09:43'),
(69, 'INV-0909433', 7, 73600, 3, '2022-10-11 02:09:43', '2022-10-12 02:09:43'),
(70, 'INV-0911401', 6, 48000, 3, '2022-10-11 02:11:40', '2022-10-12 02:11:40'),
(71, 'INV-0911401', 7, 73600, 3, '2022-10-11 02:11:40', '2022-10-12 02:11:40'),
(72, 'INV-0913262', 4, 45000, 5, '2022-10-12 02:13:26', '2022-10-12 02:13:26'),
(73, 'INV-0913262', 23, 60000, 5, '2022-10-12 02:13:26', '2022-10-12 02:13:26'),
(74, 'INV-0915383', 5, 37000, 10, '2022-10-12 02:15:38', '2022-10-12 02:15:38'),
(75, 'INV-0915383', 14, 60000, 5, '2022-10-12 02:15:38', '2022-10-12 02:15:38'),
(76, 'INV-0919313', 16, 20000, 5, '2022-10-13 02:19:32', '2022-10-13 02:19:32'),
(77, 'INV-0919313', 23, 60000, 5, '2022-10-13 02:19:32', '2022-10-13 02:19:32'),
(78, 'INV-0920561', 4, 45000, 5, '2022-10-13 02:20:56', '2022-10-13 02:20:56'),
(79, 'INV-0920561', 8, 50000, 5, '2022-10-13 02:20:56', '2022-10-13 02:20:56'),
(80, 'INV-0922041', 20, 25000, 5, '2022-10-14 02:22:04', '2022-10-14 02:22:04'),
(81, 'INV-0922041', 10, 75000, 5, '2022-10-14 02:22:04', '2022-10-14 02:22:04'),
(82, 'INV-0923332', 20, 25000, 5, '2022-10-14 02:23:33', '2022-10-14 02:23:33'),
(83, 'INV-0923332', 7, 73600, 3, '2022-10-14 02:23:33', '2022-10-14 02:23:33'),
(84, 'INV-1414071', 10, 75000, 3, '2022-10-15 07:14:07', '2022-10-15 07:14:07'),
(85, 'INV-1414071', 8, 50000, 3, '2022-10-15 07:14:07', '2022-10-15 07:14:07'),
(86, 'INV-1415033', 11, 25000, 5, '2022-10-15 07:15:03', '2022-10-15 07:15:03'),
(87, 'INV-1415033', 20, 25000, 5, '2022-10-15 07:15:03', '2022-10-15 07:15:03'),
(88, 'INV-1415413', 3, 45000, 2, '2022-10-16 07:15:41', '2022-10-16 07:15:41'),
(89, 'INV-1415413', 22, 60000, 3, '2022-10-16 07:15:41', '2022-10-16 07:15:41'),
(90, 'INV-1416501', 11, 25000, 5, '2022-10-16 07:16:50', '2022-10-16 07:16:50'),
(91, 'INV-1416501', 6, 48000, 3, '2022-10-16 07:16:50', '2022-10-16 07:16:50'),
(92, 'INV-1421541', 18, 25000, 7, '2022-10-17 07:21:54', '2022-10-17 07:21:54'),
(93, 'INV-1421541', 16, 20000, 6, '2022-10-17 07:21:54', '2022-10-17 07:21:54'),
(94, 'INV-1422553', 23, 60000, 5, '2022-10-18 07:22:55', '2022-10-18 07:22:55'),
(95, 'INV-1422553', 9, 45000, 5, '2022-10-18 07:22:55', '2022-10-18 07:22:55'),
(96, 'INV-1424262', 7, 73600, 3, '2022-10-19 07:24:26', '2022-10-19 07:24:26'),
(97, 'INV-1424262', 22, 60000, 3, '2022-10-19 07:24:26', '2022-10-19 07:24:26'),
(98, 'INV-1425261', 19, 27000, 6, '2022-10-19 07:25:26', '2022-10-19 07:25:26'),
(99, 'INV-1425261', 15, 80000, 4, '2022-10-19 07:25:26', '2022-10-19 07:25:26');

-- --------------------------------------------------------

--
-- Table structure for table `invoice_headers`
--

CREATE TABLE `invoice_headers` (
  `id` int NOT NULL,
  `invoice_id` varchar(45) NOT NULL,
  `user_id` int NOT NULL,
  `grand_total` int NOT NULL,
  `address_id` int NOT NULL,
  `status` varchar(45) NOT NULL DEFAULT 'Waiting for payment',
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `invoice_headers`
--

INSERT INTO `invoice_headers` (`id`, `invoice_id`, `user_id`, `grand_total`, `address_id`, `status`, `createdAt`, `updatedAt`) VALUES
(1, 'INV-2217461', 1, 1176000, 1, 'Completed', '2022-08-09 15:17:46', '2022-10-12 00:46:10'),
(2, 'INV-2222322', 2, 1569500, 2, 'Completed', '2022-09-10 15:22:32', '2022-10-12 00:46:21'),
(3, 'INV-2224242', 2, 834500, 2, 'Completed', '2022-09-10 15:24:24', '2022-10-12 00:46:32'),
(4, 'INV-2225582', 2, 586500, 2, 'Completed', '2022-09-11 15:25:58', '2022-10-12 00:46:40'),
(5, 'INV-2227363', 3, 565000, 3, 'Completed', '2022-09-12 15:27:36', '2022-10-12 00:46:49'),
(6, 'INV-2228503', 3, 755000, 3, 'Completed', '2022-09-12 15:28:50', '2022-10-12 01:34:18'),
(7, 'INV-0704592', 2, 900000, 2, 'Completed', '2022-09-13 00:04:59', '2022-10-12 01:34:21'),
(8, 'INV-0708332', 2, 137000, 2, 'Completed', '2022-09-14 00:08:33', '2022-10-12 01:34:27'),
(9, 'INV-0713163', 3, 236000, 3, 'Completed', '2022-09-14 00:13:16', '2022-10-12 01:34:36'),
(10, 'INV-0717251', 1, 853300, 1, 'Completed', '2022-09-15 00:17:25', '2022-10-12 01:34:43'),
(11, 'INV-0720422', 2, 274500, 2, 'Completed', '2022-09-16 00:20:42', '2022-10-12 01:34:52'),
(12, 'INV-0723222', 2, 199500, 2, 'Completed', '2022-09-17 00:23:22', '2022-10-12 01:35:00'),
(13, 'INV-0724112', 2, 169500, 2, 'Completed', '2022-09-18 00:24:11', '2022-10-12 01:35:09'),
(14, 'INV-0725151', 1, 219500, 1, 'Completed', '2022-09-19 00:25:15', '2022-10-12 01:35:16'),
(15, 'INV-0726352', 2, 119500, 2, 'Completed', '2022-09-20 00:26:35', '2022-10-12 01:35:24'),
(16, 'INV-0727361', 1, 199500, 1, 'Completed', '2022-09-21 00:27:36', '2022-10-12 01:35:39'),
(17, 'INV-0728541', 1, 244500, 1, 'Completed', '2022-09-22 00:28:54', '2022-10-12 01:35:49'),
(18, 'INV-0735063', 3, 139500, 3, 'Completed', '2022-09-23 00:35:06', '2022-10-12 01:35:56'),
(19, 'INV-0736013', 3, 144500, 3, 'Completed', '2022-09-24 00:36:01', '2022-10-12 01:38:17'),
(20, 'INV-0737211', 1, 244500, 1, 'Completed', '2022-09-25 00:37:21', '2022-10-12 01:38:31'),
(21, 'INV-0738141', 1, 469500, 1, 'Completed', '2022-09-26 00:38:14', '2022-10-12 01:38:40'),
(22, 'INV-0739173', 3, 259500, 3, 'Completed', '2022-09-27 00:39:17', '2022-10-12 01:38:51'),
(23, 'INV-0751302', 2, 259500, 2, 'Completed', '2022-09-28 00:51:30', '2022-10-12 01:39:38'),
(24, 'INV-0752252', 2, 339500, 2, 'Completed', '2022-09-29 00:52:25', '2022-10-12 01:56:07'),
(25, 'INV-0753231', 1, 269500, 1, 'Completed', '2022-09-30 00:53:23', '2022-10-12 01:56:13'),
(26, 'INV-0754212', 2, 244500, 2, 'Completed', '2022-10-01 00:54:21', '2022-10-12 01:56:20'),
(27, 'INV-0755181', 1, 319500, 1, 'Completed', '2022-10-02 00:55:18', '2022-10-12 01:56:27'),
(28, 'INV-0756311', 1, 247500, 1, 'Completed', '2022-10-03 00:56:31', '2022-10-12 01:56:37'),
(29, 'INV-0800343', 3, 367500, 3, 'Completed', '2022-10-04 01:00:34', '2022-10-12 02:30:16'),
(30, 'INV-0801492', 2, 390300, 2, 'Completed', '2022-10-04 01:01:49', '2022-10-12 02:30:22'),
(31, 'INV-0802532', 2, 274500, 2, 'Completed', '2022-10-05 01:02:53', '2022-10-12 02:30:28'),
(32, 'INV-0804263', 3, 334500, 3, 'Completed', '2022-10-06 01:04:26', '2022-10-12 02:30:34'),
(33, 'INV-0805272', 2, 186000, 2, 'Completed', '2022-10-07 01:05:27', '2022-10-12 02:30:40'),
(34, 'INV-0806461', 1, 176000, 1, 'Completed', '2022-10-08 01:06:46', '2022-10-12 02:31:04'),
(35, 'INV-0817041', 1, 471800, 1, 'Processing Order', '2022-10-09 01:17:04', '2022-10-12 07:29:10'),
(36, 'INV-0818203', 3, 302200, 3, 'Processing Order', '2022-10-09 01:18:20', '2022-10-12 07:29:13'),
(37, 'INV-0819583', 3, 514500, 3, 'Processing Order', '2022-10-10 01:19:58', '2022-10-12 07:29:17'),
(38, 'INV-0821321', 1, 734400, 1, 'Processing Order', '2022-10-10 01:21:32', '2022-10-12 07:29:20'),
(39, 'INV-0905112', 2, 814000, 2, 'Waiting for payment', '2022-10-11 02:05:11', '2022-10-12 02:05:11'),
(40, 'INV-0909433', 3, 375300, 3, 'Waiting for payment', '2022-10-11 02:09:43', '2022-10-12 02:09:43'),
(41, 'INV-0911401', 1, 384300, 1, 'Waiting for payment', '2022-10-11 02:11:40', '2022-10-12 02:11:40'),
(42, 'INV-0913262', 2, 544500, 2, 'Waiting for payment', '2022-10-12 02:13:26', '2022-10-12 02:13:26'),
(43, 'INV-0915383', 3, 696000, 3, 'Waiting for payment', '2022-10-12 02:15:38', '2022-10-12 02:15:38'),
(44, 'INV-0919313', 3, 419500, 3, 'Waiting for payment', '2022-10-13 02:19:32', '2022-10-13 02:19:32'),
(45, 'INV-0920561', 1, 494500, 1, 'Waiting for payment', '2022-10-13 02:20:56', '2022-10-13 02:20:56'),
(46, 'INV-0922041', 1, 520000, 1, 'Waiting for payment', '2022-10-14 02:22:04', '2022-10-14 02:22:04'),
(47, 'INV-0923332', 2, 365300, 2, 'Waiting for payment', '2022-10-14 02:23:33', '2022-10-14 02:23:33'),
(48, 'INV-1414071', 1, 395000, 1, 'Waiting for payment', '2022-10-15 07:14:07', '2022-10-15 07:14:07'),
(49, 'INV-1415033', 3, 269500, 3, 'Waiting for payment', '2022-10-15 07:15:03', '2022-10-15 07:15:03'),
(50, 'INV-1415413', 3, 296000, 3, 'Waiting for payment', '2022-10-16 07:15:41', '2022-10-16 07:15:41'),
(51, 'INV-1416501', 1, 288500, 1, 'Waiting for payment', '2022-10-16 07:16:50', '2022-10-16 07:16:50'),
(52, 'INV-1421541', 1, 321000, 1, 'Waiting for payment', '2022-10-17 07:21:54', '2022-10-17 07:21:54'),
(53, 'INV-1422553', 3, 544500, 3, 'Waiting for payment', '2022-10-18 07:22:55', '2022-10-18 07:22:55'),
(54, 'INV-1424262', 2, 420300, 2, 'Waiting for payment', '2022-10-19 07:24:26', '2022-10-19 07:24:26'),
(55, 'INV-1425261', 1, 501500, 1, 'Waiting for payment', '2022-10-19 07:25:26', '2022-10-19 07:25:26');

-- --------------------------------------------------------

--
-- Table structure for table `payment_confirmations`
--

CREATE TABLE `payment_confirmations` (
  `id` int NOT NULL,
  `invoice_id` varchar(255) NOT NULL,
  `bank` varchar(255) NOT NULL,
  `account_name` varchar(255) NOT NULL,
  `amount` int NOT NULL,
  `image` varchar(255) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `payment_confirmations`
--

INSERT INTO `payment_confirmations` (`id`, `invoice_id`, `bank`, `account_name`, `amount`, `image`, `createdAt`, `updatedAt`) VALUES
(1, 'INV-2217461', 'BNI', 'Felonious Gru', 1176000, 'Payment-1665501565783.jpg', '2022-10-11 15:19:25', '2022-10-11 15:19:25'),
(2, 'INV-2222322', 'BCA', 'Tony Stark', 1569500, 'Payment-1665501812457.png', '2022-10-11 15:23:32', '2022-10-11 15:23:32'),
(3, 'INV-2224242', 'BCA', 'Tony Stark', 834500, 'Payment-1665501902070.png', '2022-10-11 15:25:02', '2022-10-11 15:25:02'),
(4, 'INV-2225582', 'BCA', 'Tony Stark', 586500, 'Payment-1665501988710.png', '2022-10-11 15:26:28', '2022-10-11 15:26:28'),
(5, 'INV-2227363', 'BCA', 'Phill Culson', 565000, 'Payment-1665502092641.jpg', '2022-10-11 15:28:12', '2022-10-11 15:28:12'),
(6, 'INV-2228503', 'BCA', 'Phill Culson', 755000, 'Payment-1665502167070.jpg', '2022-10-11 15:29:27', '2022-10-11 15:29:27'),
(7, 'INV-0704592', 'BCA', 'Tony Stark', 900000, 'Payment-1665533169553.jpg', '2022-10-12 00:06:09', '2022-10-12 00:06:09'),
(8, 'INV-0708332', 'BCA', 'Tony Stark', 137000, 'Payment-1665533353995.jpg', '2022-10-12 00:09:13', '2022-10-12 00:09:13'),
(9, 'INV-0713163', 'BCA', 'Phill Culson', 236000, 'Payment-1665533623287.jpg', '2022-10-12 00:13:43', '2022-10-12 00:13:43'),
(10, 'INV-0717251', 'BNI', 'Felonious Gru', 853300, 'Payment-1665533889904.jpg', '2022-10-12 00:18:09', '2022-10-12 00:18:09'),
(11, 'INV-0720422', 'BCA', 'Tony Stark', 274500, 'Payment-1665534079825.jpg', '2022-10-12 00:21:19', '2022-10-12 00:21:19'),
(12, 'INV-0723222', 'BCA', 'Tony Stark', 199500, 'Payment-1665534227314.jpg', '2022-10-12 00:23:47', '2022-10-12 00:23:47'),
(13, 'INV-0724112', 'BCA', 'Tony Stark', 169500, 'Payment-1665534279126.jpg', '2022-10-12 00:24:39', '2022-10-12 00:24:39'),
(14, 'INV-0725151', 'BNI', 'Felonious Gru', 219500, 'Payment-1665534366273.jpg', '2022-10-12 00:26:06', '2022-10-12 00:26:06'),
(15, 'INV-0726352', 'BCA', 'Tony Stark', 119500, 'Payment-1665534421206.jpg', '2022-10-12 00:27:01', '2022-10-12 00:27:01'),
(16, 'INV-0727361', 'BNI', 'Felonious Gru', 199500, 'Payment-1665534484594.jpg', '2022-10-12 00:28:04', '2022-10-12 00:28:04'),
(17, 'INV-0728541', 'BNI', 'Felonious Gru', 244500, 'Payment-1665534566018.jpg', '2022-10-12 00:29:26', '2022-10-12 00:29:26'),
(18, 'INV-0735063', 'BCA', 'Phill Culson', 139500, 'Payment-1665534932935.jpg', '2022-10-12 00:35:32', '2022-10-12 00:35:32'),
(19, 'INV-0736013', 'BCA', 'Phill Culson', 144500, 'Payment-1665534988714.jpg', '2022-10-12 00:36:28', '2022-10-12 00:36:28'),
(20, 'INV-0737211', 'BNI', 'Felonious Gru', 244500, 'Payment-1665535068217.jpg', '2022-10-12 00:37:48', '2022-10-12 00:37:48'),
(21, 'INV-0738141', 'BNI', 'Felonious Gru', 469500, 'Payment-1665535124497.jpg', '2022-10-12 00:38:44', '2022-10-12 00:38:44'),
(22, 'INV-0739173', 'BCA', 'Phill Culson', 259500, 'Payment-1665535193517.jpg', '2022-10-12 00:39:53', '2022-10-12 00:39:53'),
(23, 'INV-0751302', 'BCA', 'Tony Stark', 259500, 'Payment-1665535920202.jpg', '2022-10-12 00:52:00', '2022-10-12 00:52:00'),
(24, 'INV-0752252', 'BCA', 'Tony Stark', 339500, 'Payment-1665535977575.jpg', '2022-10-12 00:52:57', '2022-10-12 00:52:57'),
(25, 'INV-0753231', 'BNI', 'Felonious Gru', 269500, 'Payment-1665536032535.jpg', '2022-10-12 00:53:52', '2022-10-12 00:53:52'),
(26, 'INV-0754212', 'BCA', 'Tony Stark', 244500, 'Payment-1665536091310.jpg', '2022-10-12 00:54:51', '2022-10-12 00:54:51'),
(27, 'INV-0755181', 'BNI', 'Felonious Gru', 319500, 'Payment-1665536156852.jpg', '2022-10-12 00:55:56', '2022-10-12 00:55:56'),
(28, 'INV-0756311', 'BNI', 'Felonious Gru', 247500, 'Payment-1665536224127.jpg', '2022-10-12 00:57:04', '2022-10-12 00:57:04'),
(29, 'INV-0800343', 'BCA', 'Phill Culson', 367500, 'Payment-1665536470410.jpg', '2022-10-12 01:01:10', '2022-10-12 01:01:10'),
(30, 'INV-0801492', 'BCA', 'Tony Stark', 390300, 'Payment-1665536539733.jpg', '2022-10-12 01:02:19', '2022-10-12 01:02:19'),
(31, 'INV-0802532', 'BCA', 'Tony Stark', 274500, 'Payment-1665536609862.jpg', '2022-10-12 01:03:29', '2022-10-12 01:03:29'),
(32, 'INV-0804263', 'BCA', 'Phill Culson', 334500, 'Payment-1665536696265.jpg', '2022-10-12 01:04:56', '2022-10-12 01:04:56'),
(33, 'INV-0805272', 'BCA', 'Tony Stark', 186000, 'Payment-1665536751848.jpg', '2022-10-12 01:05:51', '2022-10-12 01:05:51'),
(34, 'INV-0806461', 'BNI', 'Felonious Gru', 176000, 'Payment-1665536838639.jpg', '2022-10-12 01:07:18', '2022-10-12 01:07:18'),
(35, 'INV-0817041', 'BNI', 'Felonious Gru', 471800, 'Payment-1665537458627.jpg', '2022-10-12 01:17:38', '2022-10-12 01:17:38'),
(36, 'INV-0818203', 'BNI', 'Phill Culson', 302200, 'Payment-1665537540669.jpg', '2022-10-12 01:19:00', '2022-10-12 01:19:00'),
(37, 'INV-0819583', 'BCA', 'Phill Culson', 514500, 'Payment-1665537638849.jpg', '2022-10-12 01:20:38', '2022-10-12 01:20:38'),
(38, 'INV-0821321', 'BNI', 'Felonious Gru', 734400, 'Payment-1665537726160.jpg', '2022-10-12 01:22:06', '2022-10-12 01:22:06'),
(39, 'INV-0905112', 'BCA', 'Tony Stark', 814000, 'Payment-1665540355053.jpg', '2022-10-12 02:05:55', '2022-10-12 02:05:55'),
(40, 'INV-0909433', 'BCA', 'Phill Culson', 375300, 'Payment-1665540651599.jpg', '2022-10-12 02:10:51', '2022-10-12 02:10:51'),
(41, 'INV-0911401', 'BNI', 'Felonious Gru', 384300, 'Payment-1665540746654.jpg', '2022-10-12 02:12:26', '2022-10-12 02:12:26'),
(42, 'INV-0913262', 'BCA', 'Tony Stark', 544500, 'Payment-1665540849319.jpg', '2022-10-12 02:14:09', '2022-10-12 02:14:09'),
(43, 'INV-0915383', 'BCA', 'Phill Culson', 696000, 'Payment-1665540987758.jpg', '2022-10-12 02:16:27', '2022-10-12 02:16:27'),
(44, 'INV-0919313', 'BCA', 'Phill Culson', 419500, 'Payment-1665541212651.jpg', '2022-10-12 02:20:12', '2022-10-12 02:20:12'),
(45, 'INV-0920561', 'BNI', 'Felonious Gru', 494500, 'Payment-1665541290009.jpg', '2022-10-12 02:21:30', '2022-10-12 02:21:30'),
(46, 'INV-0922041', 'BNI', 'Felonious Gru', 520000, 'Payment-1665541355133.jpg', '2022-10-12 02:22:35', '2022-10-12 02:22:35'),
(47, 'INV-0923332', 'BCA', 'Tony Stark', 365300, 'Payment-1665541449570.jpg', '2022-10-12 02:24:09', '2022-10-12 02:24:09');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int NOT NULL,
  `category_id` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `image` varchar(255) NOT NULL,
  `price` int NOT NULL,
  `description` varchar(255) DEFAULT '',
  `total_stock` int NOT NULL,
  `unit` varchar(255) NOT NULL,
  `unit_per_bottle` int NOT NULL,
  `stock_bottle` int NOT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `category_id`, `name`, `image`, `price`, `description`, `total_stock`, `unit`, `unit_per_bottle`, `stock_bottle`, `is_deleted`, `createdAt`, `updatedAt`) VALUES
(3, 2, 'Alpha Cellulose Powder', 'Product-1663202797977.jpg', 45000, 'Cellulose, a polysaccharide composed of long chains of β(1,4) linked D-glucose units, is used in a wide range of applications that require a carbohydrate structural back-bone such microfibrils, biofilms, and biodegradable composites.', 10000, 'gram', 1000, 10, 0, '2022-09-14 01:30:49', '2022-09-15 13:12:40'),
(4, 2, 'Xylanase Enzyme Powder', 'Product-1663201999766.jpg', 45000, 'Enzim Xylanase Powder\r\n\r\nBrand Buana\r\n\r\nMade in China\r\n\r\nReady CoA\r\n\r\nSediaan Powder\r\n\r\nPrice/gr', 10000, 'gram', 1000, 10, 0, '2022-09-14 01:34:09', '2022-10-12 01:32:30'),
(5, 2, 'Papain Enzyme Powder', 'Product-1663202324633.jpg', 37000, 'Enzyme Papain Powder \r\n\r\nSediaan Powder\r\n\r\nMerek Buana Lab\r\n\r\nEx Taiwan\r\n\r\nPrice/gr', 10000, 'gram', 500, 20, 0, '2022-09-14 02:21:48', '2022-10-12 01:32:23'),
(6, 2, 'Mannase Enzyme Powder', 'Product-1663201428626.jpg', 48000, 'Enzim Mannase Powder\r\n\r\nBrandBuana\r\n\r\nMade in China\r\n\r\nReady CoA\r\n\r\nSediaan Powder \r\n\r\nPrice/gr', 10000, 'gram', 1000, 10, 0, '2022-09-14 14:56:56', '2022-09-15 00:39:41'),
(7, 2, 'Sigma-Aldrich Choline Chloride', 'Product-1663168509809.jpg', 73600, 'Choline Chloride \r\n\r\nProduct Name: Choline chloride\r\nProduct Description: ≥98%\r\nProduct Brand: Sigma-Aldrich\r\nProduct Number: C1879\r\nMolecular Weight:139.62\r\nMolecular Formula:(CH3)3N(Cl)CH2CH2OH\r\nCAS Number:67-48-1 \r\n\r\nPrice/gr', 15000, 'gram', 100, 150, 0, '2022-09-14 14:58:35', '2022-09-15 00:29:33'),
(8, 3, 'Formalin 10% Histologi', 'Product-1663200706016.jpg', 50000, 'Formalin 10% Histologi 20L\r\n\r\nMade in China\r\n\r\nSediaan Cair\r\n\r\nKadar 10%\r\n\r\nAplikasi Rumah sakit dan Laboratorium\r\n\r\nTidak untuk Konsumsi\r\n\r\nHarga per liter', 200, 'liter', 20, 10, 0, '2022-09-15 00:11:46', '2022-09-15 05:35:45'),
(9, 2, 'Protease Enzyme', 'Product-1663203045281.jpg', 45000, 'Protease Enzyme\r\n\r\nMade in Indonesia\r\n\r\nReady CoA', 100, 'liter', 1, 100, 0, '2022-09-15 00:50:45', '2022-09-15 05:26:24'),
(10, 3, 'Super Alcohol Denaturation 96%', 'Product-1663203328077.jpg', 75000, '\r\nAlkohol Denat 96% Super\r\n\r\nMade in India\r\n\r\nSediaan cair\r\n\r\nKadar 96% Murni', 1000, 'liter', 5, 200, 0, '2022-09-15 00:55:28', '2022-09-15 05:36:34'),
(11, 3, 'Sodium Hypochlorite 12%', 'Product-1663203619924.jpg', 25000, 'Sodium Hypochlorite \r\n\r\nMade in India\r\n\r\nSediaan Cair\r\n\r\nKadar 12%\r\n\r\ntechnical Grade', 6000, 'gram', 1200, 5, 0, '2022-09-15 01:00:19', '2022-09-15 05:36:21'),
(12, 3, 'Ammonia 25%', 'Product-1663204196903.jpg', 40000, 'Amonia Teknis 25%\r\n\r\nMade in India\r\n\r\nSediaan cair\r\n\r\nkadar Min 23%', 450, 'liter', 30, 15, 0, '2022-09-15 01:09:56', '2022-10-12 02:29:55'),
(13, 3, 'Hydrogen Peroxide 35%', 'Product-1663204603210.jpg', 35000, 'Hydrogen Peroxide 35%\r\n\r\nMade in India\r\n\r\nSediaan cair\r\n\r\nKadar 35%', 500, 'liter', 5, 100, 0, '2022-09-15 01:16:43', '2022-09-15 05:35:53'),
(14, 1, 'Potassium Dichromate 0,1M Liquid', 'Product-1663204767743.jpg', 60000, 'Potassium Dichromate 0,1M Liquid\r\n\r\nMade in India\r\n\r\nAssay 0,1M\r\n\r\nSediaan Cair', 500, 'liter', 1, 500, 0, '2022-09-15 01:19:27', '2022-09-15 05:36:10'),
(15, 4, 'Panax Ginseng Extract Liquid', 'Product-1663220492708.jpg', 80000, 'Panax Ginseng Extract Cair\r\n\r\nMade in Korea\r\n\r\nSediaan cair\r\n\r\nKadar 99%\r\n\r\nFood and Pharma', 300, 'liter', 5, 60, 0, '2022-09-15 05:41:32', '2022-09-15 05:41:32'),
(16, 4, 'Caramel Colour Positive', 'Product-1663220767591.jpg', 20000, '\r\nCaramel Colour Positive\r\n\r\nFood grade\r\n\r\nMade in Malaysia\r\n\r\nSediaan Cair', 600, 'kg', 30, 20, 0, '2022-09-15 05:46:07', '2022-09-15 05:46:07'),
(17, 4, 'Caramel Colour Negative', 'Product-1663220852016.jpg', 20000, 'Caramel Colour Negative\r\n\r\nFood grade\r\n\r\nMade in Malaysia\r\n\r\nSediaan Cair', 600, 'kg', 30, 20, 0, '2022-09-15 05:47:32', '2022-09-15 05:47:32'),
(18, 4, 'Benzoic Acid Purox B', 'Product-1663221129262.png', 25000, 'Benzoic Acid Purox B\r\n\r\nMade in Germany\r\n\r\nSediaan Granular\r\n\r\nReady CoA', 500, 'kg', 25, 20, 0, '2022-09-15 05:52:09', '2022-09-15 05:52:09'),
(19, 4, 'Xanthan Gum ', 'Product-1663221589844.jpg', 27000, 'Xanthan Gum\r\n\r\nMade in China\r\n\r\nFood grade\r\n\r\nSediaan Powder\r\n\r\nReady CoA', 500, 'kg', 25, 20, 0, '2022-09-15 05:59:49', '2022-09-15 05:59:49'),
(20, 4, 'Aspartame Powder', 'Product-1663221711769.jpg', 25000, 'Aspartame Powder\r\n\r\nMade in China\r\n\r\nReady CoA', 500, 'kg', 25, 20, 0, '2022-09-15 06:01:51', '2022-09-15 06:01:51'),
(21, 4, 'PGPR E476', 'Product-1663221889489.jpg', 20000, 'PGPR E476 \r\n\r\nMade in China \r\n\r\nFood grade \r\n\r\nReady CoA ', 300, 'liter', 2, 150, 0, '2022-09-15 06:04:49', '2022-09-15 06:04:49'),
(22, 1, 'Hydrochloric Acid 0,5M Aqueous', 'Product-1663222059057.jpg', 60000, 'Hydrochloric Acid 0,5M Aqueous\r\n\r\nMade in India\r\n\r\nReagensia\r\n\r\nSediaan cair', 300, 'liter', 1, 300, 0, '2022-09-15 06:07:39', '2022-09-15 06:07:39'),
(23, 1, 'Hydrogen Peroxide 50% Aqueous', 'Product-1663222359927.jpg', 60000, 'Hydrogen Peroxide 50% Aqueous\r\n\r\nMade in China \r\n\r\nSediaan Cair\r\n\r\nAssay 50%\r\n\r\nReagent Grade', 500, 'liter', 1, 500, 0, '2022-09-15 06:12:39', '2022-09-15 06:12:39');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `is_verified` tinyint(1) DEFAULT '0',
  `active_status` tinyint(1) DEFAULT '1',
  `phone` varchar(255) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `uuid`, `first_name`, `last_name`, `email`, `password`, `is_verified`, `active_status`, `phone`, `createdAt`, `updatedAt`) VALUES
(1, '95bb476d-c2cb-4a10-bf90-a9b8a5a9451b', 'Felonious', 'Gru', 'felon.gru1@gmail.com', '$2b$10$PxeuG4CeXqLg3YmlNg0oe.Jepwo0UGebmxTK63vKOCic6K2USCz6G', 1, 1, '812345678', '2022-09-11 13:43:38', '2022-09-22 09:13:57'),
(2, 'bea99278-4b22-4db9-808e-6223106667c9', 'Tony', 'Stark', 'tony@stark.co', '$2b$10$QNBRKNtzL0jihJyn1naEHO7D9aPJrqv7I7qxdXHyo01x0U.EwFsB.', 1, 1, '12345678', '2022-09-23 00:44:08', '2022-09-23 00:44:08'),
(3, 'b8940b31-6785-4f4c-b3bb-8c7922e1543e', 'Phill', 'Culson', 'phill@mail.com', '$2b$10$kj6zHt3mrEDNiACiblrHp.eVIZWddXmEC6mEXVztE0m4BZVpq7d9K', 1, 1, '269624649', '2022-09-23 01:24:37', '2022-09-23 01:24:37'),
(4, 'dddd07dc-7eaf-4ce6-ac70-a1c34058e729', 'Ryan', 'Antarisa', 'antarisaryan@gmail.com', '$2b$10$ixxpzeN6ejRSx5fS01cTYeW03jb6BN28W0RM.Ytr/jF.04E8lX4N2', 1, 1, '085678910123', '2022-10-12 09:50:03', '2022-10-12 09:50:03');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `addresses`
--
ALTER TABLE `addresses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `carts`
--
ALTER TABLE `carts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `invoice_details`
--
ALTER TABLE `invoice_details`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `invoice_headers`
--
ALTER TABLE `invoice_headers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payment_confirmations`
--
ALTER TABLE `payment_confirmations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category_id` (`category_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `addresses`
--
ALTER TABLE `addresses`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `carts`
--
ALTER TABLE `carts`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=116;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `invoice_details`
--
ALTER TABLE `invoice_details`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=100;

--
-- AUTO_INCREMENT for table `invoice_headers`
--
ALTER TABLE `invoice_headers`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=56;

--
-- AUTO_INCREMENT for table `payment_confirmations`
--
ALTER TABLE `payment_confirmations`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=48;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `carts`
--
ALTER TABLE `carts`
  ADD CONSTRAINT `carts_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `carts_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
