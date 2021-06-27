-- phpMyAdmin SQL Dump
-- version 4.9.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost:8889
-- Generation Time: Apr 06, 2021 at 07:10 AM
-- Server version: 5.7.26
-- PHP Version: 7.4.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `vue_admin_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `adonis_schema`
--

CREATE TABLE `adonis_schema` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `batch` int(11) DEFAULT NULL,
  `migration_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `adonis_schema`
--

INSERT INTO `adonis_schema` (`id`, `name`, `batch`, `migration_time`) VALUES
(1, '01_1604460220259_status', 1, '2021-02-19 09:32:30'),
(2, '02_1604460242511_user_type', 1, '2021-02-19 09:32:30'),
(3, '03_1610961347577_company', 1, '2021-02-19 09:32:30'),
(4, '04_1503248427885_user', 1, '2021-02-19 09:32:30'),
(5, '05_1503248427886_token', 1, '2021-02-19 09:32:30'),
(6, '06_1606202849827_forgot_password', 1, '2021-02-19 09:32:30'),
(7, '07_1610620944504_user_user_type', 1, '2021-02-19 09:32:30'),
(8, '08_1610961181389_receipt_type', 1, '2021-02-19 09:32:30'),
(9, '09_1611561009340_province_schema', 1, '2021-02-19 09:32:30'),
(10, '10_1611561051459_amphur_schema', 1, '2021-02-19 09:32:30'),
(11, '11_1611561064510_district_schema', 1, '2021-02-19 09:32:30'),
(12, '12_1611563865373_campaign_type_schema', 1, '2021-02-19 09:32:30'),
(13, '13_1611563939387_campaign_schema', 1, '2021-02-19 09:32:30'),
(14, '14_1611564219570_campaign_image_schema', 1, '2021-02-19 09:32:30'),
(15, '15_1611564521284_campaign_receipt_product_schema', 1, '2021-02-19 09:32:30'),
(16, '16_1611564735303_campaign_code_schema', 1, '2021-02-19 09:32:30'),
(17, '17_1611565991136_campaign_lucky_draw_schema', 1, '2021-02-19 09:32:30'),
(18, '18_1611566135211_campaign_lucky_draw_setting_schema', 1, '2021-02-19 09:32:31'),
(19, '19_1611566276291_campaign_lucky_draw_code_schema', 1, '2021-02-19 09:32:31'),
(20, '20_1611599067783_campaign_receipt_type_schema', 1, '2021-02-19 09:32:31'),
(21, '21_1612264575384_campaign_receipt_reward_schema', 1, '2021-02-19 09:32:31'),
(22, '22_1611567073771_customer_schema', 1, '2021-02-19 09:32:31'),
(23, '23_1611568159460_customer_favorite_campaign_schema', 1, '2021-02-19 09:32:31'),
(24, '24_1611569364324_customer_campaign_schema', 1, '2021-02-19 09:32:31'),
(25, '25_1611570533536_customer_campaign_receipt_schema', 1, '2021-02-19 09:32:31'),
(26, '26_1611571041543_customer_campaign_code_schema', 1, '2021-02-19 09:32:31'),
(27, '27_1611571622371_customer_campaign_lucky_draw_schema', 1, '2021-02-19 09:32:31'),
(28, '28_1611571763520_customer_campaign_code_point_schema', 1, '2021-02-19 09:32:31'),
(29, '29_1611572190484_customer_campaign_lucky_draw_remain_schema', 1, '2021-02-19 09:32:31'),
(30, '30_1611572269368_customer_campaign_lucky_draw_code_schema', 1, '2021-02-19 09:32:31'),
(31, '31_1613620149680_custom_color_schema', 1, '2021-02-19 09:32:31');

-- --------------------------------------------------------

--
-- Table structure for table `company`
--

CREATE TABLE `company` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(256) NOT NULL,
  `logo_image` varchar(256) DEFAULT NULL,
  `status_id` int(10) UNSIGNED NOT NULL DEFAULT '1',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `company`
--

