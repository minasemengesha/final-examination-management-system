-- Primary Keys--

USE FinalExamination;
GO

-- 1. Department
ALTER TABLE Department
ADD CONSTRAINT PK_Department
PRIMARY KEY (DepartmentID);
GO

-- 2. Student
ALTER TABLE Student
ADD CONSTRAINT PK_Student
PRIMARY KEY (StudentID);
GO

-- 3. Teacher
ALTER TABLE Teacher
ADD CONSTRAINT PK_Teacher
PRIMARY KEY (TeacherID);
GO

-- 4. ExamRoom
ALTER TABLE ExamRoom
ADD CONSTRAINT PK_ExamRoom
PRIMARY KEY (RoomID);
GO

-- 5. Exam
ALTER TABLE Exam
ADD CONSTRAINT PK_Exam
PRIMARY KEY (ExamCode);
GO

-- 6. Question
ALTER TABLE Question
ADD CONSTRAINT PK_Question
PRIMARY KEY (QuestionCode);
GO

-- 7. StudentExam
ALTER TABLE StudentExam
ADD CONSTRAINT PK_StudentExam
PRIMARY KEY (StudentID, ExamCode);
GO

-- 8. ExamRoomAssignment
ALTER TABLE ExamRoomAssignment
ADD CONSTRAINT PK_ExamRoomAssignment
PRIMARY KEY (ExamCode, RoomID);
GO

-- 9. ExamTeacher
ALTER TABLE ExamTeacher
ADD CONSTRAINT PK_ExamTeacher
PRIMARY KEY (ExamCode, TeacherID);
GO

-- 10. TeacherRoomAssignment
ALTER TABLE TeacherRoomAssignment
ADD CONSTRAINT PK_TeacherRoomAssignment
PRIMARY KEY (TeacherID, RoomID);
GO

-- 11. ExamTeacherView
ALTER TABLE ExamTeacherView
ADD CONSTRAINT PK_ExamTeacherView
PRIMARY KEY (TeacherID, ExamCode);
GO

-- Foreion Keys--

-- Student -> Department
ALTER TABLE Student
ADD CONSTRAINT FK_Student_Department
FOREIGN KEY (DepartmentID)
REFERENCES Department(DepartmentID);
GO

-- Teacher -> Department
ALTER TABLE Teacher
ADD CONSTRAINT FK_Teacher_Department
FOREIGN KEY (DepartmentID)
REFERENCES Department(DepartmentID);
GO

-- ExamRoom -> Department
ALTER TABLE ExamRoom
ADD CONSTRAINT FK_ExamRoom_Department
FOREIGN KEY (DepartmentID)
REFERENCES Department(DepartmentID);
GO

-- Question -> Exam
ALTER TABLE Question
ADD CONSTRAINT FK_Question_Exam
FOREIGN KEY (ExamCode)
REFERENCES Exam(ExamCode);
GO

-- StudentExam -> Student
ALTER TABLE StudentExam
ADD CONSTRAINT FK_StudentExam_Student
FOREIGN KEY (StudentID)
REFERENCES Student(StudentID);
GO

-- StudentExam -> Exam
ALTER TABLE StudentExam
ADD CONSTRAINT FK_StudentExam_Exam
FOREIGN KEY (ExamCode)
REFERENCES Exam(ExamCode);
GO

-- ExamRoomAssignment -> Exam
ALTER TABLE ExamRoomAssignment
ADD CONSTRAINT FK_ExamRoomAssignment_Exam
FOREIGN KEY (ExamCode)
REFERENCES Exam(ExamCode);
GO

-- ExamRoomAssignment -> ExamRoom
ALTER TABLE ExamRoomAssignment
ADD CONSTRAINT FK_ExamRoomAssignment_ExamRoom
FOREIGN KEY (RoomID)
REFERENCES ExamRoom(RoomID);
GO

-- ExamTeacher -> Exam
ALTER TABLE ExamTeacher
ADD CONSTRAINT FK_ExamTeacher_Exam
FOREIGN KEY (ExamCode)
REFERENCES Exam(ExamCode);
GO

-- ExamTeacher -> Teacher
ALTER TABLE ExamTeacher
ADD CONSTRAINT FK_ExamTeacher_Teacher
FOREIGN KEY (TeacherID)
REFERENCES Teacher(TeacherID);
GO

-- TeacherRoomAssignment -> Teacher
ALTER TABLE TeacherRoomAssignment
ADD CONSTRAINT FK_TeacherRoomAssignment_Teacher
FOREIGN KEY (TeacherID)
REFERENCES Teacher(TeacherID);
GO

-- TeacherRoomAssignment -> ExamRoom
ALTER TABLE TeacherRoomAssignment
ADD CONSTRAINT FK_TeacherRoomAssignment_ExamRoom
FOREIGN KEY (RoomID)
REFERENCES ExamRoom(RoomID);
GO

-- ExamTeacherView -> Teacher
ALTER TABLE ExamTeacherView
ADD CONSTRAINT FK_ExamTeacherView_Teacher
FOREIGN KEY (TeacherID)
REFERENCES Teacher(TeacherID);
GO

-- ExamTeacherView -> Exam
ALTER TABLE ExamTeacherView
ADD CONSTRAINT FK_ExamTeacherView_Exam
FOREIGN KEY (ExamCode)
REFERENCES Exam(ExamCode);
GO

-- StudentExam -> ExamRoomAssignment
-- Ensures that a student is assigned only to a room allocated to that exam.
ALTER TABLE StudentExam
ADD CONSTRAINT FK_StudentExam_ExamRoomAssignment
FOREIGN KEY (ExamCode, RoomID)
REFERENCES ExamRoomAssignment(ExamCode, RoomID);
GO

-- Unique Keys--

ALTER TABLE ExamRoom
ADD CONSTRAINT UQ_ExamRoom_Building_Room
UNIQUE (BuildingNumber, RoomNumber);
GO

-- Check Constraints --

-- Student sex
ALTER TABLE Student
ADD CONSTRAINT CK_Student_Sex
CHECK (Sex IN ('Male', 'Female'));
GO

-- Teacher sex
ALTER TABLE Teacher
ADD CONSTRAINT CK_Teacher_Sex
CHECK (Sex IN ('Male', 'Female'));
GO

-- Teacher salary
ALTER TABLE Teacher
ADD CONSTRAINT CK_Teacher_Salary
CHECK (Salary >= 0);
GO

-- Number of questions must be positive
ALTER TABLE Question
ADD CONSTRAINT CK_Question_NumberOfQuestions
CHECK (NumberOfQuestions > 0);
GO

-- Time allowed is measured in minutes and must be positive
ALTER TABLE Question
ADD CONSTRAINT CK_Question_TimeAllowed
CHECK (TimeAllowed > 0);
GO

-- Student exam status
ALTER TABLE StudentExam
ADD CONSTRAINT CK_StudentExam_Status
CHECK (Status IN ('Scheduled', 'Taken', 'Absent'));
GO

-- Student exam mark
ALTER TABLE StudentExam
ADD CONSTRAINT CK_StudentExam_Mark
CHECK (Mark IS NULL OR (Mark >= 0 AND Mark <= 100));
GO

-- Exam teacher view difficulty status
ALTER TABLE ExamTeacherView
ADD CONSTRAINT CK_ExamTeacherView_Status
CHECK (Status IN ('Easy', 'Medium', 'Difficult'));
GO