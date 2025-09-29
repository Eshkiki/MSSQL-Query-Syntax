-- IS NULL
SELECT * FROM TCourse_Student where grade is null;

-- LEN
SELECT * FROM TCourses order by code_standard;
SELECT len(code_standard) as 'length', * FROM TCourses 
order by len(code_standard), code_standard;

-- LEFT
Select *, left(D_reg,4) as 'year' from TStudent;
-- note: this is just for demonstrating functions, no need to consider the date as a string


-- RIGHT
Select *, right(D_reg,2) as 'day' from TStudent 
where right(D_reg,2) = '01';
-- note: this is just for demonstrating functions, no need to consider the date as a string

-- SUBSTRING
Select *, Substring(D_reg,1,4) as 'year',
          Substring(D_reg,6,2) as 'month',
          Substring(D_reg,9,2) as 'day'
from TStudent where Substring(D_reg,6,2) < '07';
-- note: this is just for demonstrating functions, no need to consider the date as a string


-- REPLACE
Select Fname,Lname,Replace(REPLACE(Gender,'1','Male'),'0','Female') from TStudent;
-- note: for simplicity we did not consider other Genders!


-- REVERSE
Select *, REVERSE(d_reg) '1',
           LEFT(REVERSE(d_reg),2) '2',
           reverse(LEFT(REVERSE(d_reg),2)) '3' 
from TStudent;



 