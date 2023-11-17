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
        ON DELETE CASCADE
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
    hourlyRate DECIMAL(4 , 2 ) NOT NULL,
    managerPPS VARCHAR(9) DEFAULT NULL,
    PRIMARY KEY (PPS),
    FOREIGN KEY (managerPPS)
        REFERENCES Teacher (PPS)
        ON DELETE SET NULL
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
        ON DELETE CASCADE
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
        ON DELETE CASCADE
);

-- -----------------------------------------------------
-- Create table School
-- -----------------------------------------------------

CREATE TABLE School (
    schoolName VARCHAR(50) NOT NULL,
    street VARCHAR(50),
    town VARCHAR(50) NOT NULL,
    county VARCHAR(10) NOT NULL,
    zipCode VARCHAR(10) NOT NULL,
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
    length TEXT NOT NULL,
    instrument VARCHAR(50) NOT NULL,
    PRIMARY KEY (lessonCode),
    PPS VARCHAR(9),
    schoolName VARCHAR(50),
    FOREIGN KEY (PPS)
        REFERENCES Teacher (PPS)
        ON DELETE CASCADE,
    FOREIGN KEY (schoolName)
        REFERENCES School (schoolName)
);

-- -----------------------------------------------------
-- Create table Exam
-- -----------------------------------------------------

CREATE TABLE Exam (
    examId INT AUTO_INCREMENT NOT NULL,
    examType VARCHAR(50) NOT NULL,
    instrument VARCHAR(50) NOT NULL,
    grade VARCHAR(20) NOT NULL,
    examYear VARCHAR(4) NOT NULL,
    examDate DATE,
    studentId INT NOT NULL,
    PRIMARY KEY (examId),
    FOREIGN KEY (studentId)
        REFERENCES Student (studentId)
        ON DELETE CASCADE
);

-- -----------------------------------------------------
-- Create table GroupLesson
-- -----------------------------------------------------

CREATE TABLE GroupLesson (
    groupCode INT AUTO_INCREMENT NOT NULL,
    groupSubject VARCHAR(50) NOT NULL,
    length VARCHAR(50) NOT NULL,
    groupSize INT NOT NULL,
    ageBracket VARCHAR(50) NOT NULL,
    PPS VARCHAR(9),
    schoolName VARCHAR(50),
    PRIMARY KEY (groupCode),
    FOREIGN KEY (PPS)
        REFERENCES Teacher (PPS)
        ON DELETE CASCADE,
    FOREIGN KEY (schoolName)
        REFERENCES School (schoolName)
);

-- -----------------------------------------------------
-- Create table Participates
-- -----------------------------------------------------

CREATE TABLE Participates (
    studentId INT NOT NULL,
    groupCode INT NOT NULL,
    attendance VARCHAR(50) NOT NULL,
    groupLessonTime VARCHAR(5) NOT NULL,
    groupLessonDay VARCHAR(10) NOT NULL,
    groupLessonDate DATE NOT NULL,
    PRIMARY KEY (studentId , groupCode),
    FOREIGN KEY (studentId)
        REFERENCES Student (studentId)
        ON DELETE CASCADE,
    FOREIGN KEY (groupCode)
        REFERENCES GroupLesson (groupCode)
        ON DELETE CASCADE
);

-- -----------------------------------------------------
-- Create table Attends
-- -----------------------------------------------------

CREATE TABLE Attends (
    studentId INT,
    lessonCode INT,
    progress TEXT,
    lessonTime VARCHAR(5),
    lessonDay VARCHAR(10),
    lessonDate DATE,
    PRIMARY KEY (studentId , lessonCode),
    FOREIGN KEY (studentId)
        REFERENCES Student (studentId)
        ON DELETE CASCADE,
    FOREIGN KEY (lessonCode)
        REFERENCES Lesson (lessonCode)
        ON DELETE CASCADE
);

-- -----------------------------------------------------
-- Triggers
-- -----------------------------------------------------

CREATE TABLE lessonProgress (
    reportId INT AUTO_INCREMENT PRIMARY KEY,
	studentId INT,
    lessonCode INT,
    lessonDay VARCHAR(10),
    lessonDate DATE,
    progress TEXT
);

DELIMITER $$
CREATE TRIGGER beforeLessonProgressUpdate  
    BEFORE UPDATE ON attends
    FOR EACH ROW 
BEGIN
    INSERT INTO lessonProgress
	SET studentId = OLD.studentId,
	    lessonCode = OLD.lessonCode,
        lessonTime = OLD.lessonTime,
        lessonDay = OLD.lessonDay,
        lessonDate = Old.lessonDate,
        progress = OLD.progress;
END $$
DELIMITER ;

CREATE TABLE groupAttendance (
	reportId INT AUTO_INCREMENT PRIMARY KEY,
    studentId INT NOT NULL,
    groupCode INT NOT NULL,
    attendance VARCHAR(50) NOT NULL,
    groupLessonTime VARCHAR(5) NOT NULL,
    groupLessonDay VARCHAR(10) NOT NULL,
    groupLessonDate DATE NOT NULL
);

DELIMITER $$
CREATE TRIGGER beforeGroupAttendanceUpdate 
    BEFORE UPDATE ON participates
    FOR EACH ROW 
BEGIN
    INSERT INTO groupAttendance
    SET studentId = OLD.studentId,
	    groupCode = OLD.groupCode,
        groupLessonTime = OLD.groupLessonTime,
        groupLessonDay = OLD.groupLessonDay,
        groupLessonDate = Old.groupLessonDate,
        attendance = OLD.attendance;
END $$
DELIMITER ;
	
-- -----------------------------------------------------
-- Data input
-- -----------------------------------------------------

DELETE FROM TeacherEmails;
DELETE FROM TeacherPhones;
DELETE FROM Teacher;
DELETE FROM Parent;
DELETE FROM Student;
DELETE FROM Lesson;
DELETE FROM School;
DELETE FROM Participates;

ALTER TABLE Student AUTO_INCREMENT = 1;
ALTER TABLE Lesson AUTO_INCREMENT = 1;
ALTER TABLE Exam AUTO_INCREMENT = 1;
ALTER TABLE groupLesson AUTO_INCREMENT = 1;

