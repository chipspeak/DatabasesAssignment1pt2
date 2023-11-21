USE WAMA;

-- search for a specific teacher via view
SELECT * FROM allTeachers WHERE Name = 'Robyn Walsh';

-- select all group lessons using the Age Bracket column as a filter
SELECT * FROM allGroupLessons WHERE `Age Bracket` = '5th year';

-- select all from Teacher table and group by firstName
SELECT * FROM Teacher GROUP BY firstName;

-- select all from attends
SELECT * FROM attends;

-- updates progress column in Attends table using studentId and lessonCode foreign keys
UPDATE attends set progress = 'Found bar 17 tricky but good work regardless' WHERE studentId = '1' AND lessonCode = '1';

-- select all from lessonProgress table (this table is used via a trigger to record previous lesson progress after update)
SELECT * FROM lessonProgress;

-- select all from groupAttendance table(again, this table is used via a trigger where previous values are added to this table as a record)
SELECT * FROM groupAttendance;

-- similar to lessonProgress, this will update the attendance column of the Participates table using studentId and groupCode foreign keys
UPDATE participates set attendance = 'arrived late' WHERE studentId = '4' AND groupCode = '3';

-- insert to test the trigger preventing duplicates based on matching names and address but different PPS
INSERT INTO Teacher (PPS, firstName, lastName, street, town, county, zipCode, hourlyRate, managerPPS)
VALUES
('234567891', 'Aoife', 'O\'Sullivan', '2 Sea View', 'Dungarvan', 'Waterford', 'DUN5678', '25.00', '123456789');

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



