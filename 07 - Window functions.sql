-- row number
-- 1. How can you assign a unique sequential number to each student, ordered by their education level?
SELECT ROW_NUMBER() OVER (ORDER BY education) AS rowNum, *
FROM student
ORDER BY education;

-- 2. How can you assign row numbers starting at 1 for each group of students with the same education level?
SELECT ROW_NUMBER() OVER (PARTITION BY education ORDER BY education) AS rowNum, *
FROM student
ORDER BY education;

-- Rank
-- 3. How can you rank all students by their grade in descending order (highest grade = rank 1)?
SELECT RANK() OVER (ORDER BY cs.grade DESC) AS rnk, *
FROM courseStudent cs
LEFT JOIN student s ON cs.studentId = s.studentId;

-- 4. How can you rank students within each course separately, based on their grade?
SELECT RANK() OVER (PARTITION BY cs.courseId ORDER BY cs.grade DESC) AS rnk, *
FROM courseStudent cs
LEFT JOIN student s ON cs.studentId = s.studentId;

-- Dense rank
-- 5. How can you rank students by grade so that ties receive the same rank and the next rank is not skipped?
SELECT DENSE_RANK() OVER (ORDER BY cs.grade DESC) AS denseRnk, *
FROM courseStudent cs
LEFT JOIN student s ON cs.studentId = s.studentId;

-- Aggregate with GROUP BY
-- 6. How can you show, for each course, the number of students enrolled, the average grade, and the maximum grade, ordered by enrollment count in descending order?
SELECT
  courseId,
  COUNT(*)     AS [count],
  AVG(grade)   AS [avg],
  MAX(grade)   AS [max]
FROM courseStudent
GROUP BY courseId
ORDER BY [count] DESC;
