--��ѯStu_Database�е�Student_table

--���������
Select * 
from Student_table

--��ʾ�鿴ǰ10�е�������
Select Top 10 * 
from Student_table

--��ʾ�鿴ǰ�ٷ�֮25��������
Select Top 25 percent * 
from Student_table

--where�Ӿ��ʹ�ã��߼������:Or �� and ��not
Select * 
from Student_table
where sId > 5 and sGender != 'Ů' or not sClass = 1  --������: != �򣼣�����ѡһ��sId����5��sGender������Ů�Ļ���sClass��Ϊ1�ļ���

--Between��and��(�����ķ�Χ)
Select * 
from Student_table
where sAge between 20 and 25 --����where sAge >=20 and sAge <=25��ʱ�����Between��and ����(ʱ���ʽ���ö̺��߻���б����������)

--In��Not in(�������ķ�Χ)
Select * 
from Student_table
where sClass in(1,4)--ָ1��4�ķ�Χ

Select * 
from Student_table
where sCollege in('Ӧ����ѧѧԺ','����ѧԺ') and sSubject not in('��������','��ṫ������') and sClass in('4','1')--ָ1��4��ֵ

--String���͡��ַ�����������Ҫ�ӵ�����
Select * 
from Student_table
where sCollege = 'Ӧ����ѧѧԺ'

 --ģ����ѯ��ͨ���: %(0-�����ĸ)��_(������ĸ)������Name like '_ountain%'
 --%��_д��[]�б�ʾ����ĺ��壻��[]��ʾһ�������ķ�Χ����ʹ��-���ӣ�^д��[]�ڲ��Ŀ�ͷ����ʾ��ʹ���ڲ����κ��ַ�
Select * 
from Student_table
where sCollege like '%ѧԺ'

Select * 
from Student_table
where sCollege like '����ѧ_'

Select * 
from Student_table
where sSubject like '%��_'

Select * 
from Student_table
where sCellphone like '1[4-9]%'

Select * 
from Student_table
where sCellphone like '1[^4-9]%'

--is null�� is not null ��ֵ
Select * 
from Student_table
where sEmail is null

--�ÿ�ֵ��Ԫ�񲻳���NULLֵ
Select ISNULL(sEmail,'') 
from Student_table


--�ۺϺ�����ʹ��
--Count()����:����
Select count(*) as '��������'
from Student_table

--Distinct()����:�����ظ��У�ɸѡ����һ�޶�������
Select distinct sCollege
from Student_table

Select count (distinct sCollege)
from Student_table

--Avg() as ����(as��ʡ�Բ�д�����Ĳ��üӵ�����)
Select AVG(sScore) as 'ƽ����'
from Student_table

--max()����
Select max(sScore) '��߷�'
from Student_table

--min()����
Select min(sScore) ��ͷ�
from Student_table

--sum()����
Select sum(sScore) as '�ܷ�'
from Student_table

--��ĳ�ֶβ�ѯ��������ϾۺϺ���ʹ�ã��ͱ�����ֶη���group by��
Select sClass,AVG(sScore) as 'ƽ����'
from Student_table
group by sClass

--���ԾۺϺ���ͳ�Ƶ����ݽ���ɸѡ�Ƚϣ��ͱ������having�У�������where��
--where�Ӿ��Ƕ�ԭʼ���ݽ���ɸѡ;��having�Ӿ��ǶԷ��������ݽ���ɸѡ
Select sClass,AVG(sScore) as 'ƽ����'
from Student_table
group by sClass
having AVG(sScore) > 86

--�Է����ڵ�ѧԺ���༶�������м���ͳ�ƣ��Ȱ�ѧԺ���飬���ǰ༶��Ȼ��ͳ��ͬ���������
Select sCollege,sClass,count(*) as '����'
from Student_table
group by sCollege,sClass

--order by�־䣬desc(��������)��asc(��������),Ĭ����������(��С����)
--order by�������3:��ʾ�Ե�����selectѡ���н���˳�����У����򣩲���
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

--Over() ��������,��ͳ�Ƴ��������ݷֲ���ԭ���ÿһ����,��ϾۺϺ�������������ʹ��(����)
Select *,AVG(sScore) over() as 'ƽ����'
from Student_table

Select *,rank() over(order by sScore desc) as '����'
from Student_table

--�޸ı������
update Student_table set sEmail = NULL 
where sId in (7,11)

--���ٱ���(��δ�б���)�����½���ʱ�����ڵ���Ŀ����
--���ݱ���Բ����ڣ����½�����Ľṹ���һ�£����ǲ�����Լ�����������
Select * into Class_table from Student_table

--�����ֻ�����ṹ����������(ֻ���Ʊ�ṹ��û������)������ǰ��Ӹ�top 0�����ߺ�����Where 1<>1
Select * into Class1_table from Student_table where 1<>1
Select Top 0 * into Class2_table from Student_table

--��������Ѿ��������ˣ���ñ��������в�����������(ȡ������ʶ��)


--���ٱ���(�����б���)
Insert into Class1_table select * from Student_table

