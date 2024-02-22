--day07_DML.sql

EMP_10 ���̺��� �������� �̿��� �����ϵ� ������

CREATE TABLE EMP_10(ID, NAME, SALARY, HDATE)
AS
SELECT EMPNO,ENAME,SAL,HIREDATE FROM EMP
WHERE 1=2;

DESC EMP_10;

SELECT * FROM EMP_10;

# INSERT������ �������� ���

INSERT IN ���̺��
SUBQUERY

--EMP���� 10���μ� ����� ������ ������
--EMP_10�� INSERT �ϼ���

INSERT INTO EMP_10
SELECT EMPNO,ENAME,SAL,HIREDATE
FROM EMP WHERE DEPTNO=10;

SELECT * FROM EMP_10;

SELECT * FROM EMP ORDER BY DEPTNO;

INSERT INTO EMP_10(NAME,SALARY,ID,HDATE)
VALUES('JAMES',2800,7999,'85/05/03');

ROLLBACK;
COMMIT;

INSERT INTO EMP_10
VALUES(7998,'TOM',3200,TO_DATE('860301','YYMMDD'));

SELECT * FROM EMP_10;
COMMIT;
----------------------------------------------
#UADATE ��
UPDATE ���̺�� SET �÷���1=��1,�÷���2=��2,...;
==> ��� �����Ͱ� �� �����ȴ�
UPDATE ���̺�� SET �÷���1=��1,�÷���2=��2,... WHERE ������;
==> ���ǿ� �´� �����͸� ����

--[�ǽ�]
--- EMP2���̺��� �����ϰ� EMP�� �����ͱ��� ���Խ��� �����ϼ���
CREATE TABLE EMP2
AS
SELECT * FROM EMP;

SELECT * FROM EMP2;
--- emp2���̺��� ����� 7788�� ����� �μ���ȣ�� 10���� 
--	�����ϼ���.
UPDATE EMP2 SET DEPTNO=10 WHERE EMPNO=7788;
--- emp2 ���̺��� ����� 7499�� ����� �μ��� 20,
--	�޿��� 3500���� �����Ͽ���.    
UPDATE EMP2 SET DEPTNO=20, SAL=3500 WHERE EMPNO=7499;
SELECT * FROM EMP2;
--- emp2���̺��� �μ��� ��� 10���� �����Ͽ���.
UPDATE EMP2 SET DEPTNO = 10;

ROLLBACK;

--2] ��ϵ� �� ���� �� ���� ���̸� ���� ���̿��� ��� 5�� ���� ������ 
--	      �����ϼ���.
SELECT * FROM MEMBER;
UPDATE MEMBER SET AGE = AGE+5;
ROLLBACK;

--	 2_1] �� �� 23/09/01���� ����� ������ ���ϸ����� 350���� �÷��ּ���.
UPDATE MEMBER SET MILEAGE = MILEAGE + 350 WHERE REG_DATE > '23/09/01';
--     4] ��ϵǾ� �ִ� �� ���� �� �̸��� '��'�ڰ� ����ִ� ��� �̸��� '��' ���
--	     '��'�� �����ϼ���. REPLACE()�Լ� Ȱ��
UPDATE MEMBER SET NAME = REPLACE(NAME,'��','��')
WHERE NAME LIKE '%��%';

UPDATE MEMBER SET NAME='��'||LTRIM(NAME,'��') WHERE NAME LIKE '%��%';
SELECT * FROM MEMBER;

ROLLBACK;

#UPDATE ������ SUBQUERY ���
--EMP2���̺��� SCOTT�� ������ �޿��� ��ġ�ϵ���
--		JONES�� ������ �޿��� �����Ͽ���.
SELECT * FROM EMP2;
-----------------------���ؾȰ�
UPDATE EMP2 SET (JOB, SAL)=
(SELECT JOB,SAL FROM EMP2 WHERE ENAME='SCOTT')
WHERE ENAME='JONES';
-- ���߿� ��������
ROLLBACK;

#UPDATE�� ���Ἲ �������� ����

CREATE TABLE DEPT2
AS
SELECT * FROM DEPT;

SELECT * FROM DEPT2;

-- -DEPT2�� DEPTNO�÷��� ���� PRIMARY KEY ���������� �߰��ϼ���

ALTER TABLE DEPT2 ADD CONSTRAINT DEPT2_DEPTNO_PK PRIMARY KEY (DEPTNO);

SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME='DEPT2';

-- -EMP2�� DEPTNO �÷��� ���� FOREIGN KEY �߰��ϵ� DEPT2�� DEPTNO�� �ܷ�Ű�� �����ϵ���
ALTER TABLE EMP2 ADD CONSTRAINT EMP2_DEPTNO_FK FOREIGN KEY (DEPTNO)
REFERENCES DEPT2(DEPTNO);

SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME='EMP2';


--EMP2���� �μ���ȣ�� 10���� ������� �μ���ȣ�� 40������ �����ϼ���
UPDATE EMP2 SET DEPTNO = 40 WHERE DEPTNO=10;

SELECT * FROM EMP2 ORDER BY DEPTNO DESC;
--    
--   EMP2���� 'WARD'�� �μ���ȣ�� 90������ �����ϼ���
UPDATE EMP2 SET DEPTNO=90 WHERE ENAME='WARD';

==>ERROR �߻� �θ�Ű �ȿ� ���� ������ �����ؼ�

ROLLBACK;
-----------------------------------------
#DELETE ��
-DELETE FROM ���̺��;
==>��� ������ ����
-DELETE FROM ���̺�� WHERE ������;
==>���ǿ� �´� �����͸� ����
-- 1] ��ǰ ���̺� �ִ� ��ǰ �� ��ǰ�� �Ǹ� ������ 10000�� ������ ��ǰ�� ��� 
--	      �����ϼ���.
DELETE FROM PRODUCTS WHERE OUTPUT_PRICE <= 10000;
SELECT * FROM PRODUCTS;
ROLLBACK;

--	2] ��ǰ ���̺� �ִ� ��ǰ �� ��ǰ�� ��з��� ������ ��ǰ�� �����ϼ���.
-----------���ؾȰ�
DELETE FROM PRODUCTS
WHERE CATEGORY_FK =
(SELECT CATEGORY_CODE FROM CATEGORY WHERE CATEGORY_NAME='����');
--
--	3] ��ǰ ���̺� �ִ� ��� ������ �����ϼ���.
DELETE FROM PRODUCTS;
SELECT * FROM PRODUCTS;
ROLLBACK;

#DELETE ������ SUBQUERY ���
--- EMP2���� NEW YORK�� �ٹ��ϴ� ������� ������ �����ϼ���
--------���ؾȰ�
DELETE FROM EMP2
WHERE DEPTNO=
(SELECT DEPTNO FROM DEPT2 WHERE LOC ='NEW YORK');

SELECT * FROM EMP2;

ROLLBACK;

#DELETE �� ���Ἲ �������� ����
-DEPT2���� 30�� �μ��� �����ϼ���
--------���ؾȰ� ��?30���� �����ȵǰ� 40������ �����ؼ� ������?
DELETE FROM DEPT2 WHERE DEPTNO=30;
==>ORA-02292: integrity constraint (SCOTT.EMP2_DEPTNO_FK) violated - child record found

UPDATE EMP2 SET DEPTNO=40 WHERE DEPTNO=30;
DELETE FROM DEPT2 WHERE DEPTNO=30;

SELECT * FROM DEPT2;

SELECT * FROM EMP2;

ROLLBACK;
-----------------------------------
#TCL - TRANSACTION CONTROL LANGUAGE
- COMMIT
- ROLLBACK
- SAVEPOINT (ORCLE���� ����)

# SAVEPOINT ��� - ǥ�� SQL���� �ƴ�

UPDATE EMP2 SET ENAME='CHARSE' WHERE EMPNO=7788;
SELECT * FROM EMP2;

UPDATE EMP2 SET DEPTNO=30 WHERE EMPNO=7788;

--������ ����
--SAVEPOINT �������̸�;
SAVEPOINT POINT1;

UPDATE EMP2 SET JOB='MANAGER';

SELECT * FROM EMP2;

--ROLLBACK ===>���� �۾� ��� ��ҵȴ�
ROLLBACK TO SAVEPOINT POINT1; -- ==>POINT1 ������������ ���

ROLLBACK;

