-- IS NULL
-- 1. How can you list all course enrollments where the student’s grade has not yet been entered?
SELECT * FROM courseStudent WHERE grade IS NULL;

-- LEN
-- 2. How can you see the length of each course’s standard code, and sort courses by that length?
SELECT * FROM course ORDER BY standardCode;
SELECT LEN(standardCode) AS [length], * 
FROM course 
ORDER BY LEN(standardCode), standardCode;

-- LEFT
-- 3. How can you extract just the year part (the first 4 characters) from the student’s registration date?
SELECT *, LEFT(regDate,4) AS [year] FROM student;
-- note: this is just for demonstrating functions, no need to consider the date as a string

-- RIGHT
-- 4. How can you find all students whose registration day (the last 2 characters of the date) is “01”?
SELECT *, RIGHT(regDate,2) AS [day] 
FROM student 
WHERE RIGHT(regDate,2) = '01';
-- note: this is just for demonstrating functions, no need to consider the date as a string

-- SUBSTRING
-- 5. How can you split a student’s registration date string into year, month, and day, and then return only students registered before July?
SELECT *, 
  SUBSTRING(regDate,1,4) AS [year],
  SUBSTRING(regDate,6,2) AS [month],
  SUBSTRING(regDate,9,2) AS [day]
FROM student 
WHERE SUBSTRING(regDate,6,2) < '07';
-- note: this is just for demonstrating functions, no need to consider the date as a string

-- REPLACE
-- 6. How can you display each student’s first and last name, and replace the numeric gender values (1 and 0) with “Male” and “Female”?
SELECT firstName, lastName, REPLACE(REPLACE(CAST(gender AS NVARCHAR(10)),'1','Male'),'0','Female') 
FROM student;
-- note: for simplicity we did not consider other Genders!

-- REVERSE
-- 7. How can you show the registration date reversed, and also extract the last two digits by reversing and trimming the string?
SELECT *, 
  REVERSE(regDate)                          AS [1],
  LEFT(REVERSE(regDate),2)                  AS [2],
  REVERSE(LEFT(REVERSE(regDate),2))         AS [3]
FROM student;
