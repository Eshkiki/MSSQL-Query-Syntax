-- Union
select * from TStudent  
where Code_st in (select code_st from TCourse_Student where code_course = 'C101') 
union  
select * from TStudent  
where Code_st in (select code_st from TCourse_Applicant where code_standard = '13960101');



-- INTERSECT


select * from TStudent  
where Code_st in (select code_st from TCourse_Student where code_course = 'C101') 
intersect 
select * from TStudent  
where Code_st in (select code_st from TCourse_Applicant where code_standard = '13960101');






-- JOIN
SELECT cs.Code_Course, cs.Code_St, s.Code_st, s.Fname, s.Lname, cs.Debt  
from TCourse_Student CS , TStudent S 
where Code_Course = 'C101';



-- INNER JOIN

select * from TCourses c 
inner join TCourse_Student cs on c.Code_Course = cs.Code_Course;
-- note: Only the rows that have matching values in both tables

-- Left join
Select * from TCourse_Student cs left join TCourses c on cs.Code_Course = c.Code_Course 
 where Code_St = '1' 
 -- note: All rows from the left table, and the matched rows from the right table. If no match, NULLs are returned for right table columns.


-- Right join
Select * from  TCourse_Student cs right join TCourses c   
on cs.Code_Course = c.Code_Course 
-- note: All rows from the right table, and the matched rows from the left table. If no match, NULLs are returned for left table columns.


-- Full join
Select * from  TCourse_Student cs full join TCourses c   
on cs.Code_Course = c.Code_Course 
-- note: All rows when there is a match in one of the tables. If there is no match, NULLs are returned for the missing side.



-- Mixed Left and Right Join
Select cs.Code_Course,cs.Debt,c.Code_Standard, cs.Code_St,s.Lname  
from  TCourse_Student cs right join TCourses c  on cs.Code_Course = c.Code_Course 
left join TStudent s on s.Code_st = cs.Code_St 
