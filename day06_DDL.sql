--day06_DDL.sql
DDL (DATA DEFINITION LANGUAGE)
- CREATE, ALTER, DROP, RENAME, TRUNCATE

# CREATE �� 
[1] PRIMARY KEY ��������
<1>  �÷� ����
    CREATE TABLE TEST_TAB1(
      ID NUMBER(2) CONSTRAINT TEST_TAB1_ID_PK PRIMARY KEY, --�÷������� ����
      NAME VARCHAR2(10)
    );

    DESC TEST_TAB1;
    
    ������ �������� ��ȸ
    SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME='TEST_TAB1';
    
<2> ���̺� ����
    CREATE TABLE TEST_TAB2(
       ID NUMBER(2),
       NAME VARCHAR2(10),
       -- ���̺� ������ ����
       CONSTRAINT TEST_TAB2_ID_PK PRIMARY KEY (ID)
    );
    
    SELECT * FROM USER_CONSTRAINTS
    WHERE TABLE_NAME='TEST_TAB2';
    
# �������� ����
    ALTER TABLE ���̺�� DROP CONSTRAINT �������Ǹ�

# �������� �߰�
    ALTER TABLE ���̺�� ADD CONSTRAINT �������Ǹ�  ������������ (�÷���)
    
# �������Ǹ� ����
    ALTER TABLE ���̺�� RENAME CONSTRAINT OLD_�������Ǹ� TO NEW_�������Ǹ�
    
--- TEST_TAB2 ��   TEST_TAB2_ID_PK ���������� �����ϼ���
    ALTER TABLE TEST_TAB2 DROP CONSTRAINT TEST_TAB2_ID_PK;
    
    SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME='TEST_TAB2';
    
--- TEST_TAB2�� NAME �÷��� PRIMARY ���������� �߰��ϼ���
    ALTER TABLE TEST_TAB2 ADD CONSTRAINTS TEST_TAB2_NAME_PK PRIMARY KEY (NAME);

--- TEST_TAB2�� NAME �÷��� �� �������Ǹ��� �����ϼ���
    ALTER TABLE TEST_TAB2 RENAME CONSTRAINT TEST_TAB2_NAME_PK TO TEST_TAB2_NAME_PRIMARY;


INSERT INTO TEST_TAB1(ID,NAME)
VALUES(NULL,'ȫ�浿');

INSERT INTO TEST_TAB1(ID,NAME)
VALUES(2,'��ö��');
COMMIT;

SELECT * FROM TEST_TAB1;

--PK==> UNIQUE + NOT NULL
------------------------------------------------
[2] FOREIGN KEY (�ܷ�Ű)
�θ� ���̺� - MASTER TABLE
DEPT_TAB
CREATE TABLE DEPT_TAB(
    DEPTNO NUMBER(2),
    DNAME VARCHAR2(15),
    LOC VARCHAR2(20),
    CONSTRAINT DEPT_TAB_DEPTNO_PK PRIMARY KEY(DEPTNO)
);

�ڽ� ���̺� - DETAIL TABLE
EMP_TAB

CREATE TABLE EMP_TAB(
    EMPNO NUMBER(4),
    ENAME VARCHAR2(10),
    JOB VARCHAR2(10),
    --�÷� ���ؿ��� FK ����
    MGR NUMBER(4) CONSTRAINT EMP_TAB_MGR_FK REFERENCES EMP_TAB(EMPNO),
    HIREDATE DATE,
    SAL NUMBER(7,2),
    COMM NUMBER(7,2),
    DEPTNO NUMBER(2),
    -- ���̺� ���ؿ��� FK ����
    CONSTRAINT EMP_TAB_DEPTNO_FK FOREIGN KEY (DEPTNO)
    REFERENCES  DEPT_TAB (DEPTNO),
    CONSTRAINT EMP_TAB_EMPNO_PK PRIMARY KEY (EMPNO)
);

-- �����ͻ������� ��ȸ

SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME='EMP_TAB';

DEPT_TAB�� ������ ����
10 '�λ��' '����'
20 '��ȹ��' '����'

INSERT INTO DEPT_TAB VALUES(10,'�λ��','����');
INSERT INTO DEPT_TAB VALUES(20,'��ȹ��','����');

SELECT * FROM DEPT_TAB;
COMMIT;

--EMP_TAB�� ������ �ֱ�
--10���μ� 2��
INSERT INTO EMP_TAB(EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,DEPTNO)
VALUES(1000,'ȫ�浿','MANAGER',NULL,SYSDATE,5000,10);

