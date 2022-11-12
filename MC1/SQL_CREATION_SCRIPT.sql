-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Spesen`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Spesen` (
  `idSpesen` INT NOT NULL,
  `Betrag` FLOAT NULL,
  `Grund` VARCHAR(255) NULL,
  PRIMARY KEY (`idSpesen`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Berechtigungen`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Berechtigungen` (
  `idBerechtigungen` INT NOT NULL,
  `Bezeichnung` VARCHAR(120) NULL,
  PRIMARY KEY (`idBerechtigungen`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Abteilungen`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Abteilungen` (
  `idAbteilung` INT NOT NULL,
  `Abteilungsnamen` VARCHAR(255) NOT NULL,
  `Wichtigkeit` INT NOT NULL,
  `Aufgabenbereich` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`idAbteilung`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Beamte`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Beamte` (
  `idBeamte` INT NOT NULL,
  `Spesen_idSpesen` INT NOT NULL,
  `Lohn` FLOAT NOT NULL,
  `Abteilung_idAbteilung` INT NOT NULL,
  PRIMARY KEY (`idBeamte`, `Abteilung_idAbteilung`),
  INDEX `fk_Beamte_Spesen1_idx` (`Spesen_idSpesen` ASC) VISIBLE,
  INDEX `fk_Beamte_Abteilung1_idx` (`Abteilung_idAbteilung` ASC) VISIBLE,
  CONSTRAINT `fk_Beamte_Spesen1`
    FOREIGN KEY (`Spesen_idSpesen`)
    REFERENCES `mydb`.`Spesen` (`idSpesen`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Beamte_Abteilung1`
    FOREIGN KEY (`Abteilung_idAbteilung`)
    REFERENCES `mydb`.`Abteilungen` (`idAbteilung`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Akten`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Akten` (
  `idAkten` INT NOT NULL,
  `Bezeichnung` VARCHAR(255) NOT NULL,
  `X-Akte` TINYINT NULL,
  PRIMARY KEY (`idAkten`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Adressen`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Adressen` (
  `idAdressen` INT NOT NULL,
  `Strasse` VARCHAR(120) NOT NULL,
  `Strassennummer` VARCHAR(6) NOT NULL,
  `Ort` VARCHAR(255) NOT NULL,
  `Land` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`idAdressen`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Personen`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Personen` (
  `idPersonen` INT NOT NULL,
  `Vornamen` VARCHAR(120) NULL,
  `Nachnamen` VARCHAR(120) NULL,
  `Alter` FLOAT NULL,
  `Geschlecht` TINYINT NULL,
  `Adressen_idAdressen` INT NOT NULL,
  PRIMARY KEY (`idPersonen`),
  INDEX `fk_Personen_Adressen1_idx` (`Adressen_idAdressen` ASC) VISIBLE,
  CONSTRAINT `fk_Personen_Adressen1`
    FOREIGN KEY (`Adressen_idAdressen`)
    REFERENCES `mydb`.`Adressen` (`idAdressen`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Verdächtige`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Verdächtige` (
  `idVerdächtige` INT NOT NULL,
  `Personen_idPersonen` INT NOT NULL,
  `Indizien` BLOB NOT NULL,
  `Beweisstücknummer` BIGINT NOT NULL,
  PRIMARY KEY (`idVerdächtige`),
  INDEX `fk_Verdächtige_Personen1_idx` (`Personen_idPersonen` ASC) VISIBLE,
  CONSTRAINT `fk_Verdächtige_Personen1`
    FOREIGN KEY (`Personen_idPersonen`)
    REFERENCES `mydb`.`Personen` (`idPersonen`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Verbrechen`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Verbrechen` (
  `idVerbrechen` INT NOT NULL,
  `Tatzeit` DATETIME NOT NULL,
  `Strafzeit` TIME NOT NULL,
  `Strafende` DATETIME NOT NULL,
  PRIMARY KEY (`idVerbrechen`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Alibis`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Alibis` (
  `idAlibis` INT NOT NULL,
  `Personen_idPersonen` INT NOT NULL,
  `Bezeichnung` VARCHAR(120) NOT NULL,
  `Record` BLOB NOT NULL,
  PRIMARY KEY (`idAlibis`),
  INDEX `fk_Alibis_Personen1_idx` (`Personen_idPersonen` ASC) VISIBLE,
  CONSTRAINT `fk_Alibis_Personen1`
    FOREIGN KEY (`Personen_idPersonen`)
    REFERENCES `mydb`.`Personen` (`idPersonen`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Verdächtige_has_Akten`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Verdächtige_has_Akten` (
  `Verdächtige_idVerdächtige` INT NOT NULL,
  `Akten_idAkten` INT NOT NULL,
  PRIMARY KEY (`Verdächtige_idVerdächtige`, `Akten_idAkten`),
  INDEX `fk_Verdächtige_has_Akten_Akten1_idx` (`Akten_idAkten` ASC) VISIBLE,
  INDEX `fk_Verdächtige_has_Akten_Verdächtige1_idx` (`Verdächtige_idVerdächtige` ASC) VISIBLE,
  CONSTRAINT `fk_Verdächtige_has_Akten_Verdächtige1`
    FOREIGN KEY (`Verdächtige_idVerdächtige`)
    REFERENCES `mydb`.`Verdächtige` (`idVerdächtige`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Verdächtige_has_Akten_Akten1`
    FOREIGN KEY (`Akten_idAkten`)
    REFERENCES `mydb`.`Akten` (`idAkten`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Alibis_has_Akten`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Alibis_has_Akten` (
  `Alibis_idAlibis` INT NOT NULL,
  `Akten_idAkten` INT NOT NULL,
  PRIMARY KEY (`Alibis_idAlibis`, `Akten_idAkten`),
  INDEX `fk_Alibis_has_Akten_Akten1_idx` (`Akten_idAkten` ASC) VISIBLE,
  INDEX `fk_Alibis_has_Akten_Alibis1_idx` (`Alibis_idAlibis` ASC) VISIBLE,
  CONSTRAINT `fk_Alibis_has_Akten_Alibis1`
    FOREIGN KEY (`Alibis_idAlibis`)
    REFERENCES `mydb`.`Alibis` (`idAlibis`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Alibis_has_Akten_Akten1`
    FOREIGN KEY (`Akten_idAkten`)
    REFERENCES `mydb`.`Akten` (`idAkten`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Beamte_has_Akten`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Beamte_has_Akten` (
  `Beamte_idBeamte` INT NOT NULL,
  `Akten_idAkten` INT NOT NULL,
  PRIMARY KEY (`Beamte_idBeamte`, `Akten_idAkten`),
  INDEX `fk_Beamte_has_Akten_Akten1_idx` (`Akten_idAkten` ASC) VISIBLE,
  INDEX `fk_Beamte_has_Akten_Beamte1_idx` (`Beamte_idBeamte` ASC) VISIBLE,
  CONSTRAINT `fk_Beamte_has_Akten_Beamte1`
    FOREIGN KEY (`Beamte_idBeamte`)
    REFERENCES `mydb`.`Beamte` (`idBeamte`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Beamte_has_Akten_Akten1`
    FOREIGN KEY (`Akten_idAkten`)
    REFERENCES `mydb`.`Akten` (`idAkten`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Berechtigungen_has_Beamte`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Berechtigungen_has_Beamte` (
  `Berechtigungen_idBerechtigungen` INT NOT NULL,
  `Beamte_idBeamte` INT NOT NULL,
  PRIMARY KEY (`Berechtigungen_idBerechtigungen`, `Beamte_idBeamte`),
  INDEX `fk_Berechtigungen_has_Beamte_Beamte1_idx` (`Beamte_idBeamte` ASC) VISIBLE,
  INDEX `fk_Berechtigungen_has_Beamte_Berechtigungen1_idx` (`Berechtigungen_idBerechtigungen` ASC) VISIBLE,
  CONSTRAINT `fk_Berechtigungen_has_Beamte_Berechtigungen1`
    FOREIGN KEY (`Berechtigungen_idBerechtigungen`)
    REFERENCES `mydb`.`Berechtigungen` (`idBerechtigungen`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Berechtigungen_has_Beamte_Beamte1`
    FOREIGN KEY (`Beamte_idBeamte`)
    REFERENCES `mydb`.`Beamte` (`idBeamte`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Verdächtige_has_Verbrechen`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Verdächtige_has_Verbrechen` (
  `Verdächtige_idVerdächtige` INT NOT NULL,
  `Verbrechen_idVerbrechen` INT NOT NULL,
  PRIMARY KEY (`Verdächtige_idVerdächtige`, `Verbrechen_idVerbrechen`),
  INDEX `fk_Verdächtige_has_Verbrechen_Verbrechen1_idx` (`Verbrechen_idVerbrechen` ASC) VISIBLE,
  INDEX `fk_Verdächtige_has_Verbrechen_Verdächtige1_idx` (`Verdächtige_idVerdächtige` ASC) VISIBLE,
  CONSTRAINT `fk_Verdächtige_has_Verbrechen_Verdächtige1`
    FOREIGN KEY (`Verdächtige_idVerdächtige`)
    REFERENCES `mydb`.`Verdächtige` (`idVerdächtige`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Verdächtige_has_Verbrechen_Verbrechen1`
    FOREIGN KEY (`Verbrechen_idVerbrechen`)
    REFERENCES `mydb`.`Verbrechen` (`idVerbrechen`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
