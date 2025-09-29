-- Subquery in FROM
Select * from (Select * from table1) t;

-- Courses with avg grade > 75
select * from  
(select avg(grade) as 'AVG', Code_Course from TCourse_Student group by Code_Course) cs, TCourses c 
where c.Code_Course = cs.Code_Course and cs.AVG > 75;

-- Nested select examples
Select top 1 * , (select count(*) from TCourse_Student cs 
where cs.Code_Course = c.Code_Course) as CNT from TCourses c;

Select top 1 * from TCourses C 
order by (select count(*) from TCourse_Student CS where cs.Code_Course = c.Code_Course) desc;

Select * ,(select count(*) from TCourse_Student CS where cs.Code_Course = c.Code_Course) as CNT 
from TCourses C 
Where (select count(*) from TCourse_Student CS where cs.Code_Course = c.Code_Course) > 2;