INSERT INTO `company` (`id`, `name`, `logo_image`, `status_id`, `created_at`, `updated_at`) VALUES
(1, 'NIKE', NULL, 1, '2021-02-19 09:32:31', '2021-02-19 09:32:31'),
(2, 'PEPSI', NULL, 1, '2021-02-19 09:32:31', '2021-03-02 09:48:02'),
(3, 'LEO', NULL, 1, '2021-03-03 05:08:26', '2021-03-04 09:16:38'),
(4, 'MBS', NULL, 1, '2021-03-10 13:26:58', '2021-03-10 13:26:58'),
(5, 'ADIDAS', NULL, 1, '2021-03-12 10:16:15', '2021-03-12 10:16:15'),
(6, 'SPRITE', NULL, 1, '2021-03-12 10:27:52', '2021-03-12 10:27:52'),
(7, 'FANTA', NULL, 1, '2021-03-12 10:35:09', '2021-03-12 10:35:09');

-- --------------------------------------------------------

--
-- Table structure for table `forgot_password`
--

CREATE TABLE `forgot_password` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED DEFAULT NULL,
  `email` varchar(254) NOT NULL,
  `code` varchar(6) NOT NULL,
  `status_id` int(10) UNSIGNED NOT NULL DEFAULT '1',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `status`
--

CREATE TABLE `status` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(128) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `status`
--

INSERT INTO `status` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'ACTIVE', '2021-02-19 09:32:31', '2021-02-19 09:32:31'),
(2, 'INACTIVE', '2021-02-19 09:32:31', '2021-02-19 09:32:31'),
(3, 'DELETED', '2021-02-19 09:32:31', '2021-02-19 09:32:31'),
(4, 'WAITING', '2021-02-19 09:32:31', '2021-02-19 09:32:31'),
(5, 'QUEUED', '2021-02-19 09:32:31', '2021-02-19 09:32:31'),
(6, 'PENDING', '2021-02-19 09:32:31', '2021-02-19 09:32:31'),
(7, 'PROCESSING', '2021-02-19 09:32:31', '2021-02-19 09:32:31'),
(8, 'DRAFT', '2021-02-19 09:32:31', '2021-02-19 09:32:31');

-- --------------------------------------------------------

--
-- Table structure for table `token`
--

CREATE TABLE `token` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED DEFAULT NULL,
  `token` varchar(256) NOT NULL,
  `type` varchar(128) NOT NULL,
  `is_revoked` tinyint(1) DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `token`
--

