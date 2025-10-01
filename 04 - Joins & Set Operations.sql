-- Join with filter
-- 1. How can you list all courses (code, standard, description) and grades for students with the last name “Smith”?
SELECT cs.courseId, c.standardCode, c.[description], cs.grade
FROM courseStudent cs
JOIN student s   ON cs.studentId = s.studentId
JOIN course  c   ON cs.courseId  = c.courseId
WHERE s.lastName = 'Smith';

-- 2. How can you find all students who are enrolled in course C101?
SELECT * 
FROM student  
WHERE studentId IN (SELECT studentId FROM courseStudent WHERE courseId = 'C101');


-- Union
-- 3. How can you combine (without duplicates) the list of students enrolled in course C101 with the list of students who have an “Accepted” application?
-- (Applicants don’t have studentIds; we project comparable columns)
SELECT s.firstName, s.lastName
FROM student s
WHERE s.studentId IN (SELECT studentId FROM courseStudent WHERE courseId = 'C101')
UNION
SELECT a.firstName, a.lastName
FROM courseApplicant a
WHERE a.[status] = 'Accepted';

-- INTERSECT
-- 4. How can you return only those people who are both enrolled in course C101 and have an “Accepted” application (matched by name)?
SELECT s.firstName, s.lastName
FROM student s
WHERE s.studentId IN (SELECT studentId FROM courseStudent WHERE courseId = 'C101')
INTERSECT
SELECT a.firstName, a.lastName
FROM courseApplicant a
WHERE a.[status] = 'Accepted';


-- JOIN
-- 5. How can you list students’ codes, names, and debt values for those enrolled in course C101 using a join between students and course enrollments?
SELECT cs.courseId, cs.studentId, s.studentId AS stuId, s.firstName, s.lastName, cs.debt
FROM courseStudent cs 
JOIN student s ON s.studentId = cs.studentId
WHERE cs.courseId = 'C101';


-- INNER JOIN
-- 6. How can you return all courses along with their enrollments, but only when there’s a match in both tables?
SELECT * 
FROM course c 
INNER JOIN courseStudent cs ON c.courseId = cs.courseId;
-- note: Only the rows that have matching values in both tables

-- Left join
-- 7. How can you return all enrollments for student with ID = 1, and show course details if they exist (otherwise return NULL)?
SELECT * 
FROM courseStudent cs 
LEFT JOIN course c ON cs.courseId = c.courseId 
WHERE cs.studentId = 1;
-- note: All rows from the left table, and the matched rows from the right table. If no match, NULLs are returned for right table columns.

-- Right join
-- 8. How can you return all courses, along with any enrollments they may have (showing NULL where a course has no students)?
SELECT * 
FROM courseStudent cs 
RIGHT JOIN course c ON cs.courseId = c.courseId;
-- note: All rows from the right table, and the matched rows from the left table. If no match, NULLs are returned for left table columns.

-- Full join
-- 9. How can you return all rows from both courses and enrollments, including cases where there is no match on either side?
SELECT * 
FROM courseStudent cs 
FULL JOIN course c ON cs.courseId = c.courseId;
-- note: All rows when there is a match in one of the tables. If there is no match, NULLs are returned for the missing side.

-- Mixed Left and Right Join
-- 10. How can you list each course (code and standard) together with student last names and debt values, even if a course has no enrollments or a student has no course details?
SELECT cs.courseId, cs.debt, c.standardCode, cs.studentId, s.lastName
FROM courseStudent cs 
RIGHT JOIN course  c ON cs.courseId  = c.courseId 
LEFT  JOIN student s ON s.studentId  = cs.studentId;
