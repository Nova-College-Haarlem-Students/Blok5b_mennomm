<?php
session_start();
require 'database.php';

if (!isset($_GET['dienst_id']) || !is_numeric($_GET['dienst_id'])) {
    header('Location: 404.php');
    exit;
    }
    
$id = (int)$_GET['dienst_id'];
    
    try {
    $stmt = $conn->prepare("SELECT * FROM diesten WHERE dienst_id = :id");
    $stmt->execute(['id' => $id]);
    $dienst = $stmt->fetch(PDO::FETCH_ASSOC);
   
    if (!$dienst) {
        header('Location: 404.php');
        exit;
    }
} catch (PDOException $e) {
    // Log de error (niet tonen aan gebruiker!)
    error_log("Database error: " . $e->getMessage());
    header('Location: 500.php');
    exit;
}
require 'header.php';
?>
<main class="detail-pagina">
    <h1><?= htmlspecialchars($dienst['naam']) ?></h1>
    <p>Bekijk alle informatie over deze dienst.</p>
    <div class="detail-kaart">
        <img src="images/<?= htmlspecialchars($dienst['afbeelding']) ?>" alt="<?= htmlspecialchars($dienst['naam']) ?>">
        <div class="detail-info">
            <h2><?= htmlspecialchars($dienst['naam']) ?></h2>
            <p>
                <strong>Omschrijving:</strong><br>
                <?= htmlspecialchars($dienst['omschrijving']) ?>
            </p>
            <p>
                <strong>Duur:</strong>
                <?= htmlspecialchars($dienst['duur_minuten']) ?> minuten
            </p>
            <p>
                <strong>Prijs:</strong>
                € <?= htmlspecialchars($dienst['prijs']) ?>
            </p>
        </div>

    </div>
    <a href="index.php" class="terug-knop">Terug naar overzicht</a>
</main>
<?php require 'footer.php'; ?>