INSERT INTO `token` (`id`, `user_id`, `token`, `type`, `is_revoked`, `created_at`, `updated_at`) VALUES
(1, 2, '2fd1a1b9-afe7-4b35-bd80-0d46fdaa9ee3', 'jwt_refresh_token', 1, '2021-02-19 14:13:23', '2021-03-14 10:38:01'),
(2, 2, 'c42246a8-94c8-4f5d-8468-d26aa2d328a2', 'jwt_refresh_token', 1, '2021-02-22 04:41:33', '2021-03-14 10:38:01'),
(3, 2, '5123a727-ba2b-4764-a8b1-bd71ae515f4f', 'jwt_refresh_token', 1, '2021-02-22 09:11:39', '2021-03-14 10:38:01'),
(4, 2, 'b7732d02-ea16-47b5-8d15-7cb5c9d3c9d9', 'jwt_refresh_token', 1, '2021-02-22 09:50:10', '2021-03-14 10:38:01'),
(5, 2, '89cadf47-6dd7-457b-9595-54f5f23f698b', 'jwt_refresh_token', 1, '2021-02-22 23:44:49', '2021-03-14 10:38:01'),
(6, 2, '980ea394-03c1-43b5-9bcd-6f56a23cfd0e', 'jwt_refresh_token', 1, '2021-03-01 02:32:34', '2021-03-14 10:38:01'),
(7, 2, '9d863125-02b4-4237-a055-f60a9fd06e99', 'jwt_refresh_token', 1, '2021-03-01 09:58:41', '2021-03-14 10:38:01'),
(8, 2, '1e2ec816-e6bd-4b98-a42c-848066d1b0ff', 'jwt_refresh_token', 1, '2021-03-02 08:03:31', '2021-03-14 10:38:01'),
(9, 2, '40476957-b874-45ab-a751-660ea337df1d', 'jwt_refresh_token', 1, '2021-03-02 08:57:36', '2021-03-14 10:38:01'),
(10, 2, 'a9a99747-eccb-4f11-b562-0a9ea62d231b', 'jwt_refresh_token', 1, '2021-03-02 09:00:43', '2021-03-14 10:38:01'),
(11, 3, 'ad5f31d6-9a3a-4caf-bf89-870b230c4f0e', 'jwt_refresh_token', 1, '2021-03-03 05:08:27', '2021-03-12 19:32:19'),
(12, 2, '9e68cee4-4d2d-4d3e-aa68-6407f73ffb2b', 'jwt_refresh_token', 1, '2021-03-03 07:47:44', '2021-03-14 10:38:01'),
(13, 2, 'bbd84231-c2ce-4845-93e3-88d896e5d678', 'jwt_refresh_token', 1, '2021-03-03 08:05:07', '2021-03-14 10:38:01'),
(14, 2, '759b41c8-ce11-46f2-ab53-942c1fff4131', 'jwt_refresh_token', 1, '2021-03-03 08:09:28', '2021-03-14 10:38:01'),
(15, 2, '3a0064c7-829b-4538-a832-04f4649d8a0f', 'jwt_refresh_token', 1, '2021-03-03 08:24:07', '2021-03-14 10:38:01'),
(16, 2, '7569ddfe-1440-46c1-b05e-67a798c2742e', 'jwt_refresh_token', 1, '2021-03-04 03:43:27', '2021-03-14 10:38:01'),
(17, 1, 'a255311d-e068-4991-a9a8-b92e6b11871b', 'jwt_refresh_token', 1, '2021-03-04 03:53:26', '2021-04-06 14:09:51'),
(18, 2, '9eabc236-fedb-494c-8df5-ca2c720e88cc', 'jwt_refresh_token', 1, '2021-03-04 04:27:26', '2021-03-14 10:38:01'),
(19, 2, 'ed80d372-24e1-4e48-b9fd-18b250ddfc74', 'jwt_refresh_token', 1, '2021-03-04 04:27:36', '2021-03-14 10:38:01'),
(20, 2, '2932b4ee-7e24-41fd-8210-d2fdf3dc67da', 'jwt_refresh_token', 1, '2021-03-04 05:03:10', '2021-03-14 10:38:01'),
(21, 3, 'effea147-a170-41d0-85d4-159e3a285bd3', 'jwt_refresh_token', 1, '2021-03-04 09:15:25', '2021-03-12 19:32:19'),
(22, 2, 'ac3c75df-1022-4c7f-98e4-66d4fb236880', 'jwt_refresh_token', 1, '2021-03-04 10:01:02', '2021-03-14 10:38:01'),
(23, 2, '9a466da9-59c9-4ef2-a2fb-8f6ffc842b7f', 'jwt_refresh_token', 1, '2021-03-04 10:01:48', '2021-03-14 10:38:01'),
(24, 3, '45afd4ff-bb8f-47bf-bb54-18c1e4fae27b', 'jwt_refresh_token', 1, '2021-03-04 10:56:19', '2021-03-12 19:32:19'),
(25, 2, '8bdb37ca-0c32-4271-829f-7f5edd8cf864', 'jwt_refresh_token', 1, '2021-03-05 04:01:17', '2021-03-14 10:38:01'),
(26, 2, '637ca523-7781-4725-9dca-e74179b93f09', 'jwt_refresh_token', 1, '2021-03-05 05:57:29', '2021-03-14 10:38:01'),
(27, 2, '39e4e332-09ec-46cf-894f-2e420ba62f68', 'jwt_refresh_token', 1, '2021-03-05 06:00:17', '2021-03-14 10:38:01'),
(28, 2, '490f7ef4-b4c2-4c0e-b10f-7f17177d1fcc', 'jwt_refresh_token', 1, '2021-03-05 06:18:58', '2021-03-14 10:38:01'),
(29, 2, '86e3bc58-86ca-4816-9c75-d1b7483a288e', 'jwt_refresh_token', 1, '2021-03-05 08:17:52', '2021-03-14 10:38:01'),
(30, 2, '74967240-ef14-4271-bd1d-224cbca75d92', 'jwt_refresh_token', 1, '2021-03-05 15:52:34', '2021-03-14 10:38:01'),
(31, 2, '1f647452-c186-4664-be6c-d23e74985ec5', 'jwt_refresh_token', 1, '2021-03-05 16:20:19', '2021-03-14 10:38:01'),
(32, 2, '188decc2-ccb7-451e-8032-a6aa25898625', 'jwt_refresh_token', 1, '2021-03-05 16:30:27', '2021-03-14 10:38:01'),
(33, 3, '811ef901-f4fe-4f12-891b-dad8b393060d', 'jwt_refresh_token', 1, '2021-03-05 18:47:15', '2021-03-12 19:32:19'),
(34, 3, '4a18f4d8-7f32-4fb4-9b75-718cac068b1c', 'jwt_refresh_token', 1, '2021-03-06 10:45:19', '2021-03-12 19:32:19'),
(35, 2, '3dfc8b59-9ea7-4c41-acdc-29a9454337a0', 'jwt_refresh_token', 1, '2021-03-08 13:01:30', '2021-03-14 10:38:01'),
(36, 3, '4f6a4ec3-f5fd-4ac3-84ce-0ab38c832bcd', 'jwt_refresh_token', 1, '2021-03-08 13:20:24', '2021-03-12 19:32:19'),
(37, 2, '9c0b500e-068c-4fdc-bbe9-52b9fb308034', 'jwt_refresh_token', 1, '2021-03-08 14:15:45', '2021-03-14 10:38:01'),
(38, 2, 'ee3c2986-82a7-4540-aa00-0f4eb1c1b5d4', 'jwt_refresh_token', 1, '2021-03-08 16:34:30', '2021-03-14 10:38:01'),
(39, 2, '9ae6cbaa-af68-41d6-9ec8-8d99b7215b19', 'jwt_refresh_token', 1, '2021-03-09 11:28:34', '2021-03-14 10:38:01'),
(40, 2, '08e924b7-0fb6-4afe-b048-abc785fe9494', 'jwt_refresh_token', 1, '2021-03-09 11:28:56', '2021-03-14 10:38:01'),
(41, 2, 'da26c21a-23d2-49df-948d-8a1aa8c9225c', 'jwt_refresh_token', 1, '2021-03-09 15:36:54', '2021-03-14 10:38:01'),
(42, 4, '346c7406-9df6-4ab2-8e31-cfbe295a95bd', 'jwt_refresh_token', 1, '2021-03-10 13:26:58', '2021-03-10 13:31:42'),
(43, 2, '426c7a06-0f8d-4f1b-8ba0-4fac593b317c', 'jwt_refresh_token', 1, '2021-03-10 13:31:47', '2021-03-14 10:38:01'),
(44, 3, '3db6ed12-60cb-4c61-b76f-de5bb2fa1ce1', 'jwt_refresh_token', 1, '2021-03-10 13:36:57', '2021-03-12 19:32:19'),
(45, 2, '1ed94866-bda3-4435-a5ea-a775f4ee1cad', 'jwt_refresh_token', 1, '2021-03-10 15:02:59', '2021-03-14 10:38:01'),
(46, 2, 'ee4cef0d-f56c-4985-82f8-eb799ee30e6b', 'jwt_refresh_token', 1, '2021-03-11 14:54:56', '2021-03-14 10:38:01'),
(47, 2, '388ec24d-70e4-4983-b276-4834b5bacbf4', 'jwt_refresh_token', 1, '2021-03-11 15:24:17', '2021-03-14 10:38:01'),
(48, 2, 'd0dad7b2-2ad3-4e98-83b9-bce154765428', 'jwt_refresh_token', 1, '2021-03-11 16:03:33', '2021-03-14 10:38:01'),
(49, 2, '31c1454d-3027-4650-a7ab-4a4437b9fecc', 'jwt_refresh_token', 1, '2021-03-11 16:04:06', '2021-03-14 10:38:01'),
(50, 2, 'bbccb82e-be38-47a3-8ead-5711b93d9248', 'jwt_refresh_token', 1, '2021-03-11 16:04:23', '2021-03-14 10:38:01'),
(51, 2, '810711da-83cf-4160-9ce7-7e0e5db70851', 'jwt_refresh_token', 1, '2021-03-11 16:54:25', '2021-03-14 10:38:01'),
(52, 2, '8bfb0798-4488-4bd1-9660-d51e15b48f64', 'jwt_refresh_token', 1, '2021-03-11 16:55:09', '2021-03-14 10:38:01'),
(53, 2, 'b75f7614-20a9-45df-bd28-c2a1458dea8b', 'jwt_refresh_token', 1, '2021-03-11 17:02:49', '2021-03-14 10:38:01'),
(54, 2, '03f8aa06-ddef-4b75-85c6-2420a7c2fe51', 'jwt_refresh_token', 1, '2021-03-11 17:03:58', '2021-03-14 10:38:01'),
(55, 2, '11cc0d84-da84-4a3c-863e-57ecdbcd2af4', 'jwt_refresh_token', 1, '2021-03-12 09:22:30', '2021-03-14 10:38:01'),
(56, 5, '936d7d0a-29b9-47d5-8ad7-e5f66b4cff88', 'jwt_refresh_token', 0, '2021-03-12 10:16:15', '2021-03-12 10:16:15'),
(57, 6, '73915e3b-4d76-4ef0-9dd6-512942eacd7b', 'jwt_refresh_token', 0, '2021-03-12 10:27:52', '2021-03-12 10:27:52'),
(58, 7, '68a6ac58-4e44-4ed2-9bc1-98442a5a53ab', 'jwt_refresh_token', 1, '2021-03-12 10:35:09', '2021-03-12 11:01:10'),
(59, 7, 'cac26ff4-2def-414a-9b1b-801722a4e186', 'jwt_refresh_token', 1, '2021-03-12 10:35:22', '2021-03-12 11:01:10'),
(60, 7, '4e50c325-dd65-429e-a09e-e907a1e85d40', 'jwt_refresh_token', 0, '2021-03-12 11:01:10', '2021-03-12 11:01:10'),
(61, 2, '9ead12ab-2117-441a-9a16-c512a55e46f5', 'jwt_refresh_token', 1, '2021-03-12 11:32:20', '2021-03-14 10:38:01'),
(62, 2, 'd808ebc9-a2a3-4979-a322-8b91c85fa9be', 'jwt_refresh_token', 1, '2021-03-12 11:32:51', '2021-03-14 10:38:01'),
(63, 2, 'dceadc98-2276-4e0b-b950-ee16a376fade', 'jwt_refresh_token', 1, '2021-03-12 11:38:16', '2021-03-14 10:38:01'),
(64, 2, 'bf0e2bdd-02f8-49c4-80b6-19858a162816', 'jwt_refresh_token', 1, '2021-03-12 11:38:55', '2021-03-14 10:38:01'),
(65, 2, '7fbf86ff-c7e8-4681-9385-c34f975e00cd', 'jwt_refresh_token', 1, '2021-03-12 12:29:43', '2021-03-14 10:38:01'),
(66, 2, 'e1321bd5-9f01-4284-b18a-4a5b193cd060', 'jwt_refresh_token', 1, '2021-03-12 13:07:50', '2021-03-14 10:38:01'),
(67, 2, '41e332b5-5762-425d-b0ad-502e996ad779', 'jwt_refresh_token', 1, '2021-03-12 13:16:08', '2021-03-14 10:38:01'),
(68, 3, '8e01a146-4d7e-4b57-a8d2-d0de5529761c', 'jwt_refresh_token', 1, '2021-03-12 13:37:53', '2021-03-12 19:32:19'),
(69, 2, 'b1284f8e-e376-4fa8-a4f9-77a316f83418', 'jwt_refresh_token', 1, '2021-03-12 15:24:24', '2021-03-14 10:38:01'),
(70, 2, 'c24163d0-1b67-418e-bad9-0be950998a95', 'jwt_refresh_token', 1, '2021-03-12 17:10:31', '2021-03-14 10:38:01'),
(71, 3, '41845ea9-55f8-4119-a9a0-e8d64aa67534', 'jwt_refresh_token', 0, '2021-03-12 19:32:19', '2021-03-12 19:32:19'),
(72, 2, 'ff7917de-4f0d-4b58-a856-3825e62b7e4c', 'jwt_refresh_token', 1, '2021-03-13 12:56:22', '2021-03-14 10:38:01'),
(73, 1, '19b246c0-527f-473f-a156-fe3d2a11887b', 'jwt_refresh_token', 1, '2021-03-14 10:38:38', '2021-04-06 14:09:51'),
(74, 8, '4f4a6aed-7b71-4dba-add5-286602c7ac91', 'jwt_refresh_token', 0, '2021-03-14 10:49:26', '2021-03-14 10:49:26'),
(75, 1, '982c9a9f-cf97-462c-a7fc-3afb7700186f', 'jwt_refresh_token', 1, '2021-04-06 11:15:46', '2021-04-06 14:09:51'),
(76, 1, '55247452-3ba0-4108-b822-d523559d4358', 'jwt_refresh_token', 1, '2021-04-06 13:04:24', '2021-04-06 14:09:51'),
(77, 1, '456af3ee-69b4-4b6b-91bb-3bf7b3984e18', 'jwt_refresh_token', 1, '2021-04-06 13:18:50', '2021-04-06 14:09:51');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(10) UNSIGNED NOT NULL,
  `company_id` int(10) UNSIGNED NOT NULL,
  `email` varchar(128) NOT NULL,
  `password` varchar(64) NOT NULL,
  `fullname` varchar(256) NOT NULL,
  `phone_number` varchar(64) DEFAULT NULL,
  `status_id` int(10) UNSIGNED NOT NULL DEFAULT '1',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `company_id`, `email`, `password`, `fullname`, `phone_number`, `status_id`, `created_at`, `updated_at`) VALUES
