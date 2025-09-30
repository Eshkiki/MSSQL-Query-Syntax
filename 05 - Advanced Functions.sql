
-- Count
-- 1. How can you count the total number of rows in the student table, and also count how many students have a non-null last name?
Select count(*) [count *] , count(lname) as [count a column] from TStudent;
--2. How can you count how many enrollments exist for course C101?
Select Count(*) as [count] from TCourse_Student where Code_Course = 'C101';


-- min
-- 3. How can you find the lowest grade received by student with ID = 1?
Select min(grade) from TCourse_Student where Code_St = '1'


-- Minimum number for a student
-- 4. How can you return the course(s) where student 1 received their minimum grade?
Select * from TCourses where Code_Course in  ( select Code_Course from TCourse_Student  where Grade = (select min(grade) from TCourse_Student where Code_St = '1') ) 


-- SUM 
-- 5. How can you calculate the total debt across all course enrollments?
Select sum(debt) from TCourse_Student 


-- Average
-- 6. How can you find the average grade for students in course C101?
Select avg(Grade) from TCourse_Student where Code_Course='C101' 
-- 7. How can you display each enrollment in course C101 and show the difference between that student’s grade and the overall average grade?
Select * , (select cs1.Grade- AVG(grade) from TCourse_Student )  as 'diff'  from TCourse_Student cs1 where Code_Course= 'C101' 
-- 8. How can you list each course along with the average grade of its enrolled students?
select *,(select avg(grade) from tcourse_student cs where cs.Code_Course = c.Code_Course) from TCourses c 
-- 9. How can you show each student’s enrollments along with their personal average grade across all courses?
Select  * ,avg(Grade) over(partition by Code_St) as 'avg' from TCourse_Student order by Code_St 
-- 10. How can you display each enrollment’s grade together with the overall average grade, and the deviation from it?
Select  * ,Grade - avg(Grade) over() 'Deviation' ,avg(Grade) over() 'Avg_Grade' from TCourse_Student 

 


-- Group by
-- 11. How can you group enrollments by course, and show the count, average grade, and maximum grade for each course (only when more than 1 enrollment exists)?
Select Code_Course, count(*), avg(grade), max(grade) from TCourse_Student group by Code_Course having count(*) > 1;


-- Group By + Having
-- 12. How can you return the number of enrollments, average grade, and maximum grade per course, only for courses with more than 1 student, sorted by count in descending order?
Select Code_Course, count(*) 'count', avg(grade) 'avg', max(grade) 'max' from TCourse_Student 
group by Code_Course 
having count(*) > 1 
order by 'count' desc;


-- over
-- 13. How can you list all enrollments, and for each course also show the average grade of that course using a window function?
Select  *,avg(Grade) OVER (partition  by Code_Course) as 'Average' from TCourse_Student order by Code_Course 



 