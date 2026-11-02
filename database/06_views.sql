-- View 1: Student Information View --
USE FinalExamination;
GO

CREATE VIEW vw_StudentInformation
AS
SELECT
    S.StudentID,
    S.FirstName,
    S.MiddleName,
    S.LastName,
    S.Sex,
    S.DateOfBirth,
    D.DepartmentName
FROM Student AS S
INNER JOIN Department AS D
    ON S.DepartmentID = D.DepartmentID;
GO
-- To see --
SELECT * FROM vw_StudentInformation;
GO

-- View 2: Student Examination Results View --
CREATE VIEW vw_StudentExamResults
AS
SELECT
    S.StudentID,
    S.FirstName,
    S.LastName,
    E.ExamCode,
    E.ExamName,
    SE.Mark,
    SE.Status AS ExamStatus,
    SE.ExamDate
FROM StudentExam AS SE
INNER JOIN Student AS S
    ON SE.StudentID = S.StudentID
INNER JOIN Exam AS E
    ON SE.ExamCode = E.ExamCode;
GO
-- To see --
SELECT * FROM vw_StudentExamResults;
GO

-- View 3: Teacher Examination Review View --
CREATE VIEW vw_TeacherExamReview
AS
SELECT
    T.TeacherID,
    T.FirstName,
    T.LastName,
    E.ExamCode,
    E.ExamName,
    ETV.Audited,
    ETV.Status AS DifficultyLevel
FROM ExamTeacherView AS ETV
INNER JOIN Teacher AS T
    ON ETV.TeacherID = T.TeacherID
INNER JOIN Exam AS E
    ON ETV.ExamCode = E.ExamCode;
GO
-- To See --
SELECT * FROM vw_TeacherExamReview;
GO

-- View 4: Exam Room Information View --
CREATE VIEW vw_ExamRoomInformation
AS
SELECT
    E.ExamCode,
    E.ExamName,
    ER.RoomID,
    ER.BuildingNumber,
    ER.RoomNumber,
    D.DepartmentName
FROM ExamRoomAssignment AS ERA
INNER JOIN Exam AS E
    ON ERA.ExamCode = E.ExamCode
INNER JOIN ExamRoom AS ER
    ON ERA.RoomID = ER.RoomID
INNER JOIN Department AS D
    ON ER.DepartmentID = D.DepartmentID;
GO
-- To See --
SELECT * FROM vw_ExamRoomInformation;
GO

-- View 5: Department Student Summary View --
CREATE VIEW vw_DepartmentStudentSummary
AS
SELECT
    D.DepartmentID,
    D.DepartmentName,
    COUNT(S.StudentID) AS TotalStudents
FROM Department AS D
LEFT JOIN Student AS S
    ON D.DepartmentID = S.DepartmentID
GROUP BY
    D.DepartmentID,
    D.DepartmentName;
GO
-- To See --
SELECT * FROM vw_DepartmentStudentSummary;
GO

-- To check all views --
SELECT
    TABLE_NAME
FROM INFORMATION_SCHEMA.VIEWS
ORDER BY TABLE_NAME;
GO