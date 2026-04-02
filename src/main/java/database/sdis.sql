-- phpMyAdmin SQL Dump

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

-- Désactivation temporaire des contraintes de clés étrangères pour réinitialiser la base proprement
SET FOREIGN_KEY_CHECKS = 0;

-- --------------------------------------------------------
-- 1. SUPPRESSION DES TABLES EXISTANTES
-- --------------------------------------------------------
DROP TABLE IF EXISTS `engin`;
DROP TABLE IF EXISTS `envoyer`;
DROP TABLE IF EXISTS `habiliter`;
DROP TABLE IF EXISTS `necessiter`;
DROP TABLE IF EXISTS `pompier`;
DROP TABLE IF EXISTS `caserne`;
DROP TABLE IF EXISTS `categoriegrade`;
DROP TABLE IF EXISTS `fonction`;
DROP TABLE IF EXISTS `grade`;
DROP TABLE IF EXISTS `intervention`;
DROP TABLE IF EXISTS `profession`;
DROP TABLE IF EXISTS `situation`;
DROP TABLE IF EXISTS `typeengin`;

-- --------------------------------------------------------
-- 2. CRÉATION DES TABLES
-- --------------------------------------------------------

CREATE TABLE `caserne` (
  `ID_CASERNE` int(11) NOT NULL AUTO_INCREMENT,
  `NOM` varchar(100) DEFAULT NULL,
  `RUE` varchar(255) DEFAULT NULL,
  `COPOS` varchar(5) DEFAULT NULL,
  `VILLE` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ID_CASERNE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `categoriegrade` (
  `ID_CATEGORIEGRADE` int(11) NOT NULL AUTO_INCREMENT,
  `LIBELLE` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ID_CATEGORIEGRADE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `engin` (
  `ID_ENGIN` int(11) NOT NULL AUTO_INCREMENT,
  `LIBELLE` varchar(100) DEFAULT NULL,
  `NUMEROORDRE` int(11) DEFAULT NULL,
  `ID_CASERNE` int(11) DEFAULT NULL,
  `ID_TYPEENGIN` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID_ENGIN`),
  KEY `FK_ENGIN_CASERNE` (`ID_CASERNE`),
  KEY `FK_ENGIN_TYPE` (`ID_TYPEENGIN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `envoyer` (
  `ID_INTERVENTION` int(11) NOT NULL,
  `MATRICULE` int(11) NOT NULL,
  PRIMARY KEY (`ID_INTERVENTION`,`MATRICULE`),
  KEY `FK_ENV_POMPIER` (`MATRICULE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `fonction` (
  `CODE_FONCTION` varchar(10) NOT NULL,
  `LIBELLE` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`CODE_FONCTION`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `grade` (
  `ID_GRADE` int(11) NOT NULL AUTO_INCREMENT,
  `LIBELLE` varchar(100) DEFAULT NULL,
  `ID_CATEGORIEGRADE` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID_GRADE`),
  KEY `FK_GRADE_CAT` (`ID_CATEGORIEGRADE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `habiliter` (
  `MATRICULE` int(11) NOT NULL,
  `CODE_FONCTION` varchar(10) NOT NULL,
  PRIMARY KEY (`MATRICULE`,`CODE_FONCTION`),
  KEY `FK_HAB_FONCTION` (`CODE_FONCTION`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `intervention` (
  `ID_INTERVENTION` int(11) NOT NULL AUTO_INCREMENT,
  `LIEU` varchar(255) DEFAULT NULL,
  `DATE_INTER` date DEFAULT NULL,
  `HEUREAPPEL` time DEFAULT NULL,
  `HEUREARRIVE` time DEFAULT NULL,
  `DUREE` time DEFAULT NULL,
  PRIMARY KEY (`ID_INTERVENTION`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `necessiter` (
  `ID_INTERVENTION` int(11) NOT NULL,
  `CODE_SITUATION` varchar(10) NOT NULL,
  `ID_ENGIN` int(11) NOT NULL,
  PRIMARY KEY (`ID_INTERVENTION`,`CODE_SITUATION`,`ID_ENGIN`),
  KEY `FK_NEC_SITUATION` (`CODE_SITUATION`),
  KEY `FK_NEC_ENGIN` (`ID_ENGIN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `pompier` (
  `MATRICULE` int(11) NOT NULL AUTO_INCREMENT,
  `NOM` varchar(50) DEFAULT NULL,
  `PRENOM` varchar(50) DEFAULT NULL,
  `DATENAISS` date DEFAULT NULL,
  `NUMEROTEL` varchar(15) DEFAULT NULL,
  `NUMEROBIP` int(11) DEFAULT NULL,
  `ID_GRADE` int(11) DEFAULT NULL,
  `ID_CASERNE` int(11) DEFAULT NULL,
  `ID_PROFESSION` int(11) DEFAULT NULL,
  PRIMARY KEY (`MATRICULE`),
  KEY `FK_POMPIER_GRADE` (`ID_GRADE`),
  KEY `FK_POMPIER_CASERNE` (`ID_CASERNE`),
  KEY `FK_POMPIER_PROF` (`ID_PROFESSION`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `profession` (
  `ID_PROFESSION` int(11) NOT NULL AUTO_INCREMENT,
  `LIBELLE` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ID_PROFESSION`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `situation` (
  `CODE_SITUATION` varchar(10) NOT NULL,
  `LIBELLE` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`CODE_SITUATION`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `typeengin` (
  `ID_TYPEENGIN` int(11) NOT NULL AUTO_INCREMENT,
  `LIBELLE` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ID_TYPEENGIN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- --------------------------------------------------------
-- 3. INSERTION DES DONNÉES DE RÉFÉRENCE
-- --------------------------------------------------------

INSERT INTO `caserne` (`ID_CASERNE`, `NOM`, `RUE`, `COPOS`, `VILLE`) VALUES
(1, 'Ifs', 'Rue de la République', '14123', 'Ifs'),
(2, 'Lisieux', 'Avenue Georges Pompidou', '14100', 'Lisieux'),
(3, 'Le Hom', 'Route de Condé', '14220', 'Le Hom'),
(4, 'Caen Folie Couvrechef', 'Avenue de la Folie', '14000', 'Caen'),
(5, 'Quimper', '10 Avenue Pompiers', '29000', 'Quimper');

INSERT INTO `categoriegrade` (`ID_CATEGORIEGRADE`, `LIBELLE`) VALUES
(1, 'Hommes du rang'),
(2, 'Sous-officiers'),
(3, 'Officiers');

INSERT INTO `grade` (`ID_GRADE`, `LIBELLE`, `ID_CATEGORIEGRADE`) VALUES
(1, 'Sapeur', 1),
(2, 'Caporal', 1),
(3, 'Sergent', 2),
(4, 'Adjudant', 2),
(5, 'Lieutenant', 3),
(6, 'Capitaine', 3),
(7, 'Commandant', 3);

INSERT INTO `profession` (`ID_PROFESSION`, `LIBELLE`) VALUES
(1, 'Artisan'),
(2, 'Employé de Mairie'),
(3, 'Informaticien'),
(4, 'Mécanicien'),
(5, 'Sans profession');

INSERT INTO `fonction` (`CODE_FONCTION`, `LIBELLE`) VALUES
('COND_FPT', 'Conducteur fourgon pompe-tonne'),
('COND_VSR', 'Conducteur véhicule de secours routier'),
('EQUI_EPA', 'Equiper échelle pivotante automatique'),
('EQUI_INC', 'Equipier incendie');

INSERT INTO `typeengin` (`ID_TYPEENGIN`, `LIBELLE`) VALUES
(1, 'Fourgon Pompe-Tonne (FPT)'),
(2, 'Véhicule de Secours Routier (VSR)'),
(3, 'Echelle Pivotante Automatique (EPA)'),
(4, 'Véhicule de Secours et d''Assistance aux Victimes (VSAV)');

INSERT INTO `situation` (`CODE_SITUATION`, `LIBELLE`) VALUES
('AVP', 'Accident sur la Voie Publique'),
('INC', 'Incendie de bâtiment'),
('SAP', 'Secours à Personne');

INSERT INTO `engin` (`ID_ENGIN`, `LIBELLE`, `NUMEROORDRE`, `ID_CASERNE`, `ID_TYPEENGIN`) VALUES
(1, 'FPT 1 Quimper', 1, 5, 1),
(2, 'VSR 1 Quimper', 1, 5, 2),
(3, 'VSAV 1 Ifs', 1, 1, 4),
(4, 'FPT 1 Lisieux', 1, 2, 1);


-- --------------------------------------------------------
-- 4. INSERTION DES POMPIERS (Données complétées)
-- --------------------------------------------------------

INSERT INTO `pompier` (`MATRICULE`, `NOM`, `PRENOM`, `DATENAISS`, `NUMEROTEL`, `NUMEROBIP`, `ID_GRADE`, `ID_CASERNE`, `ID_PROFESSION`) VALUES
(1, 'LEROY', 'Pierrick', '1995-04-12', '0601020304', 101, 1, 1, 3),
(2, 'MASSON', 'Bastien', '1992-08-22', '0611223344', 102, 2, 1, 4),
(3, 'DUVAL', 'Matthias', '1988-11-05', '0622334455', 103, 3, 4, 1),
(4, 'MADJI', 'Walid', '1998-02-18', '0633445566', 104, 1, 4, 5),
(6, 'CHAUVEL', 'Jules', '1998-02-18', '0633445567', 106, 1, 1, 5),
(7, 'CAUVIN', 'Nayah', '1998-02-18', '0633445568', 107, 1, 1, 5),
(8, 'TRAORE', 'Sylvain', '1985-06-30', '0644556677', 108, 5, 3, 2),
(9, 'BOULEAU', 'Line', '1990-01-15', '0655667788', 109, 2, 3, 3),
(10, 'MANCEL', 'Florianne', '1993-07-21', '0666778899', 110, 1, 2, 5),
(11, 'PONTIER', 'Claire', '1987-12-05', '0677889900', 111, 4, 2, 1),
(12, 'BARON', 'Gwladys', '1996-03-30', '0688990011', 112, 1, 3, 4),
(13, 'PASTOR', 'Lucas', '1991-09-14', '0699001122', 113, 2, 1, 2),
(14, 'BAREAU', 'Mila', '1999-05-25', '0612345678', 114, 1, 1, 5),
-- Intégration de Robert Dumontel d'après le cahier des charges
(986995, 'Dumontel', 'Robert', '1969-01-10', '02 98 56 85 42', 15, 6, 5, 2);


-- --------------------------------------------------------
-- 5. INSERTION DES HABILITATIONS (Robert Dumontel)
-- --------------------------------------------------------

INSERT INTO `habiliter` (`MATRICULE`, `CODE_FONCTION`) VALUES
(986995, 'COND_FPT'),
(986995, 'COND_VSR'),
(986995, 'EQUI_EPA'),
(986995, 'EQUI_INC');


-- --------------------------------------------------------
-- 6. INSERTION D'UNE INTERVENTION DE TEST
-- --------------------------------------------------------

INSERT INTO `intervention` (`ID_INTERVENTION`, `LIEU`, `DATE_INTER`, `HEUREAPPEL`, `HEUREARRIVE`, `DUREE`) VALUES
(1, '15 Rue de Brest, Quimper', '2026-03-25', '14:30:00', '14:42:00', '02:15:00');

INSERT INTO `necessiter` (`ID_INTERVENTION`, `CODE_SITUATION`, `ID_ENGIN`) VALUES
(1, 'INC', 1);

INSERT INTO `envoyer` (`ID_INTERVENTION`, `MATRICULE`) VALUES
(1, 986995),
(1, 1),
(1, 2);


-- --------------------------------------------------------
-- 7. RESTAURATION DES CONTRAINTES DE CLÉS ÉTRANGÈRES
-- --------------------------------------------------------

ALTER TABLE `engin`
  ADD CONSTRAINT `FK_ENGIN_CASERNE` FOREIGN KEY (`ID_CASERNE`) REFERENCES `caserne` (`ID_CASERNE`),
  ADD CONSTRAINT `FK_ENGIN_TYPE` FOREIGN KEY (`ID_TYPEENGIN`) REFERENCES `typeengin` (`ID_TYPEENGIN`);

ALTER TABLE `envoyer`
  ADD CONSTRAINT `FK_ENV_INTER` FOREIGN KEY (`ID_INTERVENTION`) REFERENCES `intervention` (`ID_INTERVENTION`),
  ADD CONSTRAINT `FK_ENV_POMPIER` FOREIGN KEY (`MATRICULE`) REFERENCES `pompier` (`MATRICULE`);

ALTER TABLE `grade`
  ADD CONSTRAINT `FK_GRADE_CAT` FOREIGN KEY (`ID_CATEGORIEGRADE`) REFERENCES `categoriegrade` (`ID_CATEGORIEGRADE`);

ALTER TABLE `habiliter`
  ADD CONSTRAINT `FK_HAB_FONCTION` FOREIGN KEY (`CODE_FONCTION`) REFERENCES `fonction` (`CODE_FONCTION`),
  ADD CONSTRAINT `FK_HAB_POMPIER` FOREIGN KEY (`MATRICULE`) REFERENCES `pompier` (`MATRICULE`);

ALTER TABLE `necessiter`
  ADD CONSTRAINT `FK_NEC_ENGIN` FOREIGN KEY (`ID_ENGIN`) REFERENCES `engin` (`ID_ENGIN`),
  ADD CONSTRAINT `FK_NEC_INTER` FOREIGN KEY (`ID_INTERVENTION`) REFERENCES `intervention` (`ID_INTERVENTION`),
  ADD CONSTRAINT `FK_NEC_SITUATION` FOREIGN KEY (`CODE_SITUATION`) REFERENCES `situation` (`CODE_SITUATION`);

ALTER TABLE `pompier`
  ADD CONSTRAINT `FK_POMPIER_CASERNE` FOREIGN KEY (`ID_CASERNE`) REFERENCES `caserne` (`ID_CASERNE`),
  ADD CONSTRAINT `FK_POMPIER_GRADE` FOREIGN KEY (`ID_GRADE`) REFERENCES `grade` (`ID_GRADE`),
  ADD CONSTRAINT `FK_POMPIER_PROF` FOREIGN KEY (`ID_PROFESSION`) REFERENCES `profession` (`ID_PROFESSION`);

SET FOREIGN_KEY_CHECKS = 1;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
