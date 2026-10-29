<?php
require 'database.php';

$kosten = $_GET['kosten'] ?? '';
$duur = $_GET['duur'] ?? '';

$sql = "SELECT * FROM diensten";

if ($kosten !== '' && is_numeric($kosten)) {
    $sql .= " WHERE prijs = :kosten";
}

if ($duur === 'ASC') {
    $sql .= " ORDER BY duur_minuten ASC";
} elseif ($duur === 'DESC') {
    $sql .= " ORDER BY duur_minuten DESC";
}

$stmt = $conn->prepare($sql);

if ($kosten !== '' && is_numeric($kosten)) {
    $stmt->execute(['kosten' => $kosten]);
} else {
    $stmt->execute();
}

$diensten = $stmt->fetchAll(PDO::FETCH_ASSOC);

require 'header.php';
?>



<main>
    <h1>Onze diensten</h1>
    <p>Bekijk wat De Sleutelwerk voor jouw auto kan doen.</p>
    <div class="filters">
        <h2>Filters</h2>
        <a href="index.php">reset filters</a>
        <form method="GET" action="dienst_filter.php">
            <label for="kosten">Filter op prijs:</label>
            <select id="kosten" name="kosten">
                <option value="">Alle prijzen</option>
                <?php foreach ($diensten as $dienst): ?>
                    <option value="<?= htmlspecialchars($dienst['prijs']) ?>">
                        €<?= htmlspecialchars($dienst['prijs']) ?>
                    </option>
                <?php endforeach; ?>
            </select>

            <label for="duur">Sorteren op duur:</label>
            <select id="duur" name="duur">
                <option value="">Standaard</option>
                <option value="ASC">Kortste naar langste</option>
                <option value="DESC">Langste naar kortste</option>
            </select>

            <button type="submit">Filter</button>
        </form>
    </div>
    <section class="diensten filter-resultaten">
        <?php foreach ($diensten as $dienst): ?>
            <div class="dienst">

                <img src="images/<?= htmlspecialchars($dienst['afbeelding']) ?>"
                    alt="<?= htmlspecialchars($dienst['naam']) ?>">

                <h2><?= htmlspecialchars($dienst['naam']) ?></h2>

                <p><?= htmlspecialchars($dienst['omschrijving']) ?></p>

                <p>Duur: <?= htmlspecialchars($dienst['duur_minuten']) ?> minuten</p>

                <p>Prijs: € <?= htmlspecialchars($dienst['prijs']) ?></p>

                <a href="dienst_detail.php?dienst_id=<?= htmlspecialchars($dienst['dienst_id']) ?>">
                    Meer informatie
                </a>

            </div>
        <?php endforeach; ?>
    </section>