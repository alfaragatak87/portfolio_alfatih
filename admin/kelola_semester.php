<?php
ob_start();
$pageTitle = "Data Semester";
require_once '../config/koneksi.php';
require_once '../includes/helpers.php';
require_once 'templates/header.php';

// Process action
$action = $_GET['action'] ?? '';
$id = isset($_GET['id']) ? (int)$_GET['id'] : 0;
$semester = isset($_GET['semester']) ? (int)$_GET['semester'] : 0;

// Create semester_data table if not exists
try {
    $pdo->exec("CREATE TABLE IF NOT EXISTS `semester_data` (
        `id` INT PRIMARY KEY AUTO_INCREMENT,
        `semester` INT NOT NULL,
        `mata_kuliah` VARCHAR(255) NOT NULL,
        `deskripsi` TEXT,
        `file` VARCHAR(255),
        `tanggal_upload` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    )");
} catch (PDOException $e) {
    setAlert('error', 'Error creating table: ' . $e->getMessage());
}

// Delete semester data
if ($action === 'delete' && $id > 0) {
    try {
        // Get file name
        $stmt = $pdo->prepare("SELECT file FROM semester_data WHERE id = :id");
        $stmt->bindParam(':id', $id);
        $stmt->execute();
        $data = $stmt->fetch();
        
        if ($data && !empty($data['file'])) {
            // Delete file
            $filePath = '../uploads/semester/' . $data['file'];
            if (file_exists($filePath)) {
                unlink($filePath);
            }
        }
        
        // Delete from database
        $stmt = $pdo->prepare("DELETE FROM semester_data WHERE id = :id");
        $stmt->bindParam(':id', $id);
        $stmt->execute();
        
        setAlert('success', 'Data deleted successfully');
        header('Location: ' . BASE_URL . '/admin/kelola_semester.php?semester=' . $semester);
        exit;
    } catch (PDOException $e) {
        setAlert('error', 'Error: ' . $e->getMessage());
    }
}

// Process form submission
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $mata_kuliah = trim($_POST['mata_kuliah'] ?? '');
    $deskripsi = trim($_POST['deskripsi'] ?? '');
    $semester = (int)($_POST['semester'] ?? 1);
    $data_id = isset($_POST['data_id']) ? (int)$_POST['data_id'] : 0;
    
    // Validate inputs
    $errors = [];
    
    if (empty($mata_kuliah)) {
        $errors[] = 'Course name is required';
    }
    
    if ($semester < 1 || $semester > 8) {
        $errors[] = 'Invalid semester';
    }
    
    // If no errors, process form
    if (empty($errors)) {
        try {
            // Upload file if provided
            $file = '';
            
            if ($data_id > 0) {
                // Get current file if editing
                $stmt = $pdo->prepare("SELECT file FROM semester_data WHERE id = :id");
                $stmt->bindParam(':id', $data_id);
                $stmt->execute();
                $currentData = $stmt->fetch();
                $file = $currentData['file'] ?? '';
            }
            
            if (!empty($_FILES['file']['name'])) {
                $uploadDir = '../uploads/semester/';
                if (!file_exists($uploadDir)) {
                    mkdir($uploadDir, 0777, true);
                }
                
                $fileExtension = pathinfo($_FILES['file']['name'], PATHINFO_EXTENSION);
                $newFileName = 'semester_' . $semester . '_' . time() . '.' . $fileExtension;
                $targetPath = $uploadDir . $newFileName;
                
                if (move_uploaded_file($_FILES['file']['tmp_name'], $targetPath)) {
                    // Delete old file if exists and updating
                    if ($data_id > 0 && !empty($file) && file_exists($uploadDir . $file)) {
                        unlink($uploadDir . $file);
                    }
                    $file = $newFileName;
                } else {
                    setAlert('error', 'Failed to upload file');
                    header('Location: ' . BASE_URL . '/admin/kelola_semester.php?semester=' . $semester);
                    exit;
                }
            }
            
            if ($data_id > 0) {
                // Update existing data
                $stmt = $pdo->prepare("UPDATE semester_data SET mata_kuliah = :mata_kuliah, deskripsi = :deskripsi, semester = :semester" . (!empty($file) ? ", file = :file" : "") . " WHERE id = :id");
                $stmt->bindParam(':id', $data_id);
            } else {
                // Add new data
                $stmt = $pdo->prepare("INSERT INTO semester_data (mata_kuliah, deskripsi, semester, file) VALUES (:mata_kuliah, :deskripsi, :semester, :file)");
            }
            
            $stmt->bindParam(':mata_kuliah', $mata_kuliah);
            $stmt->bindParam(':deskripsi', $deskripsi);
            $stmt->bindParam(':semester', $semester);
            
            if ($data_id === 0 || !empty($file)) {
                $stmt->bindParam(':file', $file);
            }
            
            $stmt->execute();
            
            setAlert('success', ($data_id > 0 ? 'Data updated' : 'Data added') . ' successfully');
            header('Location: ' . BASE_URL . '/admin/kelola_semester.php?semester=' . $semester);
            exit;
        } catch (PDOException $e) {
            setAlert('error', 'Error: ' . $e->getMessage());
        }
    } else {
        setAlert('error', implode('<br>', $errors));
    }
}

