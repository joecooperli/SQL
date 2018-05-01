use program_1

select * from Student_table
select * from Class_table

select 学号,姓名,班级,成绩,排名 from Student_table

select * from Student_table as ST join Class_table as CT on ST.班级 = CT.班级

--all 和 any 关键字
--查询出2班中，年龄大于1班所有人的同学
select * from Student_table 
where 班级='2' and 年龄>all(select 年龄 from Student_table where 班级='1' ) 

select * from Student_table 
where 班级='2' and 年龄>(select max(年龄) from Student_table where 班级='1' ) 

--查询出1班中，年龄大于2班任意一个人的同学
select * from Student_table 
where 班级='1' and 年龄>any(select 年龄 from Student_table where 班级='2' ) 

select * from Student_table 
where 班级='1' and 年龄>(select min(年龄) from Student_table where 班级='2' ) 

--exists和not exists关键字
--查询Student_table中成绩大于其他任意一位的同学(也可用any关键字查询)
select 姓名,班级,成绩 from Student_table as st1
where exists (select * from Student_table as st2 where st1.成绩>st2.成绩)

select 姓名,班级,成绩 from Student_table as st1
where 成绩>any(select 成绩 from Student_table)

--查询Student_table中成绩小于其他任意一位的同学(也可用all关键字查询)
select 姓名,班级,成绩 from Student_table as st1
where not exists (select * from Student_table as st2 where st1.成绩>st2.成绩)

select 姓名,班级,成绩 from Student_table as st1
where 成绩<=all(select 成绩 from Student_table)

--用脚本代码创建表格数据
--创建一个数据库名为‘program_2'
create database program_2
go 
--打开数据库 program_2
use program_2
go
--建立student_table
create table student_table
(stu_ID int primary key, stu_name nvarchar(20) unique(stu_name),stu_gender nchar(1) check(stu_gender='男' or stu_gender='女'),stu_age int check(stu_age between 20 and 30),stu_class int default 0)--DEFAULT约束在INSERT INTO语句没有为列指定值的时候提供一个默认值
go
--建立class_table
create table class_table
(c_ID int primary key ,c_name nvarchar(20) unique(c_name),c_amount int not null,c_activity nchar(2) check(c_activity='优秀' or c_activity='良好' or c_activity='一般' or c_activity='差劲'))
go
--建立lesson_table
create table lesson_table
(l_ID int primary key ,l_name nvarchar(20) unique(l_name),l_date date check(l_date between '2018-04-01' and '2018-04-30'),l_teacher nvarchar(10) default ('无'))
go

--修改字段
alter table student_table 
alter column [stu_gender] char(2) not null
go

--添加字段
alter table class_table 
add [l_ID] int null--只能添加允许空值null出现的字段，否则会报错
go

--删除字段
alter table student_table
drop column [stu_score]
go

--删除表格
drop table student_table
go

--查看表格的约束名的sql语句
exec sp_help 'class_table'
go

--删除约束
alter table student_table 
drop constraint DF__student_t__stu_c__2C3393D0--此处填约束名
go

--创建约束
--主键约束
alter table student_table
add constraint PK_stu_ID primary key (stu_ID)
go
--外键约束
alter table class_table 
add constraint FK_l_ID foreign key (l_ID) references lesson_table(l_ID)
go
--唯一约束
alter table student_table 
add constraint IX_stu_name unique (stu_name)
go
--Default约束
alter table student_table 
add constraint DF_l_teacher default ('无') FOR [l_teacher]
go
--Check约束
alter table student_table 
add constraint CK_stu_gender CHECK (stu_gender='男' OR stu_gender='女')
go

--填充数据
--方法一
insert into student_table 
select '6','周六','女','25','1'
  
--方法二
insert into student_table(stu_ID,stu_name,stu_gender,stu_age,c_ID) 
values ('7','梁七','女','26','2') 
 
--修改数据
update class_table set l_ID=5
where c_ID=5
go

--删除目标记录
delete from student_table where stu_ID> 6
go

--修改表格名
sp_rename 'stu_table' ,'student_table'
go

--修改字段名
exec sp_rename 'student_table.stu_class','c_ID','column'
go

select * 
from student_table

select * 
from class_table

select * 
from lesson_table

--SQL Server如何启用xp_cmdshell组件
sp_configure 'show advanced options',1
reconfigure
go
sp_configure 'xp_cmdshell',1
reconfigure
go

--开启Ad Hoc Distributed Queries组件
exec sp_configure 'show advanced options',1
reconfigure
exec sp_configure 'Ad Hoc Distributed Queries',1
reconfigure

USE [program_1]    
GO    
EXEC master.dbo.sp_MSset_oledb_prop N'Microsoft.ACE.OLEDB.12.0', N'AllowInProcess', 1    
GO    
EXEC master.dbo.sp_MSset_oledb_prop N'Microsoft.ACE.OLEDB.12.0', N'DynamicParameters', 1    
GO    

--sqlserver导出excel数据表
--未查询，导出整张表数据
EXEC master..xp_cmdshell 'bcp program_1.dbo.Student_table out C:\Users\JoeCooper\Desktop\学生信息表.xls -c -q -S"DESKTOP-2STVQ4T" -U"joe.cooper" -P"lixufa520"' 
--已查询，导出部分表格数据 
EXEC master..xp_cmdshell 'bcp "select 学号,姓名,班级,成绩,排名 from program_1.dbo.Student_table" queryout C:\Users\JoeCooper\Desktop\学生信息表（查询部分）.xls -c -q -S"DESKTOP-2STVQ4T" -U"joe.cooper" -P"lixufa520"'

--sqlserver导入excel数据表
select convert(int,ID)as ID,NAME,convert(int,CALSS)as CALSS,convert(int,SCORE)as SCORE,convert(int,RANK)as RANK into Test 
FROM OpenDataSource('Microsoft.Jet.OLEDB.4.0','Data Source="C:\Users\JoeCooper\Desktop\测试表.xlsx";User ID=joe.cooper;Password=lixufa520;Extended properties=Excel 8.0').[Sheet1$]

select convert(int,ID)as ID,NAME,convert(int,CALSS)as CALSS,convert(int,SCORE)as SCORE,convert(int,RANK)as RANK into Test 
from OPENROWSET('Microsoft.ACE.OLEDB.12.0'
,'Excel 8.0;HDR=YES;DATABASE=C:\Users\JoeCooper\Desktop\测试表.xls',Sheet1$)
 
 SELECT * 
FROM OpenDataSource( 'Microsoft.ACE.OLEDB.16.0', 
'Data Source="C:\Users\JoeCooper\Desktop\测试表.xls";User ID=joe.cooper;Password=lixufa520;Extended properties=Excel 8.0')...[Sheet1$] 