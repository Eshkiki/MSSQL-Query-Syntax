-- row number
-- 1. How can you assign a unique sequential number to each student, ordered by their education level?
select row_number() over(order by education) row,* from TStudent order by education 
-- 2. How can you assign row numbers starting at 1 for each group of students with the same education level?
select row_number() OVER(PARTITION BY education ORDER BY education)row,* from TStudent order by education 

-- Rank
-- 3. How can you rank all students by their grade in descending order (highest grade = rank 1)?
select rank() OVER(ORDER BY grade desc) ,* from TCourse_Student cs left join tstudent s on cs.code_st = s.code_st 
-- 4. How can you rank students within each course separately, based on their grade?
select rank() OVER(partition by code_course ORDER BY grade desc) ,* from TCourse_Student cs left join tstudent s on cs.code_st = s.code_st 

-- Dense rank
-- 5. How can you rank students by grade so that ties receive the same rank and the next rank is not skipped?
select dense_rank() OVER( ORDER BY grade desc) ,* from TCourse_Student cs left join tstudent s on cs.code_st = s.code_st 



-- Aggregate with GROUP BY
-- 6. How can you show, for each course, the number of students enrolled, the average grade, and the maximum grade, ordered by enrollment count in descending order?
select  Code_Course,count(*) 'count',avg(grade) 'avg',max(grade) 'max' from TCourse_Student 
group by Code_Course 
order by 2 desc 


