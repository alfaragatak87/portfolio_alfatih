-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3307
-- Generation Time: Jul 16, 2025 at 01:41 PM
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
-- Database: `portfolio_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role_id` int(11) DEFAULT 1,
  `email` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `profile_image` varchar(255) DEFAULT NULL,
  `last_login` timestamp NULL DEFAULT NULL,
  `status` enum('active','inactive') DEFAULT 'active',
  `login_attempts` int(11) DEFAULT 0,
  `recovery_token` varchar(255) DEFAULT NULL,
  `recovery_expires` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`id`, `username`, `password`, `role_id`, `email`, `phone`, `profile_image`, `last_login`, `status`, `login_attempts`, `recovery_token`, `recovery_expires`) VALUES
(1, 'admin', '$2y$10$TCZLfbegzpRbPzoXvC25ZubMF2cQ.4xrp1LFNi6zEzlf4znQkfaLS', 1, NULL, NULL, NULL, '2025-07-16 11:35:10', 'active', 0, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `admin_logs`
--

CREATE TABLE `admin_logs` (
  `id` int(11) NOT NULL,
  `admin_id` int(11) DEFAULT NULL,
  `action` varchar(255) NOT NULL,
  `details` text DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `admin_roles`
--

CREATE TABLE `admin_roles` (
  `id` int(11) NOT NULL,
  `role_name` varchar(50) NOT NULL,
  `permissions` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admin_roles`
--

INSERT INTO `admin_roles` (`id`, `role_name`, `permissions`) VALUES
(1, 'Super Admin', '{\"all\":true}'),
(2, 'Editor', '{\"dashboard\":true,\"content\":true,\"media\":true,\"settings\":false,\"users\":false}'),
(3, 'Author', '{\"dashboard\":true,\"content\":{\"view\":true,\"add\":true,\"edit\":true,\"delete\":false},\"media\":{\"view\":true,\"add\":true,\"delete\":false}}');

-- --------------------------------------------------------

--
-- Table structure for table `artikel`
--

CREATE TABLE `artikel` (
  `id` int(11) NOT NULL,
  `id_kategori` int(11) NOT NULL,
  `judul` varchar(255) NOT NULL,
  `konten` text NOT NULL,
  `gambar_unggulan` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `tanggal_dibuat` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_featured` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `contact_messages`
--

CREATE TABLE `contact_messages` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `subject` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `status` enum('unread','read','replied','archived') DEFAULT 'unread',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dokumen`
--

CREATE TABLE `dokumen` (
  `id` int(11) NOT NULL,
  `nama` varchar(255) NOT NULL,
  `file` varchar(255) NOT NULL,
  `kategori` enum('Tugas','Sertifikat','CV','Lainnya') NOT NULL,
  `semester` int(11) DEFAULT NULL,
  `deskripsi` text DEFAULT NULL,
  `tanggal_upload` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dokumen`
--

INSERT INTO `dokumen` (`id`, `nama`, `file`, `kategori`, `semester`, `deskripsi`, `tanggal_upload`) VALUES
(4, 'CV Muhammad Alfatih', 'document_1752432909.pdf', 'CV', 0, '', '2025-07-13 18:55:09');

-- --------------------------------------------------------

--
-- Table structure for table `job_titles`
--

CREATE TABLE `job_titles` (
  `id` int(11) NOT NULL,
  `title` varchar(100) NOT NULL,
  `urutan` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `job_titles`
--

INSERT INTO `job_titles` (`id`, `title`, `urutan`) VALUES
(1, 'Web Developer', 1),
(2, 'UI/UX Designer', 2),
(3, 'Mahasiswa Informatika', 3),
(4, 'Problem Solver', 4);

-- --------------------------------------------------------

--
-- Table structure for table `kategori`
--

CREATE TABLE `kategori` (
  `id` int(11) NOT NULL,
  `nama_kategori` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `kategori`
--

INSERT INTO `kategori` (`id`, `nama_kategori`) VALUES
(3, 'Digital Marketing'),
(4, 'Programming'),
(2, 'UI/UX Design'),
(1, 'Web Development');

-- --------------------------------------------------------

--
-- Table structure for table `media_library`
--

CREATE TABLE `media_library` (
  `id` int(11) NOT NULL,
  `file_name` varchar(255) NOT NULL,
  `file_type` varchar(100) NOT NULL,
  `file_size` int(11) NOT NULL,
  `file_path` varchar(255) NOT NULL,
  `thumbnail_path` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `alt_text` varchar(255) DEFAULT NULL,
  `upload_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `uploaded_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` int(11) NOT NULL,
  `admin_id` int(11) DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `type` enum('info','success','warning','error') DEFAULT 'info',
  `is_read` tinyint(1) DEFAULT 0,
  `link` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `page_content`
--

CREATE TABLE `page_content` (
  `id` int(11) NOT NULL,
  `page` varchar(100) NOT NULL,
  `section` varchar(100) NOT NULL,
  `content` text DEFAULT NULL,
  `last_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `page_content`
--

INSERT INTO `page_content` (`id`, `page`, `section`, `content`, `last_updated`) VALUES
(1, 'home', 'hero_title', '', '2025-07-15 17:51:26'),
(2, 'home', 'hero_subtitle', 'MAHASISWA S1 INFORMATIKA', '2025-07-15 17:51:26'),
(3, 'home', 'hero_description', '', '2025-07-15 17:51:26'),
(4, 'home', 'projects_title', '', '2025-07-15 17:51:26'),
(5, 'home', 'projects_subtitle', '', '2025-07-15 17:51:26'),
(6, 'home', 'articles_title', '', '2025-07-15 17:51:26'),
(7, 'home', 'articles_subtitle', '', '2025-07-15 17:51:26');

-- --------------------------------------------------------

--
-- Table structure for table `pendidikan`
--

CREATE TABLE `pendidikan` (
  `id` int(11) NOT NULL,
  `institusi` varchar(255) NOT NULL,
  `gelar` varchar(255) NOT NULL,
  `bidang_studi` varchar(255) DEFAULT NULL,
  `tahun_mulai` year(4) NOT NULL,
  `tahun_selesai` year(4) DEFAULT NULL,
  `deskripsi` text DEFAULT NULL,
  `urutan` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pendidikan`
--

INSERT INTO `pendidikan` (`id`, `institusi`, `gelar`, `bidang_studi`, `tahun_mulai`, `tahun_selesai`, `deskripsi`, `urutan`) VALUES
(1, 'ITB Widya Gama Lumajang', 'S1 Informatika', 'Ilmu Komputer', '2023', NULL, 'Fokus pada pengembangan web, algoritma, dan database management.', 1),
(2, 'SMK Miftahul Islam Kunir', 'Teknik Komputer & Jaringan', 'Jaringan Komputer', '2019', '2022', 'Belajar tentang jaringan komputer, troubleshooting hardware, dan pemrograman dasar.', 2),
(3, 'MTs Salafiyah Al-Yasiny', 'MTs', 'Pendidikan Umum', '2016', '2019', 'Pendidikan menengah pertama dengan tambahan studi Islam.', 3),
(4, 'MI Salafiyah Al-Yasiny', 'MI', 'Pendidikan Dasar', '2010', '2016', 'Pendidikan dasar dengan kursus literasi komputer dasar.', 4);

-- --------------------------------------------------------

--
-- Table structure for table `pengaturan`
--

CREATE TABLE `pengaturan` (
  `id` int(11) NOT NULL,
  `kunci` varchar(50) NOT NULL,
  `nilai` text DEFAULT NULL,
  `deskripsi` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pengaturan`
--

INSERT INTO `pengaturan` (`id`, `kunci`, `nilai`, `deskripsi`) VALUES
(1, 'site_title', 'Portfolio Muhammad Alfatih', 'Judul website yang ditampilkan di tab browser'),
(2, 'meta_description', 'Portfolio professional Muhammad Alfatih, Mahasiswa Informatika\r\nITB WIDYAGAMA LUMAJANG', 'Deskripsi meta untuk SEO'),
(3, 'footer_text', '© 2025 Muhammad Alfatih. All Rights Reserved.', 'Teks yang ditampilkan di footer'),
(4, 'enable_particles', '1', 'Aktifkan efek particles di background (1=aktif, 0=nonaktif)'),
(5, 'theme_color', '#00e5ff', 'Warna utama theme website'),
(6, 'default_language', 'id', 'Bahasa default untuk website (id = Indonesia, en = English)'),
(7, 'theme', 'dark-orange', NULL),
(10, 'animation_speed', 'normal', NULL),
(16, 'tagline', '', NULL),
(18, 'email', 's.s.6624844@gmail.com', NULL),
(19, 'whatsapp', 'https://wa.me/6283188813237', NULL),
(20, 'github_url', 'https://github.com/alfaragatak87', NULL),
(21, 'linkedin_url', '', NULL),
(22, 'instagram_url', 'https://www.instagram.com/alfamuhammad___/', NULL),
(24, 'meta_keywords', 'portofolio muhammad alfatih', NULL),
(38, 'theme_color_type', 'solid', NULL),
(39, 'theme_color_solid', '#00fffb', NULL),
(40, 'theme_color_gradient_start', '#00e5ff', NULL),
(41, 'theme_color_gradient_end', '#6943d0', NULL),
(42, 'theme_color_gradient_angle', '90', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `profil`
--

CREATE TABLE `profil` (
  `id` int(11) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `whatsapp` varchar(20) NOT NULL,
  `github` varchar(255) NOT NULL,
  `profile_image` varchar(255) DEFAULT NULL,
  `summary` text DEFAULT NULL,
  `location` varchar(100) DEFAULT NULL,
  `current_status` varchar(100) DEFAULT NULL,
  `last_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `profil`
--

INSERT INTO `profil` (`id`, `nama`, `email`, `whatsapp`, `github`, `profile_image`, `summary`, `location`, `current_status`, `last_updated`) VALUES
(1, 'Muhammad Alfatih', 's.s.6624844@gmail.com', '+62 831-8881-3237', 'https://github.com/alfaragatak87', 'profile_1752498484.png', 'Web Developer dan UI/UX Designer dengan keahlian dalam PHP, JavaScript, dan teknologi web terkini. Saya menciptakan solusi digital yang tidak hanya berfungsi dengan baik, tetapi juga memberikan pengalaman pengguna yang optimal.', 'Lumajang, East Java, Indonesia', 'Mahasiswa', '2025-07-14 13:08:04');

-- --------------------------------------------------------

--
-- Table structure for table `proyek`
--

CREATE TABLE `proyek` (
  `id` int(11) NOT NULL,
  `judul` varchar(255) NOT NULL,
  `kategori` varchar(100) NOT NULL,
  `deskripsi` text NOT NULL,
  `gambar_proyek` varchar(255) NOT NULL,
  `link_proyek` varchar(255) DEFAULT NULL,
  `tanggal_dibuat` date NOT NULL,
  `is_featured` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `semester_data`
--

CREATE TABLE `semester_data` (
  `id` int(11) NOT NULL,
  `semester` int(11) NOT NULL,
  `mata_kuliah` varchar(255) NOT NULL,
  `deskripsi` text DEFAULT NULL,
  `file` varchar(255) DEFAULT NULL,
  `tanggal_upload` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `skills`
--

CREATE TABLE `skills` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `category` varchar(100) NOT NULL,
  `level` int(11) NOT NULL DEFAULT 70,
  `icon` varchar(255) DEFAULT NULL,
  `display_order` int(11) DEFAULT 0,
  `is_active` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `system_backups`
--

CREATE TABLE `system_backups` (
  `id` int(11) NOT NULL,
  `filename` varchar(255) NOT NULL,
  `size` int(11) NOT NULL,
  `backup_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_by` int(11) DEFAULT NULL,
  `notes` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `testimonials`
--

CREATE TABLE `testimonials` (
  `id` int(11) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `posisi` varchar(100) DEFAULT NULL,
  `perusahaan` varchar(100) DEFAULT NULL,
  `testimonial` text NOT NULL,
  `foto` varchar(255) DEFAULT NULL,
  `aktif` tinyint(1) DEFAULT 1,
  `tanggal_dibuat` timestamp NOT NULL DEFAULT current_timestamp(),
  `rating` int(11) NOT NULL DEFAULT 5
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `testimonials`
--

INSERT INTO `testimonials` (`id`, `nama`, `posisi`, `perusahaan`, `testimonial`, `foto`, `aktif`, `tanggal_dibuat`, `rating`) VALUES
(4, 'unknow', '', '', 'ngeri bosssss', '', 1, '2025-07-13 12:36:46', 5);

-- --------------------------------------------------------

--
-- Table structure for table `website_analytics`
--

CREATE TABLE `website_analytics` (
  `id` int(11) NOT NULL,
  `page_url` varchar(255) NOT NULL,
  `page_title` varchar(255) DEFAULT NULL,
  `visitor_ip` varchar(45) DEFAULT NULL,
  `visitor_country` varchar(100) DEFAULT NULL,
  `visitor_device` varchar(100) DEFAULT NULL,
  `visitor_browser` varchar(100) DEFAULT NULL,
  `visit_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `referrer` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `website_analytics`
--

INSERT INTO `website_analytics` (`id`, `page_url`, `page_title`, `visitor_ip`, `visitor_country`, `visitor_device`, `visitor_browser`, `visit_date`, `referrer`) VALUES
(1, '/portfolio-alfatih/pages/index.php', 'Home', '::1', NULL, 'Desktop', 'Chrome', '2025-07-14 04:25:09', 'http://localhost:8080/portfolio-alfatih/'),
(2, '/portfolio-alfatih/pages/about.php', 'About Me', '::1', NULL, 'Desktop', 'Chrome', '2025-07-14 04:25:12', 'http://localhost:8080/portfolio-alfatih/pages/index.php'),
(3, '/portfolio-alfatih/pages/projects.php', 'Projects', '::1', NULL, 'Desktop', 'Chrome', '2025-07-14 04:25:34', 'http://localhost:8080/portfolio-alfatih/pages/about.php'),
(4, '/portfolio-alfatih/pages/cv.php', 'Curriculum Vitae', '::1', NULL, 'Desktop', 'Chrome', '2025-07-14 04:25:36', 'http://localhost:8080/portfolio-alfatih/pages/projects.php'),
(5, '/portfolio-alfatih/pages/semester.php', 'Semester Data', '::1', NULL, 'Desktop', 'Chrome', '2025-07-14 04:25:43', 'http://localhost:8080/portfolio-alfatih/pages/cv.php'),
(6, '/portfolio-alfatih/pages/blog.php', 'Blog', '::1', NULL, 'Desktop', 'Chrome', '2025-07-14 04:25:46', 'http://localhost:8080/portfolio-alfatih/pages/semester.php'),
(7, '/portfolio-alfatih/pages/contact.php', 'Contact', '::1', NULL, 'Desktop', 'Chrome', '2025-07-14 04:25:48', 'http://localhost:8080/portfolio-alfatih/pages/blog.php'),
(8, '/portfolio-alfatih/pages/testimonials.php', 'Testimonials', '::1', NULL, 'Desktop', 'Chrome', '2025-07-14 04:25:50', 'http://localhost:8080/portfolio-alfatih/pages/contact.php'),
(9, '/portfolio-alfatih/pages/index.php', 'Home', '::1', NULL, 'Desktop', 'Chrome', '2025-07-14 04:39:34', 'http://localhost:8080/portfolio-alfatih/'),
(10, '/portfolio-alfatih/pages/about.php', 'About Me', '::1', NULL, 'Desktop', 'Chrome', '2025-07-14 04:39:37', 'http://localhost:8080/portfolio-alfatih/pages/index.php'),
(11, '/portfolio-alfatih/pages/projects.php', 'Projects', '::1', NULL, 'Desktop', 'Chrome', '2025-07-14 04:39:39', 'http://localhost:8080/portfolio-alfatih/pages/about.php'),
(12, '/portfolio-alfatih/pages/cv.php', 'Curriculum Vitae', '::1', NULL, 'Desktop', 'Chrome', '2025-07-14 04:39:42', 'http://localhost:8080/portfolio-alfatih/pages/projects.php'),
(13, '/portfolio-alfatih/pages/semester.php', 'Semester Data', '::1', NULL, 'Desktop', 'Chrome', '2025-07-14 04:39:44', 'http://localhost:8080/portfolio-alfatih/pages/cv.php'),
(14, '/portfolio-alfatih/pages/blog.php', 'Blog', '::1', NULL, 'Desktop', 'Chrome', '2025-07-14 04:39:47', 'http://localhost:8080/portfolio-alfatih/pages/semester.php'),
(15, '/portfolio-alfatih/pages/contact.php', 'Contact', '::1', NULL, 'Desktop', 'Chrome', '2025-07-14 04:39:49', 'http://localhost:8080/portfolio-alfatih/pages/blog.php'),
(16, '/portfolio-alfatih/pages/cv.php', 'Curriculum Vitae', '::1', NULL, 'Desktop', 'Chrome', '2025-07-14 04:42:10', 'http://localhost:8080/portfolio-alfatih/pages/contact.php'),
(17, '/portfolio-alfatih/pages/projects.php', 'Projects', '::1', NULL, 'Desktop', 'Chrome', '2025-07-14 04:42:12', 'http://localhost:8080/portfolio-alfatih/pages/cv.php'),
(18, '/portfolio-alfatih/pages/index.php', 'Home', '::1', NULL, 'Desktop', 'Chrome', '2025-07-14 04:42:13', 'http://localhost:8080/portfolio-alfatih/pages/projects.php'),
(19, '/portfolio-alfatih/pages/about.php', 'About Me', '::1', NULL, 'Desktop', 'Chrome', '2025-07-14 04:43:09', 'http://localhost:8080/portfolio-alfatih/pages/index.php'),
(20, '/portfolio-alfatih/pages/index.php', 'Home', '::1', NULL, 'Desktop', 'Chrome', '2025-07-14 04:53:58', 'http://localhost:8080/portfolio-alfatih/index.php'),
(21, '/portfolio-alfatih/pages/projects.php', 'Projects', '::1', NULL, 'Desktop', 'Chrome', '2025-07-14 04:54:03', 'http://localhost:8080/portfolio-alfatih/pages/index.php'),
(22, '/portfolio-alfatih/pages/cv.php', 'Curriculum Vitae', '::1', NULL, 'Desktop', 'Chrome', '2025-07-14 04:54:05', 'http://localhost:8080/portfolio-alfatih/pages/projects.php'),
(23, '/portfolio-alfatih/pages/semester.php', 'Semester Data', '::1', NULL, 'Desktop', 'Chrome', '2025-07-14 04:54:06', 'http://localhost:8080/portfolio-alfatih/pages/cv.php'),
(24, '/portfolio-alfatih/pages/cv.php', 'Curriculum Vitae', '::1', NULL, 'Desktop', 'Chrome', '2025-07-14 04:54:08', 'http://localhost:8080/portfolio-alfatih/pages/semester.php'),
(25, '/portfolio-alfatih/pages/semester.php', 'Semester Data', '::1', NULL, 'Desktop', 'Chrome', '2025-07-14 04:54:13', 'http://localhost:8080/portfolio-alfatih/pages/cv.php'),
(26, '/portfolio-alfatih/pages/blog.php', 'Blog', '::1', NULL, 'Desktop', 'Chrome', '2025-07-14 04:54:15', 'http://localhost:8080/portfolio-alfatih/pages/semester.php'),
(27, '/portfolio-alfatih/pages/contact.php', 'Contact', '::1', NULL, 'Desktop', 'Chrome', '2025-07-14 04:54:17', 'http://localhost:8080/portfolio-alfatih/pages/blog.php'),
(28, '/portfolio-alfatih/pages/semester.php', 'Semester Data', '::1', NULL, 'Desktop', 'Chrome', '2025-07-14 04:54:18', 'http://localhost:8080/portfolio-alfatih/pages/contact.php'),
(29, '/portfolio-alfatih/pages/about.php', 'About Me', '::1', NULL, 'Desktop', 'Chrome', '2025-07-14 04:54:20', 'http://localhost:8080/portfolio-alfatih/pages/semester.php'),
(30, '/portfolio-alfatih/pages/projects.php', 'Projects', '::1', NULL, 'Desktop', 'Chrome', '2025-07-14 04:54:22', 'http://localhost:8080/portfolio-alfatih/pages/about.php'),
(31, '/portfolio-alfatih/pages/about.php', 'About Me', '::1', NULL, 'Desktop', 'Chrome', '2025-07-14 04:54:23', 'http://localhost:8080/portfolio-alfatih/pages/projects.php'),
(32, '/portfolio-alfatih/pages/projects.php', 'Projects', '::1', NULL, 'Desktop', 'Chrome', '2025-07-14 04:54:34', 'http://localhost:8080/portfolio-alfatih/pages/about.php'),
(33, '/portfolio-alfatih/pages/blog.php', 'Blog', '::1', NULL, 'Desktop', 'Chrome', '2025-07-14 04:55:02', 'http://localhost:8080/portfolio-alfatih/pages/projects.php'),
(34, '/portfolio-alfatih/pages/contact.php', 'Contact', '::1', NULL, 'Desktop', 'Chrome', '2025-07-14 04:55:12', 'http://localhost:8080/portfolio-alfatih/pages/blog.php'),
(35, '/portfolio-alfatih/pages/testimonials.php', 'Testimonials', '::1', NULL, 'Desktop', 'Chrome', '2025-07-14 04:55:16', 'http://localhost:8080/portfolio-alfatih/pages/contact.php'),
(36, '/portfolio-alfatih/pages/about.php', 'About Me', '::1', NULL, 'Desktop', 'Chrome', '2025-07-14 04:55:18', 'http://localhost:8080/portfolio-alfatih/pages/testimonials.php'),
(37, '/portfolio-alfatih/pages/index.php', 'Home', '::1', NULL, 'Desktop', 'Chrome', '2025-07-14 08:55:43', 'http://localhost:8080/portfolio-alfatih/index.php'),
(38, '/portfolio-alfatih/pages/index.php', 'Home', '::1', NULL, 'Desktop', 'Chrome', '2025-07-14 11:52:11', 'http://localhost:8080/portfolio-alfatih/index.php'),
(39, '/portfolio-alfatih/pages/blog.php', 'Blog', '::1', NULL, 'Desktop', 'Chrome', '2025-07-14 11:52:19', 'http://localhost:8080/portfolio-alfatih/pages/index.php'),
(40, '/portfolio-alfatih/pages/semester.php', 'Semester Data', '::1', NULL, 'Desktop', 'Chrome', '2025-07-14 11:52:21', 'http://localhost:8080/portfolio-alfatih/pages/blog.php'),
(41, '/portfolio-alfatih/pages/cv.php', 'Curriculum Vitae', '::1', NULL, 'Desktop', 'Chrome', '2025-07-14 11:52:22', 'http://localhost:8080/portfolio-alfatih/pages/semester.php'),
(42, '/portfolio-alfatih/pages/projects.php', 'Projects', '::1', NULL, 'Desktop', 'Chrome', '2025-07-14 11:52:24', 'http://localhost:8080/portfolio-alfatih/pages/cv.php'),
(43, '/portfolio-alfatih/pages/cv.php', 'Curriculum Vitae', '::1', NULL, 'Desktop', 'Chrome', '2025-07-14 11:52:25', 'http://localhost:8080/portfolio-alfatih/pages/projects.php'),
(44, '/portfolio-alfatih/pages/semester.php', 'Semester Data', '::1', NULL, 'Desktop', 'Chrome', '2025-07-14 11:52:26', 'http://localhost:8080/portfolio-alfatih/pages/cv.php'),
(45, '/portfolio-alfatih/pages/blog.php', 'Blog', '::1', NULL, 'Desktop', 'Chrome', '2025-07-14 11:52:27', 'http://localhost:8080/portfolio-alfatih/pages/semester.php'),
(46, '/portfolio-alfatih/pages/contact.php', 'Contact', '::1', NULL, 'Desktop', 'Chrome', '2025-07-14 11:52:28', 'http://localhost:8080/portfolio-alfatih/pages/blog.php'),
(47, '/portfolio-alfatih/pages/testimonials.php', 'Testimonials', '::1', NULL, 'Desktop', 'Chrome', '2025-07-14 11:52:30', 'http://localhost:8080/portfolio-alfatih/pages/contact.php'),
(48, '/portfolio-alfatih/pages/projects.php', 'Projects', '::1', NULL, 'Desktop', 'Chrome', '2025-07-14 11:52:32', 'http://localhost:8080/portfolio-alfatih/pages/testimonials.php'),
(49, '/portfolio-alfatih/pages/about.php', 'About Me', '::1', NULL, 'Desktop', 'Chrome', '2025-07-14 11:52:36', 'http://localhost:8080/portfolio-alfatih/pages/projects.php'),
(50, '/portfolio-alfatih/pages/index.php', 'Home', '::1', NULL, 'Desktop', 'Chrome', '2025-07-14 12:58:23', 'http://localhost:8080/portfolio-alfatih/'),
(51, '/portfolio-alfatih/pages/about.php', 'About Me', '::1', NULL, 'Desktop', 'Chrome', '2025-07-14 12:58:33', 'http://localhost:8080/portfolio-alfatih/pages/index.php'),
(52, '/portfolio-alfatih/pages/projects.php', 'Projects', '::1', NULL, 'Desktop', 'Chrome', '2025-07-14 12:58:34', 'http://localhost:8080/portfolio-alfatih/pages/about.php'),
(53, '/portfolio-alfatih/pages/cv.php', 'Curriculum Vitae', '::1', NULL, 'Desktop', 'Chrome', '2025-07-14 12:58:35', 'http://localhost:8080/portfolio-alfatih/pages/projects.php'),
(54, '/portfolio-alfatih/pages/semester.php', 'Semester Data', '::1', NULL, 'Desktop', 'Chrome', '2025-07-14 12:58:36', 'http://localhost:8080/portfolio-alfatih/pages/cv.php'),
(55, '/portfolio-alfatih/pages/blog.php', 'Blog', '::1', NULL, 'Desktop', 'Chrome', '2025-07-14 12:58:37', 'http://localhost:8080/portfolio-alfatih/pages/semester.php'),
(56, '/portfolio-alfatih/pages/contact.php', 'Contact', '::1', NULL, 'Desktop', 'Chrome', '2025-07-14 12:58:38', 'http://localhost:8080/portfolio-alfatih/pages/blog.php'),
(57, '/portfolio-alfatih/pages/testimonials.php', 'Testimonials', '::1', NULL, 'Desktop', 'Chrome', '2025-07-14 12:58:39', 'http://localhost:8080/portfolio-alfatih/pages/contact.php'),
(58, '/portfolio-alfatih/pages/index.php', 'Home', '::1', NULL, 'Desktop', 'Chrome', '2025-07-14 13:08:11', 'http://localhost:8080/portfolio-alfatih/'),
(59, '/portfolio-alfatih/pages/about.php', 'About Me', '::1', NULL, 'Desktop', 'Chrome', '2025-07-14 13:08:17', 'http://localhost:8080/portfolio-alfatih/pages/index.php'),
(60, '/portfolio-alfatih/pages/projects.php', 'Projects', '::1', NULL, 'Desktop', 'Chrome', '2025-07-14 13:08:35', 'http://localhost:8080/portfolio-alfatih/pages/about.php'),
(61, '/portfolio-alfatih/pages/semester.php', 'Semester Data', '::1', NULL, 'Desktop', 'Chrome', '2025-07-14 13:08:36', 'http://localhost:8080/portfolio-alfatih/pages/projects.php'),
(62, '/portfolio-alfatih/pages/cv.php', 'Curriculum Vitae', '::1', NULL, 'Desktop', 'Chrome', '2025-07-14 13:08:37', 'http://localhost:8080/portfolio-alfatih/pages/semester.php'),
(63, '/portfolio-alfatih/pages/semester.php', 'Semester Data', '::1', NULL, 'Desktop', 'Chrome', '2025-07-14 13:08:40', 'http://localhost:8080/portfolio-alfatih/pages/cv.php'),
(64, '/portfolio-alfatih/pages/blog.php', 'Blog', '::1', NULL, 'Desktop', 'Chrome', '2025-07-14 13:08:41', 'http://localhost:8080/portfolio-alfatih/pages/semester.php'),
(65, '/portfolio-alfatih/pages/contact.php', 'Contact', '::1', NULL, 'Desktop', 'Chrome', '2025-07-14 13:08:42', 'http://localhost:8080/portfolio-alfatih/pages/blog.php'),
(66, '/portfolio-alfatih/pages/testimonials.php', 'Testimonials', '::1', NULL, 'Desktop', 'Chrome', '2025-07-14 13:08:44', 'http://localhost:8080/portfolio-alfatih/pages/contact.php'),
(67, '/portfolio-alfatih/pages/index.php', 'Home', '::1', NULL, 'Desktop', 'Chrome', '2025-07-14 13:10:14', 'http://localhost:8080/portfolio-alfatih/'),
(68, '/portfolio-alfatih/pages/projects.php', 'Projects', '::1', NULL, 'Desktop', 'Chrome', '2025-07-14 13:10:21', 'http://localhost:8080/portfolio-alfatih/pages/index.php'),
(69, '/portfolio-alfatih/pages/projects.php', 'Projects', '::1', NULL, 'Desktop', 'Chrome', '2025-07-14 13:10:24', 'http://localhost:8080/portfolio-alfatih/pages/projects.php'),
(70, '/portfolio-alfatih/pages/about.php', 'About Me', '::1', NULL, 'Desktop', 'Chrome', '2025-07-14 13:10:25', 'http://localhost:8080/portfolio-alfatih/pages/projects.php'),
(71, '/portfolio-alfatih/pages/cv.php', 'Curriculum Vitae', '::1', NULL, 'Desktop', 'Chrome', '2025-07-14 13:10:27', 'http://localhost:8080/portfolio-alfatih/pages/about.php'),
(72, '/portfolio-alfatih/pages/projects.php', 'Projects', '::1', NULL, 'Desktop', 'Chrome', '2025-07-14 13:10:28', 'http://localhost:8080/portfolio-alfatih/pages/cv.php'),
(73, '/portfolio-alfatih/pages/semester.php', 'Semester Data', '::1', NULL, 'Desktop', 'Chrome', '2025-07-14 13:10:30', 'http://localhost:8080/portfolio-alfatih/pages/projects.php'),
(74, '/portfolio-alfatih/pages/blog.php', 'Blog', '::1', NULL, 'Desktop', 'Chrome', '2025-07-14 13:10:32', 'http://localhost:8080/portfolio-alfatih/pages/semester.php'),
(75, '/portfolio-alfatih/pages/contact.php', 'Contact', '::1', NULL, 'Desktop', 'Chrome', '2025-07-14 13:10:34', 'http://localhost:8080/portfolio-alfatih/pages/blog.php'),
(76, '/portfolio-alfatih/pages/testimonials.php', 'Testimonials', '::1', NULL, 'Desktop', 'Chrome', '2025-07-14 13:10:35', 'http://localhost:8080/portfolio-alfatih/pages/contact.php'),
(77, '/portfolio-alfatih/pages/index.php', 'Home', '::1', NULL, 'Desktop', 'Chrome', '2025-07-14 13:10:36', 'http://localhost:8080/portfolio-alfatih/pages/testimonials.php'),
(78, '/portfolio-alfatih/pages/index.php', 'Home', '::1', NULL, 'Desktop', 'Chrome', '2025-07-14 13:10:57', 'http://localhost:8080/portfolio-alfatih/pages/index.php'),
(79, '/portfolio-alfatih/pages/index.php', 'Home', '::1', NULL, 'Desktop', 'Chrome', '2025-07-14 13:10:58', 'http://localhost:8080/portfolio-alfatih/pages/index.php'),
(80, '/portfolio-alfatih/pages/index.php?lang=en', 'Home', '::1', NULL, 'Desktop', 'Chrome', '2025-07-14 13:11:04', 'http://localhost:8080/portfolio-alfatih/pages/index.php'),
(81, '/portfolio-alfatih/pages/about.php', 'About Me', '::1', NULL, 'Desktop', 'Chrome', '2025-07-14 13:11:11', 'http://localhost:8080/portfolio-alfatih/pages/index.php?lang=en'),
(82, '/portfolio-alfatih/pages/cv.php', 'Curriculum Vitae', '::1', NULL, 'Desktop', 'Chrome', '2025-07-14 13:11:24', 'http://localhost:8080/portfolio-alfatih/pages/about.php'),
(83, '/portfolio-alfatih/pages/semester.php', 'Semester Data', '::1', NULL, 'Desktop', 'Chrome', '2025-07-14 13:11:26', 'http://localhost:8080/portfolio-alfatih/pages/cv.php'),
(84, '/portfolio-alfatih/pages/blog.php', 'Blog', '::1', NULL, 'Desktop', 'Chrome', '2025-07-14 13:11:27', 'http://localhost:8080/portfolio-alfatih/pages/semester.php'),
(85, '/portfolio-alfatih/pages/contact.php', 'Contact', '::1', NULL, 'Desktop', 'Chrome', '2025-07-14 13:11:28', 'http://localhost:8080/portfolio-alfatih/pages/blog.php'),
(86, '/portfolio-alfatih/pages/index.php', 'Home', '::1', NULL, 'Desktop', 'Chrome', '2025-07-15 15:26:41', 'http://localhost:8080/portfolio-alfatih/index.php'),
(87, '/portfolio-alfatih/pages/about.php', 'About Me', '::1', NULL, 'Desktop', 'Chrome', '2025-07-15 15:26:43', 'http://localhost:8080/portfolio-alfatih/pages/index.php'),
(88, '/portfolio-alfatih/pages/projects.php', 'Projects', '::1', NULL, 'Desktop', 'Chrome', '2025-07-15 15:26:43', 'http://localhost:8080/portfolio-alfatih/pages/about.php'),
(89, '/portfolio-alfatih/pages/about.php', 'About Me', '::1', NULL, 'Desktop', 'Chrome', '2025-07-15 15:26:44', 'http://localhost:8080/portfolio-alfatih/pages/projects.php'),
(90, '/portfolio-alfatih/pages/index.php', 'Home', '::1', NULL, 'Desktop', 'Chrome', '2025-07-15 16:18:58', 'http://localhost:8080/portfolio-alfatih/'),
(91, '/portfolio-alfatih/pages/about.php', 'About Me', '::1', NULL, 'Desktop', 'Chrome', '2025-07-15 16:19:10', 'http://localhost:8080/portfolio-alfatih/pages/index.php'),
(92, '/portfolio-alfatih/pages/index.php', 'Home', '::1', NULL, 'Desktop', 'Chrome', '2025-07-15 16:19:37', 'http://localhost:8080/portfolio-alfatih/'),
(93, '/portfolio-alfatih/pages/about.php', 'About Me', '::1', NULL, 'Desktop', 'Chrome', '2025-07-15 16:19:49', 'http://localhost:8080/portfolio-alfatih/pages/index.php'),
(94, '/portfolio-alfatih/pages/about.php', 'About Me', '::1', NULL, 'Desktop', 'Chrome', '2025-07-15 16:55:35', 'http://localhost:8080/portfolio-alfatih/pages/index.php'),
(95, '/portfolio-alfatih/pages/projects.php', 'Projects', '::1', NULL, 'Desktop', 'Chrome', '2025-07-15 16:55:52', 'http://localhost:8080/portfolio-alfatih/pages/about.php'),
(96, '/portfolio-alfatih/pages/cv.php', 'Curriculum Vitae', '::1', NULL, 'Desktop', 'Chrome', '2025-07-15 16:55:56', 'http://localhost:8080/portfolio-alfatih/pages/projects.php'),
(97, '/portfolio-alfatih/pages/semester.php', 'Semester Data', '::1', NULL, 'Desktop', 'Chrome', '2025-07-15 16:55:59', 'http://localhost:8080/portfolio-alfatih/pages/cv.php'),
(98, '/portfolio-alfatih/pages/index.php', 'Home', '::1', NULL, 'Desktop', 'Chrome', '2025-07-15 16:56:05', 'http://localhost:8080/portfolio-alfatih/pages/semester.php'),
(99, '/portfolio-alfatih/pages/index.php', 'Home', '::1', NULL, 'Desktop', 'Chrome', '2025-07-15 16:56:56', 'http://localhost:8080/portfolio-alfatih/'),
(100, '/portfolio-alfatih/pages/about.php', 'About Me', '::1', NULL, 'Desktop', 'Chrome', '2025-07-15 16:57:02', 'http://localhost:8080/portfolio-alfatih/pages/index.php'),
(101, '/portfolio-alfatih/pages/projects.php', 'Projects', '::1', NULL, 'Desktop', 'Chrome', '2025-07-15 16:57:04', 'http://localhost:8080/portfolio-alfatih/pages/about.php'),
(102, '/portfolio-alfatih/pages/cv.php', 'Curriculum Vitae', '::1', NULL, 'Desktop', 'Chrome', '2025-07-15 16:57:07', 'http://localhost:8080/portfolio-alfatih/pages/projects.php'),
(103, '/portfolio-alfatih/pages/index.php', 'Home', '::1', NULL, 'Desktop', 'Chrome', '2025-07-15 17:00:17', 'http://localhost:8080/portfolio-alfatih/'),
(104, '/portfolio-alfatih/pages/testimonials.php', 'Testimonials', '::1', NULL, 'Desktop', 'Chrome', '2025-07-15 17:00:19', 'http://localhost:8080/portfolio-alfatih/pages/index.php'),
(105, '/portfolio-alfatih/pages/contact.php', 'Contact', '::1', NULL, 'Desktop', 'Chrome', '2025-07-15 17:00:20', 'http://localhost:8080/portfolio-alfatih/pages/testimonials.php'),
(106, '/portfolio-alfatih/pages/blog.php', 'Blog', '::1', NULL, 'Desktop', 'Chrome', '2025-07-15 17:00:20', 'http://localhost:8080/portfolio-alfatih/pages/contact.php'),
(107, '/portfolio-alfatih/pages/index.php', 'Home', '::1', NULL, 'Desktop', 'Chrome', '2025-07-15 17:51:30', 'http://localhost:8080/portfolio-alfatih/'),
(108, '/portfolio-alfatih/pages/projects.php', 'Projects', '::1', NULL, 'Desktop', 'Chrome', '2025-07-15 17:51:34', 'http://localhost:8080/portfolio-alfatih/pages/index.php'),
(109, '/portfolio-alfatih/pages/about.php', 'About Me', '::1', NULL, 'Desktop', 'Chrome', '2025-07-15 17:51:37', 'http://localhost:8080/portfolio-alfatih/pages/projects.php'),
(110, '/portfolio-alfatih/pages/index.php', 'Home', '::1', NULL, 'Desktop', 'Chrome', '2025-07-15 17:51:38', 'http://localhost:8080/portfolio-alfatih/pages/about.php'),
(111, '/portfolio-alfatih/pages/about.php', 'About Me', '::1', NULL, 'Desktop', 'Chrome', '2025-07-15 17:51:39', 'http://localhost:8080/portfolio-alfatih/pages/index.php'),
(112, '/portfolio-alfatih/pages/index.php', 'Home', '::1', NULL, 'Desktop', 'Chrome', '2025-07-15 17:51:41', 'http://localhost:8080/portfolio-alfatih/pages/about.php'),
(113, '/portfolio-alfatih/pages/projects.php', 'Projects', '::1', NULL, 'Desktop', 'Chrome', '2025-07-15 17:51:45', 'http://localhost:8080/portfolio-alfatih/pages/index.php'),
(114, '/portfolio-alfatih/pages/about.php', 'About Me', '::1', NULL, 'Desktop', 'Chrome', '2025-07-15 17:51:46', 'http://localhost:8080/portfolio-alfatih/pages/projects.php'),
(115, '/portfolio-alfatih/pages/projects.php', 'Projects', '::1', NULL, 'Desktop', 'Chrome', '2025-07-15 17:51:55', 'http://localhost:8080/portfolio-alfatih/pages/about.php'),
(116, '/portfolio-alfatih/pages/cv.php', 'Curriculum Vitae', '::1', NULL, 'Desktop', 'Chrome', '2025-07-15 17:51:56', 'http://localhost:8080/portfolio-alfatih/pages/projects.php'),
(117, '/portfolio-alfatih/pages/semester.php', 'Semester Data', '::1', NULL, 'Desktop', 'Chrome', '2025-07-15 17:51:58', 'http://localhost:8080/portfolio-alfatih/pages/cv.php'),
(118, '/portfolio-alfatih/pages/blog.php', 'Blog', '::1', NULL, 'Desktop', 'Chrome', '2025-07-15 17:52:00', 'http://localhost:8080/portfolio-alfatih/pages/semester.php'),
(119, '/portfolio-alfatih/pages/projects.php', 'Projects', '::1', NULL, 'Desktop', 'Chrome', '2025-07-15 17:52:00', 'http://localhost:8080/portfolio-alfatih/pages/blog.php'),
(120, '/portfolio-alfatih/pages/about.php', 'About Me', '::1', NULL, 'Desktop', 'Chrome', '2025-07-15 17:52:01', 'http://localhost:8080/portfolio-alfatih/pages/projects.php'),
(121, '/portfolio-alfatih/pages/index.php', 'Home', '::1', NULL, 'Desktop', 'Chrome', '2025-07-15 17:52:11', 'http://localhost:8080/portfolio-alfatih/pages/about.php'),
(122, '/portfolio-alfatih/pages/index.php', 'Home', '::1', NULL, 'Desktop', 'Chrome', '2025-07-15 17:53:07', 'http://localhost:8080/portfolio-alfatih/pages/index.php'),
(123, '/portfolio-alfatih/pages/index.php', 'Home', '::1', NULL, 'Desktop', 'Chrome', '2025-07-15 17:53:21', 'http://localhost:8080/portfolio-alfatih/index.php'),
(124, '/portfolio-alfatih/pages/index.php', 'Home', '::1', NULL, 'Desktop', 'Chrome', '2025-07-15 18:15:35', 'http://localhost:8080/portfolio-alfatih/index.php'),
(125, '/portfolio-alfatih/pages/index.php', 'Home', '::1', NULL, 'Desktop', 'Chrome', '2025-07-15 18:15:39', 'http://localhost:8080/portfolio-alfatih/index.php'),
(126, '/portfolio-alfatih/pages/index.php', 'Home', '::1', NULL, 'Desktop', 'Chrome', '2025-07-15 18:15:40', 'http://localhost:8080/portfolio-alfatih/index.php'),
(127, '/portfolio-alfatih/pages/index.php', 'Home', '::1', NULL, 'Desktop', 'Chrome', '2025-07-15 18:15:41', 'http://localhost:8080/portfolio-alfatih/index.php'),
(128, '/portfolio-alfatih/pages/index.php', 'Home', '::1', NULL, 'Desktop', 'Chrome', '2025-07-15 18:15:58', 'http://localhost:8080/portfolio-alfatih/index.php'),
(129, '/portfolio-alfatih/pages/index.php', 'Beranda', '::1', NULL, 'Desktop', 'Chrome', '2025-07-15 18:16:41', 'http://localhost:8080/portfolio-alfatih/index.php'),
(130, '/portfolio-alfatih/pages/about.php', 'About Me', '::1', NULL, 'Desktop', 'Chrome', '2025-07-15 18:16:54', 'http://localhost:8080/portfolio-alfatih/pages/index.php'),
(131, '/portfolio-alfatih/pages/index.php', 'Beranda', '::1', NULL, 'Desktop', 'Chrome', '2025-07-15 18:16:56', 'http://localhost:8080/portfolio-alfatih/pages/about.php'),
(132, '/portfolio-alfatih/pages/projects.php', 'Projects', '::1', NULL, 'Desktop', 'Chrome', '2025-07-15 18:17:18', 'http://localhost:8080/portfolio-alfatih/pages/index.php'),
(133, '/portfolio-alfatih/pages/about.php', 'About Me', '::1', NULL, 'Desktop', 'Chrome', '2025-07-15 18:17:21', 'http://localhost:8080/portfolio-alfatih/pages/projects.php'),
(134, '/portfolio-alfatih/pages/index.php', 'Beranda', '::1', NULL, 'Desktop', 'Chrome', '2025-07-15 18:17:24', 'http://localhost:8080/portfolio-alfatih/pages/about.php'),
(135, '/portfolio-alfatih/pages/index.php', 'Beranda', '::1', NULL, 'Desktop', 'Chrome', '2025-07-15 18:25:40', 'http://localhost:8080/portfolio-alfatih/pages/about.php'),
(136, '/portfolio-alfatih/pages/index.php', 'Beranda', '::1', NULL, 'Desktop', 'Chrome', '2025-07-15 18:25:44', 'http://localhost:8080/portfolio-alfatih/pages/about.php'),
(137, '/portfolio-alfatih/pages/index.php', 'Beranda', '::1', NULL, 'Desktop', 'Chrome', '2025-07-15 18:25:45', 'http://localhost:8080/portfolio-alfatih/pages/about.php'),
(138, '/portfolio-alfatih/pages/index.php', 'Beranda', '::1', NULL, 'Desktop', 'Chrome', '2025-07-15 18:33:58', 'http://localhost:8080/portfolio-alfatih/pages/index.php'),
(139, '/portfolio-alfatih/pages/index.php', 'Beranda', '::1', NULL, 'Desktop', 'Chrome', '2025-07-15 18:34:01', 'http://localhost:8080/portfolio-alfatih/pages/index.php'),
(140, '/portfolio-alfatih/pages/index.php', 'Beranda', '::1', NULL, 'Desktop', 'Chrome', '2025-07-15 18:34:06', 'http://localhost:8080/portfolio-alfatih/pages/index.php'),
(141, '/portfolio-alfatih/pages/about.php', 'About Me', '::1', NULL, 'Desktop', 'Chrome', '2025-07-15 18:34:33', 'http://localhost:8080/portfolio-alfatih/pages/index.php'),
(142, '/portfolio-alfatih/pages/projects.php', 'Projects', '::1', NULL, 'Desktop', 'Chrome', '2025-07-15 18:34:34', 'http://localhost:8080/portfolio-alfatih/pages/about.php'),
(143, '/portfolio-alfatih/pages/cv.php', 'Curriculum Vitae', '::1', NULL, 'Desktop', 'Chrome', '2025-07-15 18:34:34', 'http://localhost:8080/portfolio-alfatih/pages/projects.php'),
(144, '/portfolio-alfatih/pages/semester.php', 'Semester Data', '::1', NULL, 'Desktop', 'Chrome', '2025-07-15 18:34:35', 'http://localhost:8080/portfolio-alfatih/pages/cv.php'),
(145, '/portfolio-alfatih/pages/blog.php', 'Blog', '::1', NULL, 'Desktop', 'Chrome', '2025-07-15 18:34:36', 'http://localhost:8080/portfolio-alfatih/pages/semester.php'),
(146, '/portfolio-alfatih/pages/contact.php', 'Contact', '::1', NULL, 'Desktop', 'Chrome', '2025-07-15 18:34:36', 'http://localhost:8080/portfolio-alfatih/pages/blog.php'),
(147, '/portfolio-alfatih/pages/testimonials.php', 'Testimonials', '::1', NULL, 'Desktop', 'Chrome', '2025-07-15 18:34:37', 'http://localhost:8080/portfolio-alfatih/pages/contact.php'),
(148, '/portfolio-alfatih/pages/about.php', 'About Me', '::1', NULL, 'Desktop', 'Chrome', '2025-07-15 18:34:38', 'http://localhost:8080/portfolio-alfatih/pages/testimonials.php'),
(149, '/portfolio-alfatih/pages/index.php', 'Beranda', '::1', NULL, 'Desktop', 'Chrome', '2025-07-15 18:49:28', 'http://localhost:8080/portfolio-alfatih/pages/about.php'),
(150, '/portfolio-alfatih/pages/index.php', 'Beranda', '::1', NULL, 'Desktop', 'Chrome', '2025-07-15 18:49:30', 'http://localhost:8080/portfolio-alfatih/pages/about.php'),
(151, '/portfolio-alfatih/pages/index.php', 'Beranda', '::1', NULL, 'Desktop', 'Chrome', '2025-07-15 18:49:34', 'http://localhost:8080/portfolio-alfatih/pages/about.php'),
(152, '/portfolio-alfatih/pages/about.php', 'About Me', '::1', NULL, 'Desktop', 'Chrome', '2025-07-15 19:04:38', 'http://localhost:8080/portfolio-alfatih/pages/index.php'),
(153, '/portfolio-alfatih/pages/projects.php', 'Projects', '::1', NULL, 'Desktop', 'Chrome', '2025-07-15 19:04:55', 'http://localhost:8080/portfolio-alfatih/pages/about.php'),
(154, '/portfolio-alfatih/pages/cv.php', 'Curriculum Vitae', '::1', NULL, 'Desktop', 'Chrome', '2025-07-15 19:04:58', 'http://localhost:8080/portfolio-alfatih/pages/projects.php'),
(155, '/portfolio-alfatih/pages/semester.php', 'Semester Data', '::1', NULL, 'Desktop', 'Chrome', '2025-07-15 19:04:59', 'http://localhost:8080/portfolio-alfatih/pages/cv.php'),
(156, '/portfolio-alfatih/pages/blog.php', 'Blog', '::1', NULL, 'Desktop', 'Chrome', '2025-07-15 19:05:00', 'http://localhost:8080/portfolio-alfatih/pages/semester.php'),
(157, '/portfolio-alfatih/pages/contact.php', 'Contact', '::1', NULL, 'Desktop', 'Chrome', '2025-07-15 19:05:01', 'http://localhost:8080/portfolio-alfatih/pages/blog.php'),
(158, '/portfolio-alfatih/pages/testimonials.php', 'Testimonials', '::1', NULL, 'Desktop', 'Chrome', '2025-07-15 19:05:02', 'http://localhost:8080/portfolio-alfatih/pages/contact.php'),
(159, '/portfolio-alfatih/pages/index.php', 'Beranda', '::1', NULL, 'Desktop', 'Chrome', '2025-07-15 19:05:03', 'http://localhost:8080/portfolio-alfatih/pages/testimonials.php'),
(160, '/portfolio-alfatih/pages/index.php', 'Beranda', '::1', NULL, 'Desktop', 'Chrome', '2025-07-15 19:17:17', 'http://localhost:8080/portfolio-alfatih/pages/testimonials.php'),
(161, '/portfolio-alfatih/pages/about.php', 'About Me', '::1', NULL, 'Desktop', 'Chrome', '2025-07-15 19:17:20', 'http://localhost:8080/portfolio-alfatih/pages/index.php'),
(162, '/portfolio-alfatih/pages/index.php', 'Beranda', '::1', NULL, 'Desktop', 'Chrome', '2025-07-15 19:17:21', 'http://localhost:8080/portfolio-alfatih/pages/about.php'),
(163, '/portfolio-alfatih/pages/about.php', 'About Me', '::1', NULL, 'Desktop', 'Chrome', '2025-07-15 19:17:58', 'http://localhost:8080/portfolio-alfatih/pages/index.php'),
(164, '/portfolio-alfatih/pages/projects.php', 'Projects', '::1', NULL, 'Desktop', 'Chrome', '2025-07-15 19:18:03', 'http://localhost:8080/portfolio-alfatih/pages/about.php'),
(165, '/portfolio-alfatih/pages/cv.php', 'Curriculum Vitae', '::1', NULL, 'Desktop', 'Chrome', '2025-07-15 19:18:04', 'http://localhost:8080/portfolio-alfatih/pages/projects.php'),
(166, '/portfolio-alfatih/pages/semester.php', 'Semester Data', '::1', NULL, 'Desktop', 'Chrome', '2025-07-15 19:18:04', 'http://localhost:8080/portfolio-alfatih/pages/cv.php'),
(167, '/portfolio-alfatih/pages/blog.php', 'Blog', '::1', NULL, 'Desktop', 'Chrome', '2025-07-15 19:18:05', 'http://localhost:8080/portfolio-alfatih/pages/semester.php'),
(168, '/portfolio-alfatih/pages/contact.php', 'Contact', '::1', NULL, 'Desktop', 'Chrome', '2025-07-15 19:18:05', 'http://localhost:8080/portfolio-alfatih/pages/blog.php'),
(169, '/portfolio-alfatih/pages/testimonials.php', 'Testimonials', '::1', NULL, 'Desktop', 'Chrome', '2025-07-15 19:18:06', 'http://localhost:8080/portfolio-alfatih/pages/contact.php'),
(170, '/portfolio-alfatih/pages/index.php', 'Beranda', '::1', NULL, 'Desktop', 'Chrome', '2025-07-15 19:20:00', 'http://localhost:8080/portfolio-alfatih/pages/testimonials.php'),
(171, '/portfolio-alfatih/pages/about.php', 'About Me', '::1', NULL, 'Desktop', 'Chrome', '2025-07-15 19:20:02', 'http://localhost:8080/portfolio-alfatih/pages/index.php'),
(172, '/portfolio-alfatih/pages/index.php', 'Beranda', '::1', NULL, 'Desktop', 'Chrome', '2025-07-15 19:20:03', 'http://localhost:8080/portfolio-alfatih/pages/about.php'),
(173, '/portfolio-alfatih/pages/about.php', 'About Me', '::1', NULL, 'Desktop', 'Chrome', '2025-07-15 19:20:04', 'http://localhost:8080/portfolio-alfatih/pages/index.php'),
(174, '/portfolio-alfatih/pages/index.php', 'Beranda', '::1', NULL, 'Desktop', 'Chrome', '2025-07-15 19:20:04', 'http://localhost:8080/portfolio-alfatih/pages/about.php'),
(175, '/portfolio-alfatih/pages/index.php', 'Beranda', '::1', NULL, 'Desktop', 'Chrome', '2025-07-15 19:20:14', 'http://localhost:8080/portfolio-alfatih/pages/about.php'),
(176, '/portfolio-alfatih/pages/index.php', 'Beranda', '::1', NULL, 'Desktop', 'Chrome', '2025-07-15 19:30:18', 'http://localhost:8080/portfolio-alfatih/pages/about.php'),
(177, '/portfolio-alfatih/pages/index.php', 'Beranda', '::1', NULL, 'Desktop', 'Chrome', '2025-07-15 19:31:42', 'http://localhost:8080/portfolio-alfatih/pages/about.php'),
(178, '/portfolio-alfatih/pages/about.php', 'About Me', '::1', NULL, 'Desktop', 'Chrome', '2025-07-15 19:32:11', 'http://localhost:8080/portfolio-alfatih/pages/index.php'),
(179, '/portfolio-alfatih/pages/projects.php', 'Projects', '::1', NULL, 'Desktop', 'Chrome', '2025-07-15 19:32:13', 'http://localhost:8080/portfolio-alfatih/pages/about.php'),
(180, '/portfolio-alfatih/pages/cv.php', 'Curriculum Vitae', '::1', NULL, 'Desktop', 'Chrome', '2025-07-15 19:32:14', 'http://localhost:8080/portfolio-alfatih/pages/projects.php'),
(181, '/portfolio-alfatih/pages/index.php', 'Beranda', '::1', NULL, 'Desktop', 'Chrome', '2025-07-15 19:32:15', 'http://localhost:8080/portfolio-alfatih/pages/cv.php'),
(182, '/portfolio-alfatih/pages/contact.php', 'Contact', '::1', NULL, 'Desktop', 'Chrome', '2025-07-15 19:32:21', 'http://localhost:8080/portfolio-alfatih/pages/index.php'),
(183, '/portfolio-alfatih/pages/index.php', 'Beranda', '::1', NULL, 'Desktop', 'Chrome', '2025-07-15 19:32:23', 'http://localhost:8080/portfolio-alfatih/pages/contact.php'),
(184, '/portfolio-alfatih/pages/about.php', 'About Me', '::1', NULL, 'Desktop', 'Chrome', '2025-07-15 19:32:37', 'http://localhost:8080/portfolio-alfatih/pages/index.php'),
(185, '/portfolio-alfatih/pages/index.php', 'Beranda', '::1', NULL, 'Desktop', 'Chrome', '2025-07-15 19:45:18', 'http://localhost:8080/portfolio-alfatih/pages/about.php'),
(186, '/portfolio-alfatih/pages/index.php', 'Beranda', '::1', NULL, 'Desktop', 'Chrome', '2025-07-15 19:48:51', 'http://localhost:8080/portfolio-alfatih/pages/about.php'),
(187, '/portfolio-alfatih/pages/about.php', 'About Me', '::1', NULL, 'Desktop', 'Chrome', '2025-07-15 19:49:11', 'http://localhost:8080/portfolio-alfatih/pages/index.php'),
(188, '/portfolio-alfatih/pages/index.php', 'Beranda', '::1', NULL, 'Desktop', 'Chrome', '2025-07-15 19:49:13', 'http://localhost:8080/portfolio-alfatih/pages/about.php'),
(189, '/portfolio-alfatih/pages/index.php', 'Beranda', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 06:48:25', 'http://localhost:8080/portfolio-alfatih/pages/about.php'),
(190, '/portfolio-alfatih/pages/index.php', 'Beranda', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 07:24:14', 'http://localhost:8080/portfolio-alfatih/pages/about.php'),
(191, '/portfolio-alfatih/pages/about.php', 'About Me', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 07:25:04', 'http://localhost:8080/portfolio-alfatih/pages/index.php'),
(192, '/portfolio-alfatih/pages/projects.php', 'Projects', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 07:25:12', 'http://localhost:8080/portfolio-alfatih/pages/about.php'),
(193, '/portfolio-alfatih/pages/cv.php', 'Curriculum Vitae', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 07:25:13', 'http://localhost:8080/portfolio-alfatih/pages/projects.php'),
(194, '/portfolio-alfatih/pages/semester.php', 'Semester Data', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 07:25:15', 'http://localhost:8080/portfolio-alfatih/pages/cv.php'),
(195, '/portfolio-alfatih/pages/blog.php', 'Blog', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 07:25:16', 'http://localhost:8080/portfolio-alfatih/pages/semester.php'),
(196, '/portfolio-alfatih/pages/contact.php', 'Contact', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 07:25:17', 'http://localhost:8080/portfolio-alfatih/pages/blog.php'),
(197, '/portfolio-alfatih/pages/projects.php', 'Projects', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 07:25:19', 'http://localhost:8080/portfolio-alfatih/pages/contact.php'),
(198, '/portfolio-alfatih/pages/about.php', 'About Me', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 07:25:20', 'http://localhost:8080/portfolio-alfatih/pages/projects.php'),
(199, '/portfolio-alfatih/pages/about.php', 'About Me', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 07:34:17', 'http://localhost:8080/portfolio-alfatih/pages/projects.php'),
(200, '/portfolio-alfatih/pages/about.php', 'About Me', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 07:36:06', 'http://localhost:8080/portfolio-alfatih/pages/projects.php'),
(201, '/portfolio-alfatih/pages/about.php', 'About Me', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 07:36:07', 'http://localhost:8080/portfolio-alfatih/pages/projects.php'),
(202, '/portfolio-alfatih/pages/about.php', 'About Me', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 07:36:07', 'http://localhost:8080/portfolio-alfatih/pages/projects.php'),
(203, '/portfolio-alfatih/pages/about.php', 'About Me', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 07:36:12', 'http://localhost:8080/portfolio-alfatih/pages/projects.php'),
(204, '/portfolio-alfatih/pages/about.php', 'About Me', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 07:37:23', 'http://localhost:8080/portfolio-alfatih/pages/projects.php'),
(205, '/portfolio-alfatih/pages/about.php', 'About Me', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 07:37:24', 'http://localhost:8080/portfolio-alfatih/pages/projects.php'),
(206, '/portfolio-alfatih/pages/about.php', 'About Me', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 07:37:24', 'http://localhost:8080/portfolio-alfatih/pages/projects.php'),
(207, '/portfolio-alfatih/pages/about.php', 'About Me', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 07:37:25', 'http://localhost:8080/portfolio-alfatih/pages/projects.php'),
(208, '/portfolio-alfatih/pages/about.php', 'About Me', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 07:41:37', 'http://localhost:8080/portfolio-alfatih/pages/projects.php'),
(209, '/portfolio-alfatih/pages/about.php', 'About Me', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 07:41:37', 'http://localhost:8080/portfolio-alfatih/pages/projects.php'),
(210, '/portfolio-alfatih/pages/about.php', 'About Me', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 07:41:38', 'http://localhost:8080/portfolio-alfatih/pages/projects.php'),
(211, '/portfolio-alfatih/pages/about.php', 'About Me', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 07:41:38', 'http://localhost:8080/portfolio-alfatih/pages/projects.php'),
(212, '/portfolio-alfatih/pages/about.php', 'About Me', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 07:41:38', 'http://localhost:8080/portfolio-alfatih/pages/projects.php'),
(213, '/portfolio-alfatih/pages/about.php', 'About Me', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 07:41:39', 'http://localhost:8080/portfolio-alfatih/pages/projects.php'),
(214, '/portfolio-alfatih/pages/about.php', 'About Me', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 07:41:39', 'http://localhost:8080/portfolio-alfatih/pages/projects.php'),
(215, '/portfolio-alfatih/pages/about.php', 'About Me', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 07:42:11', 'http://localhost:8080/portfolio-alfatih/pages/projects.php'),
(216, '/portfolio-alfatih/pages/about.php', 'About Me', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 07:42:13', 'http://localhost:8080/portfolio-alfatih/pages/projects.php'),
(217, '/portfolio-alfatih/pages/index.php', 'Beranda', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 07:53:29', 'http://localhost:8080/portfolio-alfatih/'),
(218, '/portfolio-alfatih/pages/about.php', 'About Me', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 07:53:52', 'http://localhost:8080/portfolio-alfatih/pages/index.php'),
(219, '/portfolio-alfatih/pages/about.php', 'About Me', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 07:58:27', 'http://localhost:8080/portfolio-alfatih/pages/index.php'),
(220, '/portfolio-alfatih/pages/projects.php', 'Projects', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 07:59:05', 'http://localhost:8080/portfolio-alfatih/pages/about.php'),
(221, '/portfolio-alfatih/pages/index.php', 'Beranda', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 07:59:06', 'http://localhost:8080/portfolio-alfatih/pages/projects.php'),
(222, '/portfolio-alfatih/pages/index.php', 'Beranda', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 08:04:32', 'http://localhost:8080/portfolio-alfatih/pages/projects.php'),
(223, '/portfolio-alfatih/pages/about.php', 'About Me', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 08:04:34', 'http://localhost:8080/portfolio-alfatih/pages/index.php'),
(224, '/portfolio-alfatih/pages/about.php', 'About Me', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 08:13:15', 'http://localhost:8080/portfolio-alfatih/pages/index.php'),
(225, '/portfolio-alfatih/pages/index.php', 'Beranda', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 08:13:17', 'http://localhost:8080/portfolio-alfatih/pages/about.php'),
(226, '/portfolio-alfatih/pages/about.php', 'About Me', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 08:13:36', 'http://localhost:8080/portfolio-alfatih/pages/index.php'),
(227, '/portfolio-alfatih/pages/about.php', 'About Me', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 08:20:54', 'http://localhost:8080/portfolio-alfatih/pages/index.php'),
(228, '/portfolio-alfatih/pages/about.php', 'About Me', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 08:22:08', 'http://localhost:8080/portfolio-alfatih/pages/index.php'),
(229, '/portfolio-alfatih/pages/index.php', 'Beranda', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 08:22:34', 'http://localhost:8080/portfolio-alfatih/pages/about.php'),
(230, '/portfolio-alfatih/pages/index.php', 'Beranda', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 08:28:16', 'http://localhost:8080/portfolio-alfatih/pages/about.php'),
(231, '/portfolio-alfatih/pages/index.php', 'Beranda', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 08:29:10', 'http://localhost:8080/portfolio-alfatih/pages/about.php'),
(232, '/portfolio-alfatih/pages/index.php', 'Beranda', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 08:30:09', 'http://localhost:8080/portfolio-alfatih/pages/about.php'),
(233, '/portfolio-alfatih/pages/index.php', 'Beranda', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 08:32:30', 'http://localhost:8080/portfolio-alfatih/pages/about.php'),
(234, '/portfolio-alfatih/pages/about.php', 'About Me', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 08:32:51', 'http://localhost:8080/portfolio-alfatih/pages/index.php'),
(235, '/portfolio-alfatih/pages/index.php', 'Beranda', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 08:33:53', 'http://localhost:8080/portfolio-alfatih/'),
(236, '/portfolio-alfatih/pages/index.php', 'Beranda', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 08:35:00', 'http://localhost:8080/portfolio-alfatih/'),
(237, '/portfolio-alfatih/pages/index.php', 'Beranda', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 08:35:14', 'http://localhost:8080/portfolio-alfatih/'),
(238, '/portfolio-alfatih/pages/index.php', 'Beranda', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 08:35:32', 'http://localhost:8080/portfolio-alfatih/'),
(239, '/portfolio-alfatih/pages/index.php', 'Beranda', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 08:54:15', 'http://localhost:8080/portfolio-alfatih/'),
(240, '/portfolio-alfatih/pages/index.php', 'Beranda', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 08:57:48', 'http://localhost:8080/portfolio-alfatih/'),
(241, '/portfolio-alfatih/pages/index.php', 'Beranda', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 08:57:54', 'http://localhost:8080/portfolio-alfatih/'),
(242, '/portfolio-alfatih/pages/index.php', 'Beranda', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 08:57:57', 'http://localhost:8080/portfolio-alfatih/'),
(243, '/portfolio-alfatih/pages/index.php', 'Beranda', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 08:57:59', 'http://localhost:8080/portfolio-alfatih/'),
(244, '/portfolio-alfatih/pages/index.php', 'Beranda', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 09:03:50', 'http://localhost:8080/portfolio-alfatih/'),
(245, '/portfolio-alfatih/pages/index.php', 'Beranda', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 09:05:03', 'http://localhost:8080/portfolio-alfatih/'),
(246, '/portfolio-alfatih/pages/index.php', 'Beranda', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 09:05:39', 'http://localhost:8080/portfolio-alfatih/'),
(247, '/portfolio-alfatih/pages/index.php', 'Beranda', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 09:08:00', 'http://localhost:8080/portfolio-alfatih/'),
(248, '/portfolio-alfatih/pages/index.php', 'Beranda', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 09:10:02', 'http://localhost:8080/portfolio-alfatih/'),
(249, '/portfolio-alfatih/pages/index.php', 'Beranda', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 09:11:34', 'http://localhost:8080/portfolio-alfatih/'),
(250, '/portfolio-alfatih/pages/about.php', 'About Me', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 09:11:50', 'http://localhost:8080/portfolio-alfatih/pages/index.php'),
(251, '/portfolio-alfatih/pages/projects.php', 'Projects', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 09:11:51', 'http://localhost:8080/portfolio-alfatih/pages/about.php'),
(252, '/portfolio-alfatih/pages/about.php', 'About Me', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 09:11:52', 'http://localhost:8080/portfolio-alfatih/pages/projects.php'),
(253, '/portfolio-alfatih/pages/about.php', 'About Me', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 09:18:29', 'http://localhost:8080/portfolio-alfatih/pages/projects.php'),
(254, '/portfolio-alfatih/pages/about.php', 'About Me', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 09:19:01', 'http://localhost:8080/portfolio-alfatih/pages/projects.php'),
(255, '/portfolio-alfatih/pages/about.php', 'About Me', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 09:20:26', 'http://localhost:8080/portfolio-alfatih/pages/projects.php'),
(256, '/portfolio-alfatih/pages/contact.php', 'Contact', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 09:21:03', 'http://localhost:8080/portfolio-alfatih/pages/about.php'),
(257, '/portfolio-alfatih/pages/about.php', 'About Me', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 09:21:06', 'http://localhost:8080/portfolio-alfatih/pages/contact.php'),
(258, '/portfolio-alfatih/pages/about.php', 'About Me', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 09:22:12', 'http://localhost:8080/portfolio-alfatih/pages/contact.php'),
(259, '/portfolio-alfatih/pages/about.php', 'About Me', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 09:35:12', 'http://localhost:8080/portfolio-alfatih/pages/contact.php'),
(260, '/portfolio-alfatih/pages/about.php', 'About Me', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 09:37:12', 'http://localhost:8080/portfolio-alfatih/pages/contact.php'),
(261, '/portfolio-alfatih/pages/index.php', 'Beranda', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 09:39:10', 'http://localhost:8080/portfolio-alfatih/'),
(262, '/portfolio-alfatih/pages/about.php', 'About Me', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 09:39:22', 'http://localhost:8080/portfolio-alfatih/pages/index.php'),
(263, '/portfolio-alfatih/pages/projects.php', 'Projects', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 09:43:05', 'http://localhost:8080/portfolio-alfatih/pages/about.php'),
(264, '/portfolio-alfatih/pages/about.php', 'About Me', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 09:43:06', 'http://localhost:8080/portfolio-alfatih/pages/projects.php'),
(265, '/portfolio-alfatih/pages/about.php', 'About Me', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 09:43:09', 'http://localhost:8080/portfolio-alfatih/pages/projects.php'),
(266, '/portfolio-alfatih/pages/projects.php', 'Projects', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 09:43:37', 'http://localhost:8080/portfolio-alfatih/pages/about.php'),
(267, '/portfolio-alfatih/pages/about.php', 'About Me', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 09:43:39', 'http://localhost:8080/portfolio-alfatih/pages/projects.php'),
(268, '/portfolio-alfatih/pages/cv.php', 'Curriculum Vitae', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 09:43:46', 'http://localhost:8080/portfolio-alfatih/pages/about.php'),
(269, '/portfolio-alfatih/pages/about.php', 'About Me', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 09:44:29', 'http://localhost:8080/portfolio-alfatih/pages/cv.php'),
(270, '/portfolio-alfatih/pages/cv.php', 'Curriculum Vitae', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 09:44:33', 'http://localhost:8080/portfolio-alfatih/pages/about.php'),
(271, '/portfolio-alfatih/pages/semester.php', 'Semester Data', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 09:44:34', 'http://localhost:8080/portfolio-alfatih/pages/cv.php'),
(272, '/portfolio-alfatih/pages/projects.php', 'Projects', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 09:44:36', 'http://localhost:8080/portfolio-alfatih/pages/semester.php'),
(273, '/portfolio-alfatih/pages/blog.php', 'Blog', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 09:44:38', 'http://localhost:8080/portfolio-alfatih/pages/projects.php'),
(274, '/portfolio-alfatih/pages/semester.php', 'Semester Data', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 09:44:39', 'http://localhost:8080/portfolio-alfatih/pages/blog.php'),
(275, '/portfolio-alfatih/pages/projects.php', 'Projects', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 09:44:42', 'http://localhost:8080/portfolio-alfatih/pages/semester.php'),
(276, '/portfolio-alfatih/pages/cv.php', 'Curriculum Vitae', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 09:44:43', 'http://localhost:8080/portfolio-alfatih/pages/projects.php'),
(277, '/portfolio-alfatih/pages/semester.php', 'Semester Data', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 09:45:03', 'http://localhost:8080/portfolio-alfatih/pages/cv.php'),
(278, '/portfolio-alfatih/pages/cv.php', 'Curriculum Vitae', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 09:45:04', 'http://localhost:8080/portfolio-alfatih/pages/semester.php'),
(279, '/portfolio-alfatih/pages/cv.php', 'Curriculum Vitae', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 09:45:33', 'http://localhost:8080/portfolio-alfatih/pages/semester.php'),
(280, '/portfolio-alfatih/pages/about.php', 'About Me', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 09:46:31', 'http://localhost:8080/portfolio-alfatih/pages/cv.php'),
(281, '/portfolio-alfatih/pages/about.php', 'About Me', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 09:46:53', 'http://localhost:8080/portfolio-alfatih/pages/cv.php'),
(282, '/portfolio-alfatih/pages/about.php', 'About Me', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 09:53:56', 'http://localhost:8080/portfolio-alfatih/pages/cv.php'),
(283, '/portfolio-alfatih/pages/about.php', 'About Me', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 09:54:14', 'http://localhost:8080/portfolio-alfatih/pages/cv.php'),
(284, '/portfolio-alfatih/pages/projects.php', 'Projects', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 09:54:49', 'http://localhost:8080/portfolio-alfatih/pages/about.php'),
(285, '/portfolio-alfatih/pages/projects.php', 'Projects', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 09:54:55', 'http://localhost:8080/portfolio-alfatih/pages/about.php'),
(286, '/portfolio-alfatih/pages/projects.php', 'Projects', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 09:57:00', 'http://localhost:8080/portfolio-alfatih/pages/about.php'),
(287, '/portfolio-alfatih/pages/projects.php', 'Projects', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 09:57:42', 'http://localhost:8080/portfolio-alfatih/pages/about.php'),
(288, '/portfolio-alfatih/pages/testimonials.php', 'Testimonials', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 09:59:06', 'http://localhost:8080/portfolio-alfatih/pages/projects.php'),
(289, '/portfolio-alfatih/pages/contact.php', 'Contact', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 09:59:08', 'http://localhost:8080/portfolio-alfatih/pages/testimonials.php'),
(290, '/portfolio-alfatih/pages/blog.php', 'Blog', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 09:59:09', 'http://localhost:8080/portfolio-alfatih/pages/contact.php'),
(291, '/portfolio-alfatih/pages/semester.php', 'Semester Data', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 09:59:09', 'http://localhost:8080/portfolio-alfatih/pages/blog.php');
INSERT INTO `website_analytics` (`id`, `page_url`, `page_title`, `visitor_ip`, `visitor_country`, `visitor_device`, `visitor_browser`, `visit_date`, `referrer`) VALUES
(292, '/portfolio-alfatih/pages/projects.php', 'Projects', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 09:59:11', 'http://localhost:8080/portfolio-alfatih/pages/semester.php'),
(293, '/portfolio-alfatih/pages/cv.php', 'Curriculum Vitae', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 09:59:11', 'http://localhost:8080/portfolio-alfatih/pages/projects.php'),
(294, '/portfolio-alfatih/pages/cv.php', 'Curriculum Vitae', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 10:01:29', 'http://localhost:8080/portfolio-alfatih/pages/projects.php'),
(295, '/portfolio-alfatih/pages/cv.php', 'Curriculum Vitae', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 10:01:52', 'http://localhost:8080/portfolio-alfatih/pages/projects.php'),
(296, '/portfolio-alfatih/pages/cv.php', 'Curriculum Vitae', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 10:01:54', 'http://localhost:8080/portfolio-alfatih/pages/projects.php'),
(297, '/portfolio-alfatih/pages/cv.php', 'Curriculum Vitae', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 10:01:55', 'http://localhost:8080/portfolio-alfatih/pages/projects.php'),
(298, '/portfolio-alfatih/pages/cv.php', 'Curriculum Vitae', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 10:01:55', 'http://localhost:8080/portfolio-alfatih/pages/projects.php'),
(299, '/portfolio-alfatih/pages/cv.php', 'Curriculum Vitae', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 10:01:57', 'http://localhost:8080/portfolio-alfatih/pages/projects.php'),
(300, '/portfolio-alfatih/pages/cv.php', 'Curriculum Vitae', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 10:01:58', 'http://localhost:8080/portfolio-alfatih/pages/projects.php'),
(301, '/portfolio-alfatih/pages/cv.php', 'Curriculum Vitae', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 10:02:26', 'http://localhost:8080/portfolio-alfatih/pages/projects.php'),
(302, '/portfolio-alfatih/pages/cv.php', 'Curriculum Vitae', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 10:04:54', 'http://localhost:8080/portfolio-alfatih/pages/projects.php'),
(303, '/portfolio-alfatih/pages/projects.php', 'Projects', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 10:05:03', 'http://localhost:8080/portfolio-alfatih/pages/cv.php'),
(304, '/portfolio-alfatih/pages/cv.php', 'Curriculum Vitae', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 10:05:05', 'http://localhost:8080/portfolio-alfatih/pages/projects.php'),
(305, '/portfolio-alfatih/pages/semester.php', 'Semester Data', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 10:05:06', 'http://localhost:8080/portfolio-alfatih/pages/cv.php'),
(306, '/portfolio-alfatih/pages/cv.php', 'Curriculum Vitae', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 10:05:07', 'http://localhost:8080/portfolio-alfatih/pages/semester.php'),
(307, '/portfolio-alfatih/pages/semester.php', 'Semester Data', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 10:05:08', 'http://localhost:8080/portfolio-alfatih/pages/cv.php'),
(308, '/portfolio-alfatih/pages/blog.php', 'Blog', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 10:05:11', 'http://localhost:8080/portfolio-alfatih/pages/semester.php'),
(309, '/portfolio-alfatih/pages/semester.php', 'Semester Data', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 10:05:12', 'http://localhost:8080/portfolio-alfatih/pages/blog.php'),
(310, '/portfolio-alfatih/pages/contact.php', 'Contact', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 10:05:13', 'http://localhost:8080/portfolio-alfatih/pages/semester.php'),
(311, '/portfolio-alfatih/pages/semester.php', 'Semester Data', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 10:05:14', 'http://localhost:8080/portfolio-alfatih/pages/contact.php'),
(312, '/portfolio-alfatih/pages/cv.php', 'Curriculum Vitae', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 10:05:15', 'http://localhost:8080/portfolio-alfatih/pages/semester.php'),
(313, '/portfolio-alfatih/pages/projects.php', 'Projects', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 10:05:15', 'http://localhost:8080/portfolio-alfatih/pages/cv.php'),
(314, '/portfolio-alfatih/pages/about.php', 'About Me', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 10:05:16', 'http://localhost:8080/portfolio-alfatih/pages/projects.php'),
(315, '/portfolio-alfatih/pages/index.php', 'Beranda', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 10:05:17', 'http://localhost:8080/portfolio-alfatih/pages/about.php'),
(316, '/portfolio-alfatih/pages/about.php', 'About Me', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 10:05:23', 'http://localhost:8080/portfolio-alfatih/pages/index.php'),
(317, '/portfolio-alfatih/pages/index.php', 'Beranda', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 10:05:34', 'http://localhost:8080/portfolio-alfatih/pages/about.php'),
(318, '/portfolio-alfatih/pages/about.php', 'About Me', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 10:06:58', 'http://localhost:8080/portfolio-alfatih/pages/index.php'),
(319, '/portfolio-alfatih/pages/index.php', 'Beranda', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 10:07:04', 'http://localhost:8080/portfolio-alfatih/pages/about.php'),
(320, '/portfolio-alfatih/pages/about.php', 'About Me', '::1', NULL, 'Desktop', 'Chrome', '2025-07-16 10:07:08', 'http://localhost:8080/portfolio-alfatih/pages/index.php');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `admin_logs`
--
ALTER TABLE `admin_logs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `admin_roles`
--
ALTER TABLE `admin_roles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `artikel`
--
ALTER TABLE `artikel`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`),
  ADD KEY `id_kategori` (`id_kategori`);

--
-- Indexes for table `contact_messages`
--
ALTER TABLE `contact_messages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `dokumen`
--
ALTER TABLE `dokumen`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `job_titles`
--
ALTER TABLE `job_titles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `kategori`
--
ALTER TABLE `kategori`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nama_kategori` (`nama_kategori`);

--
-- Indexes for table `media_library`
--
ALTER TABLE `media_library`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `page_content`
--
ALTER TABLE `page_content`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `page_section` (`page`,`section`);

--
-- Indexes for table `pendidikan`
--
ALTER TABLE `pendidikan`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pengaturan`
--
ALTER TABLE `pengaturan`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `kunci` (`kunci`);

--
-- Indexes for table `profil`
--
ALTER TABLE `profil`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `proyek`
--
ALTER TABLE `proyek`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `semester_data`
--
ALTER TABLE `semester_data`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `skills`
--
ALTER TABLE `skills`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `system_backups`
--
ALTER TABLE `system_backups`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `testimonials`
--
ALTER TABLE `testimonials`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `website_analytics`
--
ALTER TABLE `website_analytics`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `admin_logs`
--
ALTER TABLE `admin_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `admin_roles`
--
ALTER TABLE `admin_roles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `artikel`
--
ALTER TABLE `artikel`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `contact_messages`
--
ALTER TABLE `contact_messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dokumen`
--
ALTER TABLE `dokumen`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `job_titles`
--
ALTER TABLE `job_titles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `kategori`
--
ALTER TABLE `kategori`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `media_library`
--
ALTER TABLE `media_library`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `page_content`
--
ALTER TABLE `page_content`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `pendidikan`
--
ALTER TABLE `pendidikan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `pengaturan`
--
ALTER TABLE `pengaturan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=79;

--
-- AUTO_INCREMENT for table `profil`
--
ALTER TABLE `profil`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `proyek`
--
ALTER TABLE `proyek`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `semester_data`
--
ALTER TABLE `semester_data`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `skills`
--
ALTER TABLE `skills`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `system_backups`
--
ALTER TABLE `system_backups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `testimonials`
--
ALTER TABLE `testimonials`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `website_analytics`
--
ALTER TABLE `website_analytics`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=321;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `artikel`
--
ALTER TABLE `artikel`
  ADD CONSTRAINT `artikel_ibfk_1` FOREIGN KEY (`id_kategori`) REFERENCES `kategori` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
