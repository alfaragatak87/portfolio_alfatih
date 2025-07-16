<?php
// Base URL Configuration
define('BASE_URL', 'http://localhost:8080/portfolio-alfatih');
define('ROOT_PATH', dirname(__DIR__));

// Database Configuration
define('DB_HOST', '127.0.0.1');  // Gunakan alamat IP seperti yang ditunjukkan di info server
define('DB_NAME', 'portfolio_db');
define('DB_USER', 'root');
define('DB_PASS', '');  // Kosongkan karena tidak ada password
define('DB_PORT', '3307'); // Port default MySQL

// Owner Information
define('OWNER_NAME', 'Muhammad Alfatih');
define('OWNER_EMAIL', 's.s.6624844@gmail.com');
define('OWNER_WHATSAPP', '+62 831-8881-3237');
define('OWNER_GITHUB', 'https://github.com/alfaragatak87');
define('OWNER_EDUCATION', 'S1 Informatika, ITB Widya Gama Lumajang (Semester 3)');
define('OWNER_SKILLS', 'PHP, JavaScript, HTML, CSS, MySQL, UI/UX (Figma), Digital Marketing');

// Include language file
require_once __DIR__ . '/language.php';

?>