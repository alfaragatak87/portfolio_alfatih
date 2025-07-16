<?php
$pageTitle = "About Me";

// Koneksi database - sesuaikan dengan kredensial Anda
$host = '127.0.0.1:3307';
$username = 'root';
$password = '';
$database = 'portfolio_db';

$conn = mysqli_connect($host, $username, $password, $database);

// Check koneksi database
if (!$conn) {
    die("Koneksi database gagal: " . mysqli_connect_error());
}

// Set charset
mysqli_set_charset($conn, 'utf8mb4');

// Get profile data dari tabel profil
$query = "SELECT * FROM profil WHERE id = 1";
$result = mysqli_query($conn, $query);

if ($result) {
    $profile = mysqli_fetch_assoc($result);
} else {
    $profile = null;
}

// Jika tidak ada data, buat array kosong
if (!$profile) {
    $profile = array();
}

// Define BASE_URL jika belum ada
if (!defined('BASE_URL')) {
    define('BASE_URL', 'http://localhost:8080/portfolio-alfatih');
}

// Include helpers jika diperlukan
if (file_exists('../includes/helpers.php')) {
    require_once '../includes/helpers.php';
}
require_once '../config/constants.php';

require_once '../templates/header.php';
?>

<style>
/* 🎨 SIMPLE PARTICLE SYSTEM - LIKE OLD VERSION */
.particle-system {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    z-index: -1;
    overflow: hidden;
    pointer-events: none;
}

.floating-particle {
    position: absolute;
    border-radius: 50%;
    pointer-events: none;
    animation: floatUp 15s linear infinite;
}

.floating-particle:nth-child(1) {
    width: 4px; height: 4px;
    background: rgba(0, 229, 255, 0.8);
    left: 10%; 
    animation-delay: 0s;
}

.floating-particle:nth-child(2) {
    width: 8px; height: 8px;
    background: rgba(124, 77, 255, 0.6);
    left: 20%; 
    animation-delay: 2s;
}

.floating-particle:nth-child(3) {
    width: 6px; height: 6px;
    background: rgba(6, 182, 212, 0.7);
    left: 30%; 
    animation-delay: 4s;
}

.floating-particle:nth-child(4) {
    width: 10px; height: 10px;
    background: rgba(0, 229, 255, 0.4);
    left: 40%; 
    animation-delay: 6s;
}

.floating-particle:nth-child(5) {
    width: 5px; height: 5px;
    background: rgba(124, 77, 255, 0.8);
    left: 50%; 
    animation-delay: 8s;
}

.floating-particle:nth-child(6) {
    width: 12px; height: 12px;
    background: rgba(6, 182, 212, 0.3);
    left: 60%; 
    animation-delay: 10s;
}

.floating-particle:nth-child(7) {
    width: 7px; height: 7px;
    background: rgba(0, 229, 255, 0.5);
    left: 70%; 
    animation-delay: 12s;
}

.floating-particle:nth-child(8) {
    width: 9px; height: 9px;
    background: rgba(124, 77, 255, 0.4);
    left: 80%; 
    animation-delay: 14s;
}

@keyframes floatUp {
    0% {
        transform: translateY(100vh) translateX(0px) rotate(0deg);
        opacity: 0;
    }
    10% {
        opacity: 1;
    }
    90% {
        opacity: 1;
    }
    100% {
        transform: translateY(-100px) translateX(50px) rotate(360deg);
        opacity: 0;
    }
}

/* Modern About Page Styling - Clean & Smooth */
.about-hero {
    background: transparent;
    min-height: 60vh;
    display: flex;
    align-items: center;
    position: relative;
    overflow: hidden;
}

.about-hero-content {
    max-width: 1200px;
    margin: 0 auto;
    padding: 2rem;
    text-align: center;
    position: relative;
    z-index: 2;
}

