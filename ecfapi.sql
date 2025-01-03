-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : ven. 03 jan. 2025 à 11:30
-- Version du serveur : 8.3.0
-- Version de PHP : 8.2.18

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `ecfapi`
--

-- --------------------------------------------------------

--
-- Structure de la table `categories`
--

DROP TABLE IF EXISTS `categories`;
CREATE TABLE IF NOT EXISTS `categories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `categories`
--

INSERT INTO `categories` (`id`, `name`) VALUES
(1, 'Action'),
(2, 'Aventure'),
(5, 'Comedie');

-- --------------------------------------------------------

--
-- Structure de la table `categories_movies`
--

DROP TABLE IF EXISTS `categories_movies`;
CREATE TABLE IF NOT EXISTS `categories_movies` (
  `categories_id` int NOT NULL,
  `movies_id` int NOT NULL,
  PRIMARY KEY (`categories_id`,`movies_id`),
  KEY `IDX_CE77D308A21214B7` (`categories_id`),
  KEY `IDX_CE77D30853F590A4` (`movies_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `categories_movies`
--

INSERT INTO `categories_movies` (`categories_id`, `movies_id`) VALUES
(1, 1),
(2, 1),
(2, 2),
(5, 2);

-- --------------------------------------------------------

--
-- Structure de la table `movies`
--

DROP TABLE IF EXISTS `movies`;
CREATE TABLE IF NOT EXISTS `movies` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `resume` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_sortie` datetime NOT NULL,
  `realisateur` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `movies`
--

INSERT INTO `movies` (`id`, `title`, `resume`, `date_sortie`, `realisateur`) VALUES
(1, 'Harry Potter à l\'école des sorciers', 'Harry Potter, jeune orphelin, a été élevé par son oncle et sa tante dans des conditions hostiles3. À l\'âge de onze ans, un demi-géant nommé Rubeus Hagrid lui apprend qu\'il possède des pouvoirs magiques3 et que ses parents ont été assassinés, des années au', '2001-11-21 10:33:55', 'Chris Columbus'),
(2, 'La Grande Vadrouille', 'En 1942, un avion anglais est abattu par les Allemands au-dessus de Paris. Les trois pilotes sautent en parachute et atterrissent dans différents endroits de la capitale. Ils sont aidés par deux civils français, un chef d\'orchestre et un peintre en bâtime', '1966-12-08 12:23:56', 'Gérard Oury');

-- --------------------------------------------------------

--
-- Structure de la table `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(180) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `roles` json NOT NULL,
  `refresh_token` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `refresh_token_expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_IDENTIFIER_EMAIL` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `user`
--

INSERT INTO `user` (`id`, `email`, `password`, `roles`, `refresh_token`, `refresh_token_expires_at`) VALUES
(2, 'test@test.com', '$2y$13$c5BDEfDUxz6gfmHua2RDy.5bI8UMXQh.exghIT3SFRXGahzGmfJqO', '[\"ROLE_USER\"]', NULL, NULL),
(3, 'test@test.fr', '$2y$13$teC6gDwyPZAQTQS/XhEQg.AHOaMeiRQKOUR1yRBU.ofMMGa1D/WOK', '[\"ROLE_USER\"]', NULL, NULL);

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `categories_movies`
--
ALTER TABLE `categories_movies`
  ADD CONSTRAINT `FK_CE77D30853F590A4` FOREIGN KEY (`movies_id`) REFERENCES `movies` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_CE77D308A21214B7` FOREIGN KEY (`categories_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
