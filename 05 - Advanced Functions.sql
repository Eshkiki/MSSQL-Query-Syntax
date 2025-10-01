-- Count
-- 1. How can you count the total number of rows in the student table, and also count how many students have a non-null last name?
SELECT COUNT(*) AS [count *], COUNT(lastName) AS [count a column] FROM student;
--2. How can you count how many enrollments exist for course C101?
SELECT COUNT(*) AS [count] FROM courseStudent WHERE courseId = 'C101';


-- min
-- 3. How can you find the lowest grade received by student with ID = 1?
SELECT MIN(grade) FROM courseStudent WHERE studentId = 1;


-- Minimum number for a student
-- 4. How can you return the course(s) where student 1 received their minimum grade?
SELECT * 
FROM course 
WHERE courseId IN (
  SELECT courseId 
  FROM courseStudent  
  WHERE grade = (SELECT MIN(grade) FROM courseStudent WHERE studentId = 1)
);


-- SUM 
-- 5. How can you calculate the total debt across all course enrollments?
SELECT SUM(debt) FROM courseStudent;


-- Average
-- 6. How can you find the average grade for students in course C101?
SELECT AVG(grade) FROM courseStudent WHERE courseId = 'C101';

-- 7. How can you display each enrollment in course C101 and show the difference between that student’s grade and the overall average grade?
SELECT *, (SELECT cs1.grade - AVG(grade) FROM courseStudent) AS [diff]
FROM courseStudent cs1 
WHERE courseId = 'C101';

-- 8. How can you list each course along with the average grade of its enrolled students?
SELECT *, (SELECT AVG(grade) FROM courseStudent cs WHERE cs.courseId = c.courseId) AS avgGrade
FROM course c;

-- 9. How can you show each student’s enrollments along with their personal average grade across all courses?
SELECT *, AVG(grade) OVER (PARTITION BY studentId) AS [avg]
FROM courseStudent 
ORDER BY studentId;

-- 10. How can you display each enrollment’s grade together with the overall average grade, and the deviation from it?
SELECT *, grade - AVG(grade) OVER () AS Deviation, AVG(grade) OVER () AS Avg_Grade
FROM courseStudent;


-- Group by
-- 11. How can you group enrollments by course, and show the count, average grade, and maximum grade for each course (only when more than 1 enrollment exists)?
SELECT courseId, COUNT(*) AS cnt, AVG(grade) AS avgGrade, MAX(grade) AS maxGrade
FROM courseStudent 
GROUP BY courseId 
HAVING COUNT(*) > 1;

-- Group By + Having
-- 12. How can you return the number of enrollments, average grade, and maximum grade per course, only for courses with more than 1 student, sorted by count in descending order?
SELECT courseId, COUNT(*) AS [count], AVG(grade) AS [avg], MAX(grade) AS [max]
FROM courseStudent 
GROUP BY courseId 
HAVING COUNT(*) > 1 
ORDER BY [count] DESC;

-- over
-- 13. How can you list all enrollments, and for each course also show the average grade of that course using a window function?
SELECT *, AVG(grade) OVER (PARTITION BY courseId) AS [Average]
FROM courseStudent 
ORDER BY courseId;
