-- IS NULL
-- 1. How can you list all course enrollments where the student’s grade has not yet been entered?
SELECT * FROM TCourse_Student where grade is null;

-- LEN
-- 2. How can you see the length of each course’s standard code, and sort courses by that length?
SELECT * FROM TCourses order by code_standard;
SELECT len(code_standard) as 'length', * FROM TCourses order by len(code_standard), code_standard;

-- LEFT
-- 3. How can you extract just the year part (the first 4 characters) from the student’s registration date?
Select *, left(D_reg,4) as 'year' from TStudent;
-- note: this is just for demonstrating functions, no need to consider the date as a string


-- RIGHT
-- 4. How can you find all students whose registration day (the last 2 characters of the date) is “01”?
Select *, right(D_reg,2) as 'day' from TStudent where right(D_reg,2) = '01';
-- note: this is just for demonstrating functions, no need to consider the date as a string

-- SUBSTRING
-- 5. How can you split a student’s registration date string into year, month, and day, and then return only students registered before July?
Select *, Substring(D_reg,1,4) as 'year',Substring(D_reg,6,2) as 'month',Substring(D_reg,9,2) as 'day' from TStudent where Substring(D_reg,6,2) < '07';
-- note: this is just for demonstrating functions, no need to consider the date as a string


-- REPLACE
-- 6. How can you display each student’s first and last name, and replace the numeric gender values (1 and 0) with “Male” and “Female”?
Select Fname,Lname,Replace(REPLACE(Gender,'1','Male'),'0','Female') from TStudent;
-- note: for simplicity we did not consider other Genders!


-- REVERSE
-- 7. How can you show the registration date reversed, and also extract the last two digits by reversing and trimming the string?
Select *, REVERSE(d_reg) '1', LEFT(REVERSE(d_reg),2) '2', reverse(LEFT(REVERSE(d_reg),2)) '3' from TStudent;



 