-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: mariadb
-- Gegenereerd op: 27 okt 2026 om 11:14
-- Serverversie: 10.11.16-MariaDB-ubu2204
-- PHP-versie: 8.3.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `autogarage`
--

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `afspraken`
--

CREATE TABLE `afspraken` (
  `afspraak_id` int(11) NOT NULL,
  `dienst_id` int(11) NOT NULL,
  `auto_id` int(11) NOT NULL,
  `gebruiker_id` int(11) NOT NULL,
  `datum` date NOT NULL,
  `tijd` time NOT NULL,
  `kilometerstand` int(11) DEFAULT NULL,
  `opmerking` varchar(255) DEFAULT NULL,
  `prijs_bij_boeking` decimal(10,0) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Gegevens worden geëxporteerd voor tabel `afspraken`
--

INSERT INTO `afspraken` (`afspraak_id`, `dienst_id`, `auto_id`, `gebruiker_id`, `datum`, `tijd`, `kilometerstand`, `opmerking`, `prijs_bij_boeking`) VALUES
(1, 1, 1, 3, '2026-11-02', '09:00:00', 65000, 'Graag ook de banden controleren', 149),
(2, 3, 3, 4, '2026-11-03', '10:30:00', 82000, 'APK-keuring', 49),
(3, 2, 4, 5, '2026-11-04', '13:00:00', 45000, 'Grote onderhoudsbeurt', 299),
(4, 4, 2, 3, '2026-11-05', '14:00:00', 38000, 'Winterbanden monteren', 39),
(5, 5, 5, 5, '2026-11-06', '11:00:00', 21000, 'Airco koelt niet goed', 89);

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `auditlogs`
--

CREATE TABLE `auditlogs` (
  `log_id` int(11) NOT NULL,
  `gebruiker_id` int(11) DEFAULT NULL,
  `actie` varchar(255) DEFAULT NULL,
  `entiteit` varchar(255) DEFAULT NULL,
  `entiteit_id` varchar(255) DEFAULT NULL,
  `oude_waarde` varchar(255) DEFAULT NULL,
  `nieuwe_waarde` varchar(255) DEFAULT NULL,
  `tijd` time DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Gegevens worden geëxporteerd voor tabel `auditlogs`
--

INSERT INTO `auditlogs` (`log_id`, `gebruiker_id`, `actie`, `entiteit`, `entiteit_id`, `oude_waarde`, `nieuwe_waarde`, `tijd`) VALUES
(1, 1, 'INSERT', 'gebruikers', '3', NULL, 'Lisa Visser aangemaakt', '09:00:00'),
(2, 1, 'INSERT', 'autos', '1', NULL, 'Volkswagen Golf toegevoegd', '09:15:00'),
(3, 2, 'INSERT', 'afspraken', '1', NULL, 'Afspraak aangemaakt', '10:00:00'),
(4, 2, 'UPDATE', 'diensten', '1', 'Prijs: 139', 'Prijs: 149', '10:30:00'),
(5, 1, 'INSERT', 'afspraken', '2', NULL, 'APK-afspraak aangemaakt', '11:00:00');

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `autos`
--

CREATE TABLE `autos` (
  `auto_id` int(11) NOT NULL,
  `gebruiker_id` int(11) NOT NULL,
  `kenteken` varchar(255) NOT NULL,
  `merk_id` int(11) NOT NULL,
  `model` varchar(255) DEFAULT NULL,
  `bouwjaar` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Gegevens worden geëxporteerd voor tabel `autos`
--

INSERT INTO `autos` (`auto_id`, `gebruiker_id`, `kenteken`, `merk_id`, `model`, `bouwjaar`) VALUES
(1, 3, 'AB-123-C', 1, 'Golf', 2020),
(2, 3, 'XY-456-Z', 2, '3 Serie', 2022),
(3, 4, 'KL-789-M', 3, 'Yaris', 2019),
(4, 5, 'NP-234-R', 4, 'Focus', 2021),
(5, 5, 'ST-567-V', 5, 'A4', 2023);

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `diensten`
--

CREATE TABLE `diensten` (
  `dienst_id` int(11) NOT NULL,
  `naam` varchar(255) DEFAULT NULL,
  `omschrijving` varchar(255) DEFAULT NULL,
  `duur_minuten` int(11) DEFAULT NULL,
  `prijs` decimal(10,0) DEFAULT NULL,
  `actief` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Gegevens worden geëxporteerd voor tabel `diensten`
--

INSERT INTO `diensten` (`dienst_id`, `naam`, `omschrijving`, `duur_minuten`, `prijs`, `actief`) VALUES
(1, 'Kleine beurt', 'Olie en filters vervangen', 60, 149, 1),
(2, 'Grote beurt', 'Uitgebreid onderhoud van de auto', 120, 299, 1),
(3, 'APK-keuring', 'Algemene periodieke keuring', 45, 49, 1),
(4, 'Bandenwissel', 'Zomer- of winterbanden wisselen', 30, 39, 1),
(5, 'Aircoservice', 'Controle en onderhoud van de airco', 60, 89, 1),
(6, 'Olie verversen', 'Motorolie en oliefilter vervangen', 30, 69, 0);

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `gebruikers`
--

CREATE TABLE `gebruikers` (
  `gebruiker_id` int(11) NOT NULL,
  `voornaam` varchar(255) DEFAULT NULL,
  `achternaam` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `wachtwoord` varchar(255) DEFAULT NULL,
  `rol_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Gegevens worden geëxporteerd voor tabel `gebruikers`
--

INSERT INTO `gebruikers` (`gebruiker_id`, `voornaam`, `achternaam`, `email`, `wachtwoord`, `rol_id`) VALUES
(1, 'Jan', 'Jansen', 'jan@example.nl', 'pass123', 1),
(2, 'Piet', 'Bakker', 'piet@example.nl', 'pass123', 2),
(3, 'Lisa', 'Visser', 'lisa@example.nl', 'pass123', 3),
(4, 'Tom', 'Smit', 'tom@example.nl', 'pass123', 3),
(5, 'Emma', 'de Vries', 'emma@example.nl', 'pass123', 3);

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `merken`
--

CREATE TABLE `merken` (
  `merk_id` int(11) NOT NULL,
  `merk` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Gegevens worden geëxporteerd voor tabel `merken`
--

INSERT INTO `merken` (`merk_id`, `merk`) VALUES
(1, 'Volkswagen'),
(2, 'BMW'),
(3, 'Toyota'),
(4, 'Ford'),
(5, 'Audi');

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `rollen`
--

CREATE TABLE `rollen` (
  `rol_id` int(11) NOT NULL,
  `rol` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Gegevens worden geëxporteerd voor tabel `rollen`
--

INSERT INTO `rollen` (`rol_id`, `rol`) VALUES
(1, 'admin'),
(2, 'medewerker'),
(3, 'klant');

--
-- Indexen voor geëxporteerde tabellen
--

--
-- Indexen voor tabel `afspraken`
--
ALTER TABLE `afspraken`
  ADD PRIMARY KEY (`afspraak_id`),
  ADD KEY `auto_id` (`auto_id`),
  ADD KEY `dienst_id` (`dienst_id`),
  ADD KEY `gebruiker_id` (`gebruiker_id`);

--
-- Indexen voor tabel `auditlogs`
--
ALTER TABLE `auditlogs`
  ADD PRIMARY KEY (`log_id`),
  ADD KEY `gebruiker_id` (`gebruiker_id`);

--
-- Indexen voor tabel `autos`
--
ALTER TABLE `autos`
  ADD PRIMARY KEY (`auto_id`),
  ADD KEY `gebruiker_id` (`gebruiker_id`),
  ADD KEY `autos_ibfk_2` (`merk_id`);

--
-- Indexen voor tabel `diensten`
--
ALTER TABLE `diensten`
  ADD PRIMARY KEY (`dienst_id`);

--
-- Indexen voor tabel `gebruikers`
--
ALTER TABLE `gebruikers`
  ADD PRIMARY KEY (`gebruiker_id`),
  ADD KEY `rol_id` (`rol_id`);

--
-- Indexen voor tabel `merken`
--
ALTER TABLE `merken`
  ADD PRIMARY KEY (`merk_id`);

--
-- Indexen voor tabel `rollen`
--
ALTER TABLE `rollen`
  ADD PRIMARY KEY (`rol_id`);

--
-- Beperkingen voor geëxporteerde tabellen
--

--
-- Beperkingen voor tabel `afspraken`
--
ALTER TABLE `afspraken`
  ADD CONSTRAINT `afspraken_ibfk_1` FOREIGN KEY (`auto_id`) REFERENCES `autos` (`auto_id`),
  ADD CONSTRAINT `afspraken_ibfk_2` FOREIGN KEY (`dienst_id`) REFERENCES `diensten` (`dienst_id`),
  ADD CONSTRAINT `afspraken_ibfk_3` FOREIGN KEY (`gebruiker_id`) REFERENCES `gebruikers` (`gebruiker_id`);

--
-- Beperkingen voor tabel `auditlogs`
--
ALTER TABLE `auditlogs`
  ADD CONSTRAINT `auditlogs_ibfk_1` FOREIGN KEY (`gebruiker_id`) REFERENCES `gebruikers` (`gebruiker_id`);

--
-- Beperkingen voor tabel `autos`
--
ALTER TABLE `autos`
  ADD CONSTRAINT `autos_ibfk_1` FOREIGN KEY (`gebruiker_id`) REFERENCES `gebruikers` (`gebruiker_id`),
  ADD CONSTRAINT `autos_ibfk_2` FOREIGN KEY (`merk_id`) REFERENCES `merken` (`merk_id`);

--
-- Beperkingen voor tabel `gebruikers`
--
ALTER TABLE `gebruikers`
  ADD CONSTRAINT `gebruikers_ibfk_1` FOREIGN KEY (`rol_id`) REFERENCES `rollen` (`rol_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
