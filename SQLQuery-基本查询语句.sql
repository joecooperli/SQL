--查询Stu_Database中的Student_table

--表的所有列
Select * 
from Student_table

--表示查看前10行的数据列
Select Top 10 * 
from Student_table

--表示查看前百分之25的数据列
Select Top 25 percent * 
from Student_table

--where子句的使用，逻辑运算符:Or 或 and 或not
Select * 
from Student_table
where sId > 5 and sGender != '女' or not sClass = 1  --不等于: != 或＜＞，二选一：sId大于5且sGender不等于女的或者sClass不为1的即可

--Between…and…(连续的范围)
Select * 
from Student_table
where sAge between 20 and 25 --或者where sAge >=20 and sAge <=25，时间可用Between…and 连接(时间格式可用短横线或者斜杠连接数字)

--In，Not in(不连续的范围)
Select * 
from Student_table
where sClass in(1,4)--指1到4的范围

Select * 
from Student_table
where sCollege in('应用数学学院','管理学院') and sSubject not in('物流管理','社会公共管理') and sClass in('4','1')--指1或4的值

--String类型“字符串”的数据要加单引号
Select * 
from Student_table
where sCollege = '应用数学学院'

 --模糊查询，通配符: %(0-多个字母)，_(单个字母)，例如Name like '_ountain%'
 --%与_写在[]中表示本身的含义；在[]表示一个连续的范围可以使用-连接；^写在[]内部的开头，表示不使用内部的任何字符
Select * 
from Student_table
where sCollege like '%学院'

Select * 
from Student_table
where sCollege like '管理学_'

Select * 
from Student_table
where sSubject like '%管_'

Select * 
from Student_table
where sCellphone like '1[4-9]%'

Select * 
from Student_table
where sCellphone like '1[^4-9]%'

--is null或 is not null 空值
Select * 
from Student_table
where sEmail is null

--让空值单元格不出现NULL值
Select ISNULL(sEmail,'') 
from Student_table


--聚合函数的使用
--Count()函数:计数
Select count(*) as '数据行数'
from Student_table

--Distinct()函数:消除重复行，筛选出独一无二的数据
Select distinct sCollege
from Student_table

Select count (distinct sCollege)
from Student_table

--Avg() as 别名(as可省略不写，中文不用加单引号)
Select AVG(sScore) as '平均分'
from Student_table

--max()函数
Select max(sScore) '最高分'
from Student_table

--min()函数
Select min(sScore) 最低分
from Student_table

--sum()函数
Select sum(sScore) as '总分'
from Student_table

--按某字段查询，若是配合聚合函数使用，就必须把字段放于group by中
Select sClass,AVG(sScore) as '平均分'
from Student_table
group by sClass

--若对聚合函数统计的数据进行筛选比较，就必须放于having中，而不是where中
--where子句是对原始数据进行筛选;而having子句是对分组后的数据进行筛选
Select sClass,AVG(sScore) as '平均分'
from Student_table
group by sClass
having AVG(sScore) > 86

--对分组内的学院，班级人数进行计数统计（先按学院分组，再是班级，然后统计同班的人数）
Select sCollege,sClass,count(*) as '人数'
from Student_table
group by sCollege,sClass

--order by字句，desc(降序排列)，asc(升序排列),默认升序排列(由小到大)
--order by后接数字3:表示对第三个select选项列进行顺序排列（升序）操作
Select * 
from Student_table
order by sId desc

Select * 
from Student_table
order by sHeight asc

Select * 
from Student_table
order by sScore

Select sId, sName,sScore 
from Student_table
order by 3

--Over() 开窗函数,将统计出来的数据分布在原表的每一行中,结合聚合函数，排名函数使用(必须)
Select *,AVG(sScore) over() as '平均分'
from Student_table

Select *,rank() over(order by sScore desc) as '排名'
from Student_table

--修改表格数据
update Student_table set sEmail = NULL 
where sId in (7,11)

--快速备份(向未有表备份)——新建临时表（用于导出目标表格）
--备份表可以不存在，会新建表，表的结构完成一致，但是不包含约束（主外键）
Select * into Class_table from Student_table

--如果想只包含结构不包含数据(只复制表结构，没有数据)，可以前面加个top 0，或者后面用Where 1<>1
Select * into Class1_table from Student_table where 1<>1
Select Top 0 * into Class2_table from Student_table

--若表格是已经创建好了，则该表格的数据列不能是自增的(取消“标识”)


--快速备份(向已有表备份)
Insert into Class1_table select * from Student_table

