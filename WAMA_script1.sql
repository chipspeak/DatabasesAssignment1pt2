-- -----------------------------------------------------
-- Drop the 'WAMA' database/schema
-- -----------------------------------------------------

DROP SCHEMA IF EXISTS WAMA;
-- -----------------------------------------------------
-- Create 'WAMA' database/schema and use this database
-- -----------------------------------------------------


CREATE SCHEMA IF NOT EXISTS WAMA;

USE WAMA;

-- -----------------------------------------------------
-- Create table Book
-- -----------------------------------------------------

CREATE TABLE Student (
    studentId INT AUTO_INCREMENT NOT NULL,
    firstName VARCHAR(50) NOT NULL,
    lastName VARCHAR(50) NOT NULL,
    DOB DATE NOT NULL,
    street VARCHAR(50),
    town VARCHAR(50) NOT NULL,
    county VARCHAR(10) NOT NULL,
    zipCode VARCHAR(7) NOT NULL,
    PRIMARY KEY (studentId)
);

-- -----------------------------------------------------
-- Create table Parent
-- -----------------------------------------------------


CREATE TABLE Parent (
    firstName VARCHAR(50) NOT NULL,
    lastName VARCHAR(50) NOT NULL,
    phoneNumber VARCHAR(10) NOT NULL,
    email VARCHAR(50) NOT NULL,
    studentId INT,
    PRIMARY KEY (phoneNumber),
    FOREIGN KEY (studentId)
        REFERENCES Student (studentId)
);

-- -----------------------------------------------------
-- Create table Teacher
-- -----------------------------------------------------

CREATE TABLE Teacher (
    PPS VARCHAR(9) NOT NULL,
    firstName VARCHAR(50) NOT NULL,
    lastName VARCHAR(50) NOT NULL,
    street VARCHAR(50),
    town VARCHAR(50) NOT NULL,
    county VARCHAR(10) NOT NULL,
    zipCode VARCHAR(7) NOT NULL,
    hourlyRate DECIMAL(4, 2) NOT NULL,
    managerPPS VARCHAR(9) DEFAULT NULL,
    PRIMARY KEY (PPS),
    FOREIGN KEY (managerPPS) REFERENCES Teacher(PPS) ON DELETE SET NULL
);

-- -----------------------------------------------------
-- Create table teacherPhones
-- -----------------------------------------------------

CREATE TABLE TeacherPhones (
    phoneNumber VARCHAR(10) NOT NULL,
    PPS VARCHAR(9),
    PRIMARY KEY (phoneNumber),
    FOREIGN KEY (PPS)
        REFERENCES Teacher (PPS)
);

-- -----------------------------------------------------
-- Create table TeacherEmails
-- -----------------------------------------------------

CREATE TABLE TeacherEmails (
    email VARCHAR(50) NOT NULL,
    PPS VARCHAR(9),
    PRIMARY KEY (email),
    FOREIGN KEY (PPS)
        REFERENCES Teacher (PPS)
);

-- -----------------------------------------------------
-- Create table School
-- -----------------------------------------------------

CREATE TABLE School (
    schoolName VARCHAR(11) NOT NULL,
    street VARCHAR(50),
    town VARCHAR(50) NOT NULL,
    county VARCHAR(10) NOT NULL,
    zipCode VARCHAR(7) NOT NULL,
    phoneNumber VARCHAR(10) NOT NULL,
    website VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    PRIMARY KEY (schoolName)
);

-- -----------------------------------------------------
-- Create table Lesson
-- -----------------------------------------------------

CREATE TABLE Lesson (
    lessonCode INT AUTO_INCREMENT NOT NULL,
    length INT NOT NULL,
    PRIMARY KEY (lessonCode),
    PPS VARCHAR(9),
    schoolName VARCHAR(11),
    FOREIGN KEY (PPS)
        REFERENCES Teacher (PPS),
    FOREIGN KEY (schoolName)
        REFERENCES School (schoolName)
);

-- -----------------------------------------------------
-- Create table Exam
-- -----------------------------------------------------

CREATE TABLE Exam (
    examId INT AUTO_INCREMENT NOT NULL,
    examType VARCHAR(11) NOT NULL,
    instrument VARCHAR(50) NOT NULL,
    grade VARCHAR(20),
    examYear INT,
    PRIMARY KEY (examId)
);

-- -----------------------------------------------------
-- Create table GroupLesson
-- -----------------------------------------------------

CREATE TABLE GroupLesson (
    groupCode INT AUTO_INCREMENT NOT NULL,
    groupSubject VARCHAR(50) NOT NULL,
    length INT NOT NULL,
    groupSize INT NOT NULL,
    ageBracket VARCHAR(5) NOT NULL,
    PPS VARCHAR(9),
    schoolName VARCHAR(11),
    PRIMARY KEY (groupCode),
    FOREIGN KEY (PPS)
        REFERENCES Teacher (PPS),
    FOREIGN KEY (schoolName)
        REFERENCES School (schoolName)
);

-- -----------------------------------------------------
-- Create table Participates
-- -----------------------------------------------------

CREATE TABLE Participates (
    studentId INT,
    groupCode INT,
	attendance VARCHAR(5) NOT NULL,
    groupLessondate DATE,
    PRIMARY KEY (studentId, groupCode),
    FOREIGN KEY (studentId) REFERENCES Student (studentId),
    FOREIGN KEY (groupCode) REFERENCES GroupLesson (groupCode)
);

-- -----------------------------------------------------
-- Create table Attends
-- -----------------------------------------------------

CREATE TABLE Attends (
	studentId INT,
    lessonCode INT,
    progress BLOB,
    lessonDate DATE,
    PRIMARY KEY (studentId , lessonCode),
    FOREIGN KEY (studentId)
        REFERENCES Student (studentId),
    FOREIGN KEY (lessonCode)
        REFERENCES Lesson (lessonCode)
);

COMMIT;







