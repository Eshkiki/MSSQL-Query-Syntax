-- Show all students
Select * from TStudent;
-- not ideal when dataset is large also you won't need all columns! 



-- Show selected fields
Select Code_st, Fname, Lname from TStudent;
-- note: Seems fine, but columns names are not very user friendly 


-- Calculated columns
Select Code_st, Fname + ' ' + Lname  from TStudent;


-- Alias examples
Select  
  Code_st as Code,  
  Fname [Name],  
  Lname 'Last Name'
  from TStudent;
--note: different ways to put alias for columns name!  

-- Order By examples
Select * from TStudent order by d_reg asc;
Select * from TStudent order by d_reg desc;
Select * from TStudent order by D_reg asc, Lname desc;


-- Order By by column number
Select Lname + ' ' + Fname  from TStudent order by 1 desc;
-- note: order by 2 is not a good practice, better to be replaced ORDER BY 1 with explicit aliases
-- here we could put alias for the column  

Select Lname + ' ' + Fname as [Full name]  from TStudent order by [Full name] desc;


-- Where with comparison
Select * from TStudent where education = 'Bachelor';
Select * from TStudent where 2025 - bdate <= 25;
Select * from TStudent where bdate > 2000;

-- Where with OR/AND/NOT
Select * from TStudent where (bdate = 2000) or (bdate = 2001);
Select * from TStudent where not (bdate = 2000);
Select * from TStudent where (bdate >= 2000) and (bdate <= 2005);

-- Between
Select * from TStudent where bdate between 2000 and 2005;

-- IN
Select * from TStudent where BDate in (2000,2001,2003,2006);

-- IN with subquery
Select * from TStudent 
where Code_st in (Select Code_st from TCourse_Student where debt > 0);

-- Courses for student 1
select * from TCourses  
where code_course in (Select code_course from TCourse_Student where code_st = 1);

-- EXISTS
Select * from TCourses c 
where EXISTS (select * from TCourse_Student cs where c.Code_Course = cs.Code_Course);

-- LIKE
SELECT * FROM TStudent where Fname like 'Ja%';

-- Top N
Select top 2 * from TStudent where code_st in 
  (select code_st from TCourse_Student where code_course = 'C101');

Select top 1 * from TCourse_Student 
where code_course = 'C101' order by grade desc;

Select top 1 * from TCourse_Student 
where code_course = 'C101' and  
code_st != (Select top 1 code_st from TCourse_Student 
             where code_course = 'C101' order by grade desc) 
order by grade desc;

Select top 1 code_st + 1 from TStudent order by Code_st desc;

Select top 1 code_st + 1 from TStudent 
where code_st + 1 not in (select Code_st from TStudent);

