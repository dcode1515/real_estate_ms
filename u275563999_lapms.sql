-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: May 17, 2026 at 01:06 PM
-- Server version: 11.8.6-MariaDB-log
-- PHP Version: 7.2.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `u275563999_lapms`
--

-- --------------------------------------------------------

--
-- Table structure for table `agent`
--

CREATE TABLE `agent` (
  `id` int(11) NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `contact` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `borrower`
--

CREATE TABLE `borrower` (
  `id` int(11) NOT NULL,
  `borrower_no` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `contact` varchar(12) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `loans`
--

CREATE TABLE `loans` (
  `id` int(11) NOT NULL,
  `principal` varchar(255) DEFAULT NULL,
  `interest_rate` varchar(255) DEFAULT NULL,
  `monthly_payment` varchar(255) DEFAULT NULL,
  `loan_terms` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `loan_details`
--

CREATE TABLE `loan_details` (
  `id` int(11) NOT NULL,
  `borrower_id` int(11) DEFAULT NULL,
  `agent_id` int(11) DEFAULT NULL,
  `loan_no` varchar(255) DEFAULT NULL,
  `date_released` varchar(255) DEFAULT NULL,
  `due_date` varchar(255) DEFAULT NULL,
  `loan_amount` varchar(255) DEFAULT NULL,
  `balance` decimal(10,0) DEFAULT NULL,
  `interest` double DEFAULT NULL,
  `loan_term` int(11) DEFAULT NULL,
  `monthly_payment` decimal(10,0) DEFAULT NULL,
  `partial` decimal(10,0) DEFAULT NULL,
  `interest_due` double DEFAULT NULL,
  `agent` varchar(255) DEFAULT NULL,
  `Bank` varchar(255) DEFAULT NULL,
  `account_number` varchar(255) DEFAULT NULL,
  `collateral` varchar(255) DEFAULT NULL,
  `collateral_address` varchar(255) DEFAULT NULL,
  `collateral_file` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `date_effective` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `loan_payments`
--

CREATE TABLE `loan_payments` (
  `id` int(11) NOT NULL,
  `loan_id` int(11) DEFAULT NULL,
  `payment_date` varchar(255) DEFAULT NULL,
  `payment` decimal(10,2) DEFAULT NULL,
  `interest` decimal(10,2) DEFAULT NULL,
  `adjusted_payment` decimal(10,2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `logs`
--

CREATE TABLE `logs` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `type_logs` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `memorial`
--

CREATE TABLE `memorial` (
  `id` int(11) NOT NULL,
  `date_created` date DEFAULT NULL,
  `memorial_no` varchar(255) DEFAULT NULL,
  `memorial_name` varchar(255) DEFAULT NULL,
  `memorial_address` varchar(255) DEFAULT NULL,
  `sq_meter` int(11) DEFAULT NULL,
  `amount` int(11) DEFAULT NULL,
  `documents` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `rentedidle` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `memorial_sold`
--

CREATE TABLE `memorial_sold` (
  `id` int(11) NOT NULL,
  `memorial_id` int(11) DEFAULT NULL,
  `customer_name` varchar(255) DEFAULT NULL,
  `customer_address` varchar(255) DEFAULT NULL,
  `contact_number` varchar(255) DEFAULT NULL,
  `amount_paid` varchar(255) DEFAULT NULL,
  `mode_of_payment` varchar(255) DEFAULT NULL,
  `account_number` varchar(255) DEFAULT NULL,
  `date_paid` date DEFAULT NULL,
  `proof_of_payment` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `status` varchar(45) DEFAULT NULL,
  `code_no` varchar(255) DEFAULT NULL,
  `date_created` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payment`
--

CREATE TABLE `payment` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `payment_id` int(11) DEFAULT NULL,
  `borrower_id` int(11) DEFAULT NULL,
  `period_date` timestamp NULL DEFAULT NULL,
  `due_date` varchar(255) DEFAULT NULL,
  `date_paid` varchar(255) DEFAULT NULL,
  `mode_of_payment` varchar(255) DEFAULT NULL,
  `mode_number` varchar(255) DEFAULT NULL,
  `monthly_payment` varchar(255) DEFAULT NULL,
  `total` decimal(10,0) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `interest_due` varchar(255) DEFAULT NULL,
  `partial` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `role_id` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `permission_role`
--

CREATE TABLE `permission_role` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `role_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `property`
--

CREATE TABLE `property` (
  `id` int(11) NOT NULL,
  `property_no` varchar(255) DEFAULT NULL,
  `property_name` varchar(255) DEFAULT NULL,
  `date_created` date DEFAULT NULL,
  `complete_address` varchar(255) DEFAULT NULL,
  `description_of_property` varchar(255) DEFAULT NULL,
  `province` varchar(255) DEFAULT NULL,
  `municipality` varchar(255) DEFAULT NULL,
  `barangay` varchar(255) DEFAULT NULL,
  `street` varchar(255) DEFAULT NULL,
  `zip_code` varchar(255) DEFAULT NULL,
  `bedrooms` varchar(255) DEFAULT NULL,
  `sq_meter` varchar(255) DEFAULT NULL,
  `car_park` varchar(255) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `toilet` varchar(255) DEFAULT NULL,
  `bathroom` varchar(255) DEFAULT NULL,
  `monthly_rate` varchar(255) DEFAULT NULL,
  `property_type` varchar(255) DEFAULT NULL,
  `status_type` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `furnishing` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `rentedidle` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `image2` varchar(45) DEFAULT NULL,
  `image3` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `property`
--

INSERT INTO `property` (`id`, `property_no`, `property_name`, `date_created`, `complete_address`, `description_of_property`, `province`, `municipality`, `barangay`, `street`, `zip_code`, `bedrooms`, `sq_meter`, `car_park`, `type`, `toilet`, `bathroom`, `monthly_rate`, `property_type`, `status_type`, `description`, `furnishing`, `image`, `rentedidle`, `status`, `created_at`, `updated_at`, `deleted_at`, `image2`, `image3`) VALUES
(1, 'PN-20250000', 'Lozano Subdivision, Catalunan Grande', '2025-09-26', NULL, '1 storey-house', 'Davao del Sur', 'Davao', NULL, 'Lozano St.', '8000', '3', '184', '2', NULL, '3', '3', '22000.00', 'House', 'For Rent', NULL, 'Unfurnished', NULL, NULL, 'Occupied', '2025-09-26 06:34:57', '2025-11-07 04:52:48', NULL, NULL, NULL),
(2, 'PN-20250001', 'Dinaville Subdivision, Maa', '2025-09-26', NULL, '1 storey with underground', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, '22000.00', 'House', 'For Rent', NULL, 'Semi-Furnished', NULL, NULL, 'Occupied', '2025-09-26 06:40:48', '2025-11-07 04:47:12', NULL, NULL, NULL),
(3, 'PN-20250002', 'Quimpo Building', '2025-09-26', NULL, '2 storey-building with rooftop', NULL, NULL, NULL, NULL, NULL, '0', '416', '2', NULL, NULL, NULL, '75000.00', 'Commercial', 'For Rent', NULL, 'Unfurnished', NULL, NULL, 'Available', '2025-09-26 06:46:15', '2025-09-26 06:46:15', NULL, NULL, NULL),
(4, 'PN-20250003', 'El Rio Vista', '2025-09-26', NULL, '2 storey-house with parking', NULL, NULL, NULL, NULL, NULL, NULL, '104', '1', NULL, NULL, NULL, '25000.00', 'House', 'For Rent', NULL, 'Semi-Furnished', NULL, NULL, 'Occupied', '2025-09-26 06:47:28', '2025-11-10 02:46:59', NULL, NULL, NULL),
(5, 'PN-20250004', 'Funte de Villa Abrille (1)', '2025-09-26', NULL, '2 storey-house with parking', NULL, NULL, NULL, NULL, NULL, '5', NULL, '2', NULL, '4', '4', '45000.00', 'House', 'For Rent', NULL, 'Semi-Furnished', NULL, NULL, 'Occupied', '2025-09-26 06:49:45', '2025-11-10 02:31:11', NULL, NULL, NULL),
(6, 'PN-20250005', 'Garcia Heights Door A', '2025-09-26', NULL, '1 storey motorcycle parking only', NULL, NULL, NULL, NULL, NULL, '2', NULL, NULL, NULL, '1', '1', '21000.00', 'House', 'For Rent', NULL, 'Semi-Furnished', NULL, NULL, 'Occupied', '2025-09-26 06:52:03', '2025-10-03 07:38:37', NULL, NULL, NULL),
(7, 'PN-20250006', 'Garcia Heights Door B', '2025-09-26', NULL, '2-storey with big garage but motorcyle parking only', NULL, NULL, NULL, NULL, NULL, '5', NULL, '0', NULL, '2', '2', '26000.00', 'House', 'For Rent', NULL, 'Semi-Furnished', NULL, NULL, 'Occupied', '2025-09-26 06:53:46', '2025-10-03 07:44:29', NULL, NULL, NULL),
(8, 'PN-20250007', 'Garcia Heights Door C', '2025-09-26', NULL, '1 bedroom Apartment', NULL, NULL, NULL, NULL, NULL, '1', NULL, '0', NULL, '1', '1', '15000.00', 'Apartment', 'For Rent', NULL, 'Semi-Furnished', NULL, NULL, 'Occupied', '2025-09-26 07:00:05', '2025-11-07 05:05:40', NULL, NULL, NULL),
(9, 'PN-20250008', 'Garcia Heights Door D', '2025-09-26', NULL, '2 bedroom apartment', NULL, NULL, NULL, NULL, NULL, '2', NULL, NULL, NULL, '1', '1', '17000', 'Apartment', 'For Rent', NULL, 'Semi-Furnished', NULL, NULL, 'Available', '2025-09-26 07:06:35', '2025-09-26 07:06:35', NULL, NULL, NULL),
(10, 'PN-20250009', 'Garcia Heights Door E', '2025-09-26', NULL, '1 storey', NULL, NULL, NULL, NULL, NULL, '2', NULL, '0', NULL, '1', '1', '17000.00', 'Apartment', 'For Rent', NULL, 'Semi-Furnished', NULL, NULL, 'Occupied', '2025-09-26 07:07:50', '2025-11-07 06:21:19', NULL, NULL, NULL),
(11, 'PN-20250010', 'Garcia Heights Door F', '2025-09-26', NULL, '1 storey apartment', NULL, NULL, NULL, NULL, NULL, '2', NULL, '0', NULL, '1', '1', '16500.00', 'Apartment', 'For Rent', NULL, 'Semi-Furnished', NULL, NULL, 'Occupied', '2025-09-26 07:24:19', '2025-11-10 02:42:24', NULL, NULL, NULL),
(12, 'PN-20250011', 'Ladislawa', '2025-09-26', NULL, '2 storey-house with parking', NULL, NULL, NULL, NULL, NULL, '5', NULL, '4', NULL, '5', '5', '45000.00', 'House', 'For Rent', NULL, 'Semi-Furnished', NULL, NULL, 'Available', '2025-09-26 07:25:54', '2025-09-26 07:25:54', NULL, NULL, NULL),
(13, 'PN-20250012', 'Spring Village Maa Door A', '2025-09-26', NULL, '1-storey House', NULL, NULL, NULL, NULL, NULL, '2', NULL, '1', NULL, '2', '2', '17000.00', 'House', 'For Rent', NULL, 'Semi-Furnished', NULL, NULL, 'Available', '2025-09-26 07:27:18', '2025-09-26 07:27:18', NULL, NULL, NULL),
(14, 'PN-20250013', 'Spring Village Maa Door B', '2025-09-26', NULL, '1 storey duplex house\r\nwith parking for small suv or sedan', NULL, NULL, NULL, NULL, NULL, '2', NULL, '1', NULL, '1', '1', '20000.00', 'House', 'For Rent', NULL, 'Semi-Furnished', NULL, NULL, 'Occupied', '2025-09-26 07:28:50', '2025-11-05 07:04:45', NULL, NULL, NULL),
(15, 'PN-20250014', 'Spring Village Maa Door C', '2025-09-26', NULL, '1storey duplex house', NULL, NULL, NULL, NULL, NULL, '2', NULL, '1', NULL, '2', '2', '20000.00', 'House', 'For Rent', NULL, 'Semi-Furnished', NULL, NULL, 'Occupied', '2025-09-26 07:30:36', '2025-11-07 05:46:23', NULL, NULL, NULL),
(16, 'PN-20250015', 'Sto. Niño Maa', '2025-09-26', NULL, '1-storey house', NULL, NULL, NULL, NULL, NULL, '2', NULL, '1', NULL, '2', '2', '9500.00', 'House', 'For Rent', NULL, 'Unfurnished', NULL, NULL, 'Occupied', '2025-09-26 07:32:11', '2025-11-10 02:50:51', NULL, NULL, NULL),
(17, 'PN-20250016', 'Kapundok Maa', '2025-09-26', NULL, '1 storey', 'null', 'null', 'null', 'null', 'null', '2', '0000', '2', NULL, '1', '1', '20000.00', 'Commercial', 'For Rent', NULL, 'Unfurnished', NULL, NULL, 'Occupied', '2025-09-26 07:33:36', '2025-11-05 06:42:43', NULL, NULL, NULL),
(18, 'PN-20250017', 'Morales House', '2025-09-26', NULL, '1-storey', NULL, NULL, NULL, NULL, NULL, '3', NULL, NULL, NULL, '3', '3', '22000.00', 'House', 'For Rent', NULL, 'Semi-Furnished', NULL, NULL, 'Occupied', '2025-09-26 07:34:28', '2025-11-10 02:05:00', NULL, NULL, NULL),
(19, 'PN-20250018', 'Pag-ibig Heights Apartment Door A', '2025-09-26', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '0', NULL, '1', '1', '7500.00', 'Apartment', 'For Rent', NULL, 'Semi-Furnished', NULL, NULL, 'Occupied', '2025-09-26 07:36:34', '2025-11-05 07:57:10', NULL, NULL, NULL),
(20, 'PN-20250019', 'Pag-ibig Heights Door B', '2025-09-29', NULL, 'Apartment \r\nmotorcycle parking only', NULL, NULL, NULL, NULL, NULL, '0', NULL, '0', NULL, '1', '1', '9000.00', 'Apartment', 'For Rent', NULL, 'Semi-Furnished', NULL, NULL, 'Available', '2025-09-29 01:47:15', '2025-09-29 01:47:15', NULL, NULL, NULL),
(21, 'PN-20250020', 'Pag-ibg Heights Apartment Door C', '2025-09-29', NULL, 'Studio Type Apartment \r\nMotorcycle Parking only', NULL, NULL, NULL, NULL, NULL, '0', NULL, '0', NULL, '1', '1', '5800.00', 'Apartment', 'For Rent', NULL, 'Semi-Furnished', NULL, NULL, 'Available', '2025-09-29 01:48:59', '2025-09-29 01:48:59', NULL, NULL, NULL),
(22, 'PN-20250021', 'Pag-ibig Heights Door D', '2025-09-29', NULL, 'Studio Type Apartment\r\nMotorcycle Parking only', NULL, NULL, NULL, NULL, NULL, '0', NULL, '0', NULL, '1', '1', '6000.00', 'Apartment', 'For Rent', NULL, 'Semi-Furnished', NULL, NULL, 'Available', '2025-09-29 01:50:43', '2025-09-29 01:50:43', NULL, NULL, NULL),
(23, 'PN-20250022', 'Pag-ibig Heights Apartment Door E', '2025-09-29', NULL, 'Studio Type Apartment\r\nmotorcycle parking only', NULL, NULL, NULL, NULL, NULL, '0', NULL, '0', NULL, '1', '1', '9300.00', 'Apartment', 'For Rent', NULL, 'Semi-Furnished', NULL, NULL, 'Occupied', '2025-09-29 01:52:27', '2025-11-07 04:43:27', NULL, NULL, NULL),
(24, 'PN-20250023', 'Pag-ibig Heights Apartment Door 1', '2025-09-29', NULL, '1 room apartment', NULL, NULL, NULL, NULL, NULL, '1', NULL, NULL, NULL, '1', '1', '9600.00', 'Apartment', 'For Rent', NULL, 'Semi-Furnished', NULL, NULL, 'Occupied', '2025-09-29 02:09:27', '2025-11-05 07:38:29', NULL, NULL, NULL),
(25, 'PN-20250024', 'Pag-ibig Heights Apartment Door 2', '2025-09-29', NULL, '1 room Apartment', NULL, NULL, NULL, NULL, NULL, '1', NULL, NULL, NULL, '1', '1', '10500.00', 'Apartment', 'For Rent', NULL, 'Semi-Furnished', NULL, NULL, 'Occupied', '2025-09-29 02:12:34', '2025-11-07 06:14:48', NULL, NULL, NULL),
(26, 'PN-20250025', 'Pag-ibig Heights Apartment Door 3', '2025-09-29', NULL, '1room Apartment', NULL, NULL, NULL, NULL, NULL, '1', NULL, NULL, NULL, '1', '1', '12000.00', 'Apartment', 'For Rent', NULL, 'Semi-Furnished', NULL, NULL, 'Occupied', '2025-09-29 02:20:41', '2025-11-05 06:38:55', NULL, NULL, NULL),
(27, 'PN-20250026', 'Pag-ibig Heights House', '2025-09-29', NULL, 'house with basement \r\nwith parking', NULL, NULL, NULL, NULL, NULL, '3', NULL, '2', NULL, '3', '3', '26000.00', 'House', 'For Rent', NULL, 'Semi-Furnished', NULL, NULL, 'Occupied', '2025-09-29 05:18:26', '2025-11-05 07:12:07', NULL, NULL, NULL),
(28, 'PN-20250027', 'San Rafael Door A', '2025-09-29', NULL, '1 floor Apartment \r\nwith parking', NULL, NULL, NULL, NULL, NULL, '2', NULL, '1', NULL, '2', '2', '26000.00', 'Apartment', 'For Rent', NULL, 'Semi-Furnished', NULL, NULL, 'Occupied', '2025-09-29 05:29:12', '2025-10-03 07:48:15', NULL, NULL, NULL),
(29, 'PN-20250028', 'San Rafael Door B', '2025-09-29', NULL, '2 storey house\r\nwith parking', NULL, NULL, NULL, NULL, NULL, '4', NULL, '1', NULL, '4', '4', '25000.00', 'Apartment', 'For Rent', NULL, 'Semi-Furnished', NULL, NULL, 'Occupied', '2025-09-29 05:31:18', '2025-10-03 07:58:36', NULL, NULL, NULL),
(30, 'PN-20250029', 'San Rafael Door C', '2025-09-29', NULL, '1 storey\r\nno parking', NULL, NULL, NULL, NULL, NULL, '2', NULL, '0', NULL, '2', '2', '20000.00', 'Apartment', 'For Rent', NULL, 'Semi-Furnished', NULL, NULL, 'Occupied', '2025-09-29 05:32:37', '2025-10-03 08:01:02', NULL, NULL, NULL),
(31, 'PN-20250030', 'Solariega House Antigua St.', '2025-09-29', NULL, '2-storey house\r\nwtith parking', NULL, NULL, NULL, NULL, NULL, '3', NULL, '2', NULL, '3', '3', '22000.00', 'House', 'For Rent', NULL, 'Semi-Furnished', NULL, NULL, 'Occupied', '2025-09-29 05:35:24', '2025-10-03 08:04:48', NULL, NULL, NULL),
(32, 'PN-20250031', 'Fatima Village House', '2025-09-29', NULL, '1 storey \r\nwith parking', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2', NULL, NULL, NULL, '4000.00', 'House', 'For Rent', NULL, 'Unfurnished', NULL, NULL, 'Available', '2025-09-29 05:37:30', '2025-09-29 05:37:30', NULL, NULL, NULL),
(33, 'PN-20250032', 'Villa Josephina House', '2025-09-29', NULL, 'Ilang-ilang corner Santan St.\r\n2storey', NULL, NULL, NULL, NULL, NULL, '5', NULL, '4', NULL, '5', '5', '40000.00', 'House', 'For Rent', NULL, 'Semi-Furnished', NULL, NULL, 'Occupied', '2025-09-29 05:40:53', '2025-11-10 02:37:08', NULL, NULL, NULL),
(34, 'PN-20250033', 'Woodridge House', '2025-09-29', NULL, 'B36 L12 P3 East Exit Gate', NULL, NULL, NULL, NULL, NULL, '6', NULL, '2', NULL, '7', '7', '70000', 'House', 'For Rent', NULL, 'Semi-Furnished', NULL, NULL, 'Occupied', '2025-09-29 05:44:25', '2025-11-10 02:19:37', NULL, NULL, NULL),
(35, 'PN-20250034', 'Magallanes Residences', '2025-09-30', NULL, 'Studio Type\r\nValencia Bldg. Unit 203', NULL, NULL, NULL, NULL, NULL, '0', NULL, '0', NULL, '1', '1', '16000.00', 'Condo', 'For Rent', NULL, 'Semi-Furnished', NULL, NULL, 'Occupied', '2025-09-30 03:45:21', '2025-10-03 08:08:49', NULL, NULL, NULL),
(36, 'PN-20250035', 'Gulf View House', '2025-09-30', NULL, '2 storey with parking\r\nL8 B9 Sulu Sea St. Gulf View Executive Homes', NULL, NULL, NULL, NULL, NULL, '3', NULL, '1', NULL, '4', '4', '35000.00', 'House', 'For Rent', NULL, 'Semi-Furnished', NULL, NULL, 'Occupied', '2025-09-30 03:52:30', '2025-11-05 07:32:07', NULL, NULL, NULL),
(37, 'PN-20250036', 'GSIS House Sagittarius St.', '2025-09-30', NULL, '1 storey', NULL, NULL, NULL, NULL, NULL, '3', NULL, '3', NULL, '3', '3', '35000.00', 'House', 'For Rent', NULL, 'Semi-Furnished', NULL, NULL, 'Occupied', '2025-09-30 03:53:48', '2025-11-05 06:51:50', NULL, NULL, NULL),
(38, 'PN-20250037', 'SAMPLE PROPERTIES', '2025-10-01', NULL, 'TEST', 'COTABATO CITY', 'DAVAO CITY', NULL, 'BLK 43 LOT 6 STREET', '8000', '14', '2', '3', NULL, NULL, '2', '45000', 'Apartment', 'For Rent', NULL, 'Furnished', NULL, NULL, 'Available', '2025-10-01 06:29:31', '2025-10-01 06:30:30', '2025-10-01 06:30:30', NULL, NULL),
(39, 'PN-20250037', 'DISCAYA PROPERTY', '2025-10-01', NULL, 'TEST', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '65000', 'Apartment', 'For Rent', NULL, NULL, NULL, NULL, 'Available', '2025-10-01 07:06:16', '2025-10-01 07:09:53', '2025-10-01 07:09:53', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `status` varchar(45) DEFAULT NULL,
  `permission_id` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sale_property`
--

CREATE TABLE `sale_property` (
  `id` int(11) NOT NULL,
  `property_id` int(11) DEFAULT NULL,
  `customer_name` varchar(255) DEFAULT NULL,
  `contact_no` varchar(255) DEFAULT NULL,
  `address` longtext DEFAULT NULL,
  `mode_of_payment` varchar(255) DEFAULT NULL,
  `amount` int(11) DEFAULT NULL,
  `acct_no` varchar(255) DEFAULT NULL,
  `date_paid` date DEFAULT NULL,
  `proof_of_payment` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tenancy_leases`
--

CREATE TABLE `tenancy_leases` (
  `id` int(11) NOT NULL,
  `transaction_no` varchar(255) NOT NULL DEFAULT '0',
  `date_created` date DEFAULT NULL,
  `property_id` int(11) DEFAULT NULL,
  `tenant_id` int(11) DEFAULT NULL,
  `lease_start_date` date DEFAULT NULL,
  `lease_end_date` date DEFAULT NULL,
  `monthly_rent_amount` int(11) DEFAULT NULL,
  `due_date` date DEFAULT NULL,
  `lease_duration` varchar(255) DEFAULT NULL,
  `total_amount` int(11) DEFAULT NULL,
  `upload_lease_document` varchar(255) DEFAULT NULL,
  `tenancy_terms` longtext DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tenancy_leases`
--

INSERT INTO `tenancy_leases` (`id`, `transaction_no`, `date_created`, `property_id`, `tenant_id`, `lease_start_date`, `lease_end_date`, `monthly_rent_amount`, `due_date`, `lease_duration`, `total_amount`, `upload_lease_document`, `tenancy_terms`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'TRANSACTI0N-20250000', '2025-10-03', 6, 7, '2025-02-06', '2025-10-06', 21000, '2025-10-06', '8 month(s)', 168000, NULL, '1 month advance  P21,000.00\r\n1 month deposit     P21,000.00', 'Rented', '2025-10-03 07:38:37', '2025-10-03 07:38:37', NULL),
(2, 'TRANSACTI0N-20250001', '2025-10-03', 7, 8, '2025-04-03', '2026-04-03', 26000, '2025-10-03', '1 year(s)', 312000, NULL, NULL, 'Rented', '2025-10-03 07:44:29', '2025-10-03 07:44:29', NULL),
(3, 'TRANSACTI0N-20250002', '2025-10-03', 28, 29, '2025-07-01', '2026-07-01', 26000, '2025-11-01', '1 year(s)', 312000, NULL, '2 Months deposit P52000.00', 'Rented', '2025-10-03 07:48:15', '2025-10-03 07:48:15', NULL),
(4, 'TRANSACTI0N-20250003', '2025-10-03', 29, 30, '2024-04-01', '2025-04-01', 25000, '2025-11-01', '1 year(s)', 300000, NULL, '1  month advance   P25,000.00\r\n1 month deposit       P25,000.00', 'Rented', '2025-10-03 07:58:36', '2025-10-03 07:58:36', NULL),
(5, 'TRANSACTI0N-20250004', '2025-10-03', 30, 31, '2025-07-08', '2026-07-08', 20000, '2025-10-08', '1 year(s)', 240000, NULL, '2 months deposit  P40,000.00', 'Rented', '2025-10-03 08:01:02', '2025-10-03 08:01:02', NULL),
(6, 'TRANSACTI0N-20250005', '2025-10-03', 31, 32, '2025-03-26', '2026-03-26', 22000, '2025-10-26', '1 year(s)', 264000, NULL, '1 month deposit   P22,000.00\r\n1 month advance P22,000.00', 'Rented', '2025-10-03 08:04:48', '2025-10-03 08:04:48', NULL),
(7, 'TRANSACTI0N-20250006', '2025-10-03', 35, 36, '2025-07-28', '2026-07-28', 16000, '2025-10-28', '1 year(s)', 192000, NULL, '1 month advance   P16,000.00\r\n1 month deposit      P16,000.00\r\n\r\nTOTAL                         P32,000.00', 'Rented', '2025-10-03 08:08:49', '2025-10-03 08:08:49', NULL),
(8, 'TRANSACTI0N-20250007', '2025-11-05', 26, 27, '2025-04-01', '2025-10-01', 12000, '2025-12-01', '6 month(s)', 72000, NULL, '2 months deposit \r\n12,000 x 2 = 24,000.00', 'Rented', '2025-11-05 06:38:55', '2025-11-05 06:38:55', NULL),
(9, 'TRANSACTI0N-20250008', '2025-11-05', 17, 18, '2025-10-08', '2026-10-08', 20000, '2025-11-08', '1 year(s)', 240000, NULL, '1 month deposit         20,000\r\n1 month advance       20,000', 'Rented', '2025-11-05 06:42:43', '2025-11-05 06:42:43', NULL),
(10, 'TRANSACTI0N-20250009', '2025-11-05', 37, 39, '2025-08-04', '2026-08-04', 35000, '2025-11-04', '1 year(s)', 420000, NULL, '2 months advance  35,000 x 2 = 70,000.00\r\n2 months deposit     35,000 x 2 = 70,000.00', 'Rented', '2025-11-05 06:51:50', '2025-11-05 06:51:50', NULL),
(11, 'TRANSACTI0N-20250010', '2025-11-05', 14, 15, '2025-01-13', '2026-01-13', 20000, '2025-11-13', '1 year(s)', 240000, NULL, '2 months deposit   20,000 x 2 = 40,000\r\n1  month advance  20,000 x 1  = 20,000', 'Rented', '2025-11-05 07:04:45', '2025-11-05 07:04:45', NULL),
(12, 'TRANSACTI0N-20250011', '2025-11-05', 27, 28, '2024-12-03', '2025-12-03', 26000, '2025-12-03', '1 year(s)', 312000, NULL, '2 months deposit   26,000 X 2 =  52,000.00\r\n2 months advance 26,000 x 2 =  52,000.00', 'Rented', '2025-11-05 07:12:07', '2025-11-05 07:12:07', NULL),
(13, 'TRANSACTI0N-20250012', '2025-11-05', 36, 40, '2024-07-26', '2025-07-26', 35000, '2024-10-26', '1 year(s)', 420000, NULL, '2 months deposit  35,000 x 2 = 70,000.00', 'Rented', '2025-11-05 07:32:07', '2025-11-05 07:32:07', NULL),
(14, 'TRANSACTI0N-20250013', '2025-11-05', 24, 25, '2024-07-31', '2025-07-31', 9600, NULL, '1 year(s)', 115200, NULL, '1 month deposit    9,600.00 \r\n1 month advance  9,600.00', 'Rented', '2025-11-05 07:38:29', '2025-11-05 07:38:29', NULL),
(15, 'TRANSACTI0N-20250014', '2025-11-05', 19, 20, '2024-03-30', '2024-09-30', 7500, '2024-04-30', '6 month(s)', 45000, NULL, '2 months deposit 7,500 x 2 = 15,000', 'Rented', '2025-11-05 07:57:10', '2025-11-05 07:57:10', NULL),
(16, 'TRANSACTI0N-20250015', '2025-11-07', 23, 24, '2024-09-23', '2025-09-23', 9300, '2025-11-23', '1 year(s)', 111600, NULL, '2 months deposit  9300 x 2 = 18,600', 'Rented', '2025-11-07 04:43:27', '2025-11-07 04:43:27', NULL),
(17, 'TRANSACTI0N-20250016', '2025-11-07', 2, 2, '2024-08-08', '2025-08-08', 22000, '2024-09-08', '1 year(s)', 264000, NULL, '2 months deposit 22,000 x 2 = 44,000.00\r\n1 month advance  22,000 x 1 = 22,000.00', 'Rented', '2025-11-07 04:47:12', '2025-11-07 04:47:12', NULL),
(18, 'TRANSACTI0N-20250017', '2025-11-07', 1, 1, '2024-04-16', '2025-04-16', 22000, '2026-01-16', '1 year(s)', 264000, NULL, '2 months deposit  22,000 x 2 = 44,000.00\r\n1 month deposit     22,000 x 1 =  22,000.00', 'Rented', '2025-11-07 04:52:48', '2025-11-07 04:52:48', NULL),
(19, 'TRANSACTI0N-20250018', '2025-11-07', 8, 9, '2024-01-13', '2024-07-13', 15000, '2025-12-13', '6 month(s)', 90000, NULL, '2 months deposit  15,000 x 2 = 30,000.00\r\n1 month advance  15,000 x 1  = 15,000.00', 'Rented', '2025-11-07 05:05:40', '2025-11-07 05:05:40', NULL),
(20, 'TRANSACTI0N-20250019', '2025-11-07', 15, 16, '2023-11-15', '2024-04-15', 20000, '2025-10-15', '5 month(s)', 100000, NULL, '2 months deposit 20,000.00 x 2  = 40,000.00', 'Rented', '2025-11-07 05:46:23', '2025-11-07 05:46:23', NULL),
(21, 'TRANSACTI0N-20250020', '2025-11-07', 25, 26, '2023-08-03', '2024-08-03', 10500, '2025-11-03', '1 year(s)', 126000, NULL, '2 months deposit  10,000 x 2  = 20,000.00', 'Rented', '2025-11-07 06:14:48', '2025-11-07 06:14:48', NULL),
(22, 'TRANSACTI0N-20250021', '2025-11-07', 10, 11, '2023-03-25', '2023-09-25', 17000, '2025-11-25', '6 month(s)', 102000, NULL, '2 months deposit  17,000 x 2 = 34,000.00\r\n1 month advance  17,000 x 1  = 17,000.00', 'Rented', '2025-11-07 06:21:19', '2025-11-07 06:21:19', NULL),
(23, 'TRANSACTI0N-20250022', '2025-11-10', 18, 19, '2023-01-18', '2024-01-18', 22000, '2025-11-18', '1 year(s)', 264000, NULL, '1 month deposit       22,000.00 x 1 = 22,0000.00\r\n1 month advance    22,000.00 x 1 =  22,000.00', 'Rented', '2025-11-10 02:05:00', '2025-11-10 02:05:00', NULL),
(24, 'TRANSACTI0N-20250023', '2025-11-10', 34, 35, '2024-10-17', '2025-10-17', 70000, '2025-11-17', '1 year(s)', 840000, NULL, '2 months deposit   70,000.00 x 2 = 140,000.00\r\n1 month advance   70,000.00 x 1  = 70,000.00', 'Rented', '2025-11-10 02:19:37', '2025-11-10 02:19:37', NULL),
(25, 'TRANSACTI0N-20250024', '2025-11-10', 5, 5, '2023-01-11', '2024-01-11', 45000, '2025-11-11', '1 year(s)', 540000, NULL, '2 months deposit 45,000 x 2 = 90,000.00\r\n1 month advance 45,000 x 1  = 45,000.00', 'Rented', '2025-11-10 02:31:11', '2025-11-10 02:31:11', NULL),
(26, 'TRANSACTI0N-20250025', '2025-11-10', 33, 34, '2022-09-01', '2023-09-01', 40000, '2025-12-01', '1 year(s)', 480000, NULL, '2 months deposit  40,000 x 2 = 80,000.00\r\n1 month deposit     40,000 x 1  = 40,000.00', 'Rented', '2025-11-10 02:37:08', '2025-11-10 02:37:08', NULL),
(27, 'TRANSACTI0N-20250026', '2025-11-10', 11, 12, '2022-06-30', '2022-12-30', 16500, '2025-11-30', '6 month(s)', 99000, NULL, '2 months deposit  16,500 x 2 = 33,000.00', 'Rented', '2025-11-10 02:42:24', '2025-11-10 02:42:24', NULL),
(28, 'TRANSACTI0N-20250027', '2025-11-10', 4, 4, '2022-09-30', '2023-09-30', 25000, '2025-11-30', '1 year(s)', 300000, NULL, '2 months deposit  25,000 x 2 =  50,000.00\r\n1 month advance  25,000 x 1  =  25,000.00', 'Rented', '2025-11-10 02:46:59', '2025-11-10 02:46:59', NULL),
(29, 'TRANSACTI0N-20250028', '2025-11-10', 16, 17, '2022-12-15', '2023-12-15', 9500, '2025-11-15', '1 year(s)', 114000, NULL, '1 month deposit     9500\r\n1 month advance  9500', 'Rented', '2025-11-10 02:50:51', '2025-11-10 02:50:51', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `tenant`
--

CREATE TABLE `tenant` (
  `id` int(11) NOT NULL,
  `property_id` int(11) DEFAULT NULL,
  `date_created` date DEFAULT NULL,
  `tenant_name` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `contact_number` varchar(255) DEFAULT NULL,
  `rate` varchar(255) DEFAULT NULL,
  `period` varchar(255) DEFAULT NULL,
  `duedate` date DEFAULT NULL,
  `contracts` varchar(255) DEFAULT NULL,
  `id1` varchar(255) DEFAULT NULL,
  `id2` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `tenant_no` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tenant`
--

INSERT INTO `tenant` (`id`, `property_id`, `date_created`, `tenant_name`, `address`, `contact_number`, `rate`, `period`, `duedate`, `contracts`, `id1`, `id2`, `status`, `created_at`, `updated_at`, `deleted_at`, `tenant_no`) VALUES
(1, NULL, '2025-09-26', 'Juvelyn Samuel', 'Lozano Subdivision, Lozano St. Catalunan Grande', '12345', NULL, NULL, NULL, NULL, NULL, NULL, 'Active', '2025-09-26 01:34:44', '2025-09-26 01:34:44', NULL, '20250000'),
(2, NULL, '2025-09-26', 'Golden Beam Pasuelo', 'B3 L30 Banahaw St. Dinaville Subdivision Maa', '09', NULL, NULL, NULL, NULL, NULL, NULL, 'Active', '2025-09-26 01:36:18', '2025-09-26 06:51:50', NULL, '20250001'),
(3, NULL, '2025-09-26', 'Green Coffee Roasters', 'L-5A Quimpo Blvd. Sandawa Plaza', '09', NULL, NULL, NULL, NULL, NULL, NULL, 'Active', '2025-09-26 01:38:17', '2025-09-26 01:38:17', NULL, '20250002'),
(4, NULL, '2025-09-26', 'Angelika Luna', 'Blk 13 L23 El Rio Vista, Bacaca', '09', NULL, NULL, NULL, NULL, NULL, NULL, 'Active', '2025-09-26 01:39:52', '2025-09-26 01:39:52', NULL, '20250003'),
(5, NULL, '2025-09-26', 'Emmanuel Deseo', 'L1 B23  Tulip Drive Fuente de Villa Abrille', '09', NULL, NULL, NULL, NULL, NULL, NULL, 'Active', '2025-09-26 01:40:46', '2025-09-26 01:40:46', NULL, '20250004'),
(6, NULL, '2025-09-26', 'Julian Gan', 'L19 Blk 6 Calle de Carlos St. Fuente de Villa Abrille Tulip', '09', NULL, NULL, NULL, NULL, NULL, NULL, 'Active', '2025-09-26 01:41:52', '2025-09-26 01:41:52', NULL, '20250005'),
(7, NULL, '2025-09-26', 'Chendelle Mondia', '#58 Door A Garcia Heights Bajada', '09', NULL, NULL, NULL, NULL, NULL, NULL, 'Active', '2025-09-26 01:46:08', '2025-09-26 01:46:08', NULL, '20250006'),
(8, NULL, '2025-09-26', 'Bailan Larkins', '#58 Door B Garcia Heights Bajada', '09', NULL, NULL, NULL, NULL, NULL, NULL, 'Active', '2025-09-26 01:47:17', '2025-09-26 01:47:17', NULL, '20250007'),
(9, NULL, '2025-09-26', 'Froilan Tinglao', '#58 Door C Garcia Heights Bacaca Bajada', '09', NULL, NULL, NULL, NULL, NULL, NULL, 'Active', '2025-09-26 01:50:48', '2025-09-26 01:50:48', NULL, '20250008'),
(10, NULL, '2025-09-26', 'Eve Peace Cordero', '#58 Door D Garcia Heights Bacaca', '09', NULL, NULL, NULL, NULL, NULL, NULL, 'Active', '2025-09-26 01:51:36', '2025-09-26 01:51:36', NULL, '20250009'),
(11, NULL, '2025-09-26', 'Jeanette Rapas', '#58 Door E Garcia Heights Bacaca', '09', NULL, NULL, NULL, NULL, NULL, NULL, 'Active', '2025-09-26 01:52:57', '2025-09-26 01:52:57', NULL, '20250010'),
(12, NULL, '2025-09-26', 'Carla Limen', '#58 Door F Garcia Heights Bacaca Bajada', '09', NULL, NULL, NULL, NULL, NULL, NULL, 'Active', '2025-09-26 01:53:46', '2025-09-26 01:53:46', NULL, '20250011'),
(13, NULL, '2025-09-26', 'Seouhg  Ho Cho', '163 Zinia Drive Ladislawa', '09', NULL, NULL, NULL, NULL, NULL, NULL, 'Active', '2025-09-26 01:56:16', '2025-09-26 01:56:16', NULL, '20250012'),
(14, NULL, '2025-09-26', 'Romel Bobis', '16A Green St. Spring Village Maa', '09', NULL, NULL, NULL, NULL, NULL, NULL, 'Active', '2025-09-26 02:01:04', '2025-09-26 02:01:04', NULL, '20250013'),
(15, NULL, '2025-09-26', 'Mitzi Uezono', '16B Green St. Spring Village Maa', '09', NULL, NULL, NULL, NULL, NULL, NULL, 'Active', '2025-09-26 02:02:56', '2025-09-26 02:02:56', NULL, '20250014'),
(16, NULL, '2025-09-26', 'Allysa Perez', '16C Green St. Spring Village Maa', '09', NULL, NULL, NULL, NULL, NULL, NULL, 'Active', '2025-09-26 02:04:00', '2025-09-26 02:04:00', NULL, '20250015'),
(17, NULL, '2025-09-26', 'Florindo Santiago', 'Leo St. Sto. Niño Village Maa', '09', NULL, NULL, NULL, NULL, NULL, NULL, 'Active', '2025-09-26 02:09:43', '2025-09-26 02:09:43', NULL, '20250016'),
(18, NULL, '2025-09-26', 'Rubelyn Damondamon', 'Maa Highway', '09', NULL, NULL, NULL, NULL, NULL, NULL, 'Active', '2025-09-26 02:13:26', '2025-09-26 02:13:26', NULL, '20250017'),
(19, NULL, '2025-09-26', 'Elvie Rios', '42 Upper Ruby St. Morales Village Matina', '09', NULL, NULL, NULL, NULL, NULL, NULL, 'Active', '2025-09-26 02:14:29', '2025-09-26 02:14:29', NULL, '20250018'),
(20, NULL, '2025-09-26', 'Moreno Manlabian', '#12 Door A Faith St. Pag-ibig Heights Buhangin', '09', NULL, NULL, NULL, NULL, NULL, NULL, 'Active', '2025-09-26 02:15:52', '2025-09-26 02:15:52', NULL, '20250019'),
(21, NULL, '2025-09-26', 'Ruffa Jimenez', '#12 Faith St. Door B Pag-ibig Heights Buhangin', '09', NULL, NULL, NULL, NULL, NULL, NULL, 'Active', '2025-09-26 02:16:52', '2025-09-26 02:16:52', NULL, '20250020'),
(22, NULL, '2025-09-26', 'Godofredo Chavez', '#12 Faith St. Door C Pag-ibig Heights Buhangin', '09', NULL, NULL, NULL, NULL, NULL, NULL, 'Active', '2025-09-26 02:17:48', '2025-09-26 02:17:48', NULL, '20250021'),
(23, NULL, '2025-09-26', 'Dan Marchal Rodriguez', '#12 Faith St. Door D Pag-ibig Heights Buhangin', '09', NULL, NULL, NULL, NULL, NULL, NULL, 'Active', '2025-09-26 02:21:03', '2025-09-26 02:21:03', NULL, '20250022'),
(24, NULL, '2025-09-26', 'Fracine Olarte', '#12 Faith St. Door E Pag-ibig Heights, Buhangin', '09', NULL, NULL, NULL, NULL, NULL, NULL, 'Active', '2025-09-26 02:21:58', '2025-09-26 02:21:58', NULL, '20250023'),
(25, NULL, '2025-09-26', 'Marilou Cosmiano', '#12 Faith St. Door 1 Pag-ibig Heights, Buhangin', '089', NULL, NULL, NULL, NULL, NULL, NULL, 'Active', '2025-09-26 02:23:19', '2025-09-26 02:23:19', NULL, '20250024'),
(26, NULL, '2025-09-26', 'Ma. Regine Ellah Plaza', '#12 Faith St. Door III Pag-ibig Heights, Buhangin', '09', NULL, NULL, NULL, NULL, NULL, NULL, 'Active', '2025-09-26 02:24:15', '2025-09-26 02:24:15', NULL, '20250025'),
(27, NULL, '2025-09-26', 'Earl Aries Bagion', '#12 Faith St. Door III Pag-ibig Heights Buhangin', '09', NULL, NULL, NULL, NULL, NULL, NULL, 'Active', '2025-09-26 02:26:40', '2025-09-26 02:26:40', NULL, '20250026'),
(28, NULL, '2025-09-26', 'Robert Berg Scott', '#14 Faith St. Pag-ibig Heights Buhangin', '09', NULL, NULL, NULL, NULL, NULL, NULL, 'Active', '2025-09-26 02:28:29', '2025-09-26 02:28:29', NULL, '20250027'),
(29, NULL, '2025-09-26', 'Yvonne Grace Alvarez09', '#115A Copper St. San Rafael', '09', NULL, NULL, NULL, NULL, NULL, NULL, 'Active', '2025-09-26 04:18:13', '2025-09-26 04:18:13', NULL, '20250028'),
(30, NULL, '2025-09-26', 'Hong Oh Sung', '115 Door B Copper St. San Rafael', '09', NULL, NULL, NULL, NULL, NULL, NULL, 'Active', '2025-09-26 04:19:21', '2025-09-26 04:19:21', NULL, '20250029'),
(31, NULL, '2025-09-26', 'Lyza Balanghig', '115 Door C Copper St. San Rafael', '09', NULL, NULL, NULL, NULL, NULL, NULL, 'Active', '2025-09-26 04:20:14', '2025-09-26 04:20:14', NULL, '20250030'),
(32, NULL, '2025-09-26', 'Jelly Manguiob', 'L7 B2 Ph1 Antigua St., Plantacion Solariega Subd. Talomo', '09', NULL, NULL, NULL, NULL, NULL, NULL, 'Active', '2025-09-26 04:21:33', '2025-09-26 04:21:33', NULL, '20250031'),
(33, NULL, '2025-09-26', 'Allan Parado', 'L6 B3 Fatima Village Matina Crossing', '09', NULL, NULL, NULL, NULL, NULL, NULL, 'Active', '2025-09-26 04:22:53', '2025-09-26 04:22:53', NULL, '20250032'),
(34, NULL, '2025-09-26', 'Jongkeuh Koo', 'Ilang-ilang Corner Santan St. Villa Josephina Matina', '09', NULL, NULL, NULL, NULL, NULL, NULL, 'Active', '2025-09-26 04:24:10', '2025-09-26 04:24:10', NULL, '20250033'),
(35, NULL, '2025-09-26', 'Sarra Mae Nillas', 'Bl 36 L12 Ph3 East Exit Woodridge Park Subdivision Maa', '09', NULL, NULL, NULL, NULL, NULL, NULL, 'Active', '2025-09-26 04:25:06', '2025-09-26 04:25:06', NULL, '20250034'),
(36, NULL, '2025-09-26', 'Riena Austine Narcilla', 'Unit 203 Valencia Bldg. Magallanes Residences Bolton St.', '09', NULL, NULL, NULL, NULL, NULL, NULL, 'Active', '2025-09-26 04:26:42', '2025-09-26 04:26:42', NULL, '20250035'),
(37, NULL, '2025-10-01', 'DANRICK C. TEKIKO', 'DAVAO CITY', '091098765432', NULL, NULL, NULL, NULL, NULL, NULL, 'Active', '2025-10-01 06:29:05', '2025-10-01 06:30:14', '2025-10-01 06:30:14', '20250036'),
(38, NULL, '2025-10-01', 'DANRICK C. TEKIKO', 'TIBUNGCO RELOCATION DAVAO CITY', '09199533529', NULL, NULL, NULL, NULL, NULL, NULL, 'Active', '2025-10-01 07:05:43', '2025-10-01 07:09:16', '2025-10-01 07:09:16', '20250036'),
(39, NULL, '2025-10-03', 'RIZZALIE JEAN M. MADILOSA', '26 Sagittarius St. GSIS Matina', '09912170129', NULL, NULL, NULL, NULL, NULL, NULL, 'Active', '2025-10-03 08:15:19', '2025-10-03 08:15:19', NULL, '20250036'),
(40, NULL, '2025-11-05', 'Greezel Lee Barreto', 'Block 9 Lot 8 Golf View Executive Homes Bago Aplaya', '09', NULL, NULL, NULL, NULL, NULL, NULL, 'Active', '2025-11-05 07:19:51', '2025-11-05 07:19:51', NULL, '20250037');

-- --------------------------------------------------------

--
-- Table structure for table `tenant_payment`
--

CREATE TABLE `tenant_payment` (
  `id` int(11) NOT NULL,
  `tenant_id` int(11) DEFAULT NULL,
  `property_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `invoice` varchar(255) DEFAULT NULL,
  `mode_of_payment` varchar(250) DEFAULT NULL,
  `transaction_no` varchar(250) DEFAULT NULL,
  `acctno` varchar(255) DEFAULT NULL,
  `amount` varchar(250) DEFAULT NULL,
  `proof_of_payment` varchar(255) DEFAULT NULL,
  `date_paid` varchar(255) DEFAULT NULL,
  `status` varchar(250) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tenant_payment`
--

INSERT INTO `tenant_payment` (`id`, `tenant_id`, `property_id`, `user_id`, `invoice`, `mode_of_payment`, `transaction_no`, `acctno`, `amount`, `proof_of_payment`, `date_paid`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, 6, 5, 'INV20250000', 'G-Cash', '2025-0001', '0919953329', '65000', '2025-G-CASH.INV20250000_2025-09-14.png', '2025-09-14', 'Paid', '2025-09-14 14:14:02', '2025-09-14 14:14:02', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `contact_no` varchar(255) DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `user_role` varchar(255) DEFAULT NULL,
  `user_type` varchar(255) DEFAULT NULL,
  `last_login_at` timestamp NULL DEFAULT NULL,
  `last_login_ip` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `new_column` varchar(255) NOT NULL,
  `role_id` bigint(20) UNSIGNED NOT NULL,
  `module` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `contact_no`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`, `user_role`, `user_type`, `last_login_at`, `last_login_ip`, `status`, `new_column`, `role_id`, `module`) VALUES
(5, 'SUPER ADMIN', 'admin@gmail.com', '09199533529', NULL, '$2y$10$3tatTWxmeRshqRepGHdq1eR2hYbKD7OdNaS6OPNbFbbXOken7EPMO', NULL, NULL, NULL, 'Admin', 'Super Admin', NULL, NULL, NULL, '', 0, NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `agent`
--
ALTER TABLE `agent`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `borrower`
--
ALTER TABLE `borrower`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `loans`
--
ALTER TABLE `loans`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `loan_details`
--
ALTER TABLE `loan_details`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `loan_payments`
--
ALTER TABLE `loan_payments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `logs`
--
ALTER TABLE `logs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `memorial`
--
ALTER TABLE `memorial`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `memorial_sold`
--
ALTER TABLE `memorial_sold`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `payment`
--
ALTER TABLE `payment`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `permissions_name_unique` (`name`);

--
-- Indexes for table `permission_role`
--
ALTER TABLE `permission_role`
  ADD PRIMARY KEY (`id`),
  ADD KEY `permission_role_permission_id_foreign` (`permission_id`),
  ADD KEY `permission_role_role_id_foreign` (`role_id`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `property`
--
ALTER TABLE `property`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `roles_name_unique` (`name`);

--
-- Indexes for table `sale_property`
--
ALTER TABLE `sale_property`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tenancy_leases`
--
ALTER TABLE `tenancy_leases`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tenant`
--
ALTER TABLE `tenant`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tenant_payment`
--
ALTER TABLE `tenant_payment`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `agent`
--
ALTER TABLE `agent`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `borrower`
--
ALTER TABLE `borrower`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `loans`
--
ALTER TABLE `loans`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `loan_details`
--
ALTER TABLE `loan_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `loan_payments`
--
ALTER TABLE `loan_payments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `logs`
--
ALTER TABLE `logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `memorial`
--
ALTER TABLE `memorial`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `memorial_sold`
--
ALTER TABLE `memorial_sold`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `payment`
--
ALTER TABLE `payment`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `permission_role`
--
ALTER TABLE `permission_role`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `property`
--
ALTER TABLE `property`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `sale_property`
--
ALTER TABLE `sale_property`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tenancy_leases`
--
ALTER TABLE `tenancy_leases`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `tenant`
--
ALTER TABLE `tenant`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `tenant_payment`
--
ALTER TABLE `tenant_payment`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `permission_role`
--
ALTER TABLE `permission_role`
  ADD CONSTRAINT `permission_role_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
