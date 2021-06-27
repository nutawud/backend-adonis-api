-- phpMyAdmin SQL Dump
-- version 4.7.7
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jun 07, 2021 at 06:31 AM
-- Server version: 5.6.38
-- PHP Version: 7.2.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `backend_adonis_db`
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
(1, '01_1604460220259_status_schema', 1, '2021-06-07 05:12:12'),
(2, '02_1604460242511_user_type_schema', 1, '2021-06-07 05:12:12'),
(3, '03_1503248427885_user', 1, '2021-06-07 05:12:12'),
(4, '04_1610620944504_user_user_type_schema', 1, '2021-06-07 05:12:12'),
(5, '05_1503248427886_token', 1, '2021-06-07 05:12:12'),
(6, '06_1606202849827_forgot_password_schema', 1, '2021-06-07 05:12:12');

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
(1, 'ACTIVE', NULL, NULL),
(2, 'INACTIVE', NULL, NULL),
(3, 'DELETED', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `token`
--

CREATE TABLE `token` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED DEFAULT NULL,
  `token` varchar(255) NOT NULL,
  `type` varchar(128) NOT NULL,
  `is_revoked` tinyint(1) DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `token`
--

INSERT INTO `token` (`id`, `user_id`, `token`, `type`, `is_revoked`, `created_at`, `updated_at`) VALUES
(1, 2, 'e3f7de07-5f5d-4f18-9423-a04dfadf140b', 'jwt_refresh_token', 0, '2021-06-07 12:13:21', '2021-06-07 12:13:21');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(10) UNSIGNED NOT NULL,
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

INSERT INTO `user` (`id`, `email`, `password`, `fullname`, `phone_number`, `status_id`, `created_at`, `updated_at`) VALUES
(2, 'test@gmail.com', '$2a$10$/9QodK2iQ5SB2wPbsRMOK.XPWa1z30iCviGQZ8Td2vVqT5R94hBz6', '', NULL, 1, '2021-06-07 12:13:21', '2021-06-07 12:13:21');

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
(1, 'Admin', 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `user_user_type`
--

CREATE TABLE `user_user_type` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED DEFAULT NULL,
  `user_type_id` int(10) UNSIGNED DEFAULT NULL,
  `status_id` int(10) UNSIGNED NOT NULL DEFAULT '1',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user_user_type`
--

INSERT INTO `user_user_type` (`id`, `user_id`, `user_type_id`, `status_id`, `created_at`, `updated_at`) VALUES
(1, 2, 1, 1, '2021-06-07 12:13:21', '2021-06-07 12:13:21');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `adonis_schema`
--
ALTER TABLE `adonis_schema`
  ADD PRIMARY KEY (`id`);

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
  ADD KEY `token_token_index` (`token`(191));

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_status_id_foreign` (`status_id`);

--
-- Indexes for table `user_type`
--
ALTER TABLE `user_type`
  ADD PRIMARY KEY (`id`),
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
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `forgot_password`
--
ALTER TABLE `forgot_password`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `status`
--
ALTER TABLE `status`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `token`
--
ALTER TABLE `token`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `user_type`
--
ALTER TABLE `user_type`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `user_user_type`
--
ALTER TABLE `user_user_type`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

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
  ADD CONSTRAINT `user_status_id_foreign` FOREIGN KEY (`status_id`) REFERENCES `status` (`id`);

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
