-- 1. Basic SELECT Queries--
-- Query 1: Display All Students --
USE FinalExamination;
GO

-- Display all students
SELECT *
FROM Student;
GO

-- Query 2: Display Specific Columns --
-- Display student names and department IDs --
SELECT
    StudentID,
    FirstName,
    MiddleName,
    LastName,
    DepartmentID
FROM Student;
GO

-- Query 3: WHERE Condition --
-- Find students from Software Engineering Department
SELECT *
FROM Student
WHERE DepartmentID = 1;
GO

-- Query 4: ORDER BY --
-- Display students ordered by their first names
SELECT *
FROM Student
ORDER BY FirstName ASC;
GO

-- 2. JOIN Queries --
-- Query 5: Students with Department Names --
-- Display students with their department names
SELECT
    S.StudentID,
    S.FirstName,
    S.LastName,
    D.DepartmentName
FROM Student AS S
INNER JOIN Department AS D
    ON S.DepartmentID = D.DepartmentID;
GO

-- Query 6: Teachers with Department Names --
-- Display teachers and their departments
SELECT
    T.TeacherID,
    T.FirstName,
    T.LastName,
    T.Salary,
    D.DepartmentName
FROM Teacher AS T
INNER JOIN Department AS D
    ON T.DepartmentID = D.DepartmentID;
GO

-- Query 7: Exam Room Assignments --
-- Display exams and their assigned rooms
SELECT
    E.ExamCode,
    E.ExamName,
    ER.BuildingNumber,
    ER.RoomNumber
FROM Exam AS E
INNER JOIN ExamRoomAssignment AS ERA
    ON E.ExamCode = ERA.ExamCode
INNER JOIN ExamRoom AS ER
    ON ERA.RoomID = ER.RoomID;
GO

-- Query 8: Student Examination Results --
-- Display student examination results
SELECT
    S.StudentID,
    S.FirstName,
    S.LastName,
    E.ExamName,
    SE.Mark,
    SE.Status,
    SE.ExamDate
FROM StudentExam AS SE
INNER JOIN Student AS S
    ON SE.StudentID = S.StudentID
INNER JOIN Exam AS E
    ON SE.ExamCode = E.ExamCode;
GO

-- 3. Aggregate Functions --
-- Query 9: Count Students --
-- Count total students
SELECT COUNT(*) AS TotalStudents
FROM Student;
GO

-- Query 10: Average Exam Marks --
-- Calculate average mark for each exam
SELECT
    E.ExamCode,
    E.ExamName,
    AVG(SE.Mark) AS AverageMark
FROM Exam AS E
INNER JOIN StudentExam AS SE
    ON E.ExamCode = SE.ExamCode
GROUP BY E.ExamCode, E.ExamName;
GO

-- Query 11: Count Students per Exam --
-- Count students registered for each exam
SELECT
    E.ExamCode,
    E.ExamName,
    COUNT(SE.StudentID) AS TotalStudents
FROM Exam AS E
LEFT JOIN StudentExam AS SE
    ON E.ExamCode = SE.ExamCode
GROUP BY E.ExamCode, E.ExamName;
GO

-- 4. Advanced Filtering --
-- Query 12: Students Who Scored Above 80 --
-- Find students who scored above 80
SELECT
    S.StudentID,
    S.FirstName,
    S.LastName,
    E.ExamName,
    SE.Mark
FROM StudentExam AS SE
INNER JOIN Student AS S
    ON SE.StudentID = S.StudentID
INNER JOIN Exam AS E
    ON SE.ExamCode = E.ExamCode
WHERE SE.Mark > 80;
GO

-- Query 13: Exams Reviewed by Teachers --
-- Display exams reviewed by teachers
SELECT
    T.TeacherID,
    T.FirstName,
    T.LastName,
    E.ExamName,
    ETV.Audited,
    ETV.Status AS DifficultyLevel
FROM ExamTeacherView AS ETV
INNER JOIN Teacher AS T
    ON ETV.TeacherID = T.TeacherID
INNER JOIN Exam AS E
    ON ETV.ExamCode = E.ExamCode;
GO

-- Query 14: Departments with Student Counts --
-- Count students in each department
SELECT
    D.DepartmentID,
    D.DepartmentName,
    COUNT(S.StudentID) AS TotalStudents
FROM Department AS D
LEFT JOIN Student AS S
    ON D.DepartmentID = S.DepartmentID
GROUP BY D.DepartmentID, D.DepartmentName;
GO