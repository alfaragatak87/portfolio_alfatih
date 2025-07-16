<?php
$pageTitle = "Semester Data";
require_once '../config/koneksi.php';
require_once '../templates/header.php';

// Get semester parameter
$semester = isset($_GET['semester']) ? (int)$_GET['semester'] : 0;

// Get data if semester specified
$semesterData = [];
if ($semester > 0) {
    $stmt = $pdo->prepare("SELECT * FROM semester_data WHERE semester = :semester ORDER BY mata_kuliah");
    $stmt->bindParam(':semester', $semester);
    $stmt->execute();
    $semesterData = $stmt->fetchAll();
}

// Get counts by semester for navigation
$stmt = $pdo->query("SELECT semester, COUNT(*) as count FROM semester_data GROUP BY semester ORDER BY semester");
$semesterCounts = [];
while ($row = $stmt->fetch()) {
    $semesterCounts[$row['semester']] = $row['count'];
}
?>

<!-- Semester Hero Section -->
<section class="semester-hero section-padding">
    <div class="container">
        <div class="section-header" data-aos="fade-up">
            <h1><?= $semester > 0 ? 'Semester ' . $semester . ' Data' : 'Semester Data' ?></h1>
            <p><?= $semester > 0 ? 'Courses and materials for Semester ' . $semester : 'Select a semester to view courses and materials' ?></p>
        </div>
    </div>
</section>

<!-- Semester Navigation -->
<section class="semester-nav section-padding">
    <div class="container">
        <div class="semester-tabs" data-aos="fade-up">
            <?php for ($i = 1; $i <= 8; $i++): ?>
                <a href="<?= BASE_URL ?>/pages/semester.php?semester=<?= $i ?>" class="semester-tab <?= $semester == $i ? 'active' : '' ?>">
                    Semester <?= $i ?>
                    <?php if (isset($semesterCounts[$i])): ?>
                        <span class="semester-count"><?= $semesterCounts[$i] ?></span>
                    <?php endif; ?>
                </a>
            <?php endfor; ?>
        </div>
    </div>
</section>

<?php if ($semester > 0): ?>
    <!-- Semester Content -->
    <section class="semester-content section-padding">
        <div class="container">
            <?php if (count($semesterData) > 0): ?>
                <div class="semester-courses" data-aos="fade-up">
                    <?php foreach ($semesterData as $index => $course): ?>
                        <div class="course-card" data-aos="fade-up" data-aos-delay="<?= $index * 100 ?>">
                            <div class="course-header">
                                <h3><?= $course['mata_kuliah'] ?></h3>
                                <span class="course-date"><?= date('d M Y', strtotime($course['tanggal_upload'])) ?></span>
                            </div>
                            
                            <?php if (!empty($course['deskripsi'])): ?>
                                <div class="course-description">
                                    <p><?= nl2br($course['deskripsi']) ?></p>
                                </div>
                            <?php endif; ?>
                            
                            <?php if (!empty($course['file'])): ?>
                                <div class="course-file">
                                    <a href="<?= BASE_URL ?>/uploads/semester/<?= $course['file'] ?>" class="btn btn-outline" target="_blank">
                                        <i class="fas fa-file-download"></i> Download Material
                                    </a>
                                </div>
                            <?php endif; ?>
                        </div>
                    <?php endforeach; ?>
                </div>
            <?php else: ?>
                <div class="no-data" data-aos="fade-up">
                    <div class="no-data-icon">
                        <i class="fas fa-book"></i>
                    </div>
                    <h3>No courses found</h3>
                    <p>There are no courses or materials available for Semester <?= $semester ?> yet.</p>
                </div>
            <?php endif; ?>
        </div>
    </section>
