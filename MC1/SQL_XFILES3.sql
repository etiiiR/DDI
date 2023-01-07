-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mydb` ;

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

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
  `IsPerson` ENUM('B', 'V', 'A') NULL,
  `Vornamen` VARCHAR(120) NOT NULL,
  `Nachnamen` VARCHAR(120) NOT NULL,
  `Alter` FLOAT NOT NULL,
  `Geschlecht` TINYINT NOT NULL,
  `Adressen_idAdressen1` INT NOT NULL,
  PRIMARY KEY (`idPersonen`, `Adressen_idAdressen1`),
  INDEX `fk_Personen_Adressen2_idx` (`Adressen_idAdressen1` ASC) VISIBLE,
  CONSTRAINT `fk_Personen_Adressen2`
    FOREIGN KEY (`Adressen_idAdressen1`)
    REFERENCES `mydb`.`Adressen` (`idAdressen`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Abteilungen`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Abteilungen` (
  `idAbteilungen` INT NOT NULL,
  `Namen` VARCHAR(45) NOT NULL,
  `Wichtigkeit` INT NOT NULL,
  `Aufgabenbereich` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`idAbteilungen`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Beamten`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Beamten` (
  `idBeamte` INT NOT NULL,
  `Personen_idPersonen` INT NOT NULL,
  `Lohn` FLOAT NOT NULL,
  `Vorgesetzter_id` INT NULL,
  `Abteilungen_idAbteilungen` INT NOT NULL,
  PRIMARY KEY (`idBeamte`, `Personen_idPersonen`),
  INDEX `fk_Beamte_Beamte1_idx` (`Vorgesetzter_id` ASC) VISIBLE,
  INDEX `fk_Beamte_Personen1_idx` (`Personen_idPersonen` ASC) VISIBLE,
  INDEX `fk_Beamten_Abteilungen1_idx` (`Abteilungen_idAbteilungen` ASC) VISIBLE,
  CONSTRAINT `fk_Beamte_Beamte1`
    FOREIGN KEY (`Vorgesetzter_id`)
    REFERENCES `mydb`.`Beamten` (`idBeamte`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Beamte_Personen1`
    FOREIGN KEY (`Personen_idPersonen`)
    REFERENCES `mydb`.`Personen` (`idPersonen`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Beamten_Abteilungen1`
    FOREIGN KEY (`Abteilungen_idAbteilungen`)
    REFERENCES `mydb`.`Abteilungen` (`idAbteilungen`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Spesenabrechnungen`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Spesenabrechnungen` (
  `idSpesen` INT NOT NULL,
  `Betrag` FLOAT NOT NULL,
  `Grund` VARCHAR(255) NOT NULL,
  `Adressen_idAdressen` INT NOT NULL,
  `Beamten_idBeamte` INT NOT NULL,
  `Beamten_Personen_idPersonen` INT NOT NULL,
  PRIMARY KEY (`idSpesen`, `Beamten_idBeamte`, `Beamten_Personen_idPersonen`),
  INDEX `fk_Spesenabrechnungen_Adressen1_idx` (`Adressen_idAdressen` ASC) VISIBLE,
  INDEX `fk_Spesenabrechnungen_Beamten1_idx` (`Beamten_idBeamte` ASC, `Beamten_Personen_idPersonen` ASC) VISIBLE,
  CONSTRAINT `fk_Spesenabrechnungen_Adressen1`
    FOREIGN KEY (`Adressen_idAdressen`)
    REFERENCES `mydb`.`Adressen` (`idAdressen`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Spesenabrechnungen_Beamten1`
    FOREIGN KEY (`Beamten_idBeamte` , `Beamten_Personen_idPersonen`)
    REFERENCES `mydb`.`Beamten` (`idBeamte` , `Personen_idPersonen`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Akten`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Akten` (
  `idAkten` INT NOT NULL,
  `Bezeichnung` VARCHAR(255) NOT NULL,
  `X-Akte` ENUM('T', 'F') NOT NULL,
  PRIMARY KEY (`idAkten`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Verdächtige`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Verdächtige` (
  `idVerdächtige` INT NOT NULL,
  `Indizien` BLOB NULL,
  `Beweisstücknummer` VARCHAR(45) NULL,
  PRIMARY KEY (`idVerdächtige`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Verbrechen`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Verbrechen` (
  `idVerbrechen` INT NOT NULL,
  `tatzeit` VARCHAR(45) NULL,
  PRIMARY KEY (`idVerbrechen`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Alibis`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Alibis` (
  `idAlibis` INT NOT NULL,
  `Bezeichnung` VARCHAR(45) NULL,
  `Record` BLOB NULL,
  `Alibiscol` VARCHAR(45) NULL,
  PRIMARY KEY (`idAlibis`))
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
    REFERENCES `mydb`.`Beamten` (`idBeamte`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Beamte_has_Akten_Akten1`
    FOREIGN KEY (`Akten_idAkten`)
    REFERENCES `mydb`.`Akten` (`idAkten`)
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


-- -----------------------------------------------------
-- Table `mydb`.`Akte`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Akte` (
  `idAkte` INT NOT NULL,
  `Aktenbezeichnung` VARCHAR(45) NULL,
  `Kennzeichen` TINYINT NULL,
  PRIMARY KEY (`idAkte`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Abteilungen`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Abteilungen` (
  `idAbteilungen` INT NOT NULL,
  `Namen` VARCHAR(45) NOT NULL,
  `Wichtigkeit` INT NOT NULL,
  `Aufgabenbereich` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`idAbteilungen`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Beamte`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Beamte` (
  `idBeamte` INT NOT NULL,
  `Beamte_idBeamte` INT NOT NULL,
  `Lohn` VARCHAR(45) NULL,
  `Abteilungen_idAbteilungen` INT NOT NULL,
  PRIMARY KEY (`idBeamte`),
  INDEX `fk_Beamte_Beamte2_idx` (`Beamte_idBeamte` ASC) VISIBLE,
  INDEX `fk_Beamte_Abteilungen1_idx` (`Abteilungen_idAbteilungen` ASC) VISIBLE,
  CONSTRAINT `fk_Beamte_Beamte2`
    FOREIGN KEY (`Beamte_idBeamte`)
    REFERENCES `mydb`.`Beamte` (`idBeamte`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Beamte_Abteilungen1`
    FOREIGN KEY (`Abteilungen_idAbteilungen`)
    REFERENCES `mydb`.`Abteilungen` (`idAbteilungen`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Berechtigungen`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Berechtigungen` (
  `idtable1` INT NOT NULL,
  `Bezeichnung` VARCHAR(45) NULL,
  `Code` VARCHAR(45) NULL,
  PRIMARY KEY (`idtable1`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Adresse`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Adresse` (
  `idAdresse` INT NOT NULL,
  `Strasse` VARCHAR(45) NULL,
  `Strassennummer` VARCHAR(45) NULL,
  `Ort` VARCHAR(45) NULL,
  `Land` VARCHAR(45) NULL,
  PRIMARY KEY (`idAdresse`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Spesenabrechnung`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Spesenabrechnung` (
  `idSpesenabrechnung` INT NOT NULL,
  `Betrag` VARCHAR(45) NULL,
  `Grund` VARCHAR(45) NULL,
  `Beamte_idBeamte` INT NOT NULL,
  `Adresse_idAdresse` INT NOT NULL,
  PRIMARY KEY (`idSpesenabrechnung`, `Beamte_idBeamte`, `Adresse_idAdresse`),
  INDEX `fk_Spesenabrechnung_Beamte1_idx` (`Beamte_idBeamte` ASC) VISIBLE,
  INDEX `fk_Spesenabrechnung_Adresse1_idx` (`Adresse_idAdresse` ASC) VISIBLE,
  CONSTRAINT `fk_Spesenabrechnung_Beamte1`
    FOREIGN KEY (`Beamte_idBeamte`)
    REFERENCES `mydb`.`Beamte` (`idBeamte`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Spesenabrechnung_Adresse1`
    FOREIGN KEY (`Adresse_idAdresse`)
    REFERENCES `mydb`.`Adresse` (`idAdresse`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Beamte_has_Berechtigungen`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Beamte_has_Berechtigungen` (
  `Beamte_idBeamte` INT NOT NULL,
  `Berechtigungen_idtable1` INT NOT NULL,
  PRIMARY KEY (`Beamte_idBeamte`, `Berechtigungen_idtable1`),
  INDEX `fk_Beamte_has_Berechtigungen_Berechtigungen1_idx` (`Berechtigungen_idtable1` ASC) VISIBLE,
  INDEX `fk_Beamte_has_Berechtigungen_Beamte1_idx` (`Beamte_idBeamte` ASC) VISIBLE,
  CONSTRAINT `fk_Beamte_has_Berechtigungen_Beamte1`
    FOREIGN KEY (`Beamte_idBeamte`)
    REFERENCES `mydb`.`Beamte` (`idBeamte`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Beamte_has_Berechtigungen_Berechtigungen1`
    FOREIGN KEY (`Berechtigungen_idtable1`)
    REFERENCES `mydb`.`Berechtigungen` (`idtable1`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Person`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Person` (
  `idPerson` INT NOT NULL,
  `Vornamen` VARCHAR(45) NULL,
  `Nachnamen` VARCHAR(45) NULL,
  `Alter` VARCHAR(45) NULL,
  `Geschlecht` VARCHAR(45) NULL,
  `Adresse_idAdresse` INT NOT NULL,
  PRIMARY KEY (`idPerson`, `Adresse_idAdresse`),
  INDEX `fk_Person_Adresse1_idx` (`Adresse_idAdresse` ASC) VISIBLE,
  CONSTRAINT `fk_Person_Adresse1`
    FOREIGN KEY (`Adresse_idAdresse`)
    REFERENCES `mydb`.`Adresse` (`idAdresse`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Verdächtige`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Verdächtige` (
  `idVerdächtige` INT NOT NULL,
  `Indizien` BLOB NULL,
  `Beweisstücknummer` VARCHAR(45) NULL,
  PRIMARY KEY (`idVerdächtige`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Akte_has_Verdächtige`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Akte_has_Verdächtige` (
  `Akte_idAkte` INT NOT NULL,
  `Verdächtige_idVerdächtige` INT NOT NULL,
  PRIMARY KEY (`Akte_idAkte`, `Verdächtige_idVerdächtige`),
  INDEX `fk_Akte_has_Verdächtige_Verdächtige1_idx` (`Verdächtige_idVerdächtige` ASC) VISIBLE,
  INDEX `fk_Akte_has_Verdächtige_Akte1_idx` (`Akte_idAkte` ASC) VISIBLE,
  CONSTRAINT `fk_Akte_has_Verdächtige_Akte1`
    FOREIGN KEY (`Akte_idAkte`)
    REFERENCES `mydb`.`Akte` (`idAkte`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Akte_has_Verdächtige_Verdächtige1`
    FOREIGN KEY (`Verdächtige_idVerdächtige`)
    REFERENCES `mydb`.`Verdächtige` (`idVerdächtige`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Akte_has_Beamte`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Akte_has_Beamte` (
  `Akte_idAkte` INT NOT NULL,
  `Beamte_idBeamte` INT NOT NULL,
  PRIMARY KEY (`Akte_idAkte`, `Beamte_idBeamte`),
  INDEX `fk_Akte_has_Beamte_Beamte1_idx` (`Beamte_idBeamte` ASC) VISIBLE,
  INDEX `fk_Akte_has_Beamte_Akte1_idx` (`Akte_idAkte` ASC) VISIBLE,
  CONSTRAINT `fk_Akte_has_Beamte_Akte1`
    FOREIGN KEY (`Akte_idAkte`)
    REFERENCES `mydb`.`Akte` (`idAkte`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Akte_has_Beamte_Beamte1`
    FOREIGN KEY (`Beamte_idBeamte`)
    REFERENCES `mydb`.`Beamte` (`idBeamte`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Verbrechen`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Verbrechen` (
  `idVerbrechen` INT NOT NULL,
  `tatzeit` VARCHAR(45) NULL,
  PRIMARY KEY (`idVerbrechen`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Verdächtige_has_Verbrechen1`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Verdächtige_has_Verbrechen1` (
  `Verdächtige_idVerdächtige` INT NOT NULL,
  `Verbrechen_idVerbrechen` INT NOT NULL,
  PRIMARY KEY (`Verdächtige_idVerdächtige`, `Verbrechen_idVerbrechen`),
  INDEX `fk_Verdächtige_has_Verbrechen1_Verbrechen1_idx` (`Verbrechen_idVerbrechen` ASC) VISIBLE,
  INDEX `fk_Verdächtige_has_Verbrechen1_Verdächtige1_idx` (`Verdächtige_idVerdächtige` ASC) VISIBLE,
  CONSTRAINT `fk_Verdächtige_has_Verbrechen1_Verdächtige1`
    FOREIGN KEY (`Verdächtige_idVerdächtige`)
    REFERENCES `mydb`.`Verdächtige` (`idVerdächtige`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Verdächtige_has_Verbrechen1_Verbrechen1`
    FOREIGN KEY (`Verbrechen_idVerbrechen`)
    REFERENCES `mydb`.`Verbrechen` (`idVerbrechen`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Alibis`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Alibis` (
  `idAlibis` INT NOT NULL,
  `Bezeichnung` VARCHAR(45) NULL,
  `Record` BLOB NULL,
  `Alibiscol` VARCHAR(45) NULL,
  PRIMARY KEY (`idAlibis`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Akte_has_Alibis`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Akte_has_Alibis` (
  `Akte_idAkte` INT NOT NULL,
  `Alibis_idAlibis` INT NOT NULL,
  PRIMARY KEY (`Akte_idAkte`, `Alibis_idAlibis`),
  INDEX `fk_Akte_has_Alibis_Alibis1_idx` (`Alibis_idAlibis` ASC) VISIBLE,
  INDEX `fk_Akte_has_Alibis_Akte1_idx` (`Akte_idAkte` ASC) VISIBLE,
  CONSTRAINT `fk_Akte_has_Alibis_Akte1`
    FOREIGN KEY (`Akte_idAkte`)
    REFERENCES `mydb`.`Akte` (`idAkte`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Akte_has_Alibis_Alibis1`
    FOREIGN KEY (`Alibis_idAlibis`)
    REFERENCES `mydb`.`Alibis` (`idAlibis`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Berechtigungen2`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Berechtigungen2` (
  `idBerechtigungen` INT NOT NULL,
  `Code` INT(8) NOT NULL,
  `Bezeichnung` VARCHAR(120) NOT NULL,
  PRIMARY KEY (`idBerechtigungen`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Beamten_has_Berechtigungen2`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Beamten_has_Berechtigungen2` (
  `Beamten_idBeamte` INT NOT NULL,
  `Beamten_Personen_idPersonen` INT NOT NULL,
  `Berechtigungen2_idBerechtigungen` INT NOT NULL,
  PRIMARY KEY (`Beamten_idBeamte`, `Beamten_Personen_idPersonen`, `Berechtigungen2_idBerechtigungen`),
  INDEX `fk_Beamten_has_Berechtigungen2_Berechtigungen21_idx` (`Berechtigungen2_idBerechtigungen` ASC) VISIBLE,
  INDEX `fk_Beamten_has_Berechtigungen2_Beamten1_idx` (`Beamten_idBeamte` ASC, `Beamten_Personen_idPersonen` ASC) VISIBLE,
  CONSTRAINT `fk_Beamten_has_Berechtigungen2_Beamten1`
    FOREIGN KEY (`Beamten_idBeamte` , `Beamten_Personen_idPersonen`)
    REFERENCES `mydb`.`Beamten` (`idBeamte` , `Personen_idPersonen`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Beamten_has_Berechtigungen2_Berechtigungen21`
    FOREIGN KEY (`Berechtigungen2_idBerechtigungen`)
    REFERENCES `mydb`.`Berechtigungen2` (`idBerechtigungen`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