// Get data if editing
$editData = null;
if ($action === 'edit' && $id > 0) {
    $stmt = $pdo->prepare("SELECT * FROM semester_data WHERE id = :id");
    $stmt->bindParam(':id', $id);
    $stmt->execute();
    $editData = $stmt->fetch();
    
    if (!$editData) {
        setAlert('error', 'Data not found');
        header('Location: ' . BASE_URL . '/admin/kelola_semester.php');
        exit;
    }
    
    $semester = $editData['semester'];
}

// Get semester data
if ($semester > 0) {
    $stmt = $pdo->prepare("SELECT * FROM semester_data WHERE semester = :semester ORDER BY mata_kuliah");
    $stmt->bindParam(':semester', $semester);
    $stmt->execute();
    $semesterData = $stmt->fetchAll();
} else {
    // Get counts by semester
    $stmt = $pdo->query("SELECT semester, COUNT(*) as count FROM semester_data GROUP BY semester ORDER BY semester");
    $semesterCounts = $stmt->fetchAll();
}
?>

<div class="admin-content-container">
    <!-- Tambahkan di awal semua halaman admin (seperti kelola_proyek.php, kelola_artikel.php, dll) -->

<div class="admin-breadcrumb">
    <div class="breadcrumb-container">
        <a href="<?= BASE_URL ?>/admin/dashboard.php" class="breadcrumb-item"><i class="fas fa-home"></i> Dashboard</a>
        <span class="breadcrumb-separator"><i class="fas fa-chevron-right"></i></span>
        <span class="breadcrumb-item active"><?= $pageTitle ?></span>
    </div>
    <div class="breadcrumb-actions">
        <a href="<?= BASE_URL ?>/admin/dashboard.php" class="btn btn-outline btn-sm"><i class="fas fa-arrow-left"></i> Back to Dashboard</a>
        <a href="<?= BASE_URL ?>" target="_blank" class="btn btn-primary btn-sm"><i class="fas fa-external-link-alt"></i> View Site</a>
    </div>