INSERT INTO EMP_TAB(EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,DEPTNO)
VALUES(1001,'��ö��','CLERK',1000,SYSDATE,4000,10);
COMMIT;

SELECT * FROM EMP_TAB;
20���μ� 1��
INSERT INTO EMP_TAB(EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,DEPTNO)
VALUES(1002,'�����','ANALYST',1000,SYSDATE,4000,10);

INSERT INTO EMP_TAB(EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,DEPTNO)
VALUES(1003,'�ֿ�ȣ','ANALYST',1001,SYSDATE,4000,20);

INSERT INTO EMP_TAB(EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,DEPTNO)
VALUES(1004,'ȣġ��','OPERATOR',1001,SYSDATE,3000,20);

COMMIT;

SELECT * FROM EMP_TAB;

DEPT_TAB���� 20�� �μ� ����

DELETE FROM DEPT_TAB WHERE DEPTNO=20;
==> child record found
�ܷ�Ű�� �����Ǵ� �ڽ� ���ڵ尡 ���� ��� �θ� ���ڵ�� ���� �Ұ�

EMP_TAB���� 20�� �μ� �������� �μ���ȣ�� 10������ �����ϼ���

UPDATE EMP_TAB SET DEPTNO=10 WHERE DEPTNO=20;

SELECT * FROM EMP_TAB;
COMMIT;
DELETE FROM DEPT_TAB WHERE DEPTNO=20;
/*
�Խ��� ���̺�
���̺��: bbs
no number(4) pk
title varchar2(200) not null
writer  ===> java_member���̺��� id�� �����ϵ��� �ϵ� on delete cascade �ɼ��� �־� fk�� ����
content varchar2(2000),
wdate date default sysdate
*/

create table bbs(
  no number(4) constraint bbs_no_pk primary key,
  title varchar2(200) not null,
  writer varchar2(20) constraint bbs_writer_fk references java_member(id) on delete cascade,
  content varchar2(2000),
  wdate date default sysdate
);

select * from java_member;
--�Խñ� 2�� �����ϼ���

insert into bbs(no,title,writer,content)
values(1,'ó�� ���� ��','hong','���� ó�� ���� ���');

insert into bbs(no,title,writer,content)
values(2,'�ι�° ���� ��','haha','���� ȣȣ ����');

insert into bbs(no,title,writer,content)
values(3,'���õ� �ݰ�����','hong','���õ� ��̰�...');
commit;
select * from bbs;

-- hong���̵� ȸ���� �����ϼ���
DELETE FROM java_member WHERE id='hong';

select * from java_member; --'hong'����

-- hong�� �� �Խñ���?
select * from bbs;

rollback;

SELECT * FROM DEPT_TAB;

[3] UNIQUE ��������
- ������ ���� ������ ����
- NULL�� ���ȴ�

CREATE TABLE UNI_TAB(
   DEPTNO NUMBER(2) CONSTRAINT UNI_TAB_DEPTNO_UK UNIQUE,
   DNAME CHAR(14),
   LOC CHAR(10)
);
INSERT INTO UNI_TAB
VALUES(10,'�빫��','����');

INSERT INTO UNI_TAB
VALUES(NULL,'������','����');

INSERT INTO UNI_TAB
VALUES(20,'��ȹ��','����');

SELECT * FROM UNI_TAB;

COMMIT;

UNI_TAB2
DEPTNO ==> ���̺� ���ؿ��� UNIQUE �ֱ�
DNAME
LOC

CREATE TABLE UNI_TAB2(
  DEPTNO NUMBER(2),
  DNAME CHAR(14),
  LOC CHAR(10),
  CONSTRAINT UNI_TAB2_DEPTNO_UK UNIQUE(DEPTNO)
);

������ �������� ��ȸ
SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME='UNI_TAB2';
------------------------------------------------------------
[4] NOT NULL
- NULL���� ������� ����
- �÷� ���ؿ����� ���� ����

CREATE TABLE NN_TAB(
   DEPTNO NUMBER(2) CONSTRAINT NN_TAB_DEPTNO_NN NOT NULL,
   DNAME CHAR(14)
);
INSERT INTO NN_TAB VALUES(1,'�λ��');

INSERT INTO NN_TAB VALUES(NULL,'�λ��');

[5] CHECK �������� 
- ���� �����ؾ� �� ������ ���

CREATE TABLE CK_TAB(
   DEPTNO NUMBER(2) CONSTRAINT CK_TAB_DEPTNO_CK  CHECK ( DEPTNO >10 AND DEPTNO <=20),
   DNAME CHAR(16)
);
INSERT INTO CK_TAB VALUES(20,'��ȹ��');
INSERT INTO CK_TAB VALUES(21,'��ȹ��');
SELECT * FROM CK_TAB;
-- ===================================================
�ǽ�
ZIPCODE ���̺�
MEMBER_TAB ���̺� �����ϱ�

CREATE TABLE zipcode(
    POST1 CHAR(3),
    POST2 CHAR(3),
    ADDR VARCHAR2(60) CONSTRAINT zipcode_ADDR_NOTNULL NOT NULL,
    CONSTRAINT zipcode_POST_PK PRIMARY KEY (POST1,POST2)
);

SELECT * FROM USER_CONSTRAINTS
WHERE TABLE_NAME='ZIPCODE';

CREATE TABLE MEMBER_TAB(
    id number(4,0) constraint member_tab_id_pk primary key,
    name varchar2(10) not null,
    gender char(1) constraint member_tab_gender_ck CHECK (gender = 'F' or gender = 'M'),
    jumin1 char(6),
    jumin2 char(7),
    tel varchar2(15),
    post1 char(3),
    post2 char(3),
    addr varchar2(60),
    constraint member_tab_jumin_uk unique(jumin1,jumin2),
    constraint member_tab_post_fk foreign key(post1,post2) references zipcode(post1,post2)
);
SELECT * FROM USER_CONSTRAINTS
WHERE TABLE_NAME='MEMBER_TAB';

# SUBQUERY �� �̿��� ���̺� ����

CREATE TABLE ���̺��(�÷���1,...) 
AS
SUBQUERY

--EMP���� 30���μ��� �ٹ��ϴ� ��������� �����ͼ�
--EMP_30 ���̺��� �����ϼ���

CREATE TABLE EMP_30(ENO, ENAME, JOB, HDATE, SAL,COMM,DNO)
AS
SELECT EMPNO, ENAME, JOB, HIREDATE,SAL,COMM,DEPTNO
FROM EMP
WHERE DEPTNO=30;

SELECT * FROM TAB;

DESC EMP_30;

SELECT * FROM EMP_30;

--
--[����1]
--		EMP���̺��� �μ����� �ο���,��� �޿�, �޿��� ��, �ּ� �޿�,
--		�ִ� �޿��� �����ϴ� EMP_DEPTNO ���̺��� �����϶�.
CREATE TABLE EMP_DEPTNO
AS
SELECT DEPTNO, COUNT(EMPNO) CNT, ROUND(AVG(SAL),1) AVG_SAL, SUM(SAL) SUM_SAL, 
MIN(SAL) MIN_SAL, MAX(SAL) MAX_SAL
FROM EMP
GROUP BY DEPTNO;

SELECT * FROM EMP_DEPTNO;

--[����2]	EMP���̺��� ���,�̸�,����,�Ի�����,�μ���ȣ�� �����ϴ�
--		EMP_TEMP ���̺��� �����ϴµ� �ڷ�� �������� �ʰ� ������
--		�����Ͽ���.

CREATE TABLE EMP_TEMP2
AS
SELECT EMPNO, ENAME, JOB, HIREDATE, DEPTNO FROM EMP
WHERE 1=0; -- �׻� ������ ������ �д�

SELECT * FROM EMP_TEMP2;
-- ====================================================================
# �÷� �߰�/����/����
[1] �÷� �߰�
ALTER TABLE ���̺�� ADD �߰��� �÷�����(�÷��� �ڷ��� �⺻��)
[2] �÷� ���� ����
ALTER TABLE ���̺��  MODIFY ������ �÷�����

[3] �÷� ����
ALTER TABLE ���̺��  DROP COLUMN ������ �÷���

[4] �÷��� ����
ALTER TABLE ���̺��  RENAME COLUMN OLD_�÷��� TO NEW_�÷���;

CREATE TABLE SAMPLE_TAB(
    NO NUMBER(4)
);
DESC SAMPLE_TAB;

<1> SAMPLE_TAB�� 
NAME VARCHAR2(20) �߰��ϼ���

ALTER TABLE SAMPLE_TAB
ADD NAME VARCHAR2(20) NOT NULL;

DESC SAMPLE_TAB;

<2> NO �÷��� �ڷ��� CHAR(4) �� �����ϼ���

ALTER TABLE SAMPLE_TAB MODIFY NO CHAR(4);

DESC SAMPLE_TAB;