(1, 1, 'super_admin@email.com', '$2a$10$zG.qLbYYsOZPFhrmBzVlt.kUsVt8PSZZDtf0mwwMyyadfLTxIxedy', 'Super Admin', NULL, 1, '2021-02-19 09:32:31', '2021-02-19 09:32:31');

-- --------------------------------------------------------

--
-- Table structure for table `user_register_code`
--

CREATE TABLE `user_register_code` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `code` mediumtext NOT NULL,
  `status_id` int(10) UNSIGNED NOT NULL DEFAULT '1',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `user_type`
--

CREATE TABLE `user_type` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(128) NOT NULL,
  `status_id` int(10) UNSIGNED NOT NULL DEFAULT '1',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user_type`
--

INSERT INTO `user_type` (`id`, `name`, `status_id`, `created_at`, `updated_at`) VALUES
(1, 'Admin', 1, '2021-02-19 09:32:31', '2021-02-19 09:32:31'),
(2, 'Staff', 1, '2021-02-19 09:32:31', '2021-02-19 09:32:31');

-- --------------------------------------------------------

--
-- Table structure for table `user_user_type`
--

CREATE TABLE `user_user_type` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `user_type_id` int(10) UNSIGNED NOT NULL,
  `status_id` int(10) UNSIGNED NOT NULL DEFAULT '1',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user_user_type`