--连接查询：当[需要的结果]从多张表中取时
--连接：join 表名 on 关联条件
--内连接：inner join，两表中完全匹配的数据（主外键对应，左右表顺序无所谓）
--左外连接：left outer join，两表中完全匹配的数据，左表中特有的数据（左表多出来的数据也会显示出来）
--右外连接：right outer join，两表中完全匹配的数据，右表中特有的数据（右表多出来的数据也会显示出来）
--完全外连接：full outer join，两表中完全匹配的数据，左表中特有的数据，右表中特有的数据（左右表多出来的数据也会显示出来）
Select * from Student_table as st inner join Class_table as ct on st.sId = ct.sId --Class_table是引用上面快速备份建立的表格，参数跟数据是跟Student_table一样的
--Select * from Student_table as st inner join Class_table as ct on st.sAge= ct.sAge --关联条件必须确保唯一性（没有重复值），否则连接时会出现混淆匹配，出现错误的数据行

--联合查询:将多个查询的结果集合并成一个结果集
--联合要求：结果集列数要一致;对应列的类型要一致
--union（合集，去掉重复行）、union all（合集，保留重复行）、except（差集）、intersect（交集）
--用处：在查询结果处显示汇总
Select sId from Student_table union select sId from Class_table
Select sId from Student_table union all select sId from Class_table
Select sId from Student_table except select sId from Class_table
Select sId from Student_table intersect select sId from Class_table

--纵横向转置:利用union实现
--横向
Select 最高分=MAX(sScore),最低分=MIN(sScore),总分=SUM(sScore) from Student_table
--纵向
Select '最高分' as 统计内容,MAX(sScore) as 统计结果 from Student_table
union
Select '最低分',MIN(sScore) from Student_table
union
Select '总分',SUM(sScore) from Student_table

--计算字符串个数(varchar类型)
--Len()只计算数值前面的空格，而Datalength()函数则要计算数值前后的空格
Select len(sName) from Student_table--计算字符串的个数
Select Datalength(sName) from Student_table--计算字节的个数	

--内置函数

--类型转换函数:CAST(expression as data_type),CONVERT(date_type,expression,[style]),STR(expression)
--注意数据类型为Int 和 Varchar之间的转换，必要时需要cast或convert来转换数据类型
select CAST(89.00000 as decimal(4,1))--保留一位小数	
select CONVERT(decimal(4,1),89.00000 ) 

--使1+'1'等于11
select CAST(1 as CHAR(1)) +'1'--将数值1转换成字符串1
select CONVERT(char(1),1)+'1'--将数值1转换成字符串1
select STR(1)+'1'--STR():将数值转换成字符串

select 1+1--结果出现在结果框中
print 1+1--结果出现在消息框中

--字符串函数：ascii（求单个字符的ascii值）,char（根据ascii转到字符）;注意：索引从1开始，而不是0
--left,right(两个参数)substring(三个参数)：字符串截取数几个字符
Select left(sEname,2) from Student_table
Select right(sEname,2) from Student_table
Select substring(sEname,2,2) from Student_table

--lower,upper：转小写、大写
Select lower(sEname) from Student_table
Select upper(sEname) from Student_table

--ltrim(左边),rtrim（右边）：去空格(若要去掉两边的空格，可嵌套使用)
Select rtrim(ltrim(sEname)) from Student_table--Student_table中sEname的数据并没有空格

--日期函数：getDate（获取当前日期时间）
--dateAdd（日期加）,dateDiff（日期差）,datePart（取日期的某部分）,year,month,day
--注意：dateAdd、dateDiff、datePart的第一个参数使用双引号(应该是具体时间要加单引号)
Select getdate()
--dateAdd（日期加）
Select dateAdd(DAY,365,getdate())
Select dateAdd(DAY,365,'2018-04-08')
Select dateAdd(MONTH,12,getdate())
Select dateAdd(YEAR,1,getdate())
--dateDiff（日期差）
Select dateDiff(DAY,getdate(),dateAdd(DAY,365,getdate()))
Select dateDiff(DAY,getdate(),'2019-04-08')
Select dateDiff(MONTH,getdate(),dateAdd(MONTH,12,getdate()))
Select dateDiff(YEAR,getdate(),dateAdd(YEAR,1,getdate()))
--datePart（取日期的某部分）
Select datePart(DAY,getdate())
Select datePart(DAY,'2018-04-08')
Select datePart(MONTH,getdate())
Select datePart(YEAR,getdate())