<?php else: ?>
    <!-- Semester Selection Grid -->
    <section class="semester-selection section-padding">
        <div class="container">
            <div class="semester-grid">
                <?php for ($i = 1; $i <= 8; $i++): ?>
                    <a href="<?= BASE_URL ?>/pages/semester.php?semester=<?= $i ?>" class="semester-card" data-aos="fade-up" data-aos-delay="<?= ($i - 1) * 100 ?>">
                        <div class="semester-number"><?= $i ?></div>
                        <h3>Semester <?= $i ?></h3>
                        <?php if (isset($semesterCounts[$i])): ?>
                            <p><?= $semesterCounts[$i] ?> course<?= $semesterCounts[$i] !== 1 ? 's' : '' ?></p>
                        <?php else: ?>
                            <p>No courses yet</p>
                        <?php endif; ?>
                    </a>
                <?php endfor; ?>
            </div>
        </div>
    </section>
<?php endif; ?>

<!-- Add CSS for semester pages -->
<style>
    .semester-tabs {
        display: flex;
        flex-wrap: wrap;
        justify-content: center;
        gap: 10px;
        margin-bottom: 30px;
    }
    
    .semester-tab {
        padding: 10px 20px;
        background-color: var(--dark-card);
        color: var(--text-secondary);
        border-radius: 30px;
        transition: all 0.3s ease;
        position: relative;
    }
    
    .semester-tab.active, .semester-tab:hover {
        background-color: var(--primary-color);
        color: var(--dark-bg);
        transform: translateY(-3px);
    }
    
    .semester-count {
        position: absolute;
        top: -10px;
        right: -10px;
        background-color: var(--secondary-color);
        color: white;
        font-size: 12px;
        width: 24px;
        height: 24px;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
    }
    
    .semester-grid {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
        gap: 20px;
    }
    
    .semester-card {
        background-color: var(--dark-card);
        border-radius: 15px;
        padding: 30px 20px;
        text-align: center;
        transition: all 0.3s ease;
        text-decoration: none;
        color: var(--text-primary);
    }
    
    .semester-card:hover {
        transform: translateY(-10px);
        box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
    }
    
    .semester-card:hover .semester-number {
        background-color: var(--primary-color);
        color: var(--dark-bg);
    }
    
    .semester-number {
        width: 60px;
        height: 60px;
        border-radius: 50%;
        background-color: rgba(0, 229, 255, 0.1);
        color: var(--primary-color);
        display: flex;
        align-items: center;
        justify-content: center;
        margin: 0 auto 15px;
        font-size: 24px;
        font-weight: 700;
        transition: all 0.3s ease;
    }
    
    .semester-card h3 {
        margin-bottom: 10px;
    }
    
    .semester-card p {
        color: var(--text-secondary);
        margin-bottom: 0;
    }
    
    .semester-courses {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
        gap: 20px;
    }
    
    .course-card {
        background-color: var(--dark-card);
        border-radius: 15px;
        padding: 25px;
        transition: all 0.3s ease;
    }
    
    .course-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
    }
    
    .course-header {
        display: flex;
        justify-content: space-between;
        align-items: flex-start;
        margin-bottom: 15px;
        padding-bottom: 15px;
        border-bottom: 1px solid rgba(255, 255, 255, 0.1);
    }
    
    .course-header h3 {
        margin-bottom: 0;
        flex: 1;
    }
    
    .course-date {
        font-size: 0.9rem;
        color: var(--text-muted);
        white-space: nowrap;
        margin-left: 15px;
    }
    
    .course-description {
        margin-bottom: 20px;
    }
    
    .course-file {
        text-align: center;
    }
    
    @media (max-width: 768px) {
        .semester-tabs {
            overflow-x: auto;
            justify-content: flex-start;
            padding-bottom: 10px;
        }
        
        .semester-tab {
            white-space: nowrap;
        }
        
        .course-header {
            flex-direction: column;
        }
        
        .course-date {
            margin-left: 0;
            margin-top: 10px;
        }
    }
</style>

<?php require_once '../templates/footer.php'; ?>