.about-hero h1 {
    font-size: 3.5rem;
    font-weight: 700;
    margin-bottom: 1rem;
    background: linear-gradient(135deg, #00e5ff, #7c4dff);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
}

.about-hero .subtitle {
    font-size: 1.3rem;
    color: #b0bec5;
    margin-bottom: 2rem;
}

.about-hero-quote {
    background: rgba(255, 255, 255, 0.03);
    backdrop-filter: blur(15px);
    border-radius: 20px;
    padding: 2rem;
    border: 1px solid rgba(255, 255, 255, 0.1);
    max-width: 600px;
    margin: 0 auto;
    transition: transform 0.3s ease;
}

.about-hero-quote:hover {
    transform: translateY(-5px);
}

.about-hero-quote p {
    font-size: 1.2rem;
    color: #e0e7ff;
    font-style: italic;
    margin: 1rem 0;
}

.about-hero-quote i {
    color: #00e5ff;
    font-size: 1.5rem;
}

/* About Content Grid */
.about-content {
    padding: 6rem 0;
    background: transparent;
}

.about-grid {
    display: grid;
    grid-template-columns: 1fr 1.5fr;
    gap: 4rem;
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 2rem;
    align-items: center;
}

.about-image-column {
    text-align: center;
}

.about-image {
    position: relative;
    display: inline-block;
    margin-bottom: 2rem;
}

.about-image img {
    width: 500px;
    height: 500px;
    border-radius: 50%;
    object-fit: cover;
    border: 6px solid transparent;
    background: transparent(135deg, #00e5ff, #7c4dff);
    padding: 6px;
    box-shadow: 0 20px 40px rgba(0, 0, 0, 0.3);
    transition: transform 0.3s ease;
}

.about-image img:hover {
    transform: scale(1.05);
}

.about-social {
    display: flex;
    justify-content: center;
    gap: 1rem;
    margin-top: 2rem;
}

.social-icon {
    width: 50px;
    height: 50px;
    border-radius: 50%;
    background: rgba(255, 255, 255, 0.05);
    backdrop-filter: blur(10px);
    border: 1px solid rgba(255, 255, 255, 0.1);
    display: flex;
    align-items: center;
    justify-content: center;
    color: #00e5ff;
    font-size: 1.2rem;
    text-decoration: none;
    transition: all 0.3s ease;
}

.social-icon:hover {
    background: rgba(0, 229, 255, 0.2);
    transform: translateY(-3px);
    box-shadow: 0 10px 25px rgba(0, 229, 255, 0.3);
}

/* Text Content */
.about-text-column {
    position: relative;
}

.about-text-card {
    background: rgba(255, 255, 255, 0.03);
    backdrop-filter: blur(15px);
    border-radius: 20px;
    padding: 3rem;
    border: 1px solid rgba(255, 255, 255, 0.1);
    box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
    transition: transform 0.3s ease;
}

.about-text-card:hover {
    transform: translateY(-5px);
}

.about-text-card h2 {
    font-size: 2.5rem;
    color: #fff;
    margin-bottom: 1.5rem;
    font-weight: 700;
}

.about-text-intro {
    font-size: 1.2rem;
    color: #e0e7ff;
    line-height: 1.7;
    margin-bottom: 1.5rem;
}

.about-text-card p {
    color: #b0bec5;
    line-height: 1.6;
    margin-bottom: 2rem;
}

.about-info-grid {
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    gap: 1.5rem;
    margin: 2rem 0;
}

.about-info-item {
    background: rgba(255, 255, 255, 0.02);
    padding: 1rem;
    border-radius: 10px;
    border: 1px solid rgba(255, 255, 255, 0.05);
    transition: transform 0.3s ease;
}

.about-info-item:hover {
    transform: translateY(-3px);
    background: rgba(255, 255, 255, 0.05);
}

.info-label {
    font-size: 0.9rem;
    color: #64748b;
    margin-bottom: 0.5rem;
    font-weight: 500;
}

.info-value {
    color: #fff;
    font-weight: 600;
}

.about-cta {
    display: flex;
    gap: 1.5rem;
    margin-top: 2rem;
}

.btn {
    padding: 1rem 2rem;
    border-radius: 50px;
    font-weight: 600;
    text-decoration: none;
    transition: all 0.3s ease;
    border: none;
    cursor: pointer;
    font-size: 1rem;
    display: inline-flex;
    align-items: center;
    gap: 0.5rem;
}

.btn-primary {
    background: linear-gradient(135deg, #00e5ff, #7c4dff);
    color: #0a0a1a;
}

.btn-primary:hover {
    transform: translateY(-3px);
    box-shadow: 0 10px 25px rgba(0, 229, 255, 0.3);
}

.btn-outline {
    background: transparent;
    color: #00e5ff;
    border: 2px solid #00e5ff;
}

.btn-outline:hover {
    background: rgba(0, 229, 255, 0.1);
    transform: translateY(-3px);
}

/* Skills Section */
.skills-section {
    padding: 6rem 0;
    background: transparent;
}

.skills-container {
    max-width: 1200px;
    margin: 100 auto;
    padding: 0 2rem;
}

.section-header {
    text-align: center;
    margin-bottom: 4rem;
}

.section-header h2 {
    font-size: 2.5rem;
    color: #fff;
    margin-bottom: 1rem;
    background: linear-gradient(135deg, #00e5ff, #7c4dff);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
}

.section-header p {
    color: #b0bec5;
    font-size: 1.1rem;
}

.skills-category {
    background: rgba(255, 255, 255, 0.03);
    backdrop-filter: blur(15px);
    border-radius: 20px;
    padding: 2rem;
    border: 1px solid rgba(255, 255, 255, 0.1);
    margin-bottom: 2rem;
    transition: transform 0.3s ease;
}

.skills-category:hover {
    transform: translateY(-5px);
}

.skills-category h3 {
    color: #00e5ff;
    margin-bottom: 1.5rem;
    font-size: 1.3rem;
}

.skills-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 1.5rem;
}

.skill-item {
    display: flex;
    align-items: center;
    gap: 1rem;
    padding: 1rem;
    background: rgba(255, 255, 255, 0.02);
    border-radius: 10px;
    border: 1px solid rgba(255, 255, 255, 0.05);
    transition: all 0.3s ease;
}

.skill-item:hover {
    transform: translateY(-3px);
    background: rgba(255, 255, 255, 0.05);
    box-shadow: 0 5px 15px rgba(0, 229, 255, 0.1);
}

.skill-icon img {
    width: 30px;
    height: 30px;
}

.skill-info h4 {
    color: #fff;
    margin-bottom: 0.5rem;
}

.skill-progress {
    background: rgba(255, 255, 255, 0.05);
    border-radius: 50px;
    height: 6px;
    overflow: hidden;
}

.progress {
    height: 100%;
    background: linear-gradient(90deg, #00e5ff, #7c4dff);
    border-radius: 50px;
    transition: width 2s ease;
}

/* Responsive Design */
@media (max-width: 768px) {
    .about-hero h1 {
        font-size: 2.5rem;
    }
    
    .about-grid {
        grid-template-columns: 1fr;
        gap: 2rem;
    }
    
    .about-image img {
        width: 200px;
        height: 200px;
    }
    
    .about-text-card {
        padding: 2rem;
    }
    
    .about-info-grid {
        grid-template-columns: 1fr;
    }
    
    .about-cta {
        flex-direction: column;
        align-items: center;
    }
    
    .skills-grid {
        grid-template-columns: 1fr;
    }
}
</style>

<!-- 🎨 SIMPLE PARTICLE SYSTEM -->
<div class="particle-system">
    <div class="floating-particle"></div>
    <div class="floating-particle"></div>
    <div class="floating-particle"></div>
    <div class="floating-particle"></div>
    <div class="floating-particle"></div>
    <div class="floating-particle"></div>
    <div class="floating-particle"></div>
    <div class="floating-particle"></div>
</div>

<!-- About Hero Section -->
<section class="about-hero">
    <div class="about-hero-content">
        <h1>About Me</h1>
        <p class="subtitle">Get to know me better</p>
        
        <div class="about-hero-quote">
            <i class="fas fa-quote-left"></i>
            <p>
                <?php 
                echo (isset($profile['summary']) && !empty($profile['summary'])) 
                    ? htmlspecialchars($profile['summary']) 
                    : '"Crafting digital experiences that blend functionality with beautiful design."';
                ?>
            </p>
            <i class="fas fa-quote-right"></i>
        </div>
    </div>
</section>

<!-- About Content Section -->
<section class="about-content">
    <div class="about-grid">
        <!-- Image Column -->
        <div class="about-image-column">
            <div class="about-image">
                <?php 
                // Menggunakan kolom profile_image dari database
                $profile_image = isset($profile['profile_image']) ? $profile['profile_image'] : '';
                $nama = isset($profile['nama']) ? $profile['nama'] : 'Muhammad Alfatih';
                
                if (!empty($profile_image)): 
                ?>
                    <img src="<?= BASE_URL ?>/uploads/profile/<?= htmlspecialchars($profile_image) ?>" 
                         alt="<?= htmlspecialchars($nama) ?>"
                         onerror="this.src='<?= BASE_URL ?>/assets/img/default-profile.jpg'">
                <?php else: ?>
                    <img src="<?= BASE_URL ?>/assets/img/default-profile.jpg" 
                         alt="<?= htmlspecialchars($nama) ?>">
                <?php endif; ?>
            </div>
            
            <div class="about-social">
                <a href="https://github.com/alfaragatak87<?= isset($profile['github']) ? htmlspecialchars($profile['github']) : '#' ?>" target="_blank" class="social-icon">
                    <i class="fab fa-github"></i>
                </a>
                <a href="mailto:s.s.6624844@gmail.com<?= isset($profile['email']) ? htmlspecialchars($profile['email']) : 'email@example.com' ?>" class="social-icon">
                    <i class="fas fa-envelope"></i>
                </a>
                <a href="https://wa.me/083188813237<?= isset($profile['whatsapp']) ? str_replace(['+', ' ', '-'], '', $profile['whatsapp']) : '628123456789' ?>" target="_blank" class="social-icon">
                    <i class="fab fa-whatsapp"></i>
                </a>
                <a href="https://www.instagram.com/alfamuhammad___/" class="social-icon"><i class="fab fa-instagram"></i></a>
            </div>
        </div>
        
        <!-- Content Column -->
        <div class="about-text-column">
            <div class="about-text-card">
                <h2>Hello! I'm <?= htmlspecialchars($nama) ?></h2>
                
                <p class="about-text-intro">
                    <?= isset($profile['summary']) && !empty($profile['summary']) 
                        ? htmlspecialchars($profile['summary']) 
                        : 'I .' ?>
                </p>
                
                <p>
                    My journey in web development began with a curiosity about how websites work, which quickly evolved into a passion for creating them. I continuously strive to expand my skill set and stay updated with the latest industry trends and technologies.
                </p>
                
                <div class="about-info-grid">
                    <div class="about-info-item">
                        <div class="info-label">Name</div>
                        <div class="info-value"><?= htmlspecialchars($nama) ?></div>
                    </div>
                    
                    <div class="about-info-item">
                        <div class="info-label">Email</div>
                        <div class="info-value"><?= isset($profile['email']) ? htmlspecialchars($profile['email']) : 'email@example.com' ?></div>
                    </div>
                    
                    <div class="about-info-item">
                        <div class="info-label">Phone</div>
                        <div class="info-value"><?= isset($profile['whatsapp']) ? htmlspecialchars($profile['whatsapp']) : '+62 812 3456 789' ?></div>
                    </div>
                    
                    <div class="about-info-item">
                        <div class="info-label">Location</div>
                        <div class="info-value"><?= isset($profile['location']) ? htmlspecialchars($profile['location']) : 'Lumajang, East Java, Indonesia' ?></div>
                    </div>
                    
                    <div class="about-info-item">
                        <div class="info-label">Study At</div>
                        <div class="info-value">ITB Widyagama Lumajang</div>
                    </div>
                    
                    <div class="about-info-item">
                        <div class="info-label">Status</div>
                        <div class="info-value"><?= isset($profile['current_status']) ? htmlspecialchars($profile['current_status']) : 'Student' ?></div>
                    </div>
                </div>
                
                <div class="about-cta">
                    <a href="<?= BASE_URL ?>/pages/contact.php" class="btn btn-primary">
                        <i class="fas fa-envelope"></i>
                        Contact Me
                    </a>
                    <a href="<?= BASE_URL ?>/pages/projects.php" class="btn btn-outline">
                        <i class="fas fa-briefcase"></i>
                        View Projects
                    </a>
                </div>
            </div>
        </div>
    </div>
</section>


<!-- Skills Section -->
<section class="skills-section">
    <div class="skills-container">
        <div class="section-header">
            <h2>My Skills</h2>
            <p>Technologies & tools I work with</p>
        </div>
        
        <div class="skills-category">
            <h3><i class="fas fa-laptop-code"></i> Frontend Development</h3>
            <div class="skills-grid">
                <div class="skill-item">
                    <div class="skill-icon">
                        <i class="fab fa-html5" style="color: #e34f26; font-size: 1.5rem;"></i>
                    </div>
                    <div class="skill-info">
                        <h4>HTML5</h4>
                        <div class="skill-progress">
                            <div class="progress" style="width: 95%;"></div>
                        </div>
                    </div>
                </div>
                
                <div class="skill-item">
                    <div class="skill-icon">
                        <i class="fab fa-css3-alt" style="color: #1572b6; font-size: 1.5rem;"></i>
                    </div>
                    <div class="skill-info">
                        <h4>CSS3</h4>
                        <div class="skill-progress">
                            <div class="progress" style="width: 90%;"></div>
                        </div>
                    </div>
                </div>
                
                <div class="skill-item">
                    <div class="skill-icon">
                        <i class="fab fa-js" style="color: #f7df1e; font-size: 1.5rem;"></i>
                    </div>
                    <div class="skill-info">
                        <h4>JavaScript</h4>
                        <div class="skill-progress">
                            <div class="progress" style="width: 85%;"></div>
                        </div>
                    </div>
                </div>
                
                <div class="skill-item">
                    <div class="skill-icon">
                        <i class="fab fa-bootstrap" style="color: #7952b3; font-size: 1.5rem;"></i>
                    </div>
                    <div class="skill-info">
                        <h4>Bootstrap</h4>
                        <div class="skill-progress">
                            <div class="progress" style="width: 80%;"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="skills-category">
            <h3><i class="fas fa-server"></i> Backend Development</h3>
            <div class="skills-grid">
                <div class="skill-item">
                    <div class="skill-icon">
                        <i class="fab fa-php" style="color: #777bb4; font-size: 1.5rem;"></i>
                    </div>
                    <div class="skill-info">
                        <h4>PHP</h4>
                        <div class="skill-progress">
                            <div class="progress" style="width: 90%;"></div>
                        </div>
                    </div>
                </div>
                
                <div class="skill-item">
                    <div class="skill-icon">
                        <i class="fas fa-database" style="color: #4479a1; font-size: 1.5rem;"></i>
                    </div>
                    <div class="skill-info">
                        <h4>MySQL</h4>
                        <div class="skill-progress">
                            <div class="progress" style="width: 85%;"></div>
                        </div>
                    </div>
                </div>
                
                <div class="skill-item">
                    <div class="skill-icon">
                        <i class="fab fa-laravel" style="color: #ff2d20; font-size: 1.5rem;"></i>
                    </div>
                    <div class="skill-info">
                        <h4>Laravel</h4>
                        <div class="skill-progress">
                            <div class="progress" style="width: 75%;"></div>
                        </div>
                    </div>
                </div>
                
                <div class="skill-item">
                    <div class="skill-icon">
                        <i class="fas fa-code" style="color: #00e5ff; font-size: 1.5rem;"></i>
                    </div>
                    <div class="skill-info">
                        <h4>RESTful API</h4>
                        <div class="skill-progress">
                            <div class="progress" style="width: 80%;"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="skills-category">
            <h3><i class="fas fa-paint-brush"></i> Design & Tools</h3>
            <div class="skills-grid">
                <div class="skill-item">
                    <div class="skill-icon">
                        <i class="fab fa-figma" style="color: #f24e1e; font-size: 1.5rem;"></i>
                    </div>
                    <div class="skill-info">
                        <h4>Figma</h4>
                        <div class="skill-progress">
                            <div class="progress" style="width: 80%;"></div>
                        </div>
                    </div>
                </div>
                
                <div class="skill-item">
                    <div class="skill-icon">
                        <i class="fab fa-adobe" style="color: #ff0000; font-size: 1.5rem;"></i>
                    </div>
                    <div class="skill-info">
                        <h4>Photoshop</h4>
                        <div class="skill-progress">
                            <div class="progress" style="width: 75%;"></div>
                        </div>
                    </div>
                </div>
                
                <div class="skill-item">
                    <div class="skill-icon">
                        <i class="fas fa-search" style="color: #4285f4; font-size: 1.5rem;"></i>
                    </div>
                    <div class="skill-info">
                        <h4>SEO</h4>
                        <div class="skill-progress">
                            <div class="progress" style="width: 85%;"></div>
                        </div>
                    </div>
                </div>
                
                <div class="skill-item">
                    <div class="skill-icon">
                        <i class="fas fa-chart-line" style="color: #e37400; font-size: 1.5rem;"></i>
                    </div>
                    <div class="skill-info">
                        <h4>Analytics</h4>
                        <div class="skill-progress">
                            <div class="progress" style="width: 80%;"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>


<script>
// ✅ SMOOTH CUSTOM CURSOR
const cursor = document.createElement("div");
cursor.classList.add("custom-cursor");
document.body.appendChild(cursor);

let mouseX = 0, mouseY = 0;
let cursorX = 0, cursorY = 0;

function animateCursor() {
  cursorX += (mouseX - cursorX) * 0.15;
  cursorY += (mouseY - cursorY) * 0.15;
  cursor.style.transform = `translate3d(${cursorX}px, ${cursorY}px, 0)`;
  requestAnimationFrame(animateCursor);
}

animateCursor();

document.addEventListener("mousemove", (e) => {
  mouseX = e.clientX;
  mouseY = e.clientY;
});

// Hover efek
const interactiveElements = document.querySelectorAll("a, button, .social-icon, .btn, .skill-item, .about-info-item");
interactiveElements.forEach(el => {
  el.addEventListener("mouseenter", () => cursor.classList.add("hover"));
  el.addEventListener("mouseleave", () => cursor.classList.remove("hover"));
});

// ✅ RIPPLE ON BUTTON CLICK
const buttons = document.querySelectorAll(".btn");
buttons.forEach(btn => {
  btn.addEventListener("click", function(e) {
    const ripple = document.createElement("span");
    ripple.classList.add("ripple");
    this.appendChild(ripple);

    const maxDim = Math.max(this.offsetWidth, this.offsetHeight);
    ripple.style.width = ripple.style.height = `${maxDim}px`;
    ripple.style.left = `${e.offsetX - maxDim / 2}px`;
    ripple.style.top = `${e.offsetY - maxDim / 2}px`;

    setTimeout(() => ripple.remove(), 600);
  });
});

// ✅ INTERSECTION OBSERVER ANIMATIONS
const animatedItems = document.querySelectorAll(".skill-item, .about-info-item, .skills-category");
const observer = new IntersectionObserver((entries) => {
  entries.forEach(entry => {
    if (entry.isIntersecting) {
      entry.target.classList.add("in-view");
      observer.unobserve(entry.target);
    }
  });
}, { threshold: 0.2 });

animatedItems.forEach(item => {
  observer.observe(item);
});
</script>

<style>
/* ✅ CUSTOM CURSOR */
.custom-cursor {
  width: 20px;
  height: 20px;
  position: fixed;
  top: 0; left: 0;
  background: rgba(0,229,255,0.5);
  border: 2px solid #7c4dff;
  border-radius: 50%;
  transform: translate3d(0, 0, 0);
  pointer-events: none;
  z-index: 9999;
  transition: transform 0.15s cubic-bezier(0.25, 0.46, 0.45, 0.94);
  will-change: transform;
  backface-visibility: hidden;
}

.custom-cursor.hover {
  transform: scale(1.5);
  background: rgba(124, 77, 255, 0.6);
}

/* ✅ RIPPLE EFFECT */
.btn {
  position: relative;
  overflow: hidden;
}

.btn .ripple {
  position: absolute;
  background: rgba(255,255,255,0.5);
  border-radius: 50%;
  transform: scale(0);
  animation: ripple-effect 0.6s linear;
  pointer-events: none;
}

@keyframes ripple-effect {
  to {
    transform: scale(4);
    opacity: 0;
  }
}

/* ✅ ANIMATION STYLES */
.skill-item, .about-info-item, .skills-category {
  opacity: 0;
  transform: translateY(30px);
  transition: all 0.7s cubic-bezier(0.25, 0.46, 0.45, 0.94);
  will-change: transform, opacity;
  contain: layout paint;
}

.in-view {
  opacity: 1;
  transform: translateY(0);
}
</style>
</script>

<?php require_once '../templates/footer.php'; ?>