INSERT INTO Student (firstName, lastName, DOB, street, town, county, zipCode)
VALUES
('Emma', 'Smith', '2007-12-05', '123 Main St', 'Waterford', 'Waterford', 'X1Y 2Z3'),
('Liam', 'Johnson', '2013-08-18', '456 Oak St', 'Waterford', 'Waterford', 'A1B 3C4'), 
('Olivia', 'Williams', '2009-04-03', '789 Pine St', 'Waterford', 'Waterford', 'M5N 8P2'), 
('Noah', 'Brown', '2015-09-21', '101 Cedar St', 'Waterford', 'Waterford', 'R9S 6T7'), 
('Ava', 'Taylor', '2015-02-10', '202 Maple St', 'Waterford', 'Waterford', 'L8K 4W6'), 
('Sophia', 'Jones', '2015-11-27', '303 Birch St', 'Waterford', 'Waterford', 'P2Q 7E9'), 
('Jackson', 'Miller', '2016-06-14', '404 Elm St', 'Waterford', 'Waterford', 'N3M 2R8'), 
('Oliver', 'Davis', '2017-03-30', '505 Oak St', 'Waterford', 'Waterford', 'K7L 9J4'), 
('Emma', 'Martin', '2017-07-19', '606 Cedar St', 'Waterford', 'Waterford', 'H8P 4X2'), 
('Liam', 'Hill', '2010-01-02', '707 Pine St', 'Waterford', 'Waterford', 'T1H 5E6'),
('Amelia', 'Young', '2014-05-13', '808 Birch St', 'Waterford', 'Waterford', 'V5M 7S9'),
('Lucas', 'Cooper', '2003-10-27', '909 Maple St', 'Waterford', 'Waterford', 'J6R 3T2'),
('Ava', 'Ward', '2006-04-08', '101 Oak St', 'Waterford', 'Waterford', 'Z2X 8Y7'), 
('Liam', 'Cox', '2007-11-25', '202 Pine St', 'Waterford', 'Waterford', 'R3S 1A6'),
('Olivia', 'Kelly', '2015-08-12', '303 Birch St', 'Waterford', 'Waterford', 'N7L 6K9'), 
('Noah', 'Murphy', '2005-02-17', '404 Cedar St', 'Waterford', 'Waterford', 'K4P 9Q8'),
('Sophia', 'Baker', '2015-07-09', '505 Elm St', 'Waterford', 'Waterford', 'T8H 2E4'),
('Jackson', 'Harrison', '2008-04-03', '606 Oak St', 'Waterford', 'Waterford', 'H1Y 3T6'),
('Oliver', 'Fisher', '2005-09-22', '707 Pine St', 'Waterford', 'Waterford', 'X5V 2R4'), 
('Emma', 'Barnes', '2004-01-01', '808 Maple St', 'Waterford', 'Waterford', 'Z9W 4Q7'),
('Liam', 'Reed', '2007-06-14', '909 Cedar St', 'Waterford', 'Waterford', 'L3M 8N2'),
('Ava', 'Dennis', '2007-12-14', '707 Cedar St', 'Waterford', 'Waterford', 'R6S 7K1'),
('Liam', 'French', '2006-05-30', '808 Oak St', 'Waterford', 'Waterford', 'K2G 4H9'), 
('Olivia', 'Conner', '2009-10-19', '909 Birch St', 'Waterford', 'Waterford', 'J7T 6P5'),
('Noah', 'Lambert', '2008-04-02', '101 Maple St', 'Waterford', 'Waterford', 'W4X 2V1'),
('Sophia', 'Keller', '2003-09-17', '202 Cedar St', 'Waterford', 'Waterford', 'Y3Z 7R8'),
('Jackson', 'Austin', '2007-03-06', '303 Elm St', 'Waterford', 'Waterford', 'A4B 8C9'), 
('Oliver', 'Shaw', '2004-08-21', '404 Pine St', 'Waterford', 'Waterford', 'L1N 5E6'),
('Emma', 'Cohen', '2003-01-10', '505 Oak St', 'Waterford', 'Waterford', 'P9Q 2M4'),
('Liam', 'Bates', '2006-06-25', '606 Birch St', 'Waterford', 'Waterford', 'X2T 7W3'), 
('Amelia', 'Hale', '2005-12-08', '707 Maple St', 'Waterford', 'Waterford', 'R5S 4K8'),
('Lucas', 'Lloyd', '2002-05-27', '808 Cedar St', 'Waterford', 'Waterford', 'K3R 5T8'),
('Ava', 'Fitzgerald', '2007-10-12', '909 Elm St', 'Waterford', 'Waterford', 'Y2Z 8X1'),
('Liam', 'Maxwell', '2008-04-01', '101 Birch St', 'Waterford', 'Waterford', 'A3B 7C9'),
('Sophia', 'Ortega', '2006-03-27', '606 Maple St', 'Waterford', 'Waterford', 'L1N 5E6'), 
('Jackson', 'Goodman', '2011-08-12', '707 Cedar St', 'Waterford', 'Waterford', 'P9Q 2M4'),
('Oliver', 'Bauer', '2008-02-01', '808 Elm St', 'Waterford', 'Waterford', 'X2T 7W3'),
('Ava', 'Hoover', '2008-02-10', '404 Pine St', 'Waterford', 'Waterford', 'X5V 2R4'),
('Liam', 'Bender', '2006-07-25', '505 Oak St', 'Waterford', 'Waterford', 'Z9W 4Q7'), 
('Ella', 'Clark', '2006-11-15', '111 Cedar St', 'Waterford', 'Waterford', 'R9S 6T7'), 
('Mason', 'Lee', '2007-09-02', '222 Oak St', 'Waterford', 'Waterford', 'A1B 3C4'), 
('Scarlett', 'Lewis', '2005-04-11', '333 Pine St', 'Waterford', 'Waterford', 'M5N 8P2'),
('Logan', 'Adams', '2008-06-25', '444 Maple St', 'Waterford', 'Waterford', 'L8K 4W6'),
('Aria', 'Wright', '2003-02-14', '555 Birch St', 'Waterford', 'Waterford', 'P2Q 7E9'),
('Henry', 'Hall', '2002-01-30', '666 Elm St', 'Waterford', 'Waterford', 'N3M 2R8'),
('Avery', 'Allen', '2001-08-27', '777 Cedar St', 'Waterford', 'Waterford', 'K7L 9J4'),
('Leo', 'Hill', '2004-05-16', '888 Oak St', 'Waterford', 'Waterford', 'H8P 4X2'),
('Luna', 'Baker', '2005-03-02', '999 Pine St', 'Waterford', 'Waterford', 'T1H 5E6'),
('Wyatt', 'Evans', '2006-12-12', '123 Birch St', 'Waterford', 'Waterford', 'V5M 7S9'),
('Mia', 'Turner', '2002-10-10', '456 Maple St', 'Waterford', 'Waterford', 'J6R 3T2'), 
('Elijah', 'Cox', '2003-11-20', '789 Cedar St', 'Waterford', 'Waterford', 'Z2X 8Y7'),
('Zoe', 'Dunn', '2001-06-07', '101 Oak St', 'Waterford', 'Waterford', 'R3S 1A6'),
('Carter', 'Guzman', '2004-08-30', '202 Pine St', 'Waterford', 'Waterford', 'N7L 6K9'),
('Hazel', 'Kelly', '2005-01-25', '303 Birch St', 'Waterford', 'Waterford', 'K4P 9Q8'),
('Grayson', 'Murphy', '2002-07-10', '404 Cedar St', 'Waterford', 'Waterford', 'T8H 2E4'),
('Aurora', 'Baker', '2003-03-14', '505 Elm St', 'Waterford', 'Waterford', 'H1Y 3T6'),
('Caleb', 'Fisher', '2006-02-01', '606 Oak St', 'Waterford', 'Waterford', 'X5V 2R4'), 
('Stella', 'Barnes', '2001-09-18', '707 Pine St', 'Waterford', 'Waterford', 'Z9W 4Q7'),
('Eli', 'Reed', '2007-11-02', '808 Maple St', 'Waterford', 'Waterford', 'L3M 8N2'),
('Aubrey', 'Dennis', '2004-05-18', '909 Cedar St', 'Waterford', 'Waterford', 'R6S 7K1'),
('Oliver', 'French', '2005-10-30', '101 Oak St', 'Waterford', 'Waterford', 'K2G 4H9'),
('Paisley', 'Conner', '2001-08-15', '202 Cedar St', 'Waterford', 'Waterford', 'J7T 6P5'),
('Owen', 'Lambert', '2002-04-02', '303 Elm St', 'Waterford', 'Waterford', 'W4X 2V1'),
('Nova', 'Keller', '2006-09-17', '404 Pine St', 'Waterford', 'Waterford', 'Y3Z 7R8'),
('Isaiah', 'Austin', '2005-03-06', '505 Oak St', 'Waterford', 'Waterford', 'A4B 8C9'),
('Amara', 'Shaw', '2003-08-21', '606 Maple St', 'Waterford', 'Waterford', 'L1N 5E6'),
('Liam', 'Cohen', '2002-01-10', '707 Cedar St', 'Waterford', 'Waterford', 'P9Q 2M4'),
('Hannah', 'Bates', '2005-06-25', '808 Elm St', 'Waterford', 'Waterford', 'X2T 7W3'),
('Axel', 'Hale', '2004-12-08', '909 Maple St', 'Waterford', 'Waterford', 'R5S 4K8'),
('Madison', 'Lloyd', '2001-05-27', '101 Pine St', 'Waterford', 'Waterford', 'K3R 5T8'),
('Sophie', 'Anderson', '2011-04-15', '111 Cedar St', 'Waterford', 'Waterford', 'R9S 6T7'),
('Ethan', 'Smith', '2011-07-22', '222 Oak St', 'Waterford', 'Waterford', 'A1B 3C4'),
('Isabella', 'Johnson', '2011-10-01', '333 Pine St', 'Waterford', 'Waterford', 'M5N 8P2'),
('Mason', 'Williams', '2011-12-12', '444 Maple St', 'Waterford', 'Waterford', 'L8K 4W6'),
('Chloe', 'Brown', '2011-02-28', '555 Birch St', 'Waterford', 'Waterford', 'P2Q 7E9'),
('Landon', 'Taylor', '2011-06-07', '666 Elm St', 'Waterford', 'Waterford', 'N3M 2R8'),
('Zoe', 'Jones', '2011-09-14', '777 Cedar St', 'Waterford', 'Waterford', 'K7L 9J4'),
('Carter', 'Davis', '2011-11-25', '888 Oak St', 'Waterford', 'Waterford', 'H8P 4X2'),
('Avery', 'Martin', '2011-03-18', '999 Pine St', 'Waterford', 'Waterford', 'T1H 5E6'),
('Leo', 'Hill', '2011-08-09', '123 Birch St', 'Waterford', 'Waterford', 'V5M 7S9'),
('Sophie', 'Miller', '2014-04-15', '111 Cedar St', 'Waterford', 'Waterford', 'R9S 6T7'),
('Ethan', 'Wilson', '2014-07-22', '222 Oak St', 'Waterford', 'Waterford', 'A1B 3C4'),
('Isabella', 'Moore', '2014-10-01', '333 Pine St', 'Waterford', 'Waterford', 'M5N 8P2'),
('Mason', 'Anderson', '2014-12-12', '444 Maple St', 'Waterford', 'Waterford', 'L8K 4W6'),
('Chloe', 'Clark', '2014-02-28', '555 Birch St', 'Waterford', 'Waterford', 'P2Q 7E9'),
('Landon', 'Baker', '2014-06-07', '666 Elm St', 'Waterford', 'Waterford', 'N3M 2R8'),
('Zoe', 'Ward', '2014-09-14', '777 Cedar St', 'Waterford', 'Waterford', 'K7L 9J4'),
('Carter', 'Fisher', '2014-11-25', '888 Oak St', 'Waterford', 'Waterford', 'H8P 4X2'),
('Avery', 'Wright', '2014-03-18', '999 Pine St', 'Waterford', 'Waterford', 'T1H 5E6'),
('Leo', 'Harrison', '2014-08-09', '123 Birch St', 'Waterford', 'Waterford', 'V5M 7S9'),
('Harper', 'Jones', '2016-04-15', '111 Cedar St', 'Waterford', 'Waterford', 'R9S 6T7'),
('Liam', 'Davis', '2016-07-22', '222 Oak St', 'Waterford', 'Waterford', 'A1B 3C4'),
('Aria', 'Martin', '2016-10-01', '333 Pine St', 'Waterford', 'Waterford', 'M5N 8P2'),
('Elijah', 'Taylor', '2016-12-12', '444 Maple St', 'Waterford', 'Waterford', 'L8K 4W6'),
('Ava', 'Cooper', '2016-02-28', '555 Birch St', 'Waterford', 'Waterford', 'P2Q 7E9'),
('Jackson', 'Miller', '2016-06-07', '666 Elm St', 'Waterford', 'Waterford', 'N3M 2R8'),
('Olivia', 'Ward', '2016-09-14', '777 Cedar St', 'Waterford', 'Waterford', 'K7L 9J4'),
('Noah', 'Fisher', '2016-11-25', '888 Oak St', 'Waterford', 'Waterford', 'H8P 4X2'),
('Sophia', 'Wright', '2016-03-18', '999 Pine St', 'Waterford', 'Waterford', 'T1H 5E6'),
('Mason', 'Harrison', '2016-08-09', '123 Birch St', 'Waterford', 'Waterford', 'V5M 7S9');