--

INSERT INTO `user_user_type` (`id`, `user_id`, `user_type_id`, `status_id`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 1, '2021-02-19 09:32:31', '2021-02-19 09:32:31');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `adonis_schema`
--
ALTER TABLE `adonis_schema`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `company`
--
ALTER TABLE `company`
  ADD PRIMARY KEY (`id`),
  ADD KEY `company_status_id_foreign` (`status_id`);

--
-- Indexes for table `forgot_password`
--
ALTER TABLE `forgot_password`
  ADD PRIMARY KEY (`id`),
  ADD KEY `forgot_password_user_id_foreign` (`user_id`),
  ADD KEY `forgot_password_status_id_foreign` (`status_id`);

--
-- Indexes for table `status`
--
ALTER TABLE `status`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `status_name_unique` (`name`);

--
-- Indexes for table `token`
--
ALTER TABLE `token`
  ADD PRIMARY KEY (`id`),
  ADD KEY `token_user_id_foreign` (`user_id`),
  ADD KEY `token_token_index` (`token`(255));

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_company_id_foreign` (`company_id`),
  ADD KEY `user_status_id_foreign` (`status_id`);

--
-- Indexes for table `user_register_code`
--
ALTER TABLE `user_register_code`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_register_code_user_id_foreign` (`user_id`),
  ADD KEY `user_register_code_status_id_foreign` (`status_id`);

