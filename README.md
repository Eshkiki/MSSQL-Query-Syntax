#  SQL Learning Exercises

This repository contains a series of **SQL scripts** designed to teach database concepts step by step — from creating a dataset to working with advanced queries and functions.

![Database Schema](https://github.com/Eshkiki/MSSQL-Query-Syntax/blob/69535c58d8da7cdea5eac4139ad5faed7556f73e/Diagram.png)

##  Repository Structure

### **01 - CreateDataset.sql**
- Creates the base schema:
  - `TStudent`, `TCourses`, `TCourse_Student`, `TCourse_Applicant`, `TTeacher`, `TCity`
- Adds indexes for performance
- Inserts sample data 

### **02 - Select & Data Retrieval.sql**
- Basic `SELECT` statements
- Filtering with `WHERE`, `IN`, `BETWEEN`, `LIKE`
- Ordering results with `ORDER BY`
- Limiting rows with `TOP`
- Subqueries for filtering

### **03 - Built-in Functions.sql**
- Working with string/date functions: `LEN`, `LEFT`, `RIGHT`, `SUBSTRING`, `REPLACE`, `REVERSE`
- Handling `NULL` values with `IS NULL`
- Notes on correct vs. demo usage (string dates vs. real dates)

### **04 - Joins & Set Operations.sql**
- Set operations: `UNION`, `INTERSECT`
- Joins: `INNER JOIN`, `LEFT JOIN`, `RIGHT JOIN`, `FULL JOIN`
- Examples of combining multiple joins in one query

### **05 - Advanced Functions.sql**
- Aggregate functions: `COUNT`, `SUM`, `AVG`, `MIN`, `MAX`
- `GROUP BY` and `HAVING`
- Using `OVER (PARTITION BY …)` for aggregated columns

### **06 - Subqueries & CTE.sql**
- Nested `SELECT` queries
- Counting related rows in subqueries
- `CTE` (Common Table Expressions) for cleaner queries

### **07 - Window Functions.sql**
- `ROW_NUMBER()`, `RANK()`, `DENSE_RANK()`
- Partitioning by groups (e.g., per course or education level)

### **08 - Variables & Conditions.sql**
- Using variables in T-SQL with `DECLARE` and `SET`
- Conditional logic with `CASE`
- Control flow with `IF … ELSE`
- Built-in system variables (`@@VERSION`, `@@ROWCOUNT`, etc.)
