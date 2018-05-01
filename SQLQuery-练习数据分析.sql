--创建数据库
create database program_3
go

--使用该数据库
use program_3
go

--删除表格
drop table Sheet1$
go

--修改表格名
sp_rename 'Sheet1$','CET'
go

--查询创建TestGPA临时表（用于导出表格）
select 姓名,学号,班级,品德分,绩点,综测分,绩点排名,综测分排名
into TestGPA
from GPA 
--order by 班级 asc,综测分排名 asc
order by 综测分排名 asc
go

--修改列数据
update TestGPA set 姓名='李绪法' where 姓名='李绪法123'
go

--修改字段名
exec sp_rename 'GPA.序号','班级'
exec sp_rename 'GPA.品德表现评价','品德分'
exec sp_rename 'GPA.学年平均学分绩点','绩点'
exec sp_rename 'GPA.综合测评总分','综测分'
exec sp_rename 'GPA.学业成绩考核排名','绩点排名'
exec sp_rename 'GPA.综合测评总分排名','综测分排名'
go

--导出数据表（无法导出标题行）
EXEC master..xp_cmdshell 'bcp "select 姓名,学号,班级,品德分,绩点,综测分,绩点排名,综测分排名 from program_3.dbo.GPA order by 班级 asc,综测分排名 asc" queryout C:\Users\JoeCooper\Desktop\GPA.xls -c -q -S"DESKTOP-2STVQ4T" -U"joe.cooper" -P"lixufa520"'
go

select * from CET
go

--查询创建TestCET临时表
select 姓名,性别,学号,专业,班级,语言级别,总分 
into TestCET
from CET
--where 语言级别='CET6' and 总分>425
--where 语言级别='CET4' and 总分>425
order by 总分 desc
go

--删除字段（记得字段名称前面+column）
alter table CET
drop column 班级
--drop column 专业
go

--修改字段名
exec sp_rename 'CET.专业名称','专业'
exec sp_rename 'CET.班级名称','班级'
go

--修改列数据
update CET set 班级=1 where 班级='信息计算15(1)'
update CET set 班级=2 where 班级='信息计算15(2)'
update CET set 班级=3 where 班级='信息计算15(3)'
update CET set 班级=4 where 班级='信息计算15(4)'
go

--连接查询：当[需要的结果]从多张表中取时
--连接：join 表名 on 关联条件；内连接：inner join（主外键对应）；左外连接：left outer join；右外连接：right outer join；完全外连接：full outer join
select * 
into TestGPACET
from TestGPA as TG
left join 
(select 姓名1,性别,语言级别,总分 from TestCET) as TC
on TG.姓名=TC.姓名1
go

exec sp_rename 'TestCET.姓名','姓名1'
go

select * from TestGPACET
go

alter table TestGPACET
drop column 性别
go