--
-- Indexes for table `user_type`
--
ALTER TABLE `user_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_type_name_unique` (`name`),
  ADD KEY `user_type_status_id_foreign` (`status_id`);

--
-- Indexes for table `user_user_type`
--
ALTER TABLE `user_user_type`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_user_type_user_id_foreign` (`user_id`),
  ADD KEY `user_user_type_user_type_id_foreign` (`user_type_id`),
  ADD KEY `user_user_type_status_id_foreign` (`status_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `adonis_schema`
--
ALTER TABLE `adonis_schema`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `company`
--
ALTER TABLE `company`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `forgot_password`
--
ALTER TABLE `forgot_password`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `status`
--
ALTER TABLE `status`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `token`
--
ALTER TABLE `token`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=78;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `user_register_code`
--
ALTER TABLE `user_register_code`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_type`
--
ALTER TABLE `user_type`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `user_user_type`
--
ALTER TABLE `user_user_type`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `company`
--
ALTER TABLE `company`
  ADD CONSTRAINT `company_status_id_foreign` FOREIGN KEY (`status_id`) REFERENCES `status` (`id`);

--
-- Constraints for table `forgot_password`
--
ALTER TABLE `forgot_password`
  ADD CONSTRAINT `forgot_password_status_id_foreign` FOREIGN KEY (`status_id`) REFERENCES `status` (`id`),
  ADD CONSTRAINT `forgot_password_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

