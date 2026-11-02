# Relational Database Schema
## Introduction

This document describes the relational database schema for the Final Examination Management System.

The schema is derived from the Entity Relationship Diagram (ERD) and defines the database tables, attributes, primary keys, foreign keys, and relationships.

The database is designed using relational database principles to maintain data integrity, reduce redundancy, and establish clear relationships between entities.

## Database Entities and Tables

The system contains six main entity tables and five associative tables.

### Main Entity Tables

1. Department
Stores information about academic departments.
- DepartmentID (PK): Unique department identifier.
- DepartmentName: Name of the department.
- DepartmentHeadName: Name of the department head.
- DepartmentLocation: Location of the department.
2. Student
Stores information about students.
- StudentID (PK): Unique student identifier.
- FirstName: Student's first name.
- MiddleName: Student's middle name.
- LastName: Student's last name.
- Sex: Student's sex.
- DateOfBirth: Student's date of birth.
- DepartmentID (FK): References the department to which the student belongs.
3. Teacher
Stores information about teachers.
- TeacherID (PK): Unique teacher identifier.
- FirstName: Teacher's first name.
- MiddleName: Teacher's middle name.
- LastName: Teacher's last name.
- Sex: Teacher's sex.
- DateOfBirth: Teacher's date of birth.
- Salary: Teacher's salary.
- DepartmentID (FK): References the department to which the teacher belongs.
4. ExamRoom
Stores information about examination rooms.
- RoomID (PK): Unique room identifier, generated automatically.
- BuildingNumber: Building number.
- RoomNumber: Room number.
- DepartmentID (FK): References the department responsible for the room.
- Constraint: The combination of BuildingNumber and RoomNumber must be unique.
5. Exam
Stores general information about examinations.
- ExamCode (PK): Unique examination identifier.
- ExamName: Name of the examination.
6. Question
Stores information about examination question papers. Each record represents a question paper or collection of questions, not an individual question.
- QuestionCode (PK): Unique question paper identifier.
- ExamCode (FK): References the examination associated with the question paper.
- NumberOfQuestions: Total number of questions in the paper.
- TimeAllowed: Total time allocated to complete the question paper.

### Associative Tables

These tables implement Many-to-Many (M:N) relationships.

7. StudentExam
Associates students with examinations and stores their examination participation details.
- StudentID (PK, FK): References the student.
- ExamCode (PK, FK): References the examination.
- RoomID (FK): References the examination room assigned to the student.
- Mark: Student's examination mark.
- Status: Student's attendance status (Scheduled, Taken, or Absent).
- ExamDate: Date of the examination.
- Primary Key: Composite key (StudentID, ExamCode).
- Additional Foreign Key Constraint: The combination of ExamCode and RoomID references ExamRoomAssignment (ExamCode, RoomID). This ensures that a student can only be assigned to a room allocated to that particular examination.
8. ExamRoomAssignment
Associates examinations with the rooms allocated for them.
- ExamCode (PK, FK): References the examination.
- RoomID (PK, FK): References the examination room.
- Primary Key: Composite key (ExamCode, RoomID).
9. ExamTeacher
Associates teachers with examinations they prepare or create.
- ExamCode (PK, FK): References the examination.
- TeacherID (PK, FK): References the teacher.
- Primary Key: Composite key (ExamCode, TeacherID).
10. TeacherRoomAssignment
Associates teachers with examination rooms assigned to them.
- TeacherID (PK, FK): References the teacher.
- RoomID (PK, FK): References the examination room.
- Primary Key: Composite key (TeacherID, RoomID).
11. ExamTeacherView
Stores information about teachers who review or audit examinations.
- TeacherID (PK, FK): References the teacher.
- ExamCode (PK, FK): References the examination.
- Audited: Indicates whether the teacher has reviewed or audited the examination.
- Status: Indicates the difficulty level of the examination (Easy, Medium, or Difficult).
- Primary Key: Composite key (TeacherID, ExamCode).

### Design Notes

- Naming Convention: Descriptive PascalCase names are used consistently for tables and attributes.
- Department Head: DepartmentHeadName stores the department head's name, not a foreign key.
- Question Paper: The Question table represents a question paper containing multiple questions.
- Student Examination Status: Status records attendance, not pass/fail results.
- Derived Mark: In the conceptual ER diagram, Mark is a derived attribute. Its implementation as a stored value should be documented according to the examination marking process.
- Examination Room Allocation: Room assignments are specific to each examination, not permanent student assignments.
- Retake Assumption: A student can take a particular examination only once in this project. Therefore, (StudentID, ExamCode) is sufficient as the composite primary key of StudentExam.
- Difficulty Status: In ExamTeacherView, Status represents examination difficulty, whereas in StudentExam, Status represents student attendance. These attributes have different meanings despite sharing the same name.

## Relationship Mapping

The following list summarizes how the ERD relationships are implemented in the relational database.

- Student – Department (Many-to-One): Foreign Key in Student.
- Student – Exam (Many-to-Many): StudentExam.
- Student – ExamRoom (Many-to-One): Foreign Key in Student.
- Department – ExamRoom (One-to-Many): Foreign Key in ExamRoom.
- Department – Teacher (One-to-Many): Foreign Key in Teacher.
- Exam – ExamRoom (Many-to-Many): ExamRoomAssignment.
- Exam – Question (One-to-Many): Foreign Key in Question.
- Exam – Teacher (Make) (Many-to-Many): ExamTeacher.
- Teacher – ExamRoom (Assign) (Many-to-Many): TeacherRoomAssignment.
- Teacher – Exam (View) (Many-to-Many): ExamTeacherView.

## Important Design Constraints and Assumptions
### Student Examination Participation

A student can participate in a particular examination only once in this project. Retake functionality is excluded from the current system.

Therefore, the combination of StudentID and ExamCode is used as the composite Primary Key in StudentExam.

### Examination Room Allocation

- A student does not have a permanently assigned examination room. 
- Instead, a room is assigned to a student for a specific examination through the StudentExam table.
- The ExamRoomAssignment table identifies which rooms are allocated to each examination.
- A composite Foreign Key (ExamCode, RoomID) in StudentExam references the corresponding pair in ExamRoomAssignment. This ensures that a student cannot be assigned to a room that has not been allocated to that examination.

### Derived Mark Attribute

In the conceptual ERD, Mark is identified as a derived attribute.

It represents the student's calculated examination result. Depending on the final examination marking process, the system may calculate the mark and store the resulting value in StudentExam.

The actual marking process and its implementation will be defined during database development.

### Department Head

DepartmentHeadName stores the name of the department head as specified in the original ERD. It is not treated as a Foreign Key to the Teacher table.

### Question Paper Representation

The Question table represents a complete question paper or collection of questions.

NumberOfQuestions represents the total number of questions in that paper, while TimeAllowed represents the total time allocated to complete it.

The time unit must be defined consistently during implementation.

### Different Meanings of Status

The Status attribute appears in two different tables but has different meanings:
- In StudentExam, it represents student attendance.
- In ExamTeacherView, it represents examination difficulty.
These attributes must be documented and constrained separately.

## Conclusion

The relational schema consists of 11 tables designed to represent the entities and relationships of the Final Examination Management System.

Primary Keys uniquely identify records, Foreign Keys maintain referential integrity, and associative tables resolve Many-to-Many relationships.

The schema provides the logical foundation for implementing the database in Microsoft SQL Server.