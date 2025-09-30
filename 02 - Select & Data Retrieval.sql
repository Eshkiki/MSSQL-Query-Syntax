-- Show all students
-- 1. How can you display all information about every student in the system?
Select * from TStudent;
-- not ideal when dataset is large also you won't need all columns! 



-- Show selected fields
-- 2. How can you list only the student code, first name, and last name (ignoring other details)?
Select Code_st, Fname, Lname from TStudent;
-- note: Seems fine, but columns names are not very user friendly 


-- Calculated columns
-- 3. How can you show each student’s code along with their full name by combining first and last name?
Select Code_st, Fname + ' ' + Lname  from TStudent;


-- Alias examples
-- 4. How can you rename the output columns to user friendly names
Select  
  Code_st as Code,  
  Fname [Name],  
  Lname 'Last Name'
  from TStudent;
--note: different ways to put alias for columns name!  


-- Order By examples
-- 5. How can you sort students by their registration date in ascending or descending order?
Select * from TStudent order by d_reg asc;
Select * from TStudent order by d_reg desc;
Select * from TStudent order by D_reg asc, Lname desc;



-- Order By by column number
-- 6. How can you list students’ full names and sort the result by that column in descending order?
Select Lname + ' ' + Fname  from TStudent order by 1 desc;
-- note: order by 2 is not a good practice, better to be replaced ORDER BY 1 with explicit aliases here we could put alias for the column 
-- 7. What’s the better way to do this using an alias instead of column numbers?
Select Lname + ' ' + Fname as [Full name]  from TStudent order by [Full name] desc;


-- Where with comparison
-- 8. How can you find all students whose education level is “Bachelor”?
Select * from TStudent where education = 'Bachelor';
-- 9. How can you find all students who are 25 years old or younger?
Select * from TStudent where 2025 - bdate <= 25;
-- 10. How can you list students born after the year 2000?
Select * from TStudent where bdate > 2000;

-- Where with OR/AND/NOT
-- 11. How can you get students born in either 2000 or 2001?
Select * from TStudent where (bdate = 2000) or (bdate = 2001);
-- 12. How can you find all students except those born in 2000?
Select * from TStudent where not (bdate = 2000);
-- 13. How can you return students born between 2000 and 2005, using AND conditions?
Select * from TStudent where (bdate >= 2000) and (bdate <= 2005);

-- Between
-- 14. How can you return students born between 2000 and 2005?
Select * from TStudent where bdate between 2000 and 2005;

-- IN
-- 15. How can you return students whose birth year is either 2000, 2001, 2003, or 2006?
Select * from TStudent where BDate in (2000,2001,2003,2006);

-- IN with subquery
-- 16. How can you find all students who have at least one course enrollment with unpaid debt?
Select * from TStudent where Code_st in (Select Code_st from TCourse_Student where debt > 0);

-- Courses for student 1
-- 17. How can you list all courses that student with ID = 1 is enrolled in?
select * from TCourses where code_course in (Select code_course from TCourse_Student where code_st = 1);

-- EXISTS
-- 18. How can you return all courses that currently have at least one student enrolled?
Select * from TCourses c where EXISTS (select * from TCourse_Student cs where c.Code_Course = cs.Code_Course);

-- LIKE
-- 19. How can you list all students whose first name starts with “Ja”?
SELECT * FROM TStudent where Fname like 'Ja%';

-- Top N
-- 20. How can you get the first two students enrolled in course C101?
Select top 2 * from TStudent where code_st in (select code_st from TCourse_Student where code_course = 'C101') order by D_reg asc ;
-- 21. How can you find the student with the second-highest grade in course C101?
Select top 1 * from TCourse_Student where code_course = 'C101' order by grade desc;
-- 22. How can you suggest the next student ID by taking the maximum existing ID and adding 1?
Select top 1 * from TCourse_Student where code_course = 'C101' and  code_st != (Select top 1 code_st from TCourse_Student where code_course = 'C101' order by grade desc) order by grade desc;
-- 23. How can you find the first missing student code in the sequence of IDs?
Select top 1 code_st + 1 from TStudent order by Code_st desc;

Select top 1 code_st + 1 from TStudent where code_st + 1 not in (select Code_st from TStudent);

