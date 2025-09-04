-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               8.0.30 - MySQL Community Server - GPL
-- Server OS:                    Win64
-- HeidiSQL Version:             12.1.0.6537
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for lapms
CREATE DATABASE IF NOT EXISTS `lapms` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `lapms`;

-- Dumping structure for table lapms.agent
CREATE TABLE IF NOT EXISTS `agent` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `contact` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table lapms.agent: ~0 rows (approximately)
REPLACE INTO `agent` (`id`, `name`, `address`, `contact`, `created_at`, `updated_at`, `deleted_at`, `status`) VALUES
	(4, 'ALFRED SIAREZ', 'BISLIG SURIGAO DEL SURs', '09104562225', '2023-08-20 22:10:44', '2023-08-20 22:17:18', NULL, 'Active');

-- Dumping structure for table lapms.borrower
CREATE TABLE IF NOT EXISTS `borrower` (
  `id` int NOT NULL AUTO_INCREMENT,
  `borrower_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `contact` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table lapms.borrower: ~5 rows (approximately)
REPLACE INTO `borrower` (`id`, `borrower_no`, `name`, `contact`, `address`, `status`, `created_at`, `updated_at`) VALUES
	(1, NULL, 'HELEN CULIAO', '09199533529', 'TIBUGNCO RELOCATION DAVAO CITY', 'Active', '2023-08-20 22:59:15', '2023-08-20 22:59:15'),
	(2, NULL, 'LUCITA TEKIKO', '09199533529', 'KABAYAN RELOCATION DAVAO CITY', 'Active', '2023-08-20 22:59:42', '2023-08-20 22:59:42'),
	(3, NULL, 'ANTONIO TEKIKO', '09199533529', 'TAGUM DAVAO DEL NORTE', 'Active', '2023-08-20 23:04:20', '2023-08-20 23:06:18'),
	(4, NULL, 'FITZ ANGELO TEKIKO', '09199533529', 'KABAYAN DAVAO CITY', 'Active', '2023-08-20 23:08:43', '2023-08-21 10:51:25'),
	(5, NULL, 'DEBRA DAWN TEKIKO', '09106533622', 'SASA DAVAO CITY', 'Active', '2023-08-21 07:09:57', '2023-08-21 07:09:57');

-- Dumping structure for table lapms.failed_jobs
CREATE TABLE IF NOT EXISTS `failed_jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table lapms.failed_jobs: ~0 rows (approximately)

-- Dumping structure for table lapms.loans
CREATE TABLE IF NOT EXISTS `loans` (
  `id` int NOT NULL AUTO_INCREMENT,
  `principal` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `interest_rate` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `monthly_payment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `loan_terms` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table lapms.loans: ~0 rows (approximately)
REPLACE INTO `loans` (`id`, `principal`, `interest_rate`, `monthly_payment`, `loan_terms`, `created_at`, `updated_at`) VALUES
	(1, '100000', '1', '101000', NULL, '2023-08-06 07:46:08', '2023-08-06 07:46:08');

-- Dumping structure for table lapms.loan_details
CREATE TABLE IF NOT EXISTS `loan_details` (
  `id` int NOT NULL AUTO_INCREMENT,
  `borrower_id` int DEFAULT NULL,
  `agent_id` int DEFAULT NULL,
  `loan_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_released` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `due_date` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `loan_amount` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `balance` decimal(10,0) DEFAULT NULL,
  `interest` double DEFAULT NULL,
  `loan_term` int DEFAULT NULL,
  `monthly_payment` decimal(10,0) DEFAULT NULL,
  `partial` decimal(10,0) DEFAULT NULL,
  `interest_due` double DEFAULT NULL,
  `agent` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Bank` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `account_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `collateral` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `collateral_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `collateral_file` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_effective` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table lapms.loan_details: ~2 rows (approximately)
REPLACE INTO `loan_details` (`id`, `borrower_id`, `agent_id`, `loan_no`, `date_released`, `due_date`, `loan_amount`, `balance`, `interest`, `loan_term`, `monthly_payment`, `partial`, `interest_due`, `agent`, `Bank`, `account_number`, `collateral`, `collateral_address`, `collateral_file`, `created_at`, `updated_at`, `status`, `date_effective`) VALUES
	(1, 2, 1, '23-LN-00000', '2023-02-25', NULL, '296000', 296000, 1.7, 48, 11199, 6167, 5032, NULL, 'BDO', '6767', 'ladislawa', 'davao city', '2.pdf', '2023-02-24 19:19:04', '2023-02-24 19:19:04', 'Approved', '2023-03-25'),
	(2, 2, 1, '23-LN-00001', '2023-02-25', NULL, '296000', 289833, 1.7, 48, 11199, 6167, 5032, NULL, 'BDO', '6767', 'ladislawa', 'davao city', '2.pdf', '2023-02-24 19:19:11', '2023-02-24 19:22:19', 'Approved', '2023-04-25');

-- Dumping structure for table lapms.loan_payments
CREATE TABLE IF NOT EXISTS `loan_payments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `loan_id` int DEFAULT NULL,
  `payment_date` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `payment` decimal(10,2) DEFAULT NULL,
  `interest` decimal(10,2) DEFAULT NULL,
  `adjusted_payment` decimal(10,2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table lapms.loan_payments: ~0 rows (approximately)

-- Dumping structure for table lapms.logs
CREATE TABLE IF NOT EXISTS `logs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `type_logs` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table lapms.logs: ~0 rows (approximately)

-- Dumping structure for table lapms.memorial
CREATE TABLE IF NOT EXISTS `memorial` (
  `id` int NOT NULL AUTO_INCREMENT,
  `date_created` date DEFAULT NULL,
  `memorial_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `memorial_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `memorial_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `sq_meter` int DEFAULT NULL,
  `amount` int DEFAULT NULL,
  `documents` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `rentedidle` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table lapms.memorial: ~0 rows (approximately)

-- Dumping structure for table lapms.memorial_sold
CREATE TABLE IF NOT EXISTS `memorial_sold` (
  `id` int NOT NULL AUTO_INCREMENT,
  `memorial_id` int DEFAULT NULL,
  `customer_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `customer_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `contact_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `amount_paid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `mode_of_payment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `account_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_paid` date DEFAULT NULL,
  `proof_of_payment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `status` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `code_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_created` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table lapms.memorial_sold: ~0 rows (approximately)

-- Dumping structure for table lapms.migrations
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table lapms.migrations: ~6 rows (approximately)
REPLACE INTO `migrations` (`id`, `migration`, `batch`) VALUES
	(1, '2014_10_12_000000_create_users_table', 1),
	(2, '2014_10_12_100000_create_password_resets_table', 1),
	(3, '2019_08_19_000000_create_failed_jobs_table', 1),
	(4, '2019_12_14_000001_create_personal_access_tokens_table', 1),
	(5, '2024_01_21_023552_create_roles_and_permissions_tables', 2),
	(6, '2024_01_21_030008_common_fields', 3);

-- Dumping structure for table lapms.password_resets
CREATE TABLE IF NOT EXISTS `password_resets` (
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table lapms.password_resets: ~0 rows (approximately)

-- Dumping structure for table lapms.payment
CREATE TABLE IF NOT EXISTS `payment` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `payment_id` int DEFAULT NULL,
  `borrower_id` int DEFAULT NULL,
  `period_date` timestamp NULL DEFAULT NULL,
  `due_date` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_paid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `mode_of_payment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `mode_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `monthly_payment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `total` decimal(10,0) DEFAULT NULL,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `interest_due` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `partial` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table lapms.payment: ~0 rows (approximately)

-- Dumping structure for table lapms.permissions
CREATE TABLE IF NOT EXISTS `permissions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `role_id` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `permissions_name_unique` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table lapms.permissions: ~11 rows (approximately)
REPLACE INTO `permissions` (`id`, `name`, `created_at`, `updated_at`, `role_id`) VALUES
	(11, 'Can Add Property', NULL, NULL, '\0\0\0-\0\0\0\0\0\0\0\0\0\0\0\0\0€\0\0\0\0\0\0Can Edit Property'),
	(12, 'Can Edit Property', NULL, NULL, '\0\0 \0/\0\0\0\0\0\0\0\r\0\0\0\0\0\0€\0\0\0\0\0\0Can Delete Proper'),
	(13, 'Can Delete Property', NULL, NULL, '\0(\0-\0\0\0\0\0\0\0\0\0\0\0\0\0€\0\0\0\0\0\0Can View Property'),
	(14, 'Can View Property', NULL, NULL, '\0\00\0*\0\0\0\0\0\0\0\0\0\0\0\0\0€\0\0\0\0\0\0Can Add Tenant\0'),
	(15, 'Can Add Tenant', NULL, NULL, '\0\08\0+\0\0\0\0\0\0\0\0\0\0\0\0\0€\0\0\0\0\0\0Can Edit Tenant'),
	(16, 'Can Edit Tenant', NULL, NULL, '\0\0@\0-\0\0\0\0\0\0\0\0\0\0\0\0\0€\0\0\0\0\0\0Can Delete Tenant'),
	(17, 'Can Delete Tenant', NULL, NULL, '\0\0H\0+\0\0\0\0\0\0\0\0\0\0\0\0\0€\0\0\0\0\0\0Can View Tenant'),
	(18, 'Can View Tenant', NULL, NULL, '\0\0P\02\0\0\0\0\0\0\0\0\0\0\0\0\0€\0\0\0\0\0\0Can Add Tenant Pa'),
	(19, 'Can Add Tenant Payment', NULL, NULL, '\0\0X\03\0\0\0\0\0\0\0\0\0\0\0\0\0€\0\0\0\0\0\0Can Edit Tenant P'),
	(20, 'Can Edit Tenant Payment', NULL, NULL, '\0\0`þ*\0\0\0\0\0\0\0\0\0\0\0\0\0€\0\0\0\0\0\0Can View Tenant P'),
	(21, 'Can View Tenant Payment', NULL, NULL, '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0');

-- Dumping structure for table lapms.permission_role
CREATE TABLE IF NOT EXISTS `permission_role` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `permission_id` bigint unsigned NOT NULL,
  `role_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `permission_role_permission_id_foreign` (`permission_id`),
  KEY `permission_role_role_id_foreign` (`role_id`),
  CONSTRAINT `permission_role_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table lapms.permission_role: ~0 rows (approximately)

-- Dumping structure for table lapms.personal_access_tokens
CREATE TABLE IF NOT EXISTS `personal_access_tokens` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint unsigned NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table lapms.personal_access_tokens: ~0 rows (approximately)

-- Dumping structure for table lapms.property
CREATE TABLE IF NOT EXISTS `property` (
  `id` int NOT NULL AUTO_INCREMENT,
  `property_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_created` date DEFAULT NULL,
  `property_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description_of_property` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `property_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `province` longtext COLLATE utf8mb4_general_ci,
  `municipality` longtext COLLATE utf8mb4_general_ci,
  `barangay` longtext COLLATE utf8mb4_general_ci,
  `zip_code` longtext COLLATE utf8mb4_general_ci,
  `street` longtext COLLATE utf8mb4_general_ci,
  `bedrooms` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `sq_meter` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `car_park` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `toilet` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `bathroom` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `monthly_rate` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `status_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `furnishing` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `rentedidle` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `image2` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `image3` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table lapms.property: ~7 rows (approximately)
REPLACE INTO `property` (`id`, `property_no`, `date_created`, `property_name`, `description_of_property`, `property_type`, `province`, `municipality`, `barangay`, `zip_code`, `street`, `bedrooms`, `sq_meter`, `car_park`, `type`, `toilet`, `bathroom`, `monthly_rate`, `status_type`, `furnishing`, `image`, `rentedidle`, `status`, `created_at`, `updated_at`, `deleted_at`, `image2`, `image3`) VALUES
	(1, 'PN-20240000', '2025-09-02', 'WOODRIDGE INCORPORATION', 'Woodridge is also home to several upscale townhouses called Woodridge Park Homes. Each residence is clustered into one of three design themes: North Forest Park Homes, Narra Park', 'Condo', 'COTABATO CITY', 'DAVAO CITY', 'TIBUNGCO', '8000', 'BLK 43 LOT 6 STREET', '2', '3', '2', 'For Sale', '4', '2', '4000', 'For Rent', 'Furnished', '2024-WOODRIDGE_INCORPORATION.PN-20240000-1.png', 'Available', 'Occupied', '2024-08-05 01:11:24', '2025-09-02 22:26:51', NULL, '2024-WOODRIDGE_INCORPORATION.PN-20240000-2.png', '2024-WOODRIDGE_INCORPORATION.PN-20240000-3.png'),
	(2, 'PN-20240001', '2025-09-02', 'PROPERTY NAME', 'Woodridge is also home to several upscale townhouses called Woodridge Park Homes. Each residence is clustered into one of three design themes: North Forest Park Homes, Narra Park', 'Real State', 'COTABATO CITY', 'dsa', 'dsadsa', '8000', 'BLK 43 LOT 6 STREET', '12', '32', '12', 'For Rent', '32', '32', '10000', 'For Rent', 'Furnished', '2024-PROPERTY_NAME.PN-20240001-1.jpg', 'Available', 'Occupied', '2024-08-05 01:15:49', '2025-09-02 23:36:27', NULL, '2024-PROPERTY_NAME.PN-20240001-2.jpg', '2024-PROPERTY_NAME.PN-20240001-3.jpg'),
	(3, 'PN-20240002', '2025-09-02', 'DASDSA', 'SADSADAS', 'Real State', 'cxzcxzcxz', 'zxcxzcxz', 'czxcxz', '8000', 'cxzcxzcxz', '12', '1321', '312', 'For Rent', '1321', '321', '50000', 'For Rent', 'Unfurnished', '2024-DASDSA.PN-20240002-1.jpg', 'Available', 'Occupied', '2024-08-05 01:16:18', '2025-09-02 22:28:24', NULL, '2024-DASDSA.PN-20240002-2.jpg', '2024-DASDSA.PN-20240002-3.jpg'),
	(4, '2025240003', '2025-09-02', 'DANRICK PROPERTY', 'LOCATED AT DAVAO CITY', 'Apartment', 'DAVAO DEL SUR', 'DAVAO CITY', NULL, '8000', 'SANTAN STEET DAVAO CITY', '3', '3', '12', NULL, '3', '4', '2600', 'For Rent', 'Furnished', '2025-DANRICK_PROPERTY.2025240003.image.png', NULL, 'Available', '2025-09-01 23:13:18', '2025-09-02 21:46:55', NULL, NULL, NULL),
	(5, 'PN-20250004', '2025-09-02', 'DANRICK PROPERTY', 'DASDS', 'Apartment', 'COTABATO CITY', 'DAVAO CITY', NULL, '8000', 'BLK 43 LOT 6 STREET', '31', '1231', '13', NULL, '31', '31', '1800', 'For Rent', 'Semi-Furnished', '2025-DANRICK_PROPERTY.PN-20250004.image.png', NULL, 'Available', '2025-09-01 23:16:19', '2025-09-02 21:35:23', NULL, NULL, NULL),
	(6, 'PN-20250005', '2025-09-02', 'bandiokla PROPERTY', 'sadsa', 'Apartment', 'COTABATO CITY', 'DAVAO CITY', NULL, '8000', 'BLK 43 LOT 6 STREET', '12', '32', '2', NULL, '213', '3213', '32131', 'For Rent', 'Semi-Furnished', '2025-BANDIOKLA_PROPERTY.PN-20250005.image.png', NULL, 'Occupied', '2025-09-01 23:19:48', '2025-09-03 20:46:35', NULL, NULL, NULL),
	(7, 'PN-20250006', '2025-09-02', 'test1232dasda', 'test1232dasda', 'House', 'COTABATO CITY', 'DAVAO CITY', NULL, '8000', 'BLK 43 LOT 6 STREET', '2', '12', '12', NULL, '3', '4', '131', 'For Rent', 'Furnished', '2025-TEST1232DASDA.PN-20250006.image.jpg', NULL, 'Available', '2025-09-02 00:12:53', '2025-09-02 00:12:53', NULL, NULL, NULL),
	(8, 'PN-20250007', '2025-09-02', 'diszaya corporation construction', 'dsa', 'Apartment', 'COTABATO CITY', 'DAVAO CITY', NULL, '8000', 'BLK 43 LOT 6 STREET', '2', '3', '4', NULL, '5', '2', '12321', 'For Rent', 'Furnished', '2025-DISZAYA_CORPORATION_CONSTRUCTION.PN-20250007.image.png', NULL, 'Available', '2025-09-02 00:19:56', '2025-09-02 21:54:26', NULL, NULL, NULL);

-- Dumping structure for table lapms.roles
CREATE TABLE IF NOT EXISTS `roles` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `status` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `permission_id` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `roles_name_unique` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table lapms.roles: ~3 rows (approximately)
REPLACE INTO `roles` (`id`, `name`, `created_at`, `updated_at`, `deleted_at`, `status`, `permission_id`) VALUES
	(1, 'Administrator', '2024-01-21 06:13:21', '2024-01-21 06:30:17', NULL, 'Active', '11,12,13,14,15,16,17,18,19,20,21'),
	(2, 'Viewer', '2024-01-21 06:14:06', '2024-01-21 06:14:06', NULL, 'Active', '14,18,21'),
	(3, 'Moderator', '2024-01-21 06:26:00', '2024-01-21 06:29:59', NULL, 'Active', '11,19,15,14,13');

-- Dumping structure for table lapms.tenancy_leases
CREATE TABLE IF NOT EXISTS `tenancy_leases` (
  `id` int NOT NULL AUTO_INCREMENT,
  `transaction_no` varchar(255) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0',
  `date_created` date DEFAULT NULL,
  `property_id` int DEFAULT NULL,
  `tenant_id` int DEFAULT NULL,
  `lease_start_date` date DEFAULT NULL,
  `lease_end_date` date DEFAULT NULL,
  `monthly_rent_amount` int DEFAULT NULL,
  `lease_duration` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `total_amount` int DEFAULT NULL,
  `upload_lease_document` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `tenancy_terms` longtext COLLATE utf8mb4_general_ci,
  `status` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table lapms.tenancy_leases: ~2 rows (approximately)
REPLACE INTO `tenancy_leases` (`id`, `transaction_no`, `date_created`, `property_id`, `tenant_id`, `lease_start_date`, `lease_end_date`, `monthly_rent_amount`, `lease_duration`, `total_amount`, `upload_lease_document`, `tenancy_terms`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(1, 'TRANSACTI0N-20250000', '2025-09-03', 1, 1, '2025-09-03', '2026-01-03', 100, '0 year(s) 3 month(s)', 93693, '2025-DIZAYA.TRANSACTI0N-20250000.upload_lease_document.pdf', 'dsadsada', 'Rented', '2025-09-02 22:26:51', '2025-09-02 22:26:51', NULL),
	(2, 'TRANSACTI0N-20250001', '2025-09-03', 3, 4, '2025-09-03', '2025-12-25', 31231, '0 year(s) 3 month(s)', 93693, '2025-DASD.TRANSACTI0N-20250001.upload_lease_document.pdf', 'dasda', 'Rented', '2025-09-02 22:28:24', '2025-09-02 22:28:24', NULL),
	(3, 'TRANSACTI0N-20250002', '2025-09-04', 6, 8, '2025-09-04', '2026-09-04', 3500, '1 year(s) 0 month(s)', 42000, '2025-CHRISTINE_MAE_CALUNSOD.TRANSACTI0N-20250002.upload_lease_document.pdf', '1 MONTH PAY', 'Rented', '2025-09-03 20:46:35', '2025-09-03 20:46:35', NULL);

-- Dumping structure for table lapms.tenant
CREATE TABLE IF NOT EXISTS `tenant` (
  `id` int NOT NULL AUTO_INCREMENT,
  `property_id` int DEFAULT NULL,
  `date_created` date DEFAULT NULL,
  `tenant_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `contact_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `rate` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `period` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `duedate` date DEFAULT NULL,
  `contracts` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `id1` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `id2` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `tenant_no` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table lapms.tenant: ~8 rows (approximately)
REPLACE INTO `tenant` (`id`, `property_id`, `date_created`, `tenant_name`, `address`, `contact_number`, `rate`, `period`, `duedate`, `contracts`, `id1`, `id2`, `status`, `created_at`, `updated_at`, `deleted_at`, `tenant_no`) VALUES
	(1, NULL, '2025-09-02', 'DANRICK C. TEKIKO', 'MANILA', '091134567', '12', '123', '2025-10-04', '2025-DIZAYA.20250000.contracts.pdf', '2025-DIZAYA.20250000.id1.png', '2025-DIZAYA.20250000.id2.jpg', 'Active', '2025-09-01 20:34:37', '2025-09-04 00:20:54', NULL, '20250000'),
	(2, NULL, '2025-09-02', 'WOIWIN CONTRACTORS', 'dasda', '09199533529', '321321', 'adasda', '2025-09-02', '2025-DSAD.20250001.contracts.pdf', '2025-DSAD.20250001.id1.png', '2025-DSAD.20250001.id2.png', 'Active', '2025-09-01 20:35:25', '2025-09-01 21:30:12', NULL, '20250001'),
	(3, NULL, '2025-09-02', 'dasd', 'dasdas', '09199533529', '32131', '12', '2025-09-02', '2025-DASD.20250002.contracts.pdf', '2025-DASD.20250002.id1.png', '2025-DASD.20250002.id2.png', 'Active', '2025-09-01 20:36:12', '2025-09-01 20:36:12', NULL, '20250002'),
	(4, NULL, '2025-09-02', 'dasd', 'DASDAS', '09199533529', '1321', '321321', '2025-10-04', '2025-DASD.20250003.contracts.pdf', '2025-DASD.20250003.id1.png', '2025-DASD.20250003.id2.jpg', 'Active', '2025-09-01 20:37:52', '2025-09-03 21:45:58', NULL, '20250003'),
	(5, NULL, '2025-09-02', 'dsadsa', 'dsadad', '09199533529', '31231', '123', '2025-09-02', '2025-DSADSA.20250004.contracts.pdf', '2025-DSADSA.20250004.id1.png', '2025-DSADSA.20250004.id2.jpg', 'Active', '2025-09-01 20:38:43', '2025-09-01 20:38:43', NULL, '20250004'),
	(6, NULL, '2025-09-02', 'dsdsa', 'dasda', '09199533529', '12', '3', '2025-09-02', '2025-DSDSA.20250005.contracts.pdf', '2025-DSDSA.20250005.id1.png', '2025-DSDSA.20250005.id2.jpg', 'Active', '2025-09-01 20:40:49', '2025-09-01 20:40:49', NULL, '20250005'),
	(7, 2, '2025-09-03', 'das', 'dsadsa', '09199533529', '312', '2', '2025-09-03', '2025-DAS.20250006.contracts.pdf', '2025-DAS.20250006.id1.png', '2025-DAS.20250006.id2.jpg', 'Rented', '2025-09-02 23:36:27', '2025-09-02 23:36:27', NULL, '20250006'),
	(8, NULL, '2025-09-04', 'CHRISTINE MAE CALUNSOD', 'MATI DAVAO ORIENTAK', '09199533529', '1000', '2', '2025-10-04', '2025-CHRISTINE_MAE_CALUNSOD.20250007.contracts.pdf', '2025-CHRISTINE_MAE_CALUNSOD.20250007.id1.png', '2025-CHRISTINE_MAE_CALUNSOD.20250007.id2.png', 'Active', '2025-09-03 20:45:30', '2025-09-04 00:25:27', NULL, '20250007');

-- Dumping structure for table lapms.tenant_payment
CREATE TABLE IF NOT EXISTS `tenant_payment` (
  `id` int NOT NULL AUTO_INCREMENT,
  `tenant_id` int DEFAULT NULL,
  `property_id` int DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `invoice` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `transaction_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `mode_of_payment` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `acctno` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `amount` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `proof_of_payment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_paid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `status` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table lapms.tenant_payment: ~2 rows (approximately)
REPLACE INTO `tenant_payment` (`id`, `tenant_id`, `property_id`, `user_id`, `invoice`, `transaction_no`, `mode_of_payment`, `acctno`, `amount`, `proof_of_payment`, `date_paid`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(1, 8, 6, 1, 'INV20250000', '2025-0001', 'Cash', 'undefined', '3500', 'INV20250000/2025-INV20250000.png', '2025-09-04', 'Paid', '2025-09-04 00:23:19', '2025-09-04 00:23:19', NULL),
	(2, 8, 6, 1, 'INV20250001', '2025-0002', 'G-Cash', '09199533529', '3500', 'INV202500012025-INV20250001.png', '2025-09-04', 'Paid', '2025-09-04 00:25:27', '2025-09-04 00:25:27', NULL);

-- Dumping structure for table lapms.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `contact_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `user_role` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_login_at` timestamp NULL DEFAULT NULL,
  `last_login_ip` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `new_column` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `role_id` bigint unsigned NOT NULL,
  `module` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table lapms.users: ~4 rows (approximately)
REPLACE INTO `users` (`id`, `name`, `email`, `contact_no`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`, `user_role`, `last_login_at`, `last_login_ip`, `status`, `new_column`, `role_id`, `module`) VALUES
	(1, 'Danrick C. Tekiko', 'dcode0516@gmail.com', '09199533529', NULL, '$2y$10$3tatTWxmeRshqRepGHdq1eR2hYbKD7OdNaS6OPNbFbbXOken7EPMO', NULL, '2023-01-24 04:43:52', '2024-01-04 03:17:09', 'Admin', '2024-01-04 03:17:09', '::1', 'Active', '', 2, 'Property Modeule'),
	(2, 'password', 'al@gmail.com', '09199533529', NULL, '$2y$10$tos0uRCnc2wONsm5OdGYI.LWdSGxQR3XCwzKRSYK0K7lIh8iDE8jm', NULL, '2023-07-06 07:47:45', '2023-07-06 08:00:08', 'User', '2023-07-06 08:00:08', '::1', 'Active', '', 0, NULL),
	(3, 'password', 'siarez@gmail.com', '09199533529', NULL, '$2y$10$7DEtB0QLVow9NlbOM5Ssd.c5yFdT3iqv6A6.tcjyueFLIXc0.enkC', NULL, '2023-07-06 07:48:27', '2023-07-06 07:48:27', 'User', NULL, NULL, 'Active', '', 0, NULL),
	(4, 'password', 'cristal@gmail.com', '09199533529', NULL, '$2y$10$3tatTWxmeRshqRepGHdq1eR2hYbKD7OdNaS6OPNbFbbXOken7EPMO', NULL, '2023-07-06 07:50:13', '2023-07-06 07:50:13', 'User', NULL, NULL, 'Active', '', 0, NULL);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
