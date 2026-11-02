-- Procedure 1: Get All Students --
USE FinalExamination;
GO

CREATE PROCEDURE sp_GetAllStudents
AS
BEGIN
    SELECT
        S.StudentID,
        S.FirstName,
        S.MiddleName,
        S.LastName,
        S.Sex,
        D.DepartmentName
    FROM Student AS S
    INNER JOIN Department AS D
        ON S.DepartmentID = D.DepartmentID;
END;
GO
-- Execute: --
EXEC sp_GetAllStudents;
GO

-- Procedure 2: Get Student by ID --
CREATE PROCEDURE sp_GetStudentByID
    @StudentID INT
AS
BEGIN
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
        ON S.DepartmentID = D.DepartmentID
    WHERE S.StudentID = @StudentID;
END;
GO
-- Execute: --
EXEC sp_GetStudentByID @StudentID = 1001;
GO

-- Procedure 3: Get Student Examination Results --
CREATE PROCEDURE sp_GetStudentExamResults
    @StudentID INT
AS
BEGIN
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
        ON SE.ExamCode = E.ExamCode
    WHERE S.StudentID = @StudentID;
END;
GO
-- Execute: --
EXEC sp_GetStudentExamResults @StudentID = 1001;
GO

-- Procedure 4: Get Exams by Department --
CREATE PROCEDURE sp_GetExamsByDepartment
    @DepartmentID INT
AS
BEGIN
    SELECT DISTINCT
        D.DepartmentName,
        E.ExamCode,
        E.ExamName
    FROM Exam AS E
    INNER JOIN ExamRoomAssignment AS ERA
        ON E.ExamCode = ERA.ExamCode
    INNER JOIN ExamRoom AS ER
        ON ERA.RoomID = ER.RoomID
    INNER JOIN Department AS D
        ON ER.DepartmentID = D.DepartmentID
    WHERE D.DepartmentID = @DepartmentID;
END;
GO
-- Execute: --
EXEC sp_GetExamsByDepartment @DepartmentID = 1;
GO

-- Procedure 5: Update Student Exam Mark --
CREATE PROCEDURE sp_UpdateStudentExamMark
    @StudentID INT,
    @ExamCode VARCHAR(20),
    @Mark DECIMAL(5,2)
AS
BEGIN
    UPDATE StudentExam
    SET
        Mark = @Mark,
        Status = 'Taken'
    WHERE
        StudentID = @StudentID
        AND ExamCode = @ExamCode;

    IF @@ROWCOUNT = 0
        PRINT 'No matching student examination record was found.';
    ELSE
        PRINT 'Student examination mark updated successfully.';
END;
GO
-- Execute: --
EXEC sp_UpdateStudentExamMark
    @StudentID = 1003,
    @ExamCode = 'SE103',
    @Mark = 88.50;
GO

-- To check The Result --
SELECT *
FROM StudentExam
WHERE StudentID = 1003
  AND ExamCode = 'SE103';
GO

-- Verify Stored Procedures --
SELECT
    name AS ProcedureName,
    create_date AS CreatedDate
FROM sys.procedures
WHERE schema_id = SCHEMA_ID('dbo')
ORDER BY name;
GO