INSERT INTO Parent (firstName, lastName, phoneNumber, email, studentId)
VALUES
('John', 'Smith', '0801722334', 'john.smith123@example.com', '1'),
('Emma', 'Smith', '0802233445', 'emma.smith456@example.com', '1'),
('Michael', 'Johnson', '0803344556', 'michael.johnson789@example.com', '2'),
('Sarah', 'Johnson', '0804455667', 'sarah.johnson012@example.com', '2'),
('David', 'Williams', '0805566778', 'david.williams345@example.com', '3'),
('Emily', 'Williams', '0806677889', 'emily.williams678@example.com', '3'),
('Christopher', 'Brown', '0807788990', 'christopher.brown901@example.com', '4'),
('Olivia', 'Brown', '0808899001', 'olivia.brown234@example.com', '4'),
('Daniel', 'Taylor', '0809900112', 'daniel.taylor567@example.com', '5'),
('Amy', 'Taylor', '0811001223', 'amy.taylor890@example.com', '5'),
('Matthew', 'Jones', '0812112334', 'matthew.jones123@example.com', '6'),
('Sandra', 'Jones', '0813223445', 'sandra.jones456@example.com', '6'),
('Andrew', 'Miller', '0814334556', 'andrew.miller789@example.com', '7'),
('Mia', 'Miller', '0815445667', 'mia.miller012@example.com', '7'),
('James', 'Davis', '0816556778', 'james.davis345@example.com', '8'),
('Amelia', 'Davis', '0817667889', 'amelia.davis678@example.com', '8'),
('Joseph', 'Martin', '0818778990', 'joseph.martin901@example.com', '9'),
('Harper', 'Martin', '0819889001', 'harper.martin234@example.com', '9'),
('William', 'Hill', '0820990112', 'william.hill567@example.com', '10'),
('Evelyn', 'Hill', '0822001223', 'evelyn.hill890@example.com', '10'),
('Benjamin', 'Young', '0823112334', 'benjamin.young123@example.com', '11'),
('Abigail', 'Young', '0824223445', 'abigail.young456@example.com', '11'),
('Samuel', 'Cooper', '0825334556', 'samuel.cooper789@example.com', '12'),
('Ella', 'Cooper', '0826445667', 'ella.cooper012@example.com', '12'),
('Alexander', 'Ward', '0827556778', 'alexander.ward345@example.com', '13'),
('Scarlett', 'Ward', '0828667889', 'scarlett.ward678@example.com', '13'),
('Nicholas', 'Cox', '0829778990', 'nicholas.cox901@example.com', '14'),
('Grace', 'Cox', '0820889001', 'grace.cox234@example.com', '14'),
('Ethan', 'Kelly', '0821990112', 'ethan.kelly567@example.com', '15'),
('Lily', 'Kelly', '0833001223', 'lily.kelly890@example.com', '15'),
('Aiden', 'Murphy', '0834112334', 'aiden.murphy123@example.com', '16'),
('Chloe', 'Murphy', '0835223445', 'chloe.murphy456@example.com', '16'),
('Anthony', 'Baker', '0836334556', 'anthony.baker789@example.com', '17'),
('Zoey', 'Baker', '0837445667', 'zoey.baker012@example.com', '17'),
('Ryan', 'Harrison', '0838556778', 'ryan.harrison345@example.com', '18'),
('Aria', 'Harrison', '0839667889', 'aria.harrison678@example.com', '18'),
('Emma', 'Fisher', '0840778990', 'emma.fisher901@example.com', '19'),
('Liam', 'Fisher', '0841889001', 'liam.fisher234@example.com', '19'),
('Sophia', 'Barnes', '0842990112', 'sophia.barnes567@example.com', '20'),
('Ava', 'Barnes', '0844001223', 'ava.barnes890@example.com', '20'),
('Jackson', 'Reed', '0845112334', 'jackson.reed123@example.com', '21'),
('Isabella', 'Reed', '0846223445', 'isabella.reed456@example.com', '21'),
('Lucas', 'Dennis', '0847334556', 'lucas.dennis789@example.com', '22'),
('Mia', 'Dennis', '0848445667', 'mia.dennis012@example.com', '22'),
('Noah', 'French', '0849556778', 'noah.french345@example.com', '23'),
('Amelia', 'French', '0850667889', 'amelia.french678@example.com', '23'),
('John', 'Conner', '0851778990', 'john.conner901@example.com', '24'),
('Sophia', 'Conner', '0852889001', 'sophia.conner234@example.com', '24'),
('Henry', 'Lambert', '0853990112', 'henry.lambert567@example.com', '25'),
('Chloe', 'Lambert', '0855001223', 'chloe.lambert890@example.com', '25'),
('Logan', 'Keller', '0856112334', 'logan.keller123@example.com', '26'),
('Aria', 'Keller', '0857223445', 'aria.keller456@example.com', '26'),
('Oliver', 'Austin', '0858334556', 'oliver.austin789@example.com', '27'),
('Harper', 'Austin', '0859445667', 'harper.austin012@example.com', '27'),
('Elijah', 'Shaw', '0860556778', 'elijah.shaw345@example.com', '28'),
('Evelyn', 'Shaw', '0861667889', 'evelyn.shaw678@example.com', '28'),
('Gabriel', 'Cohen', '0862778990', 'gabriel.cohen901@example.com', '29'),
('Addison', 'Cohen', '0863889001', 'addison.cohen234@example.com', '29'),
('Julian', 'Bates', '0864990112', 'julian.bates567@example.com', '30'),
('Ella', 'Bates', '0865001223', 'ella.bates890@example.com', '30'),
('Samuel', 'Hale', '0866112334', 'samuel.hale123@example.com', '31'),
('Scarlett', 'Hale', '0867223445', 'scarlett.hale456@example.com', '31'),
('Abigail', 'Lloyd', '0868334556', 'abigail.lloyd789@example.com', '32'),
('Grace', 'Lloyd', '0869445667', 'grace.lloyd012@example.com', '32'),
('Harper', 'Fitzgerald', '0870556778', 'harper.fitzgerald345@example.com', '33'),
('Ellie', 'Fitzgerald', '0871667889', 'ellie.fitzgerald678@example.com', '33'),
('Madison', 'Maxwell', '0872778990', 'madison.maxwell901@example.com', '34'),
('Hazel', 'Maxwell', '0873889001', 'hazel.maxwell234@example.com', '34'),
('Claire', 'Ortega', '0874990112', 'claire.ortega567@example.com', '35'),
('Penelope', 'Ortega', '0875001223', 'penelope.ortega890@example.com', '35'),
('Stella', 'Goodman', '0876112334', 'stella.goodman123@example.com', '36'),
('Nora', 'Goodman', '0877223445', 'nora.goodman456@example.com', '36'),
('Violet', 'Bauer', '0878334556', 'violet.bauer789@example.com', '37'),
('Lucy', 'Bauer', '0879445667', 'lucy.bauer012@example.com', '37'),
('Skylar', 'Hoover', '0880556778', 'skylar.hoover345@example.com', '38'),
('Lily', 'Hoover', '0881667889', 'lily.hoover678@example.com', '38'),
('Jamie', 'Bender', '0882778990', 'jamie.bender901@example.com', '39'),
('Zoey', 'Bender', '0883889001', 'zoey.bender234@example.com', '39'),
('Daniel', 'Clark', '0884990112', 'daniel.clark567@example.com', '40'),
('Emily', 'Clark', '0885001223', 'emily.clark890@example.com', '40'),
('Benjamin', 'Lee', '0886112334', 'benjamin.lee123@example.com', '41'),
('Olivia', 'Lee', '0887223445', 'olivia.lee456@example.com', '41'),
('Christopher', 'Lewis', '0888334556', 'christopher.lewis789@example.com', '42'),
('Sophia', 'Lewis', '0889445667', 'sophia.lewis012@example.com', '42'),
('Samuel', 'Adams', '0890556778', 'samuel.adams345@example.com', '43'),
('Victoria', 'Adams', '0891667889', 'victoria.adams678@example.com', '43'),
('Matthew', 'Wright', '0892778990', 'matthew.wright901@example.com', '44'),
('Evelyn', 'Wright', '0893889001', 'evelyn.wright234@example.com', '44'),
('Andrew', 'Hall', '0894990112', 'andrew.hall567@example.com', '45'),
('Natalie', 'Hall', '0895001223', 'natalie.hall890@example.com', '45'),
('William', 'Allen', '0896112334', 'william.allen123@example.com', '46'),
('Chloe', 'Allen', '0897223445', 'chloe.allen456@example.com', '46'),
('Daniel', 'Hill', '0898334556', 'daniel.hill789@example.com', '47'),
('Lily', 'Hill', '0899445667', 'lily.hill012@example.com', '47'),
('Anthony', 'Baker', '0900556778', 'anthony.baker345@example.com', '48'),
('Harper', 'Baker', '0901667889', 'harper.baker678@example.com', '48'),
('Christopher', 'Evans', '0902778990', 'christopher.evans901@example.com', '49'),
('Madison', 'Evans', '0903889001', 'madison.evans234@example.com', '49'),
('Ethan', 'Turner', '0904990112', 'ethan.turner567@example.com', '50'),
('Grace', 'Turner', '0905001223', 'grace.turner890@example.com', '50'),
('Lucas', 'Cox', '0906112334', 'lucas.cox123@example.com', '51'),
('Stella', 'Cox', '0907223445', 'stella.cox456@example.com', '51'),
('Jonathan', 'Dunn', '0908334556', 'jonathan.dunn789@example.com', '52'),
('Audrey', 'Dunn', '0909445667', 'audrey.dunn012@example.com', '52'),
('Julian', 'Guzman', '0910556778', 'julian.guzman345@example.com', '53'),
('Penelope', 'Guzman', '0911667889', 'penelope.guzman678@example.com', '53'),
('Nathan', 'Kelly', '0912778990', 'nathan.kelly901@example.com', '54'),
('Isabella', 'Kelly', '0913889001', 'isabella.kelly234@example.com', '54'),
('Isaac', 'Murphy', '0914990112', 'isaac.murphy567@example.com', '55'),
('Aurora', 'Murphy', '0915001223', 'aurora.murphy890@example.com', '55'),
('Carter', 'Baker', '0916112334', 'carter.baker123@example.com', '56'),
('Aria', 'Baker', '0917223445', 'aria.baker456@example.com', '56'),
('Oliver', 'Fisher', '0918334556', 'oliver.fisher789@example.com', '57'),
('Stella', 'Fisher', '0919445667', 'stella.fisher012@example.com', '57'),
('Vincent', 'Barnes', '0920556778', 'vincent.barnes345@example.com', '58'),
('Valentina', 'Barnes', '0921667889', 'valentina.barnes678@example.com', '58'),
('Victor', 'Reed', '0922778990', 'victor.reed901@example.com', '59'),
('Nova', 'Reed', '0923889001', 'nova.reed234@example.com', '59'),
('Nathan', 'Dennis', '0924990112', 'nathan.dennis567@example.com', '60'),
('Clara', 'Dennis', '0925001223', 'clara.dennis890@example.com', '60'),
('Carter', 'French', '0926112334', 'carter.french123@example.com', '61'),
('Eliana', 'French', '0927223445', 'eliana.french456@example.com', '61'),
('Eric', 'Conner', '0928334556', 'eric.conner789@example.com', '62'),
('Elise', 'Conner', '0929445667', 'elise.conner012@example.com', '62'),
('Ethan', 'Lambert', '0930556778', 'ethan.lambert345@example.com', '63'),
('Olivia', 'Lambert', '0931667889', 'olivia.lambert678@example.com', '63'),
('Evan', 'Keller', '0932778990', 'evan.keller901@example.com', '64'),
('Emilia', 'Keller', '0933889001', 'emilia.keller234@example.com', '64'),
('Austin', 'Austin', '0934990112', 'austin.austin567@example.com', '65'),
('Isla', 'Austin', '0935001223', 'isla.austin890@example.com', '65'),
('Max', 'Shaw', '0936112334', 'max.shaw123@example.com', '66'),
('Sophia', 'Shaw', '0937223445', 'sophia.shaw456@example.com', '66'),
('Simon', 'Cohen', '0938334556', 'simon.cohen789@example.com', '67'),
('Amelia', 'Cohen', '0939445667', 'amelia.cohen012@example.com', '67'),
('Andrew', 'Bates', '0940556778', 'andrew.bates345@example.com', '68'),
('Ava', 'Bates', '0941667889', 'ava.bates678@example.com', '68'),
('Austin', 'Hale', '0942778990', 'austin.hale901@example.com', '69'),
('Ava', 'Hale', '0943889001', 'ava.hale234@example.com', '69'),
('Mason', 'Lloyd', '0944990112', 'mason.lloyd567@example.com', '70'),
('Mia', 'Lloyd', '0945001223', 'mia.lloyd890@example.com', '70'),
('Ciaran', 'Anderson', '0801722324', 'ciaran.anderson@example.com', '71'),
('Siobhan', 'Anderson', '0802233435', 'siobhan.anderson@example.com', '71'),
('Finn', 'Smith', '0803344552', 'finn.smith@example.com', '72'),
('Aoife', 'Smith', '0804455668', 'aoife.smith@example.com', '72'),
('Saoirse', 'Johnson', '0805566779', 'saoirse.johnson@example.com', '73'),
('Padraig', 'Johnson', '0806677880', 'padraig.johnson@example.com', '73'),
('Eamon', 'Williams', '0807788991', 'eamon.williams@example.com', '74'),
('Aisling', 'Williams', '0808899002', 'aisling.williams@example.com', '74'),
('Cillian', 'Brown', '0809900113', 'cillian.brown@example.com', '75'),
('Sinead', 'Brown', '0811001224', 'sinead.brown@example.com', '75'),
('Conall', 'Taylor', '0812112335', 'conall.taylor@example.com', '76'),
('Eilis', 'Taylor', '0813223446', 'eilis.taylor@example.com', '76'),
('Orlaith', 'Jones', '0814334557', 'orlaith.jones@example.com', '77'),
('Fionn', 'Jones', '0815445668', 'fionn.jones@example.com', '77'),
('Cathal', 'Davis', '0816556779', 'cathal.davis@example.com', '78'),
('Aine', 'Davis', '0817667880', 'aine.davis@example.com', '78'),
('Oisin', 'Martin', '0818778991', 'oisin.martin@example.com', '79'),
('Aislinn', 'Martin', '0819889002', 'aislinn.martin@example.com', '79'),
('Fionnuala', 'Hill', '0820990113', 'fionnuala.hill@example.com', '80'),
('Ciaran', 'Hill', '0822001224', 'ciaran.hill@example.com', '80'),
('Sophie', 'Miller', '0123455115', 'sophie.miller@email.com', 81),
('Tom', 'Miller', '0123455226', 'tom.miller@email.com', 81),
('Ethan', 'Wilson', '0123455337', 'ethan.wilson@email.com', 82),
('Olivia', 'Wilson', '0123455448', 'olivia.wilson@email.com', 82),
('Isabella', 'Moore', '0123455559', 'isabella.moore@email.com', 83),
('Daniel', 'Moore', '0123455660', 'daniel.moore@email.com', 83),
('Mason', 'Anderson', '0123455771', 'mason.anderson@email.com', 84),
('Ava', 'Anderson', '0123455882', 'ava.anderson@email.com', 84),
('Chloe', 'Clark', '0123455993', 'chloe.clark@email.com', 85),
('Caleb', 'Clark', '0123455101', 'caleb.clark@email.com', 85),
('Landon', 'Baker', '0123455111', 'landon.baker@email.com', 86),
('Sophia', 'Baker', '0123455222', 'sophia.baker@email.com', '86'),
('Zoe', 'Ward', '0123455333', 'zoe.ward@email.com', 87),
('Matthew', 'Ward', '0123455444', 'matthew.ward@email.com', 87),
('Carter', 'Fisher', '0123455555', 'carter.fisher@email.com', 88),
('Grace', 'Fisher', '0123455666', 'grace.fisher@email.com', 88),
('Avery', 'Wright', '0123455777', 'avery.wright@email.com', 89),
('Ella', 'Wright', '0123455888', 'ella.wright@email.com', 89),
('Leo', 'Harrison', '0123455999', 'leo.harrison@email.com', 90),
('Lily', 'Harrison', '0123455110', 'lily.harrison@email.com', 90),
('Harper', 'Jones', '0123455113', 'harper.jones@email.com', 91),
('Samuel', 'Jones', '0123455224', 'samuel.jones@email.com', 91),
('Liam', 'Davis', '0123455345', 'liam.davis@email.com', 92),
('Emily', 'Davis', '0123455456', 'emily.davis@email.com', 92),
('Aria', 'Martin', '0123455567', 'aria.martin@email.com', 93),
('James', 'Martin', '0123455678', 'james.martin@email.com', 93),
('Elijah', 'Taylor', '0123455789', 'elijah.taylor@email.com', 94),
('Zoe', 'Taylor', '0123455890', 'zoe.taylor@email.com', 94),
('Ava', 'Cooper', '0123455901', 'ava.cooper@email.com', 95),
('Jackson', 'Cooper', '0123401010', 'jackson.cooper@email.com', 95),
('Olivia', 'Miller', '0123455121', 'olivia.miller@email.com', 96),
('Henry', 'Miller', '0123552232', 'henry.miller@email.com', 96),
('Noah', 'Ward', '0124553343', 'noah.ward@email.com', 97),
('Emma', 'Ward', '0134554454', 'emma.ward@email.com', 97),
('Sophia', 'Fisher', '0123455565', 'sophia.fisher@email.com', 98),
('William', 'Fisher', '0123455676', 'william.fisher@email.com', 98),
('Mason', 'Wright', '0123455787', 'mason.wright@email.com', 99),
('Avery', 'Wright', '0123455878', 'avery.wright@email.com', 99),
('Lisa', 'Harrison', '0123455909', 'leo.harrison@email.com', 100),
('Leo', 'Harrison', '0123455910', 'leo.harrison@email.com', 100);


