--�������ݿ�
create database program_3
go

--ʹ�ø����ݿ�
use program_3
go

--ɾ�����
drop table Sheet1$
go

--�޸ı����
sp_rename 'Sheet1$','CET'
go

--��ѯ����TestGPA��ʱ�����ڵ������
select ����,ѧ��,�༶,Ʒ�·�,����,�۲��,��������,�۲������
into TestGPA
from GPA 
--order by �༶ asc,�۲������ asc
order by �۲������ asc
go

--�޸�������
update TestGPA set ����='������' where ����='������123'
go

--�޸��ֶ���
exec sp_rename 'GPA.���','�༶'
exec sp_rename 'GPA.Ʒ�±�������','Ʒ�·�'
exec sp_rename 'GPA.ѧ��ƽ��ѧ�ּ���','����'
exec sp_rename 'GPA.�ۺϲ����ܷ�','�۲��'
exec sp_rename 'GPA.ѧҵ�ɼ���������','��������'
exec sp_rename 'GPA.�ۺϲ����ܷ�����','�۲������'
go

--�������ݱ��޷����������У�
EXEC master..xp_cmdshell 'bcp "select ����,ѧ��,�༶,Ʒ�·�,����,�۲��,��������,�۲������ from program_3.dbo.GPA order by �༶ asc,�۲������ asc" queryout C:\Users\JoeCooper\Desktop\GPA.xls -c -q -S"DESKTOP-2STVQ4T" -U"joe.cooper" -P"lixufa520"'
go

select * from CET
go

--��ѯ����TestCET��ʱ��
select ����,�Ա�,ѧ��,רҵ,�༶,���Լ���,�ܷ� 
into TestCET
from CET
--where ���Լ���='CET6' and �ܷ�>425
--where ���Լ���='CET4' and �ܷ�>425
order by �ܷ� desc
go

--ɾ���ֶΣ��ǵ��ֶ�����ǰ��+column��
alter table CET
drop column �༶
--drop column רҵ
go

--�޸��ֶ���
exec sp_rename 'CET.רҵ����','רҵ'
exec sp_rename 'CET.�༶����','�༶'
go

--�޸�������
update CET set �༶=1 where �༶='��Ϣ����15(1)'
update CET set �༶=2 where �༶='��Ϣ����15(2)'
update CET set �༶=3 where �༶='��Ϣ����15(3)'
update CET set �༶=4 where �༶='��Ϣ����15(4)'
go

--���Ӳ�ѯ����[��Ҫ�Ľ��]�Ӷ��ű���ȡʱ
--���ӣ�join ���� on ���������������ӣ�inner join���������Ӧ�����������ӣ�left outer join���������ӣ�right outer join����ȫ�����ӣ�full outer join
select * 
into TestGPACET
from TestGPA as TG
left join 
(select ����1,�Ա�,���Լ���,�ܷ� from TestCET) as TC
on TG.����=TC.����1
go

exec sp_rename 'TestCET.����','����1'
go

select * from TestGPACET
go

alter table TestGPACET
drop column �Ա�
go