-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema art_gallery
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema art_gallery
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS art_gallery DEFAULT CHARACTER SET utf8 ;
USE art_gallery ;

-- -----------------------------------------------------
-- Table art_gallery.artist
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS art_gallery.artist (
  artist_id INT NOT NULL AUTO_INCREMENT,
  fname VARCHAR(45) NULL,
  mname VARCHAR(45) NULL,
  lname VARCHAR(45) NOT NULL,
  dob INT(4) NOT NULL,
  dod INT(4) NULL,
  country VARCHAR(25) NOT NULL,
  is_local ENUM('y', 'n') NULL,
  PRIMARY KEY (artist_id))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table art_gallery.artwork
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS art_gallery.artwork (
  artwork_id INT NOT NULL,
  title VARCHAR(45) NOT NULL,
  year INT(4) NOT NULL,
  period ENUM('Impressionism', 'Post-Impressionism', 'Baroque', 'Dutch Golden Age', 'High Renaissance', 'Renaissance', 'Modern') NOT NULL,
  type ENUM('Oil', 'Tempra', 'Watercolor') NOT NULL,
  file VARCHAR(45) NOT NULL,
  artist_id INT NOT NULL,
  PRIMARY KEY (artwork_id),
  INDEX fk_artwork_artist1_idx (artist_id ASC) VISIBLE,
  CONSTRAINT fk_artwork_artist1
    FOREIGN KEY (artist_id)
    REFERENCES art_gallery.artist (artist_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table art_gallery.keyword
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS art_gallery.keyword (
  keyword_id INT NOT NULL,
  keyword VARCHAR(45) NOT NULL,
  PRIMARY KEY (keyword_id))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table art_gallery.artwork_has_keyword
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS art_gallery.artwork_has_keyword (
  artwork_id INT NOT NULL,
  keyword_id INT NOT NULL,
  PRIMARY KEY (artwork_id, keyword_id),
  INDEX fk_artwork_has_subject_subject1_idx (keyword_id ASC) VISIBLE,
  INDEX fk_artwork_has_subject_artwork1_idx (artwork_id ASC) VISIBLE,
  CONSTRAINT fk_artwork_has_subject_artwork1
    FOREIGN KEY (artwork_id)
    REFERENCES art_gallery.artwork (artwork_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_artwork_has_subject_subject1
    FOREIGN KEY (keyword_id)
    REFERENCES art_gallery.keyword (keyword_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

USE art_gallery;

SELECT * FROM artist;

INSERT INTO artist (artist_id, fname, mname, lname, dob, dod, country, is_local)
VALUES
(1, 'Vincent', NULL, 'van Gogh', 1853, 1890, 'France', 'n'),
(2, 'Rembrandt', 'Harmenszoon', 'van Rijn', 1606, 1669, 'Netherlands', 'n'),
(3, 'Leonardo', NULL, 'da Vinci', 1452, 1519, 'Italy', 'n'),
(4, 'Venture', 'Lonzo', 'Coy', 1965, NULL, 'United States', 'y'),
(5, 'Deborah', NULL, 'Gill', 1970, NULL, 'United States', 'y'),
(6, 'Claude', NULL, 'Monet', 1840, 1926, 'France', 'n'),
(7, 'Pablo', NULL, 'Picasso', 1881, 1973, 'Spain', 'n'),
(8, 'Michelangelo', 'di Lodovico', 'Simoni', 1475, 1564, 'Italy', 'n');

SELECT * FROM keyword;

INSERT INTO keyword (keyword_id, keyword)
VALUES
(1, 'flowers'),
(2, 'blue'),
(3, 'landscape'),
(4, 'girl'),
(5, 'people'),
(6, 'battle'),
(7, 'boat'),
(8, 'water'),
(9, 'Christ'),
(10, 'food'),
(11, 'baby');

SELECT * FROM artwork;

INSERT INTO artwork (artwork_id, title, year, period, type, file, artist_id)
VALUES
(1, 'Irises', 1889, 'Impressionism', 'Oil', 'irises.jpg', 1),
(2, 'The Starry Night', 1889, 'Post-Impressionism', 'Oil', 'starrynight.jpg', 1),
(3, 'Sunflowers', 1888, 'Post-Impressionism', 'Oil', 'sunflowers.jpg', 1),
(4, 'Night Watch', 1642, 'Baroque', 'Oil', 'nightwatch.jpg', 2),
(5, 'Storm on the Sea of Galilee', 1633, 'Dutch Golden Age', 'Oil', 'stormgalilee.jpg', 2),
(6, 'Head of a Woman', 1508, 'High Renaissance', 'Oil', 'headwoman.jpg', 3),
(7, 'Last Supper', 1498, 'Renaissance', 'Tempra', 'lastsupper.jpg', 3),
(8, 'Mona Lisa', 1517, 'Renaissance', 'Oil', 'monalisa.jpg', 3),
(9, 'Hillside Stream', 2005, 'Modern', 'Oil', 'hillsidestream.jpg', 4),
(10, 'Old Barn', 1992, 'Modern', 'Oil', 'oldbarn.jpg', 4),
(11, 'Beach Baby', 1999, 'Modern', 'Watercolor', 'beachbaby.jpg', 5),
(12, 'Women in the Garden', 1866, 'Impressionism', 'Oil', 'womengarden.jpg', 6),
(13, 'Old Guitarist', 1904, 'Modern', 'Oil', 'guitarist.jpg', 7);

SELECT * FROM artwork_has_keyword;

INSERT INTO artwork_has_keyword (artwork_id, keyword_id)
VALUES
(1, 1), (2, 1), (2, 2), (2, 3), (3, 1), (4, 6), (4, 5), (4, 7), (4, 9), (5, 7), (5, 8), (5, 5), (5, 9), (6, 4), (6, 5), (7, 4), (7, 5), (8, 4), (8, 5), (9, 8), (9, 3), (10, 3), (11, 8), (11, 5), (11, 11), (12, 3), (12, 5), (12, 1);