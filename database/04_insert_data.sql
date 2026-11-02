USE FinalExamination;
GO

-- 1. Department Records
INSERT INTO Department
    (DepartmentID, DepartmentName, DepartmentHeadName, DepartmentLocation)
VALUES
    (1, 'Software Engineering', 'Dr. Abebe Kebede', 'Block A'),
    (2, 'Computer Science', 'Dr. Hana Tadesse', 'Block B'),
    (3, 'Information Technology', 'Dr. Samuel Bekele', 'Block C'),
    (4, 'Electrical Engineering', 'Dr. Meron Alemu', 'Block D'),
    (5, 'Civil Engineering', 'Dr. Daniel Girma', 'Block E');
GO

-- 2. Student Records
INSERT INTO Student
    (StudentID, FirstName, MiddleName, LastName, Sex, DateOfBirth, DepartmentID)
VALUES
    (1001, 'Minase', 'Mengesha', 'Kebede', 'Male', '2005-03-15', 1),
    (1002, 'Abel', 'Tesfaye', 'Bekele', 'Male', '2004-07-21', 1),
    (1003, 'Sara', 'Getachew', 'Alemu', 'Female', '2005-01-10', 2),
    (1004, 'Dawit', 'Kassa', 'Girma', 'Male', '2003-11-05', 3),
    (1005, 'Hana', 'Mekonnen', 'Tadesse', 'Female', '2004-09-18', 4);
GO 

-- 3. Teacher Records
INSERT INTO Teacher
    (TeacherID, FirstName, MiddleName, LastName, Sex, DateOfBirth, Salary, DepartmentID)
VALUES
    (2001, 'Abebe', 'Kebede', 'Worku', 'Male', '1980-05-12', 25000.00, 1),
    (2002, 'Meron', 'Tadesse', 'Alemu', 'Female', '1985-08-20', 28000.00, 2),
    (2003, 'Samuel', 'Bekele', 'Girma', 'Male', '1978-02-14', 32000.00, 3),
    (2004, 'Hana', 'Mekonnen', 'Kassa', 'Female', '1982-12-01', 27000.00, 4),
    (2005, 'Daniel', 'Tesfaye', 'Abebe', 'Male', '1975-06-25', 35000.00, 5);
GO

-- 4. ExamRoom Records
INSERT INTO ExamRoom
    (BuildingNumber, RoomNumber, DepartmentID)
VALUES
    (1, 101, 1),
    (1, 102, 1),
    (2, 201, 2),
    (3, 301, 3),
    (4, 401, 4);
GO

-- 5. Exam Records
INSERT INTO Exam
    (ExamCode, ExamName)
VALUES
    ('SE101', 'Programming Fundamentals'),
    ('SE102', 'Database Systems'),
    ('SE103', 'Data Structures'),
    ('SE104', 'Software Engineering'),
    ('SE105', 'Computer Networks');
GO

-- 6. Question Records
INSERT INTO Question
    (QuestionCode, ExamCode, NumberOfQuestions, TimeAllowed)
VALUES
    ('Q001', 'SE101', 50, 120),
    ('Q002', 'SE102', 40, 90),
    ('Q003', 'SE103', 45, 120),
    ('Q004', 'SE104', 35, 90),
    ('Q005', 'SE105', 40, 100);
GO

-- 7. ExamRoomAssignment Records
INSERT INTO ExamRoomAssignment
    (ExamCode, RoomID)
VALUES
    ('SE101', 1),
    ('SE102', 2),
    ('SE103', 3),
    ('SE104', 4),
    ('SE105', 5);
GO

-- 8. ExamTeacher Records
INSERT INTO ExamTeacher
    (ExamCode, TeacherID)
VALUES
    ('SE101', 2001),
    ('SE102', 2002),
    ('SE103', 2003),
    ('SE104', 2004),
    ('SE105', 2005);
GO

-- 9. TeacherRoomAssignment Records
INSERT INTO TeacherRoomAssignment
    (TeacherID, RoomID)
VALUES
    (2001, 1),
    (2002, 2),
    (2003, 3),
    (2004, 4),
    (2005, 5);
GO

-- 10. StudentExam Records
INSERT INTO StudentExam
    (StudentID, ExamCode, RoomID, Mark, Status, ExamDate)
VALUES
    (1001, 'SE101', 1, 85.50, 'Taken', '2026-11-10'),
    (1002, 'SE102', 2, 78.00, 'Taken', '2026-11-11'),
    (1003, 'SE103', 3, NULL, 'Scheduled', '2026-11-12'),
    (1004, 'SE104', 4, NULL, 'Absent', '2026-11-13'),
    (1005, 'SE105', 5, 92.00, 'Taken', '2026-11-14');
GO

-- 11. ExamTeacherView Records
INSERT INTO ExamTeacherView
    (TeacherID, ExamCode, Audited, Status)
VALUES
    (2001, 'SE101', 1, 'Easy'),
    (2002, 'SE102', 1, 'Medium'),
    (2003, 'SE103', 0, 'Difficult'),
    (2004, 'SE104', 1, 'Medium'),
    (2005, 'SE105', 0, 'Easy');
GO