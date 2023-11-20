USE WAMA;

SELECT * FROM allTeachers WHERE Name = 'Robyn Walsh';

SELECT * FROM allGroupLessons WHERE `Age Bracket` = '5th year';

SELECT * FROM Teacher GROUP BY firstName;

SELECT * FROM attends;

SELECT * FROM lessonProgress;

UPDATE attends set progress = 'Found bar 17 tricky but good work regardless' WHERE studentId = '1' AND lessonCode = '1';

UPDATE participates set attendance = 'arrived late' WHERE studentId = '4' AND groupCode = '3';

SELECT * FROM groupAttendance;

-- duplicate trigger test
INSERT INTO Teacher (PPS, firstName, lastName, street, town, county, zipCode, hourlyRate, managerPPS)
VALUES
('234567890', 'Aoife', 'O\'Sullivan', '2 Sea View', 'Dungarvan', 'Waterford', 'DUN5678', '25.00', '123456789');

-- where in
SELECT *
FROM allLessons
WHERE Instrument IN ('piano', 'guitar');

-- where like
SELECT * FROM Student WHERE DOB LIKE '2002-%-%';

-- where between
SELECT * FROM Student WHERE DOB BETWEEN '2000-01-01' AND '2005-01-01';

-- aggregate function + date function
SELECT ROUND(AVG(DATEDIFF(CURDATE(), DOB) / 365.25)) AS averageAgeInYears
FROM Student;

-- group by having
SELECT COUNT(studentId) AS 'Group Size', groupCode AS 'Group Code', groupLessonDay AS 'Lesson Day'
FROM Participates
GROUP BY groupCode, groupLessonDay
HAVING COUNT(studentId) < 10;

-- outer joins, multi-table joins and sub-queries can be found in views



