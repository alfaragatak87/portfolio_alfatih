<?php
ob_start();
$pageTitle = "Kelola Proyek";
require_once '../config/koneksi.php';
require_once '../includes/helpers.php';
require_once 'templates/header.php';

// Process action
$action = $_GET['action'] ?? '';
$id = isset($_GET['id']) ? (int)$_GET['id'] : 0;

// Delete project
if ($action === 'delete' && $id > 0) {
    try {
        // Get project image filename
        $stmt = $pdo->prepare("SELECT gambar_proyek FROM proyek WHERE id = :id");
        $stmt->bindParam(':id', $id);
        $stmt->execute();
        $project = $stmt->fetch();
        
        if ($project) {
            // Delete image file
            $imagePath = '../uploads/projects/' . $project['gambar_proyek'];
            if (file_exists($imagePath)) {
                unlink($imagePath);
            }
            
            // Delete project from database
            $stmt = $pdo->prepare("DELETE FROM proyek WHERE id = :id");
            $stmt->bindParam(':id', $id);
            $stmt->execute();
            
            setAlert('success', 'Project deleted successfully');
        } else {
            setAlert('error', 'Project not found');
        }
    } catch (PDOException $e) {
        setAlert('error', 'Error: ' . $e->getMessage());
    }
    
    header('Location: ' . BASE_URL . '/admin/kelola_proyek.php');
    exit;
}

// Process form submission (Add/Edit)
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $judul = trim($_POST['judul'] ?? '');
    $kategori = trim($_POST['kategori'] ?? '');
    $deskripsi = trim($_POST['deskripsi'] ?? '');
    $link_proyek = trim($_POST['link_proyek'] ?? '');
    $tanggal_dibuat = $_POST['tanggal_dibuat'] ?? date('Y-m-d');
    $is_featured = isset($_POST['is_featured']) ? 1 : 0;
    $project_id = isset($_POST['project_id']) ? (int)$_POST['project_id'] : 0;
    
    // Validate inputs
    $errors = [];
    
    if (empty($judul)) {
        $errors[] = 'Title is required';
    }
    
    if (empty($kategori)) {
        $errors[] = 'Category is required';
    }
    
    if (empty($deskripsi)) {
        $errors[] = 'Description is required';
    }
    
    if (empty($tanggal_dibuat)) {
        $errors[] = 'Date is required';
    }
    
    // If no errors, process form
    if (empty($errors)) {
        try {
            // Upload image if provided
            $gambar_proyek = '';
            
            if ($project_id > 0) {
                // Get current image if editing
                $stmt = $pdo->prepare("SELECT gambar_proyek FROM proyek WHERE id = :id");
                $stmt->bindParam(':id', $project_id);
                $stmt->execute();
                $currentProject = $stmt->fetch();
                $gambar_proyek = $currentProject['gambar_proyek'] ?? '';
            }
            
            if (!empty($_FILES['gambar_proyek']['name'])) {
                $uploadDir = '../uploads/projects/';
                if (!file_exists($uploadDir)) {
                    mkdir($uploadDir, 0777, true);
                }
                
                $fileExtension = pathinfo($_FILES['gambar_proyek']['name'], PATHINFO_EXTENSION);
                $newFileName = 'project_' . time() . '.' . $fileExtension;
                $targetPath = $uploadDir . $newFileName;
                
                if (move_uploaded_file($_FILES['gambar_proyek']['tmp_name'], $targetPath)) {
                    // Delete old image if exists and updating
                    if ($project_id > 0 && !empty($gambar_proyek) && file_exists($uploadDir . $gambar_proyek)) {
                        unlink($uploadDir . $gambar_proyek);
                    }
                    $gambar_proyek = $newFileName;
                } else {
                    setAlert('error', 'Failed to upload image');
                    header('Location: ' . BASE_URL . '/admin/kelola_proyek.php');
                    exit;
                }
            } elseif ($project_id === 0 && empty($gambar_proyek)) {
                // Require image for new projects
                setAlert('error', 'Project image is required');
                header('Location: ' . BASE_URL . '/admin/kelola_proyek.php?action=add');
                exit;
            }
            
            if ($project_id > 0) {
                // Update existing project
                $stmt = $pdo->prepare("UPDATE proyek SET judul = :judul, kategori = :kategori, deskripsi = :deskripsi, link_proyek = :link_proyek, tanggal_dibuat = :tanggal_dibuat, is_featured = :is_featured" . (!empty($gambar_proyek) ? ", gambar_proyek = :gambar_proyek" : "") . " WHERE id = :id");
                $stmt->bindParam(':id', $project_id);
            } else {
                // Add new project
                $stmt = $pdo->prepare("INSERT INTO proyek (judul, kategori, deskripsi, gambar_proyek, link_proyek, tanggal_dibuat, is_featured) VALUES (:judul, :kategori, :deskripsi, :gambar_proyek, :link_proyek, :tanggal_dibuat, :is_featured)");
            }
            
            $stmt->bindParam(':judul', $judul);
            $stmt->bindParam(':kategori', $kategori);
            $stmt->bindParam(':deskripsi', $deskripsi);
            $stmt->bindParam(':link_proyek', $link_proyek);
            $stmt->bindParam(':tanggal_dibuat', $tanggal_dibuat);
            $stmt->bindParam(':is_featured', $is_featured);
            
            if ($project_id === 0 || !empty($gambar_proyek)) {
                $stmt->bindParam(':gambar_proyek', $gambar_proyek);
            }
            
            $stmt->execute();
            
            setAlert('success', ($project_id > 0 ? 'Project updated' : 'Project added') . ' successfully');
            header('Location: ' . BASE_URL . '/admin/kelola_proyek.php');
            exit;
        } catch (PDOException $e) {
            setAlert('error', 'Error: ' . $e->getMessage());
        }
    } else {
        setAlert('error', implode('<br>', $errors));
    }
}

