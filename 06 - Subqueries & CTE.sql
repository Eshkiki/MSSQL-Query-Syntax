-- Courses with avg grade > 75
-- 1. How can you list all courses where the average grade of enrolled students is greater than 16?
SELECT *
FROM (SELECT AVG(grade) AS [AVG], courseId FROM courseStudent GROUP BY courseId) cs,
     course c
WHERE c.courseId = cs.courseId
  AND cs.AVG > 16;

-- Nested select examples
-- 2. How can you show the first course along with a count of how many students are enrolled in it?
SELECT TOP 1
  *,
  (SELECT COUNT(*) FROM courseStudent cs WHERE cs.courseId = c.courseId) AS CNT
FROM course c;

-- 3. How can you return the course with the highest number of enrolled students?
SELECT TOP 1 *
FROM course c
ORDER BY (SELECT COUNT(*) FROM courseStudent cs WHERE cs.courseId = c.courseId) DESC;

-- 4. How can you return only those courses that have more than 2 students enrolled?
SELECT *,
       (SELECT COUNT(*) FROM courseStudent cs WHERE cs.courseId = c.courseId) AS CNT
FROM course c
WHERE (SELECT COUNT(*) FROM courseStudent cs WHERE cs.courseId = c.courseId) > 2;

-- CTE
-- 5. How can you use a CTE to calculate the average grade per course, and then list the courses whose average is greater than 16 (75%)?
;WITH csCTE ([avg], courseId) AS
(
  SELECT AVG(grade), courseId
  FROM courseStudent
  GROUP BY courseId
)
SELECT *
FROM csCTE cs
JOIN course c ON c.courseId = cs.courseId
WHERE cs.[avg] > 16;