INSERT INTO Teacher (PPS, firstName, lastName, street, town, county, zipCode, hourlyRate, managerPPS)
VALUES
('123456789', 'Seán', 'Murphy', '1 River Road', 'Waterford', 'Waterford', 'WAT1234', '50.00', NULL),
('234567890', 'Aoife', 'O\'Sullivan', '2 Sea View', 'Dungarvan', 'Waterford', 'DUN5678', '25.00', '123456789'),
('345678901', 'Ciarán', 'Fitzgerald', '3 Lakeside', 'Tramore', 'Waterford', 'TRA9012', '25.00', '123456789'),
('456789012', 'Niamh', 'Walsh', '4 Mountain View', 'Waterford', 'Waterford', 'WAT3456', '25.00', '123456789'),
('567890123', 'Eoin', 'Ryan', '5 Coastal Drive', 'Dungarvan', 'Waterford', 'DUN7890', '25.00', '123456789'),
('678901234', 'Síle', 'Flynn', '6 Harbour Street', 'Tramore', 'Waterford', 'TRA2345', '25.00', '123456789'),
('789012345', 'Padraig', 'O\'Connor', '7 Meadow Lane', 'Waterford', 'Waterford', 'WAT6789', '25.00', '123456789'),
('890123456', 'Aisling', 'O\'Brien', '8 Riverside', 'Dungarvan', 'Waterford', 'DUN0123', '25.00', '123456789'),
('901234567', 'Darragh', 'Daly', '9 Greenfield', 'Tramore', 'Waterford', 'TRA4567', '25.00', '123456789'),
('012345678', 'Gráinne', 'Kavanagh', '10 Bluebell Lane', 'Waterford', 'Waterford', 'WAT8901', '25.00', '123456789'),
('978654321', 'Pat', 'Grant', '42 Riverside', 'Dunmore Road', 'Waterford', 'X91PD31', '50.00', '123456789'),
('878654321', 'Robyn', 'Walsh', '36 Riverside', 'Dunmore Road', 'Waterford', 'X91DS31', '50.00', '123456789');


