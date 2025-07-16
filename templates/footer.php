</main>
    
    <!-- Footer -->
    <footer class="glassmorphism">
        <div class="container">
            <div class="footer-content">
                <div class="footer-logo">
                    <h3><?= OWNER_NAME ?></h3>
                    <p>Web Developer & UI/UX Designer</p>
                </div>
                
                <div class="footer-social">
                    <h4><?= __('connect_with_me') ?></h4>
                    <div class="social-icons">
                        <a href="https://github.com/alfaragatak87<?= OWNER_GITHUB ?>" target="_blank" class="social-icon"><i class="fab fa-github"></i></a>
                        <a href="mailto:s.s.6624844@gmail.com<?= OWNER_EMAIL ?>" class="social-icon"><i class="fas fa-envelope"></i></a>
                        <a href="https://wa.me/083188813237<?= str_replace(['+', ' '], '', OWNER_WHATSAPP) ?>" class="social-icon"><i class="fab fa-whatsapp"></i></a>
                        <a href="https://www.instagram.com/alfamuhammad___/" class="social-icon"><i class="fab fa-instagram"></i></a>
                    </div>
                </div>
                
                <div class="footer-nav">
                    <h4><?= __('navigation') ?></h4>
                    <ul>
                        <li><a href="<?= BASE_URL ?>/pages/index.php"><?= __('home') ?></a></li>
                        <li><a href="<?= BASE_URL ?>/pages/about.php"><?= __('about') ?></a></li>
                        <li><a href="<?= BASE_URL ?>/pages/projects.php"><?= __('projects') ?></a></li>
                        <li><a href="<?= BASE_URL ?>/pages/cv.php"><?= __('cv') ?></a></li>
                        <li><a href="<?= BASE_URL ?>/pages/semester.php"><?= __('semester') ?></a></li>
                        <li><a href="<?= BASE_URL ?>/pages/blog.php"><?= __('blog') ?></a></li>
                        <li><a href="<?= BASE_URL ?>/pages/contact.php"><?= __('contact') ?></a></li>
                        <li><a href="<?= BASE_URL ?>/pages/testimonials.php"><?= __('testimonials') ?></a></li>
                    </ul>
                </div>
            </div>
            
            <div class="footer-bottom">
                <p>&copy; <?= date('Y') ?> <?= OWNER_NAME ?>. <?= __('all_rights_reserved') ?></p>
            </div>
        </div>
    </footer>
    
    <!-- JavaScript -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/particles.js/2.0.0/particles.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/aos/2.3.4/aos.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/typed.js/2.0.12/typed.min.js"></script>
    <script src="<?= BASE_URL ?>/assets/js/main.js"></script>
</body>
</html>