// Get project data if editing
$editProject = null;
if ($action === 'edit' && $id > 0) {
    $stmt = $pdo->prepare("SELECT * FROM proyek WHERE id = :id");
    $stmt->bindParam(':id', $id);
    $stmt->execute();
    $editProject = $stmt->fetch();
    
    if (!$editProject) {
        setAlert('error', 'Project not found');
        header('Location: ' . BASE_URL . '/admin/kelola_proyek.php');
        exit;
    }
}

// Get search term
$search = $_GET['search'] ?? '';

// Get all projects for listing with search functionality
$sql = "SELECT * FROM proyek";
if (!empty($search)) {
    $sql .= " WHERE judul LIKE :search OR kategori LIKE :search";
}
$sql .= " ORDER BY tanggal_dibuat DESC";
$stmt = $pdo->prepare($sql);

if (!empty($search)) {
    $searchTerm = "%{$search}%";
    $stmt->bindParam(':search', $searchTerm);
}
$stmt->execute();
$projects = $stmt->fetchAll();


// Get distinct categories for dropdown
$stmt = $pdo->query("SELECT DISTINCT kategori FROM proyek ORDER BY kategori");
$existingCategories = $stmt->fetchAll(PDO::FETCH_COLUMN);
?>

<div class="admin-content-container">
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
            <i class="fas fa-briefcase"></i> 
            <?= ($action === 'add' || $action === 'edit') ? ($action === 'add' ? 'Add New Project' : 'Edit Project') : 'Manage Projects' ?>
        </h1>
        <p><?= ($action === 'add' || $action === 'edit') ? 'Enter project details below' : 'View, edit or delete your projects' ?></p>
    </div>
    
    <?php if ($action === 'add' || $action === 'edit'): ?>
        <div class="admin-form-container">
            <form action="" method="POST" enctype="multipart/form-data">
                <?php if ($action === 'edit'): ?>
                    <input type="hidden" name="project_id" value="<?= $editProject['id'] ?>">
                <?php endif; ?>
                
                <div class="form-grid">
                    <div class="form-group">
                        <label for="judul">Project Title*</label>
                        <input type="text" id="judul" name="judul" class="form-control" value="<?= $editProject['judul'] ?? '' ?>" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="kategori">Category*</label>
                        <input type="text" id="kategori" name="kategori" class="form-control" list="kategori-list" value="<?= $editProject['kategori'] ?? '' ?>" required>
                        <datalist id="kategori-list">
                            <?php foreach ($existingCategories as $cat): ?>
                                <option value="<?= $cat ?>">
                            <?php endforeach; ?>
                        </datalist>
                    </div>
                    
                    <div class="form-group">
                        <label for="tanggal_dibuat">Date*</label>
                        <input type="date" id="tanggal_dibuat" name="tanggal_dibuat" class="form-control" value="<?= $editProject['tanggal_dibuat'] ?? date('Y-m-d') ?>" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="link_proyek">Project URL</label>
                        <input type="url" id="link_proyek" name="link_proyek" class="form-control" value="<?= $editProject['link_proyek'] ?? '' ?>" placeholder="https://example.com">
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="deskripsi">Description*</label>
                    <textarea id="deskripsi" name="deskripsi" class="form-control" rows="6" required><?= $editProject['deskripsi'] ?? '' ?></textarea>
                </div>
                
                <div class="form-group">
                    <label for="gambar_proyek">Project Image<?= ($action === 'add') ? '*' : '' ?></label>
                    <div class="custom-file">
                        <input type="file" id="gambar_proyek" name="gambar_proyek" class="custom-file-input" accept="image/*" <?= ($action === 'add') ? 'required' : '' ?>>
                        <label class="custom-file-label" for="gambar_proyek">Choose file</label>
                    </div>
                    <?php if ($action === 'edit' && !empty($editProject['gambar_proyek'])): ?>
                        <div class="image-preview">
                            <img src="<?= BASE_URL ?>/uploads/projects/<?= $editProject['gambar_proyek'] ?>" alt="Project Image">
                        </div>
                        <p class="form-text">Leave empty to keep current image</p>
                    <?php endif; ?>
                </div>
                
                <div class="form-group">
                    <div class="checkbox-group">
                        <input type="checkbox" id="is_featured" name="is_featured" value="1" <?= (isset($editProject['is_featured']) && $editProject['is_featured'] == 1) ? 'checked' : '' ?>>
                        <label for="is_featured">Feature this project (show on homepage)</label>
                    </div>
                </div>
                
                <div class="form-actions">
                    <button type="submit" class="btn btn-primary"><i class="fas fa-save"></i> <?= ($action === 'edit') ? 'Update' : 'Save' ?> Project</button>
                    <a href="<?= BASE_URL ?>/admin/kelola_proyek.php" class="btn btn-outline"><i class="fas fa-arrow-left"></i> Cancel</a>
                </div>
            </form>
        </div>
    <?php else: ?>
        <div class="admin-actions">
            <a href="<?= BASE_URL ?>/admin/kelola_proyek.php?action=add" class="btn btn-primary"><i class="fas fa-plus"></i> Add New Project</a>
            <div class="search-box">
                <form action="" method="GET">
                    <input type="text" name="search" placeholder="Search projects..." class="form-control" value="<?= htmlspecialchars($search) ?>">
                    <button type="submit" class="btn-search"><i class="fas fa-search"></i></button>
                </form>
            </div>
        </div>
        
        <div class="admin-card">
            <div class="card-body">
                <?php if (count($projects) > 0): ?>
                    <div class="table-responsive">
                        <table class="admin-table">
                            <thead>
                                <tr>
                                    <th>Image</th>
                                    <th>Title</th>
                                    <th>Category</th>
                                    <th>Date</th>
                                    <th>Featured</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php foreach ($projects as $project): ?>
                                    <tr>
                                        <td>
                                            <div class="table-image">
                                                <img src="<?= BASE_URL ?>/uploads/projects/<?= $project['gambar_proyek'] ?>" alt="<?= $project['judul'] ?>">
                                            </div>
                                        </td>
                                        <td><?= $project['judul'] ?></td>
                                        <td><?= $project['kategori'] ?></td>
                                        <td><?= date('d M Y', strtotime($project['tanggal_dibuat'])) ?></td>
                                        <td>
                                            <span class="status-badge <?= $project['is_featured'] ? 'status-active' : 'status-inactive' ?>">
                                                <?= $project['is_featured'] ? 'Yes' : 'No' ?>
                                            </span>
                                        </td>
                                        <td>
                                            <a href="<?= BASE_URL ?>/admin/kelola_proyek.php?action=edit&id=<?= $project['id'] ?>" class="action-btn edit-btn" title="Edit">
                                                <i class="fas fa-edit"></i>
                                            </a>
                                            <a href="<?= BASE_URL ?>/admin/kelola_proyek.php?action=delete&id=<?= $project['id'] ?>" class="action-btn delete-btn" title="Delete" onclick="return confirm('Are you sure you want to delete this project?')">
                                                <i class="fas fa-trash-alt"></i>
                                            </a>
                                        </td>
                                    </tr>
                                <?php endforeach; ?>
                            </tbody>
                        </table>
                    </div>
                <?php else: ?>
                    <p class="no-data">No projects found. <a href="<?= BASE_URL ?>/admin/kelola_proyek.php?action=add">Add your first project</a>.</p>
                <?php endif; ?>
            </div>
        </div>
    <?php endif; ?>
</div>

<?php 
require_once 'templates/footer.php';
ob_end_flush();
?>