INSERT INTO TeacherPhones (phoneNumber, PPS)
VALUES
('1234567890', '123456789'),
('2234567890', '123456789'),
('2345678901', '234567890'),
('3345678901', '234567890'),
('3456789012', '345678901'),
('4456789012', '345678901'),
('4567890123', '456789012'),
('5567890123', '456789012'),
('5678901234', '567890123'),
('6678901234', '567890123'),
('6789012345', '678901234'),
('7789012345', '678901234'),
('7890123456', '789012345'),
('8890123456', '789012345'),
('8901234567', '890123456'),
('9901234567', '890123456'),
('9012345678', '901234567'),
('8012345678', '901234567'),
('0123456789', '012345678'),
('1123456789', '012345678'),
('0868997889', '978654321'),
('0868997882', '978654321'),
('0872031442', '878654321'),
('0872031331', '878654321');


INSERT INTO TeacherEmails (email, PPS)
VALUES
('sean@wama.com', '123456789'),
('sean@example.com', '123456789'),
('aoife@wama.com', '234567890'),
('aoife@example.com', '234567890'),
('ciaran@wama.com', '345678901'),
('ciaran@example.com', '345678901'),
('niamh@wama.com', '456789012'),
('niamh@example.com', '456789012'),
('eoin@wama.com', '567890123'),
('eoin@example.com', '567890123'),
('sile@wama.com', '678901234'),
('sile@example.com', '678901234'),
('padraig@wama.com', '789012345'),
('padraig@example.com', '789012345'),
('aisling@wama.com', '890123456'),
('aisling@example.com', '890123456'),
('darragh@wama.com', '901234567'),
('darragh@example.com', '901234567'),
('grainne@wama.com', '012345678'),
('grainne@example.com', '012345678'),
('pat@example.com', '978654321'),
('pat@wama.com', '978654321'),
('robyn@example.com', '878654321'),
('robyn@email.com', '878654321');


INSERT INTO School (schoolName, street, town, county, zipCode, phoneNumber, website, email)
VALUES
('Waterford Academy of Music and Art', 'Passage Cross', 'Waterford', 'Waterford', 'X91 W1XF', '051821014', 'wama.ie', 'info@wama.ie');


