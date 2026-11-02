# Database Normalization
## Final Examination Management System
## Introduction

Database normalization is the process of organizing data in a relational database to reduce data redundancy, prevent data anomalies, and improve data integrity.

Normalization divides data into related tables and establishes relationships between them using Primary Keys and Foreign Keys.

The main objectives of normalization are:

- To minimize unnecessary data duplication.
- To prevent insertion anomalies.
- To prevent update anomalies.
- To prevent deletion anomalies.
- To improve data consistency and integrity.
- To create a well-structured and maintainable relational database.

The Final Examination Management System applies the principles of normalization through the following stages:
  - First Normal Form (1NF).
  - Second Normal Form (2NF).
  - Third Normal Form (3NF).

## First Normal Form (1NF)
### Definition

A relation is in First Normal Form (1NF) if:

- Each column contains atomic (single) values.
- Each cell contains only one value.
- There are no repeating groups or multivalued attributes.
- Each record can be uniquely identified.

### Example of a Table Not in 1NF

Consider a StudentExamination table containing multiple examination codes in one attribute.

StudentID   StudentName    ExamCodes         
ST001        Abebe Kebede   EX001, EX002      
ST002        Hana Bekele    EX001, EX003 

The ExamCodes column contains multiple values in a single cell. This violates First Normal Form.

### Converting the Table into 1NF

To achieve 1NF, each examination code must be stored as an individual value in a separate record.

StudentID  StudentName     ExamCode              
ST001       Abebe Kebede    EX001              
ST001       Abebe Kebede    EX002              
ST002       Hana Bekele     EX001              
ST002       Hana Bekele     EX003 

Now, each cell contains a single atomic value.

### Application of 1NF in the Project

In the Final Examination Management System:

- Student names are stored in separate attributes.
- Teacher names are stored in separate attributes.
- Each student-examination participation is stored as an individual record.
- Each examination-room allocation is stored as an individual record.
- Each teacher-examination assignment is stored as an individual record.
- Each teacher-room assignment is stored as an individual record.
- Each teacher's examination review is stored as an individual record.

Therefore, the tables are designed to satisfy the requirements of First Normal Form.

## Second Normal Form (2NF)
### Definition

A relation is in Second Normal Form (2NF) if:

- It is already in First Normal Form (1NF).
- Every non-key attribute is fully functionally dependent on the entire Primary Key.
- There are no partial functional dependencies of non-key attributes on a part of a composite Primary Key.

2NF is particularly important for tables that use composite Primary Keys.

### Example of a Table Not in 2NF

Consider the following StudentExam table:

StudentID  ExamCode  StudentName ExamName      Mark 
ST001       EX001     Abebe Kebede  Database    85 
ST001       EX002     Abebe Kebede  Programming 90 
ST002       EX001     Hana Bekele   Database    78

Assume that the composite Primary Key is (StudentID, ExamCode).

However:

- StudentName depends only on StudentID.
- ExamName depends only on ExamCode.
- Mark depends on the complete combination of StudentID and ExamCode.

Therefore, StudentName and ExamName have partial dependencies, which violate 2NF.

### Converting the Table into 2NF

To eliminate partial dependencies, the data is separated into three tables.

Student Table

StudentID (PK)   StudentName                    
ST001             Abebe Kebede                 
ST002             Hana Bekele 

Exam Table

ExamCode (PK) ExamName                             
EX001          Database                         
EX002          Programming

StudentExam Table

StudentID (PK, FK)  ExamCode (PK, FK)    Mark     
ST001                EX001                85      
ST001                EX002                90    
ST002                EX001                78 

Now:

- Student information depends on StudentID.
- Examination information depends on ExamCode.
- Examination participation information depends on the complete composite key (StudentID, ExamCode).

This removes partial dependencies.

### Application of 2NF in the Project

The Final Examination Management System uses separate entity tables to store information about students, teachers, departments, examinations, and examination rooms.

For example:

- Student information is stored in Student.
- Teacher information is stored in Teacher.
- Department information is stored in Department.
- Examination information is stored in Exam.
- Examination room information is stored in ExamRoom.

Associative tables use composite Primary Keys where appropriate.

Examples include:

- StudentExam: (StudentID, ExamCode).
- ExamRoomAssignment: (ExamCode, RoomID).
- ExamTeacher: (ExamCode, TeacherID).
- TeacherRoomAssignment: (TeacherID, RoomID).
- ExamTeacherView: (TeacherID, ExamCode).

The non-key attributes in these associative tables are intended to depend on the complete composite key.

