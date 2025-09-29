-- Case when
select *, Case gender when 1 then ' Male' when 0 then 'Female' else 'Other' end as [Gender] from TStudent 


select *, 
	case  
	when grade >= 16 then 'A'  
	when grade >= 15 then 'B' 
	else 'C' 
	end 
 from TCourse_Student  

 


-- If
if (Select count(Code_Course) from TCourse_Student where Code_Course ='C91') > 0 
Begin 
	Select * from TCourse_Student where Code_Course ='C101' 
end 
Else 
	Select 'No Student' as 'Notification' 
 

-- Variables
Declare @Code_Course varchar(10) ; 
set  @Code_Course = (select top 1 code_course from TCourses where Code_Standard = '13960101') 
Select * from TCourse_Student where Code_Course = @Code_Course 



Declare @Code_Course varchar(10) ; 
select top 1  @Code_Course= code_course from TCourses where Code_Standard = '13960101' 
Select * from TCourse_Student where Code_Course = @Code_Course 


-- System Variables
-- sql version
SELECT @@VERSION;    
-- active transaction
SELECT @@TRANCOUNT;  
-- row count
SELECT @@ROWCOUNT;      
-- last insrted identity
SELECT @@IDENTITY;       

Insert into dbo.TTeacher Select 'Ben', 'KullumnBerg', '2012-09-09', 'Python', 'B.Kull@example.com', '077111111111', 'London Kings way' 
Select @@IDENTITY as [code_techer]
