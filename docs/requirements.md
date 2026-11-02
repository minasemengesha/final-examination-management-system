# Final Examination Management System
# System Requirements
## Introduction

This document defines the functional requirements, non-functional requirements, business rules, and technical requirements of the Final Examination Management System.

It describes the expected behavior of the database system and establishes the conditions that must be satisfied during database design, implementation, and testing.

## Functional Requirements

Functional requirements describe the operations and services that the system must support.

- FR-01: Department Management
The system shall store and manage academic department information, including department ID, name, head name, and location.
- FR-02: Student Management
The system shall store student information, including student ID, first name, middle name, last name, sex, date of birth, and department.
- FR-03: Teacher Management
The system shall store teacher information, including teacher ID, first name, middle name, last name, sex, date of birth, salary, and department.
- FR-04: Examination Room Management
The system shall store examination room information, including room ID, building number, room number, and responsible department.
- FR-05: Examination Management
The system shall store general examination information, including examination code and examination name.
- FR-06: Question Paper Management
The system shall store question paper information, including question paper code, associated examination, total number of questions, and allocated completion time.
- FR-07: Student Examination Registration and Participation
The system shall associate students with examinations and record their examination participation information.
- FR-08: Student Examination Attendance
The system shall maintain the attendance status of students for each examination.
- FR-09: Student Examination Results
The system shall store the calculated examination mark for each student when the result is available.
- FR-10: Examination Room Allocation
The system shall associate examinations with the rooms allocated for them.
- FR-11: Student Room Assignment
The system shall record the examination room assigned to each student for a particular examination.
- FR-12: Teacher Examination Assignment
The system shall record teachers assigned to prepare or create examinations.
- FR-13: Teacher Room Assignment
The system shall record teachers assigned to examination rooms.
- FR-14: Examination Review and Auditing
The system shall record teachers who review or audit examinations and maintain their auditing information and examination difficulty assessments.
- FR-15: Data Retrieval
The system shall support retrieving examination-related information using SQL queries.
- FR-16: Database Views
The system shall support creating and using database views to retrieve organized information from one or more related tables.
- FR-17: Stored Procedures
The system shall support stored procedures for executing reusable database operations.
- FR-18: Database Triggers
The system shall support triggers to automatically execute specified actions when relevant database events occur.
- FR-19: Database Recovery
The system shall support database backup and recovery operations to demonstrate how database information can be protected and restored.

## Non-Functional Requirements

Non-functional requirements define the quality attributes and operational expectations of the database system.

- NFR-01: Data Integrity
The database shall maintain accurate and consistent data through Primary Keys, Foreign Keys, unique constraints, and appropriate validation rules.
- NFR-02: Data Consistency
The database shall prevent invalid relationships and inconsistent records.
- NFR-03: Data Redundancy
The database shall minimize unnecessary duplication through appropriate relational design and normalization.
- NFR-04: Maintainability
The database shall use consistent naming conventions and a structured schema to simplify future modifications.
- NFR-05: Reliability
The database shall maintain reliable data storage and support backup and recovery operations.
- NFR-06: Performance
Database queries and operations should retrieve and manipulate information efficiently for the expected project workload.
- NFR-07: Security
The database should use appropriate access permissions to prevent unauthorized database operations.
- NFR-08: Documentation
The project shall maintain clear documentation describing its database design, requirements, implementation, and testing.

## Business Rules

Business rules define the conditions and restrictions that govern how the Final Examination Management System operates.

- BR-01: Student Examination Participation
A student shall participate in a particular examination only once. Examination retakes are excluded from the current project.
- BR-02: Unique Examination Room
The combination of BuildingNumber and RoomNumber shall be unique within the system.
- BR-03: Student Attendance Status
The Status attribute in StudentExam shall accept only the following values:
    - Scheduled: The student is registered but has not yet taken the examination.
    - Taken: The student attended and took the examination.
    - Absent: The student did not attend the examination.
- BR-04: Examination Difficulty Status
The Status attribute in ExamTeacherView shall accept only the following values:
       - Easy
       - Medium
       - Difficult
- BR-05: Examination Auditing
The Audited attribute in ExamTeacherView shall indicate whether a teacher has reviewed or audited an examination.
It shall use a Boolean value representing Yes or No.
- BR-06: Examination Room Allocation
A student shall only be assigned to an examination room that has already been allocated to the corresponding examination.
- BR-07: Department Head Information
DepartmentHeadName shall store the name of the department head. It shall not be treated as a Foreign Key to the Teacher table.
- BR-08: Examination Question Paper
Each Question record shall represent a question paper or collection of questions rather than an individual question.
- BR-09: Examination Mark
The examination mark shall represent the student's calculated examination result. It may remain unavailable until the marking process is completed.

## Technical Requirements

The project shall satisfy the following technical requirements:

1. Create a database named FinalExamination.
2. Create all 11 relational tables.
3. Define appropriate Primary Keys and Foreign Keys.
4. Apply appropriate constraints to maintain data integrity.
5. Insert at least five sample records into each table.
6. Write and execute SQL queries to retrieve relevant information.
7. Study database views and create at least one example.
8. Study stored procedures and create at least one example.
9. Study triggers and create at least one example.
10. Study database recovery and demonstrate an appropriate backup and recovery example.

## Database Design Requirements

The database design shall follow these principles:

- The database shall contain 11 relational tables.
- Each table shall have an appropriate Primary Key.
- Foreign Keys shall establish relationships between related tables.
- Many-to-Many relationships shall be implemented using associative tables.
- The database shall follow First Normal Form (1NF), Second Normal Form (2NF), and Third Normal Form (3NF), according to the defined functional dependencies and business rules.
- A consistent naming convention shall be applied across all tables and attributes.
- Appropriate constraints shall be used to enforce business rules.

## Conclusion

These requirements establish the functional, non-functional, business, and technical expectations of the Final Examination Management System.

They will guide the database implementation, testing, and evaluation to ensure that the final system meets the objectives of the project and the instructor's assignment requirements.