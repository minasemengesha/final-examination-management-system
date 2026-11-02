/*
=================================================
FINAL EXAMINATION MANAGEMENT SYSTEM
Main Database Setup Script
=================================================
*/

-- Step 1: Create Database
:r .\01_create_database.sql

-- Step 2: Create Tables
:r .\02_create_tables.sql

-- Step 3: Add Constraints
:r .\03_constraints.sql

-- Step 4: Insert Sample Data
:r .\04_insert_data.sql

-- Step 5: Execute SQL Queries
:r .\05_queries.sql

-- Step 6: Create Views
:r .\06_views.sql

-- Step 7: Create Stored Procedures
:r .\07_stored_procedures.sql

-- Step 8: Create Triggers
:r .\08_triggers.sql

/*
=================================================
DATABASE SETUP COMPLETED
=================================================
*/

PRINT 'Final Examination Database Setup Completed Successfully!';
GO