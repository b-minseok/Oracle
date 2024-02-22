--day08_object.sql_
# ORACLE�� ��ü
[1] TABLE
[2] SEQUENCE
[3] VIEW
[4] INDEX
[5] SYNONYM
....
# SEQUENCE
--DEPT �� pk�� ���Ǵ� DEPTNO ������ ����� �������� ������

CREATE SEQUENCE DEPT_DEPTNO_SEQ
START WITH 30 --���۰�
INCREMENT BY 10 --����ġ
MAXVALUE 99-- �ִ밪
MINVALUE 30
NOCACHE--�޸�
NOCYCLE;

������ �������� ��ȸ

SELECT * FROM USER_SEQUENCES WHERE SEQUENCE_NAME='DEPT_DEPTNO_SEQ';
SELECT * FROM USER_OBJECTS WHERE OBJECT_TYPE='SEQUENCE';

# ������ ����
- NEXTVAL : �������� �������� ��ȯ
- CURRVAL : �������� ���簪�� ��ȯ
- [���ǻ���] NEXTVAL�� ���� ���� ä�� CURRVAL �� ���� ����� �� ����

INSERT INTO DEPT(DEPTNO,DNAME,LOC)
VALUES(DEPT_DEPTNO_SEQ.NEXTVAL,'ȫ����','��õ');

INSERT INTO DEPT(DEPTNO,DNAME,LOC)
VALUES(DEPT_DEPTNO_SEQ.NEXTVAL,'������3','����');

SELECT * FROM DEPT;

SELECT DEPT_DEPTNO_SEQ.CURRVAL FROM DUAL;

<1> BBS ���̺�(�Խ���)�� ����� �������� �����ϼ���
���۰�: n
����ġ: 1
�ּҰ�: n
NOCYCLE
CACHE n

CREATE SEQUENCE BBS_SEQ
START WITH 1
INCREMENT BY 1
MINVALUE 1
NOCYCLE
CACHE 30;

SELECT * FROM USER_SEQUENCES
WHERE SEQUENCE_NAME='BBS_SEQ';

SELECT BBS_SEQ.CURRVAL FROM DAUL;
==> ERROR �߻�
---------------�� ������?
<2> BBS�� �������� �̿��ؼ� �Խñ��� �����ϼ���
SELECT * FROM JAVA_MEMBER;

INSERT INTO BBS(NO,TITLE,WRITER,CONTENT)
VALUES(BBS_SEQ.NEXTVAL,'�� �� ���','','�������� �̿��մϴ�');

SELECT * FROM BBS;
-----------------------------------
DEPT_DEPTNO_SEQ

SELECT * FROM USER_SEQUENCES
WHERE SEQUENCE_NAME='DEPT_DEPTNO_SEQ';

DEPT_DEPTNO_SEQ�� �Ʒ��� ���� �����ϼ���
����ġ : 5
CYCLE �ɼ� �ֱ�
ĳ�� ������: 20
���� �����ϼ���

ALTER SEQUENCE ��������
INCREMENT BY N
MINVALUE N
MAXVALUE N
CYCLE|NOCYCLE
CACHE N|NOCACHE;
[����]���۰��� ������ �� ����

ALTER SEQUENCE DEPT_DEPTNO_SEQ
--START WITH 60 [X] ERROR�߻�
INCREMENT BY 5
MAXVALUE 150
CYCLE
NOCACHE;

SELECT * FROM USER_SEQUENCES
WHERE SEQUENCE_NAME='DEPT_DEPTNO_SEQ';

SELECT DEPT_DEPTNO_SEQ.NEXTVAL FROM DUAL;

# ������ ����
DROP SEQUENCE ��������;

DEPT_DEPTNO_SEQ�� �����ϼ���

DROP SEQUENCE DEPT_DEPTNO_SEQ;
------------------------------------

# VIEW
- ������ ���̺�

CREATE [OR REPLACE] VIEW ���̸�
AS
SELECT��

CREATE VIEW EMP20_VIEW
AS
SELECT * FROM EMP
WHERE DEPTNO=20;

==> ORA-01031: insufficient privileges ���� �߻�

system/oracle�� �����ؼ� ������ �ο��Ѵ�
grant create view to scott;

�� ��ȸ
SELECT * FROM emp20_view;

--EMP���̺��� 30�� �μ��� EMPNO�� EMP_NO�� ENAME�� NAME����
--	SAL�� SALARY�� �ٲپ� EMP30_VIEW�� �����Ͽ���.

CREATE OR REPLACE VIEW EMP30_VIEW
AS
SELECT EMPNO EMP_NO, ENAME NAME, SAL SALARY, DEPTNO DNO
FROM EMP WHERE DEPTNO=30; 

SELECT * FROM EMP30_VIEW;

update emp set deptno=10 where ename=upper('allen');

update emp30_view set salary=1550 where name=upper('ward');

