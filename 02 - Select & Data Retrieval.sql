-- Show all students
-- 1. How can you display all information about every student in the system?
SELECT * FROM student;
-- not ideal when dataset is large also you won't need all columns! 


-- Show selected fields
-- 2. How can you list only the student code, first name, and last name (ignoring other details)?
SELECT studentId, firstName, lastName FROM student;
-- note: Seems fine, but columns names are not very user friendly 


-- Calculated columns
-- 3. How can you show each student’s code along with their full name by combining first and last name?
SELECT studentId, firstName + ' ' + lastName FROM student;


-- Alias examples
-- 4. How can you rename the output columns to user friendly names
SELECT  
  studentId AS Code,  
  firstName AS [Name],  
  lastName  AS [Last Name]
FROM student;
--note: different ways to put alias for columns name!  


-- Order By examples
-- 5. How can you sort students by their registration date in ascending or descending order?
SELECT * FROM student ORDER BY regDate ASC;
SELECT * FROM student ORDER BY regDate DESC;
SELECT * FROM student ORDER BY regDate ASC, lastName DESC;


-- Order By by column number
-- 6. How can you list students’ full names and sort the result by that column in descending order?
SELECT lastName + ' ' + firstName FROM student ORDER BY 1 DESC;
-- note: order by 2 is not a good practice, better to be replaced ORDER BY 1 with explicit aliases here we could put alias for the column 
-- 7. What’s the better way to do this using an alias instead of column numbers?
SELECT lastName + ' ' + firstName AS [Full name] FROM student ORDER BY [Full name] DESC;


-- Where with comparison
-- 8. How can you find all students whose education level is “Bachelor”?
SELECT * FROM student WHERE education = 'Bachelor';
-- 9. How can you find all students who are 25 years old or younger?
SELECT * FROM student WHERE 2025 - birthYear <= 25;
-- 10. How can you list students born after the year 2000?
SELECT * FROM student WHERE birthYear > 2000;

-- Where with OR/AND/NOT
-- 11. How can you get students born in either 2000 or 2001?
SELECT * FROM student WHERE (birthYear = 2000) OR (birthYear = 2001);
-- 12. How can you find all students except those born in 2000?
SELECT * FROM student WHERE NOT (birthYear = 2000);
-- 13. How can you return students born between 2000 and 2005, using AND conditions?
SELECT * FROM student WHERE (birthYear >= 2000) AND (birthYear <= 2005);

-- Between
-- 14. How can you return students born between 2000 and 2005?
SELECT * FROM student WHERE birthYear BETWEEN 2000 AND 2005;

-- IN
-- 15. How can you return students whose birth year is either 2000, 2001, 2003, or 2006?
SELECT * FROM student WHERE birthYear IN (2000,2001,2003,2006);

-- IN with subquery
-- 16. How can you find all students who have at least one course enrollment with unpaid debt?
SELECT * FROM student 
WHERE studentId IN (SELECT studentId FROM courseStudent WHERE debt > 0);

-- Courses for student 1
-- 17. How can you list all courses that student with ID = 1 is enrolled in?
SELECT * FROM course 
WHERE courseId IN (SELECT courseId FROM courseStudent WHERE studentId = 1);

-- EXISTS
-- 18. How can you return all courses that currently have at least one student enrolled?
SELECT * FROM course c 
WHERE EXISTS (SELECT 1 FROM courseStudent cs WHERE c.courseId = cs.courseId);

-- LIKE
-- 19. How can you list all students whose first name starts with “Ja”?
SELECT * FROM student WHERE firstName LIKE 'Ja%';

-- Top N
-- 20. How can you get the first two students enrolled in course C101?
SELECT TOP 2 * 
FROM student 
WHERE studentId IN (SELECT studentId FROM courseStudent WHERE courseId = 'C101') 
ORDER BY regDate ASC;

-- 21. How can you find the student with the second-highest grade in course C101?
SELECT TOP 1 * 
FROM courseStudent 
WHERE courseId = 'C101' 
  AND studentId <> (
    SELECT TOP 1 studentId 
    FROM courseStudent 
    WHERE courseId = 'C101' 
    ORDER BY grade DESC
  )
ORDER BY grade DESC;

-- 22. How can you suggest the next student ID by taking the maximum existing ID and adding 1?
SELECT TOP 1 studentId + 1 FROM student ORDER BY studentId DESC;

-- 23. How can you find the first missing student code in the sequence of IDs?
SELECT TOP 1 studentId + 1 FROM student 
WHERE studentId + 1 NOT IN (SELECT studentId FROM student);