--���Ӳ�ѯ����[��Ҫ�Ľ��]�Ӷ��ű���ȡʱ
--���ӣ�join ���� on ��������
--�����ӣ�inner join����������ȫƥ������ݣ��������Ӧ�����ұ�˳������ν��
--�������ӣ�left outer join����������ȫƥ������ݣ���������е����ݣ��������������Ҳ����ʾ������
--�������ӣ�right outer join����������ȫƥ������ݣ��ұ������е����ݣ��ұ�����������Ҳ����ʾ������
--��ȫ�����ӣ�full outer join����������ȫƥ������ݣ���������е����ݣ��ұ������е����ݣ����ұ�����������Ҳ����ʾ������
Select * from Student_table as st inner join Class_table as ct on st.sId = ct.sId --Class_table������������ٱ��ݽ����ı�񣬲����������Ǹ�Student_tableһ����
--Select * from Student_table as st inner join Class_table as ct on st.sAge= ct.sAge --������������ȷ��Ψһ�ԣ�û���ظ�ֵ������������ʱ����ֻ���ƥ�䣬���ִ����������

--���ϲ�ѯ:�������ѯ�Ľ�����ϲ���һ�������
--����Ҫ�󣺽��������Ҫһ��;��Ӧ�е�����Ҫһ��
--union���ϼ���ȥ���ظ��У���union all���ϼ��������ظ��У���except�������intersect��������
--�ô����ڲ�ѯ�������ʾ����
Select sId from Student_table union select sId from Class_table
Select sId from Student_table union all select sId from Class_table
Select sId from Student_table except select sId from Class_table
Select sId from Student_table intersect select sId from Class_table

--�ݺ���ת��:����unionʵ��
--����
Select ��߷�=MAX(sScore),��ͷ�=MIN(sScore),�ܷ�=SUM(sScore) from Student_table
--����
Select '��߷�' as ͳ������,MAX(sScore) as ͳ�ƽ�� from Student_table
union
Select '��ͷ�',MIN(sScore) from Student_table
union
Select '�ܷ�',SUM(sScore) from Student_table

--�����ַ�������(varchar����)
--Len()ֻ������ֵǰ��Ŀո񣬶�Datalength()������Ҫ������ֵǰ��Ŀո�
Select len(sName) from Student_table--�����ַ����ĸ���
Select Datalength(sName) from Student_table--�����ֽڵĸ���	

--���ú���

--����ת������:CAST(expression as data_type),CONVERT(date_type,expression,[style]),STR(expression)
--ע����������ΪInt �� Varchar֮���ת������Ҫʱ��Ҫcast��convert��ת����������
select CAST(89.00000 as decimal(4,1))--����һλС��	
select CONVERT(decimal(4,1),89.00000 ) 

--ʹ1+'1'����11
select CAST(1 as CHAR(1)) +'1'--����ֵ1ת�����ַ���1
select CONVERT(char(1),1)+'1'--����ֵ1ת�����ַ���1
select STR(1)+'1'--STR():����ֵת�����ַ���

select 1+1--��������ڽ������
print 1+1--�����������Ϣ����

--�ַ���������ascii���󵥸��ַ���asciiֵ��,char������asciiת���ַ���;ע�⣺������1��ʼ��������0
--left,right(��������)substring(��������)���ַ�����ȡ�������ַ�
Select left(sEname,2) from Student_table
Select right(sEname,2) from Student_table
Select substring(sEname,2,2) from Student_table

--lower,upper��תСд����д
Select lower(sEname) from Student_table
Select upper(sEname) from Student_table

--ltrim(���),rtrim���ұߣ���ȥ�ո�(��Ҫȥ�����ߵĿո񣬿�Ƕ��ʹ��)
Select rtrim(ltrim(sEname)) from Student_table--Student_table��sEname�����ݲ�û�пո�

--���ں�����getDate����ȡ��ǰ����ʱ�䣩
--dateAdd�����ڼӣ�,dateDiff�����ڲ,datePart��ȡ���ڵ�ĳ���֣�,year,month,day
--ע�⣺dateAdd��dateDiff��datePart�ĵ�һ������ʹ��˫����(Ӧ���Ǿ���ʱ��Ҫ�ӵ�����)
Select getdate()
--dateAdd�����ڼӣ�
Select dateAdd(DAY,365,getdate())
Select dateAdd(DAY,365,'2018-04-08')
Select dateAdd(MONTH,12,getdate())
Select dateAdd(YEAR,1,getdate())
--dateDiff�����ڲ
Select dateDiff(DAY,getdate(),dateAdd(DAY,365,getdate()))
Select dateDiff(DAY,getdate(),'2019-04-08')
Select dateDiff(MONTH,getdate(),dateAdd(MONTH,12,getdate()))
Select dateDiff(YEAR,getdate(),dateAdd(YEAR,1,getdate()))
--datePart��ȡ���ڵ�ĳ���֣�
Select datePart(DAY,getdate())
Select datePart(DAY,'2018-04-08')
Select datePart(MONTH,getdate())
Select datePart(YEAR,getdate())
