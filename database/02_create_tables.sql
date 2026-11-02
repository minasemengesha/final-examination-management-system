USE FinalExamination;
GO

-- 1. Department Table
CREATE TABLE Department (
    DepartmentID INT NOT NULL,
    DepartmentName VARCHAR(100) NOT NULL,
    DepartmentHeadName VARCHAR(100),
    DepartmentLocation VARCHAR(100)
);
GO

-- 2. Student Table
CREATE TABLE Student (
    StudentID INT NOT NULL,
    FirstName VARCHAR(50) NOT NULL,
    MiddleName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Sex VARCHAR(10) NOT NULL,
    DateOfBirth DATE NOT NULL,
    DepartmentID INT NOT NULL
);
GO

-- 3. Teacher Table
CREATE TABLE Teacher (
    TeacherID INT NOT NULL,
    FirstName VARCHAR(50) NOT NULL,
    MiddleName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Sex VARCHAR(10) NOT NULL,
    DateOfBirth DATE NOT NULL,
    Salary DECIMAL(10,2) NOT NULL,
    DepartmentID INT NOT NULL
);
GO

-- 4. ExamRoom Table
CREATE TABLE ExamRoom (
    RoomID INT IDENTITY(1,1) NOT NULL,
    BuildingNumber INT NOT NULL,
    RoomNumber INT NOT NULL,
    DepartmentID INT NOT NULL
);
GO

-- 5. Exam Table
CREATE TABLE Exam (
    ExamCode VARCHAR(20) NOT NULL,
    ExamName VARCHAR(100) NOT NULL
);
GO

-- 6. Question Table
CREATE TABLE Question (
    QuestionCode VARCHAR(20) NOT NULL,
    ExamCode VARCHAR(20) NOT NULL,
    NumberOfQuestions INT NOT NULL,
    TimeAllowed INT NOT NULL
);
GO

-- 7. StudentExam Table
CREATE TABLE StudentExam (
    StudentID INT NOT NULL,
    ExamCode VARCHAR(20) NOT NULL,
    RoomID INT NOT NULL,
    Mark DECIMAL(5,2) NULL,
    Status VARCHAR(20) NOT NULL,
    ExamDate DATE NOT NULL
);
GO

-- 8. ExamRoomAssignment Table
CREATE TABLE ExamRoomAssignment (
    ExamCode VARCHAR(20) NOT NULL,
    RoomID INT NOT NULL
);
GO

-- 9. ExamTeacher Table
CREATE TABLE ExamTeacher (
    ExamCode VARCHAR(20) NOT NULL,
    TeacherID INT NOT NULL
);
GO

-- 10. TeacherRoomAssignment Table
CREATE TABLE TeacherRoomAssignment (
    TeacherID INT NOT NULL,
    RoomID INT NOT NULL
);
GO

-- 11. ExamTeacherView Table
CREATE TABLE ExamTeacherView (
    TeacherID INT NOT NULL,
    ExamCode VARCHAR(20) NOT NULL,
    Audited BIT NOT NULL,
    Status VARCHAR(20) NOT NULL
);
GO