</div>
    <div class="admin-content-header">
        <h1>
            <i class="fas fa-graduation-cap"></i> 
            <?= $action === 'add' ? 'Add New Course Data' : ($action === 'edit' ? 'Edit Course Data' : ($semester > 0 ? 'Semester ' . $semester . ' Data' : 'Semester Data')) ?>
        </h1>
        <p><?= $action === 'add' || $action === 'edit' ? 'Enter course details below' : ($semester > 0 ? 'Manage your courses and materials for Semester ' . $semester : 'Select a semester to manage') ?></p>
    </div>
    
    <?php if ($semester === 0 && $action === ''): ?>
        <!-- Semester Selection -->
        <div class="semester-grid">
            <?php for ($i = 1; $i <= 8; $i++): ?>
                <?php 
                $count = 0;
                foreach ($semesterCounts as $semCount) {
                    if ($semCount['semester'] == $i) {
                        $count = $semCount['count'];
                        break;
                    }
                }
                ?>
                <a href="<?= BASE_URL ?>/admin/kelola_semester.php?semester=<?= $i ?>" class="semester-card">
                    <div class="semester-number"><?= $i ?></div>
                    <h3>Semester <?= $i ?></h3>
                    <p><?= $count ?> course<?= $count !== 1 ? 's' : '' ?></p>
                </a>
            <?php endfor; ?>
        </div>
    <?php elseif ($action === 'add' || $action === 'edit'): ?>
        <!-- Add/Edit Form -->
        <div class="admin-form-container">
            <form action="" method="POST" enctype="multipart/form-data">
                <?php if ($action === 'edit'): ?>
                    <input type="hidden" name="data_id" value="<?= $editData['id'] ?>">
                <?php endif; ?>
                
                <div class="form-grid">
                    <div class="form-group">
                        <label for="mata_kuliah">Course Name*</label>
                        <input type="text" id="mata_kuliah" name="mata_kuliah" class="form-control" value="<?= $editData['mata_kuliah'] ?? '' ?>" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="semester">Semester*</label>
                        <select id="semester" name="semester" class="form-control" required>
                            <?php for ($i = 1; $i <= 8; $i++): ?>
                                <option value="<?= $i ?>" <?= (isset($editData['semester']) && $editData['semester'] == $i) || (!isset($editData) && $semester == $i) ? 'selected' : '' ?>>
                                    Semester <?= $i ?>
                                </option>
                            <?php endfor; ?>
                        </select>
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="deskripsi">Description</label>
                    <textarea id="deskripsi" name="deskripsi" class="form-control" rows="5"><?= $editData['deskripsi'] ?? '' ?></textarea>
                </div>
                
                <div class="form-group">
                    <label for="file">File<?= $action === 'add' ? '' : ' (Leave empty to keep current file)' ?></label>
                    <div class="custom-file">
                        <input type="file" id="file" name="file" class="custom-file-input">
                        <label class="custom-file-label" for="file">Choose file</label>
                    </div>
                    <?php if ($action === 'edit' && !empty($editData['file'])): ?>
                        <p class="form-text">Current file: <a href="<?= BASE_URL ?>/uploads/semester/<?= $editData['file'] ?>" target="_blank"><?= $editData['file'] ?></a></p>
                    <?php endif; ?>
                </div>
                
                <div class="form-actions">
                    <button type="submit" class="btn btn-primary"><i class="fas fa-save"></i> <?= $action === 'edit' ? 'Update' : 'Save' ?> Data</button>
                    <a href="<?= BASE_URL ?>/admin/kelola_semester.php?semester=<?= $semester ?>" class="btn btn-outline"><i class="fas fa-arrow-left"></i> Cancel</a>
                </div>
            </form>
        </div>
    <?php elseif ($semester > 0): ?>
        <!-- Semester Data List -->
        <div class="admin-actions">
            <a href="<?= BASE_URL ?>/admin/kelola_semester.php" class="btn btn-outline"><i class="fas fa-arrow-left"></i> Back to Semesters</a>
            <a href="<?= BASE_URL ?>/admin/kelola_semester.php?action=add&semester=<?= $semester ?>" class="btn btn-primary"><i class="fas fa-plus"></i> Add New Course</a>
        </div>
        
        <div class="admin-card">
            <div class="card-body">
                <?php if (count($semesterData) > 0): ?>
                    <div class="table-responsive">
                        <table class="admin-table">
                            <thead>
                                <tr>
                                    <th>Course Name</th>
                                    <th>Description</th>
                                    <th>File</th>
                                    <th>Date Added</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php foreach ($semesterData as $data): ?>
                                    <tr>
                                        <td><?= $data['mata_kuliah'] ?></td>
                                        <td><?= truncateText($data['deskripsi'] ?? 'No description', 100) ?></td>
                                        <td>
                                            <?php if (!empty($data['file'])): ?>
                                                <a href="<?= BASE_URL ?>/uploads/semester/<?= $data['file'] ?>" target="_blank" class="file-link">
                                                    <i class="fas fa-file-alt"></i> View File
                                                </a>
                                            <?php else: ?>
                                                <span class="text-muted">No file</span>
                                            <?php endif; ?>
                                        </td>
                                        <td><?= date('d M Y', strtotime($data['tanggal_upload'])) ?></td>
                                        <td>
                                            <a href="<?= BASE_URL ?>/admin/kelola_semester.php?action=edit&id=<?= $data['id'] ?>" class="action-btn edit-btn" title="Edit">
                                                <i class="fas fa-edit"></i>
                                            </a>
                                            <a href="<?= BASE_URL ?>/admin/kelola_semester.php?action=delete&id=<?= $data['id'] ?>&semester=<?= $semester ?>" class="action-btn delete-btn" title="Delete" onclick="return confirm('Are you sure you want to delete this data?')">
                                                <i class="fas fa-trash-alt"></i>
                                            </a>
                                        </td>
                                    </tr>
                                <?php endforeach; ?>
                            </tbody>
                        </table>
                    </div>
                <?php else: ?>
                    <p class="no-data">No data found for Semester <?= $semester ?>. <a href="<?= BASE_URL ?>/admin/kelola_semester.php?action=add&semester=<?= $semester ?>">Add your first course</a>.</p>
                <?php endif; ?>
            </div>
        </div>
    <?php endif; ?>
</div>

<style>
    .semester-grid {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
        gap: 20px;
        margin-top: 20px;
    }
    
    .semester-card {
        background-color: var(--dark-card);
        border-radius: 10px;
        padding: 30px 20px;
        text-align: center;
        transition: all 0.3s ease;
        text-decoration: none;
        color: var(--text-primary);
        position: relative;
        overflow: hidden;
    }
    
    .semester-card:hover {
        transform: translateY(-10px);
        box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
        background-color: var(--dark-surface);
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
    
    .file-link {
        display: inline-flex;
        align-items: center;
        color: var(--primary-color);
    }
    
    .file-link i {
        margin-right: 5px;
    }
</style>

<?php 
require_once 'templates/footer.php';
ob_end_flush();
?>