--
-- Constraints for table `token`
--
ALTER TABLE `token`
  ADD CONSTRAINT `token_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

--
-- Constraints for table `user`
--
ALTER TABLE `user`
  ADD CONSTRAINT `user_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `company` (`id`),
  ADD CONSTRAINT `user_status_id_foreign` FOREIGN KEY (`status_id`) REFERENCES `status` (`id`);

--
-- Constraints for table `user_register_code`
--
ALTER TABLE `user_register_code`
  ADD CONSTRAINT `user_register_code_status_id_foreign` FOREIGN KEY (`status_id`) REFERENCES `status` (`id`),
  ADD CONSTRAINT `user_register_code_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

--
-- Constraints for table `user_type`
--
ALTER TABLE `user_type`
  ADD CONSTRAINT `user_type_status_id_foreign` FOREIGN KEY (`status_id`) REFERENCES `status` (`id`);

--
-- Constraints for table `user_user_type`
--
ALTER TABLE `user_user_type`
  ADD CONSTRAINT `user_user_type_status_id_foreign` FOREIGN KEY (`status_id`) REFERENCES `status` (`id`),
  ADD CONSTRAINT `user_user_type_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `user_user_type_user_type_id_foreign` FOREIGN KEY (`user_type_id`) REFERENCES `user_type` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
