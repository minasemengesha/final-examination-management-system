-- Trigger 1: Prevent Invalid Exam Marks --
USE FinalExamination;
GO

CREATE TRIGGER trg_PreventInvalidExamMark
ON StudentExam
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (
        SELECT 1
        FROM inserted
        WHERE Mark IS NOT NULL
          AND (Mark < 0 OR Mark > 100)
    )
    BEGIN
        ROLLBACK TRANSACTION;
        THROW 50001, 'Exam mark must be between 0 and 100.', 1;
    END;
END;
GO
-- The Wrong Test: --
UPDATE StudentExam
SET Mark = 150
WHERE StudentID = 1001
  AND ExamCode = 'SE101';
GO
-- The Right Test 2: --
SELECT StudentID, ExamCode, Mark
FROM StudentExam
WHERE StudentID = 1001
  AND ExamCode = 'SE101';
GO

-- Trigger 2: Prevent Mark Entry for Absent Students --
CREATE TRIGGER trg_PreventMarkForAbsentStudent
ON StudentExam
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (
        SELECT 1
        FROM inserted
        WHERE Status = 'Absent'
          AND Mark IS NOT NULL
    )
    BEGIN
        ROLLBACK TRANSACTION;
        THROW 50002, 'An absent student cannot receive an exam mark.', 1;
    END;
END;
GO
-- -- The Wrong Test: --
UPDATE StudentExam
SET Mark = 75
WHERE StudentID = 1004
  AND ExamCode = 'SE104';
GO

-- Trigger 3: Automatically Set Status When Mark Is Entered --
CREATE TRIGGER trg_SetStatusWhenMarkEntered
ON StudentExam
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    IF UPDATE(Mark)
    BEGIN
        UPDATE SE
        SET Status = 'Taken'
        FROM StudentExam AS SE
        INNER JOIN inserted AS I
            ON SE.StudentID = I.StudentID
           AND SE.ExamCode = I.ExamCode
        WHERE I.Mark IS NOT NULL
          AND I.Status <> 'Absent'
          AND SE.Status <> 'Taken';
    END;
END;
GO
-- The Wrong Test: --
UPDATE StudentExam
SET Mark = 95
WHERE StudentID = 1003
  AND ExamCode = 'SE103';
GO

-- Verify Triggers --
SELECT
    name AS TriggerName,
    OBJECT_NAME(parent_id) AS TableName,
    create_date AS CreatedDate
FROM sys.triggers
WHERE parent_class = 1
ORDER BY name;
GO