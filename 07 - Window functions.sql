-- row number
select row_number() over(order by education) row,* from TStudent order by education 

select row_number() OVER(PARTITION BY education ORDER BY education)row,* from TStudent order by education 

-- Rank

select rank() OVER(ORDER BY grade desc) ,* from TCourse_Student cs left join tstudent s on cs.code_st = s.code_st 


select rank() OVER(partition by code_course ORDER BY grade desc) ,* from TCourse_Student cs left join tstudent s on cs.code_st = s.code_st 

-- dense rank
select dense_rank() OVER( ORDER BY grade desc) ,* from TCourse_Student cs left join tstudent s on cs.code_st = s.code_st 



-- 
select  Code_Course,count(*) 'count',avg(grade) 'avg',max(grade) 'max' from TCourse_Student group by Code_Course order by 2 desc 


