
-- Count
Select count(*) [count *] , count(lname) as [count a column] from TStudent;
Select Count(*) as [count] from TCourse_Student where Code_Course = 'C101';


-- min
Select min(grade) from TCourse_Student where Code_St = '1'


-- Minimum number for a student

Select * from TCourses 
where Code_Course in  ( select Code_Course from TCourse_Student  where Grade = (select min(grade) from TCourse_Student where Code_St = '1') ) 


-- sum 
Select sum(debt) from TCourse_Student 


-- Average
Select avg(Grade) from TCourse_Student 
where Code_Course='C101' 


Select * , (select cs1.Grade- AVG(grade) from TCourse_Student )  as 'diff'  
from TCourse_Student cs1 where Code_Course= 'C101' 


select *,(select avg(grade) from tcourse_student cs where cs.Code_Course = c.Code_Course) from TCourses c 


Select  * ,avg(Grade) over(partition by Code_St) as 'avg' from TCourse_Student order by Code_St 

Select  * ,Grade - avg(Grade) over() 'Deviation' ,avg(Grade) over() 'Avg_Grade' from TCourse_Student 

 


-- Group by
Select Code_Course, count(*), avg(grade), max(grade) 
from TCourse_Student group by Code_Course having count(*) > 1;





-- Group By + Having
Select Code_Course, count(*) 'count', avg(grade) 'avg', max(grade) 'max' 
from TCourse_Student 
group by Code_Course 
having count(*) > 1 
order by 'count' desc;


-- over
Select  *,avg(Grade) OVER (partition  by Code_Course) as 'Average' from TCourse_Student 
order by Code_Course 


-- 


 