SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';


-- -----------------------------------------------------
-- Table `Institution`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Institution` (
  `institution_id` INT NOT NULL ,
  `name` VARCHAR(20) NOT NULL ,
  `street_address` VARCHAR(45) NOT NULL ,
  `city` VARCHAR(22) NOT NULL ,
  `state` VARCHAR(20) NOT NULL ,
  `zip_code` CHAR(5) NOT NULL ,
  `phone_number` CHAR(10) NOT NULL ,
  PRIMARY KEY (`institution_id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `User`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `User` (
  `user_id` INT NOT NULL ,
  `type` ENUM('admin','instructor','student') NOT NULL ,
  `first_name` VARCHAR(45) NOT NULL ,
  `last_name` VARCHAR(45) NOT NULL ,
  `email` VARCHAR(45) NOT NULL ,
  `password` VARCHAR(45) NOT NULL ,
  `institution_id` INT NOT NULL ,
  PRIMARY KEY (`user_id`) ,
  INDEX `institution_id` (`institution_id` ASC) ,
  CONSTRAINT `institution_id`
    FOREIGN KEY (`institution_id` )
    REFERENCES `Institution` (`institution_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `File`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `File` (
  `file_id` INT NOT NULL AUTO_INCREMENT ,
  `file_name` VARCHAR(45) NOT NULL ,
  `owner_id` INT NOT NULL ,
  PRIMARY KEY (`file_id`) ,
  INDEX `fk_owner` (`owner_id` ASC) ,
  CONSTRAINT `fk_owner`
    FOREIGN KEY (`owner_id` )
    REFERENCES `User` (`user_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Course`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Course` (
  `course_id` INT NOT NULL ,
  `name` VARCHAR(45) NOT NULL ,
  `instructor_id` INT NOT NULL ,
  PRIMARY KEY (`course_id`) ,
  INDEX `fk_courseinstructor` (`instructor_id` ASC) ,
  CONSTRAINT `fk_courseinstructor`
    FOREIGN KEY (`instructor_id` )
    REFERENCES `User` (`user_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Assignment`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Assignment` (
  `assignment_id` INT NOT NULL AUTO_INCREMENT ,
  `course_id` INT NOT NULL ,
  `name` VARCHAR(45) NOT NULL ,
  `due_date` TIMESTAMP NULL ,
  `assignment_file` INT NOT NULL ,
  PRIMARY KEY (`assignment_id`) ,
  INDEX `course_id` (`course_id` ASC) ,
  INDEX `file_id` (`assignment_file` ASC) ,
  CONSTRAINT `course_id`
    FOREIGN KEY (`course_id` )
    REFERENCES `Course` (`course_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `file_id`
    FOREIGN KEY (`assignment_file` )
    REFERENCES `File` (`file_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Submission`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Submission` (
  `submission_id` INT NOT NULL AUTO_INCREMENT ,
  `file` INT NOT NULL ,
  `assignment` INT NOT NULL ,
  PRIMARY KEY (`submission_id`) ,
  INDEX `fk_submissionfile` (`file` ASC) ,
  INDEX `fk_submission_assignment` (`assignment` ASC) ,
  CONSTRAINT `fk_submissionfile`
    FOREIGN KEY (`file` )
    REFERENCES `File` (`file_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_submission_assignment`
    FOREIGN KEY (`assignment` )
    REFERENCES `Assignment` (`assignment_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Result`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Result` (
  `result_id` INT NOT NULL AUTO_INCREMENT ,
  `submission` INT NOT NULL ,
  `file` INT NOT NULL ,
  INDEX `fk_submission` (`submission` ASC) ,
  INDEX `fk_resultfile` (`file` ASC) ,
  PRIMARY KEY (`result_id`) ,
  CONSTRAINT `fk_submission`
    FOREIGN KEY (`submission` )
    REFERENCES `Submission` (`submission_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_resultfile`
    FOREIGN KEY (`file` )
    REFERENCES `File` (`file_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Test`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Test` (
  `testfile_id` INT NOT NULL AUTO_INCREMENT ,
  `file` INT NOT NULL ,
  `assignment` INT NOT NULL ,
  PRIMARY KEY (`testfile_id`) ,
  INDEX `fk_testfile` (`file` ASC) ,
  INDEX `assignment_id` (`assignment` ASC) ,
  CONSTRAINT `fk_testfile`
    FOREIGN KEY (`file` )
    REFERENCES `File` (`file_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `assignment_id`
    FOREIGN KEY (`assignment` )
    REFERENCES `Assignment` (`assignment_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Course_Student`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Course_Student` (
  `student_id` INT NOT NULL ,
  `course_id` INT NOT NULL ,
  PRIMARY KEY (`student_id`, `course_id`) ,
  INDEX `fk_course` (`course_id` ASC) ,
  INDEX `fk_course_student` (`student_id` ASC) ,
  CONSTRAINT `fk_course`
    FOREIGN KEY (`course_id` )
    REFERENCES `Course` (`course_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_course_student`
    FOREIGN KEY (`student_id` )
    REFERENCES `User` (`user_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
