# Database Normalization
## Introduction

Database normalization is the process of organizing data in a relational database to reduce data redundancy, prevent data anomalies, and improve data integrity.

In the Final Examination Management System, normalization is applied to organize the database tables properly and establish clear relationships between entities.

This project follows three main normalization levels:
- First Normal Form (1NF)
- Second Normal Form (2NF)
- Third Normal Form (3NF)

## First Normal Form (1NF)
### Definition

A table is in First Normal Form (1NF) if:
- Each column contains atomic (single) values.
- Each record is unique.
- There are no repeating groups or multiple values stored in a single column.
- Each column contains values of the same type.

### Example

Consider a student table that stores multiple examination codes in one column:

sidno    sname       exam_codes
S001      Abebe        E001,E002                S002       Hana        E001 

This structure violates 1NF because the exam_codes column contains multiple values.

### Solution

Separate student information from examination participation by creating two tables:
 Student
   - sidno (PK)  - sname   -smname    -slname
   - ssex        - sbdate  - Did (FK) - RoomID (FK)
 StudentExam 
   - sidno (PK, FK)   - ecode (PK, FK)   -mark
   - status           - examdate

Now, each column contains a single value, and each student can participate in multiple examinations through the StudentExam table.

Therefore, the structure satisfies 1NF.

## Second Normal Form (2NF)
### Definition

A table is in Second Normal Form (2NF) if:
- It is already in First Normal Form (1NF).
- Every non-key attribute depends on the whole primary key.
- There are no partial dependencies on part of a composite primary key.

### Example

Consider a table with a composite primary key consisting of sidno and ecode:

sidno  ecode    sname   ename            mark 
S001   E001      Abebe   Database Exam    85 
S001   E002      Abebe   Programming Exam 90 

In this table:
- sname depends only on sidno.
- ename depends only on ecode.
- mark depends on both sidno and ecode.
Therefore, the table contains partial dependencies and violates 2NF.

### Solution
Separate the information into three tables:
  Student
   - sidno (PK)  - sname  - smname
   - slname      - ssex   - sbdate
   - Did (FK)    - RoomID (FK)
  Exam
   - ecode (PK)  - ename
  StudentExam
   - sidno (PK, FK)   - ecode (PK, FK)
   - mark             - status
   - examdate

Now, student information is stored in the Student table, examination information is stored in the Exam table, and participation information is stored in StudentExam.

The non-key attributes in StudentExam depend on the complete composite primary key.

Therefore, the structure satisfies 2NF.

## Third Normal Form (3NF)
### Definition

A table is in Third Normal Form (3NF) if:
- It is already in Second Normal Form (2NF).
- It contains no transitive dependencies.
- Non-key attributes depend directly on the primary key, not on another non-key attribute.

### Example

Consider the following Student table:
sidno   sname  Did  Dname 
S001    Abebe  D01  Software Engineering 
S002    Hana   D01  Software Engineering
S003    Bekele D02  Computer Science 

In this table:
- sidno determines Did.
- Did determines Dname.
Therefore, Dname depends on sidno through Did.
This is a transitive dependency and violates 3NF.

### Solution

Separate student information from department information.
  Student
   - sidno (PK)  - sname  - smname
   - slname      - ssex   - sbdate
   - Did (FK)    - RoomID (FK)
  Department
   - Did (PK)   - Dname   - Dhead
   - Dlocation
Now, department information is stored only in the Department table, and the Student table references it through Did.
This eliminates the transitive dependency and satisfies 3NF.

## Normalization Applied to the Project

The Final Examination Management System applies normalization principles through the following design decisions:

### Main Entity Tables

Each main entity has its own table:

  - Department
  - Student
  - Teacher
  - ExamRoom
  - Exam
  - Question

Each table stores information that directly describes its corresponding entity.

### Associative Tables

Many-to-Many relationships are implemented using associative tables:
1. StudentExam
2. ExamRoomAssignment
3. ExamTeacher
4. TeacherRoomAssignment
5. ExamTeacherView

These tables use composite primary keys formed from the foreign keys of the related entities.

Relationship-specific attributes are stored in their corresponding associative tables.

For example:
 - StudentExam stores mark, status, and examdate.
 - ExamTeacherView stores audited and status.

### Question and Exam Separation

The Exam entity represents the general examination, while the Question entity represents a collection of examination questions or a question paper.

Therefore:
- no_question belongs to Question.
- time belongs to Question.
- ecode is stored in Question as a foreign key.

One Exam can have multiple Question records, while each Question record belongs to one Exam.

### Department Information

Department information is maintained separately in the Department table.

Student and Teacher records reference their department through Did, avoiding unnecessary repetition of department details.

## Benefits of Normalization

Normalization provides several benefits to the Final Examination Management System:
- Reduces unnecessary data duplication.
- Improves data consistency.
- Prevents insertion, update, and deletion anomalies.
- Improves data integrity.
- Makes database maintenance easier.
- Establishes clear relationships between tables.

## Conclusion

The Final Examination Management System is designed using the principles of First Normal Form (1NF), Second Normal Form (2NF), and Third Normal Form (3NF).

The design separates main entities, resolves Many-to-Many relationships using associative tables, and stores attributes according to their actual meanings.

This normalized structure provides a reliable foundation for implementing the database using Microsoft SQL Server.