For example, in StudentExam, Mark, Status, ExamDate, and RoomID describe the participation of a particular student in a particular examination.

Therefore, the design is structured to satisfy Second Normal Form.

## Third Normal Form (3NF)
### Definition

A relation is in Third Normal Form (3NF) if:

- It is already in Second Normal Form (2NF).
- It contains no transitive dependencies of non-key attributes on the Primary Key.
- Every non-key attribute depends directly on the Primary Key, the whole Primary Key, and nothing but the Primary Key.

A transitive dependency occurs when a non-key attribute depends on another non-key attribute instead of depending directly on the Primary Key.

### Example of a Table Not in 3NF

Consider the following Student table:

StudentID StudentName   DepartmentID DepartmentName 
ST002      Abebe Kebede  DEP01        Software Engi 
ST002      Hana Bekele   DEP02        Computer Sci 
ST003      Dawit Alemu   DEP01        Software Engi

Here:

- StudentID determines DepartmentID.
- DepartmentID determines DepartmentName.

Therefore:

StudentID → DepartmentID → DepartmentName

The DepartmentName attribute depends on DepartmentID, which is a non-key attribute in the Student table.

This creates a transitive dependency and violates 3NF.

### Converting the Table into 3NF

To eliminate the transitive dependency, the information is separated into two tables.

Student Table

StudentID (PK)     StudentName   DepartmentID (FK)
ST001               Abebe Kebede   DEP01        
ST002               Hana Bekele    DEP02       
ST003               Dawit Alemu    DEP01 

Department Table

DepartmentID (PK)   DepartmentName             
DEP01                 Software Engineering      
DEP02                 Computer Science 

Now:

- Student information depends directly on StudentID.
- Department information depends directly on DepartmentID.
- The Student table references Department through a Foreign Key.

This removes the transitive dependency.

### Application of 3NF in the Project

The Final Examination Management System separates information into independent entity tables to prevent transitive dependencies.

Examples:

Department and Student

- Department details are stored in Department.
- Student details are stored in Student.
- DepartmentID connects Student to Department.

Department and Teacher

- Teacher details are stored in Teacher.
- Department details are stored in Department.
- DepartmentID connects Teacher to Department.

Department and ExamRoom

- Room details are stored in ExamRoom.
- Department details are stored in Department.
- DepartmentID connects ExamRoom to Department.

Exam and Question

- General examination details are stored in Exam.
- Question paper details are stored in Question.
- ExamCode connects Question to Exam.

Student and Exam

- Student details are stored in Student.
- Examination details are stored in Exam.
- StudentExam stores the relationship and participation information.

Exam and ExamRoom

- Examination information is stored in Exam.
- Room information is stored in ExamRoom.
- ExamRoomAssignment manages the allocation relationship.

Teacher and Exam

- Teacher information is stored in Teacher.
- Examination information is stored in Exam.
- ExamTeacher manages the examination preparation relationship.
ExamTeacherView manages the examination review and auditing relationship.

Teacher and ExamRoom

- Teacher information is stored in Teacher.
- Room information is stored in ExamRoom.
- TeacherRoomAssignment manages the assignment relationship.

By separating these entities and their relationships, the design avoids storing the same descriptive information repeatedly across unrelated records.

## Normalization of Associative Tables

Associative tables are used to resolve Many-to-Many relationships. Their composite Primary Keys help identify each unique relationship.

The following table summarizes their keys and non-key attributes.

Table                  Composite   Primary Key       Non-Key Attributes
StudentExam             StudentID,  ExamCode RoomID,  Mark, Status, ExamDate
ExamRoomAssignment      ExamCode,   RoomID            None 
ExamTeacher             ExamCode,   TeacherID         None
TeacherRoomAssignment   TeacherID,  RoomID            None
ExamTeacherView         TeacherID,  ExamCode          Audited, Status 

- For associative tables with no additional non-key attributes, the composite Primary Key identifies each relationship record.

- For tables with additional attributes, those attributes describe the complete relationship represented by the composite Primary Key.

## Conclusion

The Final Examination Management System is designed using the principles of First Normal Form (1NF), Second Normal Form (2NF), and Third Normal Form (3NF).

The database separates independent entities into their own tables, resolves Many-to-Many relationships through associative tables, and uses Primary Keys and Foreign Keys to maintain data integrity.

The normalization process provides a structured foundation for implementing the database in Microsoft SQL Server.

Note: Final confirmation of 3NF requires checking all functional dependencies and business rules against the completed schema. The design described here is structured to satisfy the normal forms under the stated assumptions.