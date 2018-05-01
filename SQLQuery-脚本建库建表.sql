use program_1

select * from Student_table
select * from Class_table

select ѧ��,����,�༶,�ɼ�,���� from Student_table

select * from Student_table as ST join Class_table as CT on ST.�༶ = CT.�༶

--all �� any �ؼ���
--��ѯ��2���У��������1�������˵�ͬѧ
select * from Student_table 
where �༶='2' and ����>all(select ���� from Student_table where �༶='1' ) 

select * from Student_table 
where �༶='2' and ����>(select max(����) from Student_table where �༶='1' ) 

--��ѯ��1���У��������2������һ���˵�ͬѧ
select * from Student_table 
where �༶='1' and ����>any(select ���� from Student_table where �༶='2' ) 

select * from Student_table 
where �༶='1' and ����>(select min(����) from Student_table where �༶='2' ) 

--exists��not exists�ؼ���
--��ѯStudent_table�гɼ�������������һλ��ͬѧ(Ҳ����any�ؼ��ֲ�ѯ)
select ����,�༶,�ɼ� from Student_table as st1
where exists (select * from Student_table as st2 where st1.�ɼ�>st2.�ɼ�)

select ����,�༶,�ɼ� from Student_table as st1
where �ɼ�>any(select �ɼ� from Student_table)

--��ѯStudent_table�гɼ�С����������һλ��ͬѧ(Ҳ����all�ؼ��ֲ�ѯ)
select ����,�༶,�ɼ� from Student_table as st1
where not exists (select * from Student_table as st2 where st1.�ɼ�>st2.�ɼ�)

select ����,�༶,�ɼ� from Student_table as st1
where �ɼ�<=all(select �ɼ� from Student_table)

--�ýű����봴���������
--����һ�����ݿ���Ϊ��program_2'
create database program_2
go 
--�����ݿ� program_2
use program_2
go
--����student_table
create table student_table
(stu_ID int primary key, stu_name nvarchar(20) unique(stu_name),stu_gender nchar(1) check(stu_gender='��' or stu_gender='Ů'),stu_age int check(stu_age between 20 and 30),stu_class int default 0)--DEFAULTԼ����INSERT INTO���û��Ϊ��ָ��ֵ��ʱ���ṩһ��Ĭ��ֵ
go
--����class_table
create table class_table
(c_ID int primary key ,c_name nvarchar(20) unique(c_name),c_amount int not null,c_activity nchar(2) check(c_activity='����' or c_activity='����' or c_activity='һ��' or c_activity='�'))
go
--����lesson_table
create table lesson_table
(l_ID int primary key ,l_name nvarchar(20) unique(l_name),l_date date check(l_date between '2018-04-01' and '2018-04-30'),l_teacher nvarchar(10) default ('��'))
go

--�޸��ֶ�
alter table student_table 
alter column [stu_gender] char(2) not null
go

--����ֶ�
alter table class_table 
add [l_ID] int null--ֻ����������ֵnull���ֵ��ֶΣ�����ᱨ��
go

--ɾ���ֶ�
alter table student_table
drop column [stu_score]
go

--ɾ�����
drop table student_table
go

--�鿴����Լ������sql���
exec sp_help 'class_table'
go

--ɾ��Լ��
alter table student_table 
drop constraint DF__student_t__stu_c__2C3393D0--�˴���Լ����
go

--����Լ��
--����Լ��
alter table student_table
add constraint PK_stu_ID primary key (stu_ID)
go
--���Լ��
alter table class_table 
add constraint FK_l_ID foreign key (l_ID) references lesson_table(l_ID)
go
--ΨһԼ��
alter table student_table 
add constraint IX_stu_name unique (stu_name)
go
--DefaultԼ��
alter table student_table 
add constraint DF_l_teacher default ('��') FOR [l_teacher]
go
--CheckԼ��
alter table student_table 
add constraint CK_stu_gender CHECK (stu_gender='��' OR stu_gender='Ů')
go

--�������
--����һ
insert into student_table 
select '6','����','Ů','25','1'
  
--������
insert into student_table(stu_ID,stu_name,stu_gender,stu_age,c_ID) 
values ('7','����','Ů','26','2') 
 
--�޸�����
update class_table set l_ID=5
where c_ID=5
go

--ɾ��Ŀ���¼
delete from student_table where stu_ID> 6
go

--�޸ı����
sp_rename 'stu_table' ,'student_table'
go

--�޸��ֶ���
exec sp_rename 'student_table.stu_class','c_ID','column'
go

select * 
from student_table

select * 
from class_table

select * 
from lesson_table

--SQL Server�������xp_cmdshell���
sp_configure 'show advanced options',1
reconfigure
go
sp_configure 'xp_cmdshell',1
reconfigure
go

--����Ad Hoc Distributed Queries���
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

--sqlserver����excel���ݱ�
--δ��ѯ���������ű�����
EXEC master..xp_cmdshell 'bcp program_1.dbo.Student_table out C:\Users\JoeCooper\Desktop\ѧ����Ϣ��.xls -c -q -S"DESKTOP-2STVQ4T" -U"joe.cooper" -P"lixufa520"' 
--�Ѳ�ѯ���������ֱ������ 
EXEC master..xp_cmdshell 'bcp "select ѧ��,����,�༶,�ɼ�,���� from program_1.dbo.Student_table" queryout C:\Users\JoeCooper\Desktop\ѧ����Ϣ����ѯ���֣�.xls -c -q -S"DESKTOP-2STVQ4T" -U"joe.cooper" -P"lixufa520"'

--sqlserver����excel���ݱ�
select convert(int,ID)as ID,NAME,convert(int,CALSS)as CALSS,convert(int,SCORE)as SCORE,convert(int,RANK)as RANK into Test 
FROM OpenDataSource('Microsoft.Jet.OLEDB.4.0','Data Source="C:\Users\JoeCooper\Desktop\���Ա�.xlsx";User ID=joe.cooper;Password=lixufa520;Extended properties=Excel 8.0').[Sheet1$]

select convert(int,ID)as ID,NAME,convert(int,CALSS)as CALSS,convert(int,SCORE)as SCORE,convert(int,RANK)as RANK into Test 
from OPENROWSET('Microsoft.ACE.OLEDB.12.0'
,'Excel 8.0;HDR=YES;DATABASE=C:\Users\JoeCooper\Desktop\���Ա�.xls',Sheet1$)
 
 SELECT * 
FROM OpenDataSource( 'Microsoft.ACE.OLEDB.16.0', 
'Data Source="C:\Users\JoeCooper\Desktop\���Ա�.xls";User ID=joe.cooper;Password=lixufa520;Extended properties=Excel 8.0')...[Sheet1$] 