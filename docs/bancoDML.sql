-- MySQL Script generated by MySQL Workbench
-- Tue Oct 15 00:17:21 2024
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema 1corre_manager
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema 1corre_manager
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `1corre_manager` DEFAULT CHARACTER SET utf8 ;
USE `1corre_manager` ;

-- -----------------------------------------------------
-- Table `1corre_manager`.`Endereco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `1corre_manager`.`Endereco` (
  `idEndereco` INT NOT NULL AUTO_INCREMENT,
  `cep` CHAR(8) NULL,
  `estado` VARCHAR(45) NOT NULL,
  `cidade` VARCHAR(45) NOT NULL,
  `bairro` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idEndereco`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `1corre_manager`.`Pessoa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `1corre_manager`.`Pessoa` (
  `idPessoa` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(120) NOT NULL,
  `data_nasc` DATE NOT NULL,
  `cpf` VARCHAR(45) NOT NULL,
  `rg` VARCHAR(45) NOT NULL,
  `senha` VARCHAR(8) NOT NULL,
  `usuario` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `Endereco` INT NOT NULL,
  `data_registro` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idPessoa`),
  INDEX `fk_Pessoa_Endereco_idx` (`Endereco` ASC),
  CONSTRAINT `fk_Pessoa_Endereco`
    FOREIGN KEY (`Endereco`)
    REFERENCES `1corre_manager`.`Endereco` (`idEndereco`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `1corre_manager`.`Freelancer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `1corre_manager`.`Freelancer` (
  `idFreelancer` INT NOT NULL AUTO_INCREMENT,
  `Pessoa` INT NOT NULL,
  PRIMARY KEY (`idFreelancer`),
  INDEX `fk_Freelancer_Pessoa1_idx` (`Pessoa` ASC),
  CONSTRAINT `fk_Freelancer_Pessoa1`
    FOREIGN KEY (`Pessoa`)
    REFERENCES `1corre_manager`.`Pessoa` (`idPessoa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `1corre_manager`.`Area`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `1corre_manager`.`Area` (
  `idArea` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idArea`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `1corre_manager`.`Servico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `1corre_manager`.`Servico` (
  `idServico` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `Area` INT NOT NULL,
  PRIMARY KEY (`idServico`),
  INDEX `fk_Servico_Area1_idx` (`Area` ASC),
  CONSTRAINT `fk_Servico_Area1`
    FOREIGN KEY (`Area`)
    REFERENCES `1corre_manager`.`Area` (`idArea`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `1corre_manager`.`Oferta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `1corre_manager`.`Oferta` (
  `idOferta` INT NOT NULL,
  `Freelancer` INT NOT NULL,
  `Servico` INT NOT NULL,
  `descricao` VARCHAR(200) NOT NULL,
  `preco` DOUBLE NULL,
  PRIMARY KEY (`idOferta`, `Freelancer`, `Servico`),
  INDEX `fk_Freelancer_has_Servico_Servico1_idx` (`Servico` ASC),
  INDEX `fk_Freelancer_has_Servico_Freelancer1_idx` (`Freelancer` ASC),
  CONSTRAINT `fk_Freelancer_has_Servico_Freelancer1`
    FOREIGN KEY (`Freelancer`)
    REFERENCES `1corre_manager`.`Freelancer` (`idFreelancer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Freelancer_has_Servico_Servico1`
    FOREIGN KEY (`Servico`)
    REFERENCES `1corre_manager`.`Servico` (`idServico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `1corre_manager`.`Amostra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `1corre_manager`.`Amostra` (
  `idAmostra` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `descricao` VARCHAR(800) NULL,
  `Oferta` INT NOT NULL,
  `url` VARCHAR(120) NULL,
  `imagem` VARCHAR(130) NULL,
  PRIMARY KEY (`idAmostra`),
  INDEX `fk_Amostra_Oferta1_idx` (`Oferta` ASC),
  CONSTRAINT `fk_Amostra_Oferta1`
    FOREIGN KEY (`Oferta`)
    REFERENCES `1corre_manager`.`Oferta` (`idOferta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `1corre_manager`.`Contratante`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `1corre_manager`.`Contratante` (
  `idContratante` INT NOT NULL AUTO_INCREMENT,
  `Pessoa` INT NOT NULL,
  PRIMARY KEY (`idContratante`),
  INDEX `fk_Cliente_Pessoa1_idx` (`Pessoa` ASC),
  CONSTRAINT `fk_Cliente_Pessoa1`
    FOREIGN KEY (`Pessoa`)
    REFERENCES `1corre_manager`.`Pessoa` (`idPessoa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `1corre_manager`.`Telefone`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `1corre_manager`.`Telefone` (
  `idTelefone` INT NOT NULL AUTO_INCREMENT,
  `telefone` VARCHAR(45) NOT NULL,
  `Pessoa` INT NOT NULL,
  PRIMARY KEY (`idTelefone`),
  INDEX `fk_E-mail_Pessoa1_idx` (`Pessoa` ASC),
  UNIQUE INDEX `telefone_UNIQUE` (`telefone` ASC),
  CONSTRAINT `fk_E-mail_Pessoa1`
    FOREIGN KEY (`Pessoa`)
    REFERENCES `1corre_manager`.`Pessoa` (`idPessoa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `1corre_manager`.`Acordo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `1corre_manager`.`Acordo` (
  `idAcordo` INT NOT NULL AUTO_INCREMENT,
  `Contratante` INT NOT NULL,
  `Oferta` INT NOT NULL,
  `valor` DOUBLE NOT NULL,
  `descricao` VARCHAR(300) NULL,
  `estado` ENUM("ativo", "pausado", "finalizado", "proposto", "quebrado") NOT NULL,
  `modalidade` ENUM("horista", "total") NOT NULL,
  PRIMARY KEY (`idAcordo`, `Contratante`, `Oferta`),
  INDEX `fk_Cliente_has_Oferta_Oferta1_idx` (`Oferta` ASC),
  INDEX `fk_Cliente_has_Oferta_Cliente1_idx` (`Contratante` ASC),
  CONSTRAINT `fk_Cliente_has_Oferta_Cliente1`
    FOREIGN KEY (`Contratante`)
    REFERENCES `1corre_manager`.`Contratante` (`idContratante`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Cliente_has_Oferta_Oferta1`
    FOREIGN KEY (`Oferta`)
    REFERENCES `1corre_manager`.`Oferta` (`idOferta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `1corre_manager`.`Quebra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `1corre_manager`.`Quebra` (
  `idQuebra` INT NOT NULL,
  `parte` TINYINT(1) NOT NULL COMMENT 'parte que quebrou o acordo',
  `descricao` VARCHAR(400) NOT NULL,
  `Acordo` INT NOT NULL,
  PRIMARY KEY (`idQuebra`),
  INDEX `fk_Quebra_Acordo1_idx` (`Acordo` ASC),
  CONSTRAINT `fk_Quebra_Acordo1`
    FOREIGN KEY (`Acordo`)
    REFERENCES `1corre_manager`.`Acordo` (`idAcordo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `1corre_manager`.`Avaliacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `1corre_manager`.`Avaliacao` (
  `idAvaliacao` INT NOT NULL AUTO_INCREMENT,
  `comentario` VARCHAR(200) NULL,
  `Acordo` INT NOT NULL,
  `grau` INT NOT NULL,
  PRIMARY KEY (`idAvaliacao`),
  INDEX `fk_Avaliacao_Acordo1_idx` (`Acordo` ASC),
  CONSTRAINT `fk_Avaliacao_Acordo1`
    FOREIGN KEY (`Acordo`)
    REFERENCES `1corre_manager`.`Acordo` (`idAcordo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