SELECT * FROM EMP30_VIEW;
select * from emp;

�並 �����ϸ� => �� ���̺� ������
���̺� ���� => �䵵 ������

���� �並 ���� ���ϰ� �Ϸ��� with read only �ɼ��� �ش�

--�����̺��� �� ���� �� ���̰� 19�� �̻���
--	���� ������
--	Ȯ���ϴ� �並 ��������.
--	�� ���� �̸��� MEMBER_19VIEW�� �ϼ���

CREATE OR REPLACE VIEW MEMBER_19VIEW
AS
SELECT * FROM MEMBER
WHERE AGE >= 19
WITH READ ONLY;

SELECT * FROM MEMBER_19VIEW ORDER BY AGE;

member���� id1�� ȸ���� ���̸� 17���� �����ϼ���

UPDATE MEMBER SET AGE=17 WHERE USERID='id1';
SELECT * FROM MEMBER_19VIEW;

MEMBER_19VIEW���� 'id3' �� ȸ���� ���ϸ����� 500���� �ο��ϼ���
UPDATE MEMBER_19VIEW SET MILEAGE = MILEAGE + 500 
WHERE USERID='id3';
==> error �߻�. with read only �ɼ��� �־����Ƿ�
----------------JOIN���ؾȰ�
- ī�װ�,��ǰ,���޾�ü�� join�� �並 ���弼��
- ���̸� : prod_view

CREATE OR REPLACE VIEW prod_view
AS
SELECT * FROM CATEGORY C JOIN PRODUCTS P
ON c.category_code = p.category_fk
JOIN SUPPLY_COMP S
ON p.ep_code_fk = s.ep_code;

select category_name,products_name,output_price,ep_name
from prod_view;

join������ ������ ��� �б� �������θ� ��� ����

#with check option
=>where ���� ������ �����ϰ� �����ϵ��� ������

create or replace view emp20vw
as
select * from emp
where deptno=20
with check option constraint emp20vw_ck;

select * from emp20vw;

update emp20vw set sal=sal+500 where empno=7369;

update emp20vw set deptno=30 where empno=7369;
==> ORA-01402: view WITH CHECK OPTION where-clause violation

# ������ ���� ��ȸ
- user_views
- user_objects
select * from user_views where view_name=upper('emp20vw');
select * from user_objects where object_name=upper('emp20vw');

select text from user_views where view_name=upper('emp20vw');

# View ����
drop view ���̸�;

drop view emp20vw;
--------------------------------------
# Index
create [unique]index �ε����� on ���̺�� (�÷���)

create index emp_ename_indx on emp (ename);

������ �������� ��ȸ
- user_objects
- user_indexes
- user_ind_columns

SELECT * FROM USER_OBJECTS
WHERE OBJECT_TYPE='INDEX' AND OBJECT_NAME='EMP_ENAME_INDX';

SELECT * FROM USER_INDEXES
WHERE TABLE_NAME='EMP';

�����̺��� NAME �� �ε����� �����ϼ���

CREATE INDEX MEMBER_NAME_INDX ON MEMBER(NAME);

SELECT * FROM USER_INDEXES
WHERE TABLE_NAME='MEMBER';

SELECT * FROM USER_IND_COLUMNS
WHERE TABLE_NAME='MEMBER';

SELECT * FROM MEMBER
WHERE NAME LIKE '%�浿%';

--��ǰ ���̺��� �ε����� �ɾ�θ� ���� �÷��� ã�� �ε����� ���弼��.
--CATEGORY_FK, EP_CODE_FK
CREATE INDEX PRODUCTS_INDX1 ON PRODUCTS (CATEGORY_FK);
CREATE INDEX PRODUCTS_INDX2 ON PRODUCTS (EP_CODE_FK);

SELECT * FROM USER_IND_COLUMNS
WHERE TABLE_NAME='PRODUCTS';

# �ε��� ������ ���� =>�����ϰ� �ٽ� ����
# �ε��� ����
DROP INDEX �ε�����;

MEMBER_INDX�� �����ϼ���
DROP INDEX MEMBER_INDX;

SELECT * FROM USER_INDEDXES
WHERE TABLE_NAME='MEMBER';

# Synonym - ���Ǿ�
����Ŭ ��ü(���̺�,��,������,���ν���..)�� ���� ��Ī(ALIAS)
��ü�� ���� ������ �ǹ�
-���Ǿ� ����
CREATE SYNONYM ���Ǿ��̸� FOR ��ü��(��Ű��.���̺��);

������ �������� ��ȸ
SELECT * FROM USER_OBJECTS
WHERE OBJECT_TYPE='SYNONYM';

-���Ǿ� ����
DROP SYNONYM ���Ǿ��;

DROP SYNONYM A;

SELECT * FROM A;
SELECT* FROM MYSTAR.NOTE;

---------------------------
# ���ν��� - crud

# db���� - ���伳��/������/�������� , ����ȭ
---------------------
