
-- Join with filter
-- 1. How can you list all courses (code, standard, description) and grades for students with the last name “Smith”?
Select Cs.Code_Course,TCourses.Code_Standard,TCourses.[Descriptions] ,Grade  from TCourse_Student CS,TStudent S,TCourses where Cs.Code_St = S.Code_st and cs.Code_Course = TCourses.Code_Course  and Lname = 'Smith' 

-- 2. How can you find all students who are enrolled in course C101?
select * from TStudent  where Code_st in (select code_st from tcourse_student where code_course = 'C101') 



 


-- Union
-- 3. How can you combine (without duplicates) the list of students enrolled in course C101 with the list of students who have an “Accepted” application?
select * from TStudent where Code_st in (select code_st from TCourse_Student where code_course = 'C101') 
union  
select * from TStudent  where Code_st in (select code_st from TCourse_Applicant where [status] = 'Accepted');



-- INTERSECT
-- 4. How can you return only those students who are both enrolled in course C101 and have an “Accepted” application?
select * from TStudent  where Code_st in (select code_st from TCourse_Student where code_course = 'C101') 
intersect 
select * from TStudent  where Code_st in (select code_st from TCourse_Applicant where [status] = 'Accepted');






-- JOIN
-- 5. How can you list students’ codes, names, and debt values for those enrolled in course C101 using a join between students and course enrollments?
SELECT cs.Code_Course, cs.Code_St, s.Code_st, s.Fname, s.Lname, cs.Debt  from TCourse_Student CS , TStudent S where Code_Course = 'C101';



-- INNER JOIN
-- 6. How can you return all courses along with their enrollments, but only when there’s a match in both tables?
select * from TCourses c inner join TCourse_Student cs on c.Code_Course = cs.Code_Course;
-- note: Only the rows that have matching values in both tables

-- Left join
-- 7. How can you return all enrollments for student with ID = 1, and show course details if they exist (otherwise return NULL)?
Select * from TCourse_Student cs left join TCourses c on cs.Code_Course = c.Code_Course where Code_St = '1' 
 -- note: All rows from the left table, and the matched rows from the right table. If no match, NULLs are returned for right table columns.


-- Right join
-- 8. How can you return all courses, along with any enrollments they may have (showing NULL where a course has no students)?
Select * from  TCourse_Student cs right join TCourses c on cs.Code_Course = c.Code_Course 
-- note: All rows from the right table, and the matched rows from the left table. If no match, NULLs are returned for left table columns.


-- Full join
-- 9. How can you return all rows from both courses and enrollments, including cases where there is no match on either side?
Select * from  TCourse_Student cs full join TCourses c   
on cs.Code_Course = c.Code_Course 
-- note: All rows when there is a match in one of the tables. If there is no match, NULLs are returned for the missing side.



-- Mixed Left and Right Join
-- 10. How can you list each course (code and standard) together with student last names and debt values, even if a course has no enrollments or a student has no course details?
Select cs.Code_Course,cs.Debt,c.Code_Standard, cs.Code_St,s.Lname  
from  TCourse_Student cs right join TCourses c  on cs.Code_Course = c.Code_Course 
left join TStudent s on s.Code_st = cs.Code_St 