INSERT INTO Lesson (length, instrument, PPS, schoolName)
VALUES
('30 minutes', 'Piano', '123456789', 'Waterford Academy of Music and Art'),
('30 minutes', 'Piano', '123456789', 'Waterford Academy of Music and Art'),
('30 minutes', 'Piano', '123456789', 'Waterford Academy of Music and Art'),
('30 minutes', 'Piano', '123456789', 'Waterford Academy of Music and Art'),
('30 minutes', 'Piano', '123456789', 'Waterford Academy of Music and Art'),
('30 minutes', 'Guitar', '234567890', 'Waterford Academy of Music and Art'),
('30 minutes', 'Guitar', '234567890', 'Waterford Academy of Music and Art'),
('30 minutes', 'Guitar', '234567890', 'Waterford Academy of Music and Art'),
('30 minutes', 'Guitar', '234567890', 'Waterford Academy of Music and Art'),
('30 minutes', 'Guitar', '234567890', 'Waterford Academy of Music and Art'),	
('30 minutes', 'Drums', '345678901', 'Waterford Academy of Music and Art'),
('30 minutes', 'Drums', '345678901', 'Waterford Academy of Music and Art'),
('30 minutes', 'Drums', '345678901', 'Waterford Academy of Music and Art'),
('30 minutes', 'Drums', '345678901', 'Waterford Academy of Music and Art'),
('30 minutes', 'Drums', '345678901', 'Waterford Academy of Music and Art'),
('30 minutes', 'Trumpet', '456789012', 'Waterford Academy of Music and Art'),
('30 minutes', 'Trumpet', '456789012', 'Waterford Academy of Music and Art'),
('30 minutes', 'Trumpet', '456789012', 'Waterford Academy of Music and Art'),
('30 minutes', 'Trumpet', '456789012', 'Waterford Academy of Music and Art'),
('30 minutes', 'Trumpet', '456789012', 'Waterford Academy of Music and Art'),
('30 minutes', 'Banjo', '567890123', 'Waterford Academy of Music and Art'),
('30 minutes', 'Banjo', '567890123', 'Waterford Academy of Music and Art'),
('30 minutes', 'Banjo', '567890123', 'Waterford Academy of Music and Art'),
('30 minutes', 'Banjo', '567890123', 'Waterford Academy of Music and Art'),
('30 minutes', 'Banjo', '567890123', 'Waterford Academy of Music and Art'),
('30 minutes', 'Viola', '678901234', 'Waterford Academy of Music and Art'),
('30 minutes', 'Viola', '678901234', 'Waterford Academy of Music and Art'),
('30 minutes', 'Viola', '678901234', 'Waterford Academy of Music and Art'),
('30 minutes', 'Viola', '678901234', 'Waterford Academy of Music and Art'),
('30 minutes', 'Viola', '678901234', 'Waterford Academy of Music and Art'), 
('30 minutes', 'Piano', '789012345', 'Waterford Academy of Music and Art'),
('30 minutes', 'Piano', '789012345', 'Waterford Academy of Music and Art'),
('30 minutes', 'Piano', '789012345', 'Waterford Academy of Music and Art'),
('30 minutes', 'Piano', '789012345', 'Waterford Academy of Music and Art'),
('30 minutes', 'Piano', '789012345', 'Waterford Academy of Music and Art'),
('30 minutes', 'Voice', '890123456', 'Waterford Academy of Music and Art'),
('30 minutes', 'Voice', '890123456', 'Waterford Academy of Music and Art'),
('30 minutes', 'Voice', '890123456', 'Waterford Academy of Music and Art'),
('30 minutes', 'Voice', '890123456', 'Waterford Academy of Music and Art'),
('30 minutes', 'Voice', '890123456', 'Waterford Academy of Music and Art'),
('30 minutes', 'Flute', '901234567', 'Waterford Academy of Music and Art'),
('30 minutes', 'Flute', '901234567', 'Waterford Academy of Music and Art'),
('30 minutes', 'Flute', '901234567', 'Waterford Academy of Music and Art'),
('30 minutes', 'Flute', '901234567', 'Waterford Academy of Music and Art'),
('30 minutes', 'Flute', '901234567', 'Waterford Academy of Music and Art'),
('30 minutes', 'Ukulele', '012345678', 'Waterford Academy of Music and Art'),
('30 minutes', 'Ukulele', '012345678', 'Waterford Academy of Music and Art'),
('30 minutes', 'Ukulele', '012345678', 'Waterford Academy of Music and Art'),
('30 minutes', 'Ukulele', '012345678', 'Waterford Academy of Music and Art'),
('30 minutes', 'Ukulele', '012345678', 'Waterford Academy of Music and Art');

INSERT INTO Attends(studentId, lessonCode, progress, lessonTime, lessonDay, lessonDate)
VALUES
('1', '1', 'Continues to improve', '16:00', 'Tuesday', '2023-9-5'),
('3', '2', 'More practice needed', '16:30', 'Tuesday', '2023-9-5'),
('10', '3', 'Good work', '17:00', 'Tuesday', '2023-9-5'),
('11', '4', 'Continues to improve', '17:30', 'Tuesday', '2023-9-5'),
('12', '5', 'Continues to improve', '18:00', 'Tuesday', '2023-9-5'),
('14', '6', 'Continues to improve', '16:00', 'Tuesday', '2023-9-5'),
('16', '7', 'More practice needed', '16:30', 'Tuesday', '2023-9-5'),
('18', '8', 'Continues to improve', '17:00', 'Tuesday', '2023-9-5'),
('19', '9', 'Continues to improve', '17:30', 'Tuesday', '2023-9-5'),
('20', '10', 'Continues to improve', '18:00', 'Tuesday', '2023-9-5'),
('21', '11', 'Continues to improve', '16:00', 'Tuesday', '2023-9-5'),
('22', '12', 'Continues to improve', '16:30', 'Tuesday', '2023-9-5'),
('24', '13', 'Good work', '17:00', 'Tuesday', '2023-9-5'),
('25', '14', 'Continues to improve', '17:30', 'Tuesday', '2023-9-5'),
('26', '15', 'Continues to improve', '18:00', 'Tuesday', '2023-9-5'),
('28', '16', 'Continues to improve', '16:00', 'Tuesday', '2023-9-5'),
('29', '17', 'Good work', '16:30', 'Tuesday', '2023-9-5'),
('31', '18', 'Good work', '17:00', 'Tuesday', '2023-9-5'),
('32', '19', 'Continues to improve', '17:30', 'Tuesday', '2023-9-5'),
('33', '20', 'Good work', '18:00', 'Tuesday', '2023-9-5'),
('34', '21', 'Continues to improve', '16:00', 'Tuesday', '2023-9-5'),
('36', '22', 'Excellent work', '16:30', 'Tuesday', '2023-9-5'),
('37', '23', 'Good work', '17:00', 'Tuesday', '2023-9-5'),
('38', '24', 'Continues to improve', '17:30', 'Tuesday', '2023-9-5'),
('42', '25', 'No practice this week', '18:00', 'Tuesday', '2023-9-5'),
('43', '26', 'Continues to improve', '16:00', 'Tuesday', '2023-9-5'),
('44', '27', 'Excellent work', '16:30', 'Tuesday', '2023-9-5'),
('45', '28', 'Good work', '17:00', 'Tuesday', '2023-9-5'),
('46', '29', 'Continues to improve', '17:30', 'Tuesday', '2023-9-5'),
('47', '30', 'sight reading needs work', '18:00', 'Tuesday', '2023-9-5'),
('48', '31', 'Continues to improve', '16:00', 'Tuesday', '2023-9-5'),
('51', '32', 'Ok work', '16:30', 'Tuesday', '2023-9-5'),
('52', '33', 'Good work', '17:00', 'Tuesday', '2023-9-5'),
('53', '34', 'Continues to improve', '17:30', 'Tuesday', '2023-9-5'),
('54', '35', 'sight reading has improved', '18:00', 'Tuesday', '2023-9-5'),
('55', '36', 'Continues to improve', '16:00', 'Tuesday', '2023-9-5'),
('56', '37', 'Ok work', '16:30', 'Tuesday', '2023-9-5'),
('58', '38', 'Good work', '17:00', 'Tuesday', '2023-9-5'),
('59', '39', 'Continues to improve', '17:30', 'Tuesday', '2023-9-5'),
('60', '40', 'Well done', '18:00', 'Tuesday', '2023-9-5'),
('61', '41', 'Continues to improve', '16:00', 'Tuesday', '2023-9-5'),
('62', '42', 'Great work', '16:30', 'Tuesday', '2023-9-5'),
('63', '43', 'Good work', '17:00', 'Tuesday', '2023-9-5'),
('64', '44', 'Continues to improve', '17:30', 'Tuesday', '2023-9-5'),
('65', '45', 'Excellent work this week', '18:00', 'Tuesday', '2023-9-5'),
('66', '46', 'Good work', '16:00', 'Tuesday', '2023-9-5'),
('67', '47', 'Great work', '16:30', 'Tuesday', '2023-9-5'),
('68', '48', 'Good work', '17:00', 'Tuesday', '2023-9-5'),
('69', '49', 'Good work', '17:30', 'Tuesday', '2023-9-5'),
('70', '50', 'Great work', '18:00', 'Tuesday', '2023-9-5');

INSERT INTO Exam(examType, instrument, grade, examYear, examDate, studentId)
VALUES
('RIAM', 'Piano', '5', '2024', NULL, '1'),
('RIAM', 'Piano', '3', '2023', '2023-11-07', '3'),
('RIAM', 'Piano', '1', '2023', '2023-11-07', '10'),
('RIAM', 'Piano', '1', '2023', '2023-11-07', '11'),
('RIAM', 'Piano', 'Preliminary', '2024', NULL, '12'),
('RIAM', 'Piano', '8', '2024', NULL, '14');

INSERT INTO groupLesson(groupSubject, length, groupSize, ageBracket, PPS, schoolName)
VALUES
('Piano', '1 hour', '5', '2nd Class', '789012345', 'Waterford Academy of Music and Art'),
('Ukulele', '1 hour', '5', '2nd Class', '012345678', 'Waterford Academy of Music and Art'),
('Guitar', '1 hour', '5', '3rd Class', '234567890', 'Waterford Academy of Music and Art'),
('Drama', '1 hour 30 minutes', '10', '5th year', '978654321', 'Waterford Academy of Music and Art'),
('Dance', '1 hour 30 minutes', '10', '5th year', '878654321', 'Waterford Academy of Music and Art'),
('Guitar', '1 hour', '4', '4th Class', '234567890', 'Waterford Academy of Music and Art'),
('Ukulele', '1 hour', '5', '4th Class', '012345678', 'Waterford Academy of Music and Art'),
('Drama', '1 hour 30 minutes', '9', '6th class', '978654321', 'Waterford Academy of Music and Art'),
('Dance', '1 hour 30 minutes', '9', '6th class', '878654321', 'Waterford Academy of Music and Art');

INSERT INTO Participates (studentId, groupCode, attendance, groupLessonTime, groupLessonDay, groupLessonDate)
VALUES
('91', '1', 'Present', '15:00', 'Wednesday', '2023-9-6'),
('92', '1', 'Present', '15:00', 'Wednesday', '2023-9-6'),
('93', '1', 'Present', '15:00', 'Wednesday', '2023-9-6'),
('94', '1', 'Present', '15:00', 'Wednesday', '2023-9-6'),
('95', '1', 'Absent', '15:00', 'Wednesday', '2023-9-6'),
('96', '2', 'Present', '15:00', 'Wednesday', '2023-9-6'),
('97', '2', 'Absent', '15:00', 'Wednesday', '2023-9-6'),
('98', '2', 'Present', '15:00', 'Wednesday', '2023-9-6'),
('99', '2', 'Present', '15:00', 'Wednesday', '2023-9-6'),
('100', '2', 'Absent', '15:00', 'Wednesday', '2023-9-6'),
('4', '3', 'Present', '16:00', 'Wednesday', '2023-9-6'),
('5', '3', 'Absent', '16:00', 'Wednesday', '2023-9-6'),
('6', '3', 'Absent', '16:00', 'Wednesday', '2023-9-6'),
('15', '3', 'Present', '16:00', 'Wednesday', '2023-9-6'),
('17', '3', 'Absent', '16:00', 'Wednesday', '2023-9-6'),
('13', '4', 'Present', '17:00', 'Wednesday', '2023-9-6'),
('23', '4', 'Absent', '17:00', 'Wednesday', '2023-9-6'),
('27', '4', 'Present', '17:00', 'Wednesday', '2023-9-6'),
('30', '4', 'Present', '17:00', 'Wednesday', '2023-9-6'),
('35', '4', 'Absent', '17:00', 'Wednesday', '2023-9-6'),
('19', '4', 'Present', '17:00', 'Wednesday', '2023-9-6'),
('40', '4', 'Absent', '17:00', 'Wednesday', '2023-9-6'),
('41', '4', 'Present', '17:00', 'Wednesday', '2023-9-6'),
('49', '4', 'Present', '17:00', 'Wednesday', '2023-9-6'),
('57', '4', 'Absent', '17:00', 'Wednesday', '2023-9-6'),
('13', '5', 'Present', '17:00', 'Wednesday', '2023-9-6'),
('23', '5', 'Absent', '17:00', 'Wednesday', '2023-9-6'),
('27', '5', 'Present', '17:00', 'Wednesday', '2023-9-6'),
('30', '5', 'Present', '17:00', 'Wednesday', '2023-9-6'),
('35', '5', 'Absent', '17:00', 'Wednesday', '2023-9-6'),
('19', '5', 'Present', '17:00', 'Wednesday', '2023-9-6'),
('40', '5', 'Absent', '17:00', 'Wednesday', '2023-9-6'),
('41', '5', 'Present', '17:00', 'Wednesday', '2023-9-6'),
('49', '5', 'Present', '17:00', 'Wednesday', '2023-9-6'),
('57', '5', 'Absent', '17:00', 'Wednesday', '2023-9-6'),
('81', '6', 'Present', '15:00', 'Thursday', '2023-9-7'),
('82', '6', 'Present', '15:00', 'Thursday', '2023-9-7'),
('83', '6', 'Present', '15:00', 'Thursday', '2023-9-7'),
('84', '6', 'Present', '15:00', 'Thursday', '2023-9-7'),
('86', '7', 'Present', '15:00', 'Thursday', '2023-9-7'),
('87', '7', 'Present', '15:00', 'Thursday', '2023-9-7'),
('88', '7', 'Present', '15:00', 'Thursday', '2023-9-7'),
('89', '7', 'Present', '15:00', 'Thursday', '2023-9-7'),
('90', '7', 'Absent', '15:00', 'Thursday', '2023-9-7'),
('71', '8', 'Present', '16:00', 'Thursday', '2023-9-7'),
('72', '8', 'Absent', '16:00', 'Thursday', '2023-9-7'),
('73', '8', 'Present', '16:00', 'Thursday', '2023-9-7'),
('74', '8', 'Present', '16:00', 'Thursday', '2023-9-7'),
('75', '8', 'Present', '16:00', 'Thursday', '2023-9-7'),
('76', '8', 'Absent', '16:00', 'Thursday', '2023-9-7'),
('77', '8', 'Present', '16:00', 'Thursday', '2023-9-7'),
('78', '8', 'Present', '16:00', 'Thursday', '2023-9-7'),
('79', '8', 'Present', '16:00', 'Thursday', '2023-9-7'),
('80', '8', 'Present', '16:00', 'Thursday', '2023-9-7'),
('71', '9', 'Present', '16:00', 'Thursday', '2023-9-7'),
('72', '9', 'Absent', '16:00', 'Thursday', '2023-9-7'),
('73', '9', 'Present', '16:00', 'Thursday', '2023-9-7'),
('74', '9', 'Present', '16:00', 'Thursday', '2023-9-7'),
('75', '9', 'Present', '16:00', 'Thursday', '2023-9-7'),
('76', '9', 'Absent', '16:00', 'Thursday', '2023-9-7'),
('77', '9', 'Present', '16:00', 'Thursday', '2023-9-7'),
('78', '9', 'Present', '16:00', 'Thursday', '2023-9-7'),
('79', '9', 'Present', '16:00', 'Thursday', '2023-9-7'),
('80', '9', 'Present', '16:00', 'Thursday', '2023-9-7');

-- -----------------------------------------------------
-- Indexes
-- -----------------------------------------------------

CREATE INDEX studentNameIndex ON Student(firstName, lastName);

CREATE INDEX parentNameIndex ON Parent(firstName, lastName);

CREATE INDEX instrumentIndex ON Lesson(instrument);

CREATE INDEX subjectIndex ON groupLesson(groupSubject);

DELIMITER //
CREATE FUNCTION checkAgeBracket(DOB Date) RETURNS VARCHAR(50) DETERMINISTIC
BEGIN
	DECLARE ageBracket VARCHAR(50);
    CASE
        WHEN DATEDIFF(CURDATE(), DOB) / 365 BETWEEN 4 AND 5 THEN SET ageBracket = 'Junior Infants';
        WHEN DATEDIFF(CURDATE(), DOB) / 365 BETWEEN 5 AND 6 THEN SET ageBracket = 'Senior Infants';
        WHEN DATEDIFF(CURDATE(), DOB) / 365 BETWEEN 6 AND 7 THEN SET ageBracket = '1st Class';
        WHEN DATEDIFF(CURDATE(), DOB) / 365 BETWEEN 7 AND 8 THEN SET ageBracket = '2nd Class';
        WHEN DATEDIFF(CURDATE(), DOB) / 365 BETWEEN 8 AND 9 THEN SET ageBracket = '3rd Class';
        WHEN DATEDIFF(CURDATE(), DOB) / 365 BETWEEN 9 AND 10 THEN SET ageBracket = '4th Class';
        WHEN DATEDIFF(CURDATE(), DOB) / 365 BETWEEN 10 AND 11 THEN SET ageBracket = '5th Class';
        WHEN DATEDIFF(CURDATE(), DOB) / 365 BETWEEN 11 AND 12 THEN SET ageBracket = '6th Class';
        WHEN DATEDIFF(CURDATE(), DOB) / 365 BETWEEN 12 AND 13 THEN SET ageBracket = '1st Year';
        WHEN DATEDIFF(CURDATE(), DOB) / 365 BETWEEN 13 AND 14 THEN SET ageBracket = '2nd Year';
        WHEN DATEDIFF(CURDATE(), DOB) / 365 BETWEEN 14 AND 15 THEN SET ageBracket = '3rd Year';
        WHEN DATEDIFF(CURDATE(), DOB) / 365 BETWEEN 15 AND 17 THEN SET ageBracket = 'TY/5th Year';
        WHEN DATEDIFF(CURDATE(), DOB) / 365 BETWEEN 17 AND 18 THEN SET ageBracket = '6th Year';
        ELSE SET ageBracket = 'Adult';
        END CASE;
        RETURN ageBracket;
	END //
DELIMITER ;

-- -----------------------------------------------------
-- Views
-- -----------------------------------------------------

-- Vew to display all students on record whether attending classes or not
CREATE VIEW allStudentsOnRecord AS
SELECT 
    student.studentId AS 'Student ID',
    GROUP_CONCAT(DISTINCT CONCAT(student.firstName, ' ', student.lastName)
        SEPARATOR ', ') AS 'Name',
    student.DOB AS 'Date of Birth',
    checkAgeBracket(DOB) AS 'Age Bracket',
    student.street AS 'Street',
    student.town AS 'Town',
    student.county AS 'County',
    GROUP_CONCAT(CONCAT(Parent.firstName, ' ', Parent.lastName)
        SEPARATOR ' & ') AS 'Parents',
    GROUP_CONCAT(CONCAT(Parent.phoneNumber)
        SEPARATOR ' | ') AS 'Parent Phone Numbers',
    GROUP_CONCAT(CONCAT(Parent.email)
        SEPARATOR ' | ') AS 'Parent Emails'
FROM
    Student
        JOIN
    Parent ON Student.studentId = Parent.studentId
GROUP BY student.studentId , student.firstName , student.lastName , student.DOB , student.street , student.town , student.county
ORDER BY GROUP_CONCAT(DISTINCT CONCAT(student.firstName, ' ', student.lastName) SEPARATOR ', ');


-- View to list all lessons
CREATE VIEW allLessons AS
SELECT 
    GROUP_CONCAT(DISTINCT CONCAT(student.firstName, ' ', student.lastName)
        SEPARATOR ', ') AS 'Student Name',
    Attends.lessonTime AS 'Time',
    Attends.lessonDay AS 'Day',
    Lesson.length AS 'Length',
    Lesson.instrument AS 'Subject',
    GROUP_CONCAT(DISTINCT CONCAT(Teacher.firstName, ' ', Teacher.lastName)
        SEPARATOR ', ') AS 'Teacher Name',
    Attends.progress
FROM
    Student
        JOIN
    Attends ON Student.studentId = Attends.studentId
        JOIN
    Lesson ON Lesson.lessonCode = Attends.lessonCode
        JOIN
    Teacher ON Teacher.PPS = Lesson.PPS
GROUP BY student.studentId , student.firstName , Attends.lessonTime , Attends.lessonDay , Lesson.Length , Lesson.instrument , Attends.progress;


-- List all students preparing for exams and their respective teachers and exam details
CREATE VIEW examStudents AS
SELECT 
    GROUP_CONCAT(DISTINCT CONCAT(student.firstName, ' ', student.lastName)
        SEPARATOR ', ') AS 'Student Name',
    Exam.examType AS 'Exam Type',
    Exam.examYear AS 'Exam Year',
    Exam.grade AS 'Grade',
    Exam.instrument AS 'Subject',
    COALESCE(Exam.examDate, '') AS 'Date',
    GROUP_CONCAT(DISTINCT CONCAT(Teacher.firstName, ' ', Teacher.lastName)
        SEPARATOR ', ') AS 'Teacher Name'
FROM
    Student
        JOIN
    Attends ON Student.studentId = Attends.studentId
        JOIN
    Lesson ON Lesson.lessonCode = Attends.lessonCode
        JOIN
    Exam ON Exam.studentId = Student.studentId
        JOIN
    Teacher ON Teacher.PPS = Lesson.PPS
GROUP BY student.studentId , student.firstName , Exam.examType , Exam.examYear , Exam.grade , Exam.instrument , Exam.examDate;


-- List all teachers and their respective contact details
CREATE VIEW allTeachers AS
SELECT 
    GROUP_CONCAT(DISTINCT CONCAT(Teacher.firstName, ' ', Teacher.lastName)
        SEPARATOR ', ') AS 'Name',
    Teacher.street AS 'Street',
    Teacher.town AS 'Town',
    Teacher.county AS 'County',
    GROUP_CONCAT(DISTINCT CONCAT(TeacherPhones.phoneNumber)
        SEPARATOR ' | ') AS 'Teacher Phone Numbers',
    GROUP_CONCAT(DISTINCT CONCAT(TeacherEmails.email)
        SEPARATOR ' | ') AS 'Teacher Emails'
FROM
    Teacher
        JOIN
    TeacherPhones ON Teacher.PPS = TeacherPhones.PPS
        JOIN
    TeacherEmails ON Teacher.PPS = TeacherEmails.PPS
GROUP BY Teacher.firstName , Teacher.lastName , Teacher.street , Teacher.town , Teacher.county;


-- List all group lessons
CREATE VIEW allGroupLessons AS
SELECT 
    GroupLesson.groupSubject AS 'Subject',
    Participates.groupLessonDay AS 'Day',
    Participates.groupLessonTime AS 'Time',
    GroupLesson.ageBracket AS 'Age Bracket',
    GROUP_CONCAT(DISTINCT CONCAT(student.firstName, ' ', student.lastName)
        SEPARATOR ', ') AS 'Student Name',
	Participates.attendance AS 'Recent Attendance',
    GroupLesson.length AS 'Length',
    GROUP_CONCAT(DISTINCT CONCAT(Teacher.firstName, ' ', Teacher.lastName)
        SEPARATOR ', ') AS 'Teacher Name'
FROM
    Student
        JOIN
    Participates ON Student.studentId = Participates.studentId
        JOIN
    GroupLesson ON GroupLesson.GroupCode = Participates.GroupCode
        JOIN
    Teacher ON Teacher.PPS = groupLesson.PPS
GROUP BY groupLesson.groupSubject , student.studentId , student.firstName , Participates.groupLessonTime , Participates.groupLessonDay , groupLesson.Length, Participates.attendance, groupLesson.ageBracket;


-- List all students currently assigned to groups or lessons
CREATE VIEW AttendingStudents AS
SELECT 
    student.studentId AS 'Student ID',
    CONCAT(student.firstName, ' ', student.lastName) AS 'Name',
    checkAgeBracket(DOB) AS 'Age Bracket',
    student.street AS 'Street',
    student.town AS 'Town',
    student.county AS 'County',
    GROUP_CONCAT(DISTINCT CONCAT(Parent.firstName, ' ', Parent.lastName)
        SEPARATOR ' & ') AS 'Parents',
    GROUP_CONCAT(DISTINCT CONCAT(Parent.phoneNumber)
        SEPARATOR ' | ') AS 'Parent Phone Numbers',
    GROUP_CONCAT(DISTINCT CONCAT(Parent.email)
        SEPARATOR ' | ') AS 'Parent Emails',
    GROUP_CONCAT(DISTINCT Attends.lessonCode
        SEPARATOR ', ') AS 'Lesson Code',
    GROUP_CONCAT(DISTINCT Participates.groupCode
        SEPARATOR ', ') AS 'Group Code'
FROM
    Student
        JOIN
    Parent ON Student.studentId = Parent.studentId
        LEFT JOIN
    Attends ON Attends.studentId = Student.studentId
        LEFT JOIN
    Participates ON Participates.studentId = Student.studentId
WHERE
    Attends.lessonCode IS NOT NULL
        OR Participates.groupCode IS NOT NULL
GROUP BY student.studentId , student.firstName , student.lastName , student.DOB , student.street , student.town , student.county;


-- List all students currently awaiting assignment to a lesson or group
CREATE VIEW waitingList AS
SELECT 
    student.studentId AS 'Student ID',
    CONCAT(student.firstName, ' ', student.lastName) AS 'Name',
    checkAgeBracket(DOB) AS 'Age Bracket',
    student.street AS 'Street',
    student.town AS 'Town',
    student.county AS 'County',
    GROUP_CONCAT(DISTINCT CONCAT(Parent.firstName, ' ', Parent.lastName)
        SEPARATOR ' & ') AS 'Parents',
    GROUP_CONCAT(DISTINCT CONCAT(Parent.phoneNumber)
        SEPARATOR ' | ') AS 'Parent Phone Numbers',
    GROUP_CONCAT(DISTINCT CONCAT(Parent.email)
        SEPARATOR ' | ') AS 'Parent Emails'
FROM
    Student
        JOIN
    Parent ON Student.studentId = Parent.studentId
WHERE
    NOT EXISTS( SELECT 
            1
        FROM
            Attends
        WHERE
            Attends.studentId = Student.studentId)
        AND NOT EXISTS( SELECT 
            1
        FROM
            Participates
        WHERE
            Participates.studentId = Student.studentId)
GROUP BY student.studentId , student.firstName , student.lastName , student.DOB , student.street , student.town , student.county;

-- -----------------------------------------------------
-- User creation
-- -----------------------------------------------------

DROP USER IF EXISTS 'WamaAdmin'@'%';
DROP USER IF EXISTS 'WamaTeacher'@'%';
    
CREATE USER 'WamaAdmin' IDENTIFIED BY 'admin';
CREATE USER 'WamaTeacher' IDENTIFIED BY 'teacher';

GRANT ALL ON WAMA.* TO 'WamaAdmin' WITH GRANT OPTION;

GRANT UPDATE (progress, lessonDate) ON WAMA.Attends TO 'WamaTeacher';
GRANT UPDATE (attendance, groupLessonDate) ON WAMA.Participates TO 'WamaTeacher';
GRANT SELECT ON WAMA.allGroupLessons TO 'WamaTeacher';
GRANT SELECT ON WAMA.allLessons TO 'WamaTeacher';
GRANT SELECT ON WAMA.examStudents TO 'WamaTeacher';

COMMIT;








