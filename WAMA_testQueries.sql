USE WAMA;

SELECT * FROM waitingList;

SELECT * FROM allTeachers WHERE Name = 'Robyn Walsh';

SELECT * FROM allGroupLessons WHERE `Age Bracket` = '5th year';

SELECT * FROM allLessons;

SELECT * FROM attends;

SELECT * FROM lessonProgress;

UPDATE attends set progress = 'Found bar 17 tricky but good work regardless' WHERE studentId = '1' AND lessonCode = '1';

UPDATE participates set attendance = 'arrived late' WHERE studentId = '4' AND groupCode = '3';

SELECT * FROM groupAttendance;



