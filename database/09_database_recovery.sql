-- Full Database Backup --
USE master;
GO

BACKUP DATABASE FinalExamination
TO DISK = 'C:\SQLBackups\FinalExamination_Full.bak'
WITH
    INIT,
    NAME = 'FinalExamination Full Backup',
    DESCRIPTION = 'Full backup of Final Examination Management System';
GO

-- Verify Backup --
RESTORE VERIFYONLY
FROM DISK = 'C:\SQLBackups\FinalExamination_Full.bak';
GO

-- Database Recovery (Restore) --
SELECT
    SERVERPROPERTY('InstanceDefaultDataPath') AS DefaultDataPath,
    SERVERPROPERTY('InstanceDefaultLogPath') AS DefaultLogPath;
GO

RESTORE FILELISTONLY
FROM DISK = 'C:\SQLBackups\FinalExamination_Full.bak';
GO

-- Restore Database --
USE master;
GO

DECLARE @DataPath NVARCHAR(4000);
DECLARE @LogPath NVARCHAR(4000);

SELECT
    @DataPath = CAST(SERVERPROPERTY('InstanceDefaultDataPath') AS NVARCHAR(4000)),
    @LogPath = CAST(SERVERPROPERTY('InstanceDefaultLogPath') AS NVARCHAR(4000));

-- Ensure paths end with a backslash
IF RIGHT(@DataPath, 1) <> '\'
    SET @DataPath = @DataPath + '\';

IF RIGHT(@LogPath, 1) <> '\'
    SET @LogPath = @LogPath + '\';

DECLARE @SQL NVARCHAR(MAX);

SET @SQL =
    N'RESTORE DATABASE FinalExamination_Restored
      FROM DISK = N''C:\SQLBackups\FinalExamination_Full.bak''
      WITH
          MOVE N''FinalExamination''
              TO N''' + REPLACE(@DataPath + 'FinalExamination_Restored.mdf', '''', '''''') + N''',
          MOVE N''FinalExamination_log''
              TO N''' + REPLACE(@LogPath + 'FinalExamination_Restored_log.ldf', '''', '''''') + N''',
          RECOVERY,
          STATS = 10;';

EXEC sp_executesql @SQL;
GO
-- Verify Recovery --
SELECT
    name,
    state_desc
FROM sys.databases
WHERE name = 'FinalExamination_Restored';
GO

USE FinalExamination_Restored;
GO

SELECT COUNT(*) AS TotalDepartments
FROM Department;

SELECT COUNT(*) AS TotalStudents
FROM Student;

SELECT COUNT(*) AS TotalTeachers
FROM Teacher;
GO

--============================================================--
-- Final Verfication of all database --

USE FinalExamination;
GO

-- 1. Verify Tables
SELECT name AS TableName
FROM sys.tables
ORDER BY name;

-- 2. Verify Views
SELECT name AS ViewName
FROM sys.views
ORDER BY name;

-- 3. Verify Stored Procedures
SELECT name AS ProcedureName
FROM sys.procedures
WHERE name LIKE 'sp_%'
ORDER BY name;

-- 4. Verify Triggers
SELECT
    name AS TriggerName,
    OBJECT_NAME(parent_id) AS TableName
FROM sys.triggers
WHERE parent_class = 1
ORDER BY name;

-- 5. Verify Constraints
SELECT
    name AS ConstraintName,
    type_desc AS ConstraintType
FROM sys.objects
WHERE type IN ('PK', 'F', 'UQ', 'C')
ORDER BY type_desc, name;
GO
--==================================================--