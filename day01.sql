-- �ܹ� �ּ�
/* ���� �ּ�
    ���� ���� �ּ� ó��
    ��Ʈ�� +������ �ּ�ó����
*/
--select count(*) from tab;
--select * from tab;
--select * from dept;
--select * from emp;
--select * from salgrade;
--select * from category;
--select * from products;
--select * from member;
--select * from supply_comp;
--day01.sql

--�л� ���̺�
create table student(
    no number(4) primary key, --unique + not null
    name varchar2(30) not null,
    addr varchar2(100),
    tel varchar2(16) not null,
    indate date default sysdate,
    sclass varchar2(30),
    sroom number(3)
);
desc student;
insert into student (no,name,tel)
values(1,'��ö��','010-2222-3333');
commit;
--����Ŭ�� ���� commit,mysql�� auto commit

select * from student;
--c: create=>insert
--r: read==>select
--u: update==>update
--d: delete==>delete
--2 �迵�� �ּ� ����ó '��ص尳���ڹ�' 201ȣ
insert into student (no,name,addr,tel,sclass,sroom)
values(3,'��浿','���� ������','010-5333-4444','�鿣�� �����ڹ�',201);
rollback; --���
select * from student;
commit;
delete from student where no=3;

--����Ʈ �����ڹ� �л� 2�� ������ insert�ϼ���
--202ȣ
--�÷����� �����ϰ� insert�� ���� ���̺��� create������ ���� �÷��������
--���� �־��־�� ��
insert into student
values(5,'ȫ�浿','����','010-7323-7232',sysdate,'����Ʈ �����ڹ�',202);
select * from student;
commit;
--1�� �л��� �ּ�,�б�,���ǹ�ȣ�� �����սô�
--update ���̺�� set �÷���1=��,�÷���2=��2 where ������
update student set addr='���� ������', sclass='��ص� ������', sroom=201
where no=1;
rollback;

select * from student where sclass='�鿣�� �����ڹ�';
select * from student where sroom=201;

--�л� ���̺��� �����ϰ� �ٽ� ������
--drop table ���̺��
drop table student;
select * from student;

�б� ���̺� ���� 
���̺��: sclass
�б޹�ȣ(snum) number(4) primary key
�б޸�(sname) varchar2(30)
���ǹ�ȣ(sroom) number(3)

create table sclass(
    snum number(4) primary key,
    sname varchar2(30) not null,
    sroom number(3)
);
create table student(
    no number(4) primary key,
    name varchar2(30) not null,
    addr varchar2(100),
    tel varchar2(16) not null,
    indate date default sysdate,
    snum_fk number(4) references sclass(snum)
);
insert into sclass(snum,sname,sroom)
values(10,'�鿣�� �����ڹ�',201);
insert into sclass
values(20,'����Ʈ���� �����ڹ�',202);
insert into sclass
values(30,'�����͹�',203);
select * from sclass;

insert into student(no,name,addr,tel,snum_fk)
values(2,'��ö��','���� ������','010-2111-2222',20);
select * from student;
--join
select student.*, sclass.*
from sclass join student
on sclass.snum = student.snum_fk;

10�� �б� �л����� 3�� ���
20�� �б� �л����� 3�� ���
30�� �б� �л����� 1�� ���

insert,update,delete