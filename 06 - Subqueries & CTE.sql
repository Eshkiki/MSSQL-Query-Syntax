 
-- Courses with avg grade > 75
-- 1. How can you list all courses where the average grade of enrolled students is greater than 16?
select * from  (select avg(grade) as 'AVG', Code_Course from TCourse_Student group by Code_Course) cs, TCourses c 
where c.Code_Course = cs.Code_Course and cs.AVG > 16;

-- Nested select examples
-- 2. How can you show the first course along with a count of how many students are enrolled in it?
Select top 1 * , (select count(*) from TCourse_Student cs where cs.Code_Course = c.Code_Course) as CNT from TCourses c;

-- 3. How can you return the course with the highest number of enrolled students?
Select top 1 * from TCourses C order by (select count(*) from TCourse_Student CS where cs.Code_Course = c.Code_Course) desc;

-- 4. How can you return only those courses that have more than 2 students enrolled?
Select * ,(select count(*) from TCourse_Student CS where cs.Code_Course = c.Code_Course) as CNT 
from TCourses C 
Where (select count(*) from TCourse_Student CS where cs.Code_Course = c.Code_Course) > 2;


-- CTE
-- 5. How can you use a CTE to calculate the average grade per course, and then list the courses whose average is greater than 16 (75%)?
;With CS ([Avg],Code_Course)  
As (select avg(grade) , Code_Course  from TCourse_Student group by Code_Course) 
Select * from CS, TCourses c  
where c.Code_Course = cs.Code_Course and cs.Avg > 16 
