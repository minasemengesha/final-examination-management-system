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
- Did (PK): Department ID.
- Dname: Department name.
- Dhead: Department head's name.
- Dlocation: Department location.
2. Student
Stores information about students.
- sidno (PK): Student ID number.
- sname: Student first name.
- smname: Student middle name.
- slname: Student last name.
- ssex: Student sex.
- sbdate: Student birth date.
- Did (FK): Department ID.
- RoomID (FK): Assigned examination room.
3. Teacher
Stores information about teachers.
- Tid (PK): Teacher ID.
- tfname: Teacher first name.
- tmname: Teacher middle name.
- tlname: Teacher last name.
- tsex: Teacher sex.
- tbdate: Teacher birth date.
- salary: Teacher salary.
- Did (FK): Department ID.
4. ExamRoom
Stores information about examination rooms.
- RoomID (PK): Automatically generated room ID.
- bnum: Building number.
- roomnum: Room number.
- Did (FK): Department ID.
- Constraint: The combination of bnum and roomnum must be unique.
5. Exam
Stores information about examinations.
- ecode (PK): Examination code.
- ename: Examination name.
- time: Total time allocated to complete the examination.
6. Question
Stores information about examination questions.
- qcode (PK): Question code.
- no_question: Total number of questions in the examination.
- ecode (FK): Examination code.

### Associative Tables

These tables implement Many-to-Many (M:N) relationships.

7. StudentExam
Connects students with examinations and stores their examination results.
- sidno (PK, FK): Student ID.
- ecode (PK, FK): Examination code.
- mark: Student examination mark.
- status: Examination result status (Pass or Fail).
- examdate: Examination date.
- Primary Key: Composite key (sidno, ecode).
8. ExamRoomAssignment
Connects examinations with examination rooms.
- ecode (PK, FK): Examination code.
- RoomID (PK, FK): Examination room ID.
- Primary Key: Composite key (ecode, RoomID).
9. ExamTeacher
Connects teachers with examinations they prepare.
- ecode (PK, FK): Examination code.
- Tid (PK, FK): Teacher ID.
- Primary Key: Composite key (ecode, Tid).
10. TeacherRoomAssignment
Connects teachers with examination rooms assigned to them.
- Tid (PK, FK): Teacher ID.
- RoomID (PK, FK): Examination room ID.
- Primary Key: Composite key (Tid, RoomID).
11. ExamTeacherView
Connects teachers with examinations they review and stores their examination evaluations.
- Tid (PK, FK): Teacher ID.
- ecode (PK, FK): Examination code.
- audited: Indicates whether the examination has been reviewed.
- status: Examination difficulty evaluation.
- Primary Key: Composite key (Tid, ecode).
The status attribute represents the teacher's evaluation of examination difficulty:
     - Easy
     - Medium
     - Difficult

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

## Primary Key and Foreign Key Constraints

- Each main entity table has a primary key that uniquely identifies each record.
- Associative tables use composite primary keys to prevent duplicate relationship records.
- Foreign keys maintain referential integrity between related tables.
- The combination of bnum and roomnum in ExamRoom must be unique.
- A student can take multiple examinations, but the same student cannot take the same examination more than once in this project.

## Design Decisions and Assumptions

- RoomID is used as the primary key of ExamRoom, while (bnum, roomnum) has a UNIQUE constraint.
- The Dhead attribute stores the department head's name.
- One examination can contain multiple questions, but each question belongs to only one examination.
- The examination duration is stored in the Exam table as time.
- The Teacher–Exam View relationship is Many-to-Many.
- The status attribute in ExamTeacherView represents examination difficulty: Easy, Medium, or Difficult.
- The status attribute in StudentExam represents the student's result: Pass or Fail.
- Student examination records are stored in StudentExam, including mark, status, and examdate.
- Examination retakes are not included in the current project scope.

## Conclusion

This relational schema provides the structural foundation for implementing the Final Examination Management System using Microsoft SQL Server.

The next design stage is database normalization, followed by SQL Server implementation.