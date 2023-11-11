USE WAMA;

DELETE FROM TeacherPhones;

DELETE FROM Teacher;

-- Delete all rows from the Parent table
DELETE FROM Parent;

-- Delete all rows from the Student table
DELETE FROM Student;

ALTER TABLE Student AUTO_INCREMENT = 1;


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
('Olivia', 'Kelly', '2004-08-12', '303 Birch St', 'Waterford', 'Waterford', 'N7L 6K9'),
('Noah', 'Murphy', '2005-02-17', '404 Cedar St', 'Waterford', 'Waterford', 'K4P 9Q8'),
('Sophia', 'Baker', '2003-07-09', '505 Elm St', 'Waterford', 'Waterford', 'T8H 2E4'),
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
('Madison', 'Lloyd', '2001-05-27', '101 Pine St', 'Waterford', 'Waterford', 'K3R 5T8');

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
('Mia', 'Lloyd', '0945001223', 'mia.lloyd890@example.com', '70');

INSERT INTO Teacher (PPS, firstName, lastName, street, town, county, zipCode, hourlyRate, managerPPS)
VALUES
('123456789', 'Seán', 'Murphy', '1 River Road', 'Waterford', 'Waterford', 'WAT1234', '25.50', NULL),
('234567890', 'Aoife', 'O\'Sullivan', '2 Sea View', 'Dungarvan', 'Waterford', 'DUN5678', '30.00', '123456789'),
('345678901', 'Ciarán', 'Fitzgerald', '3 Lakeside', 'Tramore', 'Waterford', 'TRA9012', '22.75', '123456789'),
('456789012', 'Niamh', 'Walsh', '4 Mountain View', 'Waterford', 'Waterford', 'WAT3456', '28.00', '123456789'),
('567890123', 'Eoin', 'Ryan', '5 Coastal Drive', 'Dungarvan', 'Waterford', 'DUN7890', '26.50', '123456789'),
('678901234', 'Síle', 'Flynn', '6 Harbour Street', 'Tramore', 'Waterford', 'TRA2345', '24.25', '123456789'),
('789012345', 'Padraig', 'O\'Connor', '7 Meadow Lane', 'Waterford', 'Waterford', 'WAT6789', '31.75', '123456789'),
('890123456', 'Aisling', 'O\'Brien', '8 Riverside', 'Dungarvan', 'Waterford', 'DUN0123', '29.50', '123456789'),
('901234567', 'Darragh', 'Daly', '9 Greenfield', 'Tramore', 'Waterford', 'TRA4567', '27.00', '123456789'),
('012345678', 'Gráinne', 'Kavanagh', '10 Bluebell Lane', 'Waterford', 'Waterford', 'WAT8901', '23.75', '123456789'),
('123456780', 'Colm', 'O\'Neill', '11 Willow Walk', 'Dungarvan', 'Waterford', 'DUN2345', '32.00', '123456789'),
('234567891', 'Muireann', 'McCarthy', '12 Ivy Court', 'Tramore', 'Waterford', 'TRA6789', '26.50', '123456789'),
('345678902', 'Tadhg', 'O\'Mahony', '13 Pine Grove', 'Waterford', 'Waterford', 'WAT3456', '28.75', '123456789'),
('456789013', 'Fiona', 'Kennedy', '14 Oakwood', 'Dungarvan', 'Waterford', 'DUN7890', '25.00', '123456789'),
('567890124', 'Conor', 'Byrne', '15 Cedar Lane', 'Tramore', 'Waterford', 'TRA0123', '30.50', '123456789'),
('678901235', 'Siobhán', 'Nolan', '16 Rose Avenue', 'Waterford', 'Waterford', 'WAT4567', '29.25', '123456789'),
('789012346', 'Ruairí', 'Hogan', '17 Maple Street', 'Dungarvan', 'Waterford', 'DUN8901', '27.00', '123456789'),
('890123457', 'Ailbhe', 'Quinn', '18 Holly Close', 'Tramore', 'Waterford', 'TRA2345', '24.50', '123456789'),
('901234568', 'Liam', 'Reilly', '19 Sunnyside', 'Waterford', 'Waterford', 'WAT6789', '31.00', '123456789'),
('012345679', 'Orla', 'Power', '20 Fairview', 'Dungarvan', 'Waterford', 'DUN0123', '28.75', '123456789'),
('123456781', 'Pádraig', 'Foley', '21 Mill Lane', 'Tramore', 'Waterford', 'TRA4567', '26.25', '123456789'),
('234567892', 'Aoibhinn', 'Cunningham', '22 Willowbank', 'Waterford', 'Waterford', 'WAT8901', '33.00', '123456789'),
('345678903', 'Diarmuid', 'Hughes', '23 Oak Lane', 'Dungarvan', 'Waterford', 'DUN2345', '28.50', '123456789'),
('456789014', 'Clíodhna', 'Doyle', '24 Riverbank', 'Tramore', 'Waterford', 'TRA6789', '25.75', '123456789'),
('567890125', 'Gearóid', 'Kearney', '25 Harbour View', 'Waterford', 'Waterford', 'WAT0123', '30.25', '123456789'),
('678901236', 'Niamh', 'Lynch', '26 Meadowview', 'Dungarvan', 'Waterford', 'DUN4567', '29.00', '123456789'),
('789012347', 'Cormac', 'Farrell', '27 Green Valley', 'Tramore', 'Waterford', 'TRA8901', '27.50', '123456789'),
('890123458', 'Róisín', 'Cahill', '28 Seafield', 'Waterford', 'Waterford', 'WAT2345', '34.00', '123456789');

INSERT INTO TeacherPhones (phoneNumber, PPS)
VALUES
('1234567890', '123456789'),
('2345678901', '234567890'),
('3456789012', '345678901'),
('4567890123', '456789012'),
('5678901234', '567890123'),
('6789012345', '678901234'),
('7890123456', '789012345'),
('8901234567', '890123456'),
('9012345678', '901234567'),
('0123456789', '012345678'),
('1234567801', '123456780'),
('2345678912', '234567891'),
('3456789023', '345678902'),
('4567890134', '456789013'),
('5678901245', '567890124'),
('6789012356', '678901235'),
('7890123467', '789012346'),
('8901234578', '890123457'),
('9012345689', '901234568'),
('0123456790', '012345679'),
('1234567812', '123456781'),
('2345678923', '234567892'),
('3456789034', '345678903'),
('4567890145', '456789014'),
('5678901256', '567890125'),
('6789012367', '678901236'),
('7890123478', '789012347'),
('8901234589', '890123458');

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
('colm@wama.com', '123456780'),
('colm@example.com', '123456780'),
('muireann@wama.com', '234567891'),
('muireann@example.com', '234567891'),
('tadhg@wama.com', '345678902'),
('tadhg@example.com', '345678902'),
('fiona@wama.com', '456789013'),
('fiona@example.com', '456789013'),
('conor@wama.com', '567890124'),
('conor@example.com', '567890124'),
('siobhan@wama.com', '678901235'),
('siobhan@example.com', '678901235'),
('ruairi@wama.com', '789012346'),
('ruairi@example.com', '789012346'),
('ailbhe@wama.com', '890123457'),
('ailbhe@example.com', '890123457'),
('liam@wama.com', '901234568'),
('liam@example.com', '901234568'),
('orla@wama.com', '012345679'),
('orla@example.com', '012345679'),
('padraig2@wama.com', '123456781'),
('padraig2@example.com', '123456781'),
('aoibhinn@wama.com', '234567892'),
('aoibhinn@example.com', '234567892'),
('diarmuid@wama.com', '345678903'),
('diarmuid@example.com', '345678903'),
('cliodhna@wama.com', '456789014'),
('cliodhna@example.com', '456789014'),
('gearoid@wama.com', '567890125'),
('gearoid@example.com', '567890125'),
('niamh2@wama.com', '678901236'),
('niamh2@example.com', '678901236'),
('cormac@wama.com', '789012347'),
('cormac@example.com', '789012347'),
('roisin@wama.com', '890123458'),
('roisin@example.com', '890123458');