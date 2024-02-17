--day02_select.sql
desc dept;
select * from dept;

desc emp;
select * from emp;
SELECT ENAME, JOB, SAL, (SAL+300)*2 AS SALUP FROM EMP ORDER BY SALUP DESC;
--[1] EMP���̺��� ���(EMPNO), �̸�(ENAME), �޿�(SAL), ���ʽ�(COMM)�� ������ 
--   �����ּ���
SELECT EMPNO, ENAME, SAL, COMM FROM EMP;
--[2] ������̺��� �����, �޿�, �޿��� 10%�λ���� ������ �����ּ���
SELECT ENAME, SAL, SAL+SAL*0.1 SALUP_10, SAL *1.1 "10% �޿� �λ��" FROM EMP;
--[3]  ������̺��� �����, �޿�,���ʽ�, 1�� ������ ����� �����ּ���
--1�� ����=�޿�*12 +���ʽ�(COMM)
SELECT ENAME, SAL, COMM, SAL*12+COMM "1�� ����"
FROM EMP;

--NVL(�÷���, ��) �Լ� Ȱ��
--=> �ش��÷����� NULL�϶� ������ ������ ��ȯ�ϴ� �Լ�

SELECT ENAME, SAL, COMM, SAL*12+NVL(COMM,0) "1�� ����"
FROM EMP; --??????????? 

NVL2�Լ�
NVL2(�÷���, ��1, ��2)
�÷����� NULL�� �ƴϸ� ��1�� ��ȯ, NULL�̸� ��2�� ��ȯ�ϴ� �Լ�

--��� ���̺��� ������(MGR)�� �ִ� ���� 1, ������ 0��
--������ �Բ� ����Ͻÿ�
SELECT ENAME, MGR, NVL2(MGR,1,0) "������ ���� ����" FROM EMP;

--"SMITH IS A CLERK"
SELECT ENAME||' IS A '||JOB "EMPLOYEES DETAIL"FROM EMP;

--DISTINCT - �ߺ��� ����
SELECT JOB FROM EMP;
SELECT DISTINCT JOB FROM EMP;

--�μ� ���� ����ϴ� ����
SELECT DISTINCT DEPTNO, JOB FROM EMP ORDER BY DEPTNO ASC;

[����]
--	 1] EMP���̺��� �ߺ����� �ʴ� �μ���ȣ�� ����ϼ���.
SELECT DISTINCT DEPTNO
FROM EMP
ORDER BY DEPTNO;
--	 2] MEMBER���̺��� ȸ���� �̸��� ���� ������ �����ּ���.
SELECT NAME, AGE, JOB
FROM MEMBER;
--	 3] CATEGORY ���̺� ����� ��� ������ �����ּ���.
SELECT * 
FROM CATEGORY;
--	 4] MEMBER���̺��� ȸ���� �̸��� ������ ���ϸ����� �����ֵ�,
--	      ���ϸ����� 13�� ���� ����� "MILE_UP"�̶�� ��Ī����
--	      �Բ� �����ּ���.
SELECT NAME, MILEAGE, MILEAGE * 13 AS "MILE_UP"
FROM MEMBER;
--
--    5] EMP���̺��� �̸��� ������ "KING: 1 YEAR SALARY = 60000"
--	�������� ����϶�
SELECT ENAME||': 1 YEAR SALARY = '||SAL*12 AS anual_sal
FROM EMP;

# WHERE ���� �̿��� Ư���� �˻�
--EMP���� �޿��� 3000�̻��� ����� ���,�̸� ����, �޿��� �����ּ���
SELECT EMPNO, ENAME, JOB, SAL
FROM EMP
WHERE SAL >= 3000;
--EMP���̺��� �������� MANAGER�� �����
--	������ �����ȣ,�̸�,����,�޿�,�μ���ȣ�� ����ϼ���.
SELECT EMPNO, ENAME, JOB, SAL, DEPTNO
FROM EMP
WHERE LOWER(JOB) = 'manager';
--EMP���̺��� 1982�� 1��1�� ���Ŀ� �Ի��� ����� 
--�����ȣ,����,����,�޿�,�Ի����ڸ� ����ϼ���. (HIREDATE-�Ի���)
SELECT EMPNO, ENAME, JOB, SAL, HIREDATE
FROM EMP
WHERE HIREDATE >= '82/01/01' ORDER BY HIREDATE;

#���ڰ��� ��ҹ��ڸ� �����Կ� ����
#��¥���� ��¥ ������ �����Ѵ�

--[�ǽ�]
--	[1] emp���̺��� �޿��� 1300���� 1500������ ����� �̸�,����,�޿�,
--	�μ���ȣ�� ����ϼ���
SELECT ENAME, JOB, SAL, DEPTNO
FROM emp
WHERE SAL BETWEEN 1300 AND 1500;
    -- WHERE SAL >=1300 AND SAL <=1500;
--  [2] emp���̺��� �����ȣ�� 7902,7788,7566�� ����� �����ȣ,
--	�̸�,����,�޿�,�Ի����ڸ� ����ϼ���.
SELECT EMPNO, ENAME, JOB, SAL, HIREDATE
FROM emp
WHERE EMPNO IN (7902, 7788, 7566);
--WHERE EMPNO=7902 OR EMPNO=7788 OR EMPNO=7566;
--    
-- [3] 10�� �μ��� �ƴ� ����� �̸�,����,�μ���ȣ�� ����ϼ���
SELECT ENAME, JOB, DEPTNO
FROM emp
WHERE DEPTNO <> 10 ORDER BY 3;
--WHERE DEPTNO NOT IN (10);

--[4] emp���̺��� ������ SALESMAN �̰ų� PRESIDENT��
--	����� �����ȣ,�̸�,����,�޿��� ����ϼ���.
    SELECT EMPNO, ENAME, JOB, SAL
    FROM emp
    WHERE JOB = 'SALESMAN' OR JOB = 'PRESIDENT';
    --WHERE JOB IN ('SALESMAN', 'PRESIDENT');
--	[5] Ŀ�̼�(COMM)�� 300�̰ų� 500�̰ų� 1400�� ��������� ����ϼ���
    SELECT *
    FROM emp
    where COMM = 300 OR COMM = 500 OR COMM = 1400;
    --WHERE COMM IN (300, 500, 1400);
--	[6] Ŀ�̼��� 300,500,1400�� �ƴ� ����� ������ ����ϼ���
    SELECT *
    FROM emp
    where COMM NOT IN (300,500,1400);
    
   -- EMP���� �̸��� S�� �����ϴ� ��� ������ �����ּ���
    SELECT * FROM EMP
    WHERE ENAME LIKE 'S%';
    
--    EMP���� �̸��� S�� ������ ��� ������ �����ּ���
    SELECT * FROM EMP
    WHERE ENAME LIKE '%S';
--    S�ڰ� ����ִ� ��� ���� ���
    SELECT * FROM EMP
    WHERE ENAME LIKE '%S%';
    
--    �̸� �ι�° ���ڿ� 'O'�ڰ� �� ��� ����
    SELECT * FROM EMP
    WHERE ENAME LIKE '_O%';
--    --[����]
--	
--	- ��(MEMBER) ���̺� ��� ���� �达�� ����� ������ �����ּ���.
SELECT *
FROM MEMBER
WHERE NAME LIKE '��%';
--	- �� ���̺� ��� '����'�� ���Ե� ������ �����ּ���.
SELECT *
FROM MEMBER
WHERE ADDR LIKE '%����%';
--
--	- ī�װ� ���̺� ��� category_code�� 0000�� ������ ��ǰ������ �����ּ���.
SELECT *
FROM CATEGORY
WHERE category_code LIKE '%0000';
--	- EMP���̺��� �Ի����ڰ� 82�⵵�� �Ի��� ����� ���,�̸�,����
--	   �Ի����ڸ� ����ϼ���.
SELECT EMPNO, ENAME, JOB, HIREDATE
FROM EMP
WHERE HIREDATE LIKE '82%';

#��¥ ���� ����
ALTER SESSION SET NLS_DATE_FORMAT='YYYY-MM-DD';
ALTER SESSION SET NLS_DATE_FORMAT='DD-MON=YY';
ALTER SESSION SET NLS_DATE_FORMAT='YY/MM/DD';
SELECT ENAME, HIREDATE FROM EMP;

���ʽ� ������ ���޴� �������� ��������� �����ּ���
SELECT * FROM EMP
WHERE COMM = NULL;

#���� : NULL ���� ��ȣ(=)�� ���� �� ����
IS NULL
IS NOT NULL

SELECT * FROM EMP
WHERE COMM IS NULL;

SELECT * FROM EMP
WHERE COMM <> NULL; --[X]

SELECT * FROM EMP
WHERE COMM IS NOT NULL; --[O]

#�� ������
AND 
OR 
NOT

--[����]
--	- EMP���̺��� �޿��� 1000�̻� 1500���ϰ� �ƴ� �����
SELECT *
FROM EMP
WHERE NOT (SAL >=1000 AND SAL <= 1500);

SELECT * FROM EMP
WHERE SAL NOT BETWEEN 1000 AND 1500;
--
-- EMP���̺��� �̸��� 'S'�ڰ� ���� ���� ����� �̸��� ���
--	  ����ϼ���.
SELECT ENAME
FROM EMP
WHERE ENAME NOT LIKE '%S%';
--������̺��� ������ PRESIDENT�̰� �޿��� 1500�̻��̰ų�
--������ SALESMAN�� ����� ���,�̸�,����,�޿��� ����ϼ���.
SELECT EMPNO, ENAME, JOB, SAL
FROM EMP
WHERE JOB = 'PRESIDENT' AND SAL >= 1500 OR JOB = 'SALESMAN';

--- �� ���̺��� �̸��� ȫ�浿�̸鼭 ������ �л��� ������ 
--	    ��� �����ּ���.
SELECT *
FROM MEMBER
WHERE NAME = 'ȫ�浿' AND JOB = '�л�';
--	- �� ���̺��� �̸��� ȫ�浿�̰ų� ������ �л��� ������ 
--	��� �����ּ���.
SELECT *
FROM MEMBER
WHERE NAME = 'ȫ�浿' OR JOB = '�л�';
--	- ��ǰ ���̺��� �����簡 S�� �Ǵ� D���̸鼭 
--	   �ǸŰ��� 100���� �̸��� ��ǰ ����� �����ּ���
SELECT *
FROM PRODUCTS
WHERE (COMPANY = '�Ｚ' OR COMPANY ='���') AND OUTPUT_PRICE < 1000000;

# ORDER BY
    -ASC: ��������
    -DESC: ��������
    
EMP���� �ֱ� �Ի��� ������ ���,�̸�,����,�Ի������� �����ּ���

SELECT EMPNO, ENAME, JOB, HIREDATE
FROM EMP
ORDER BY HIREDATE DESC;

--��� ���̺��� �μ���ȣ�� ������ �� �μ���ȣ�� ���� ���
--	�޿��� ���� ������ �����Ͽ� ���,�̸�,����,�μ���ȣ,�޿���
--	����ϼ���.
SELECT EMPNO, ENAME,JOB, DEPTNO, SAL
FROM EMP
ORDER BY DEPTNO ASC,SAL DESC;
--    
--    ��� ���̺��� ù��° ������ �μ���ȣ��, �ι�° ������
--	������, ����° ������ �޿��� ���� ������ �����Ͽ�
--	���,�̸�,�Ի�����,�μ���ȣ,����,�޿��� ����ϼ���.
SELECT EMPNO, ENAME, HIREDATE, DEPTNO, JOB, SAL
FROM EMP
ORDER BY DEPTNO, JOB, SAL DESC;
--��ǰ ���̺��� ��ۺ��� ������������ �����ϵ�, 
--	    ���� ��ۺ� �ִ� ��쿡��
--		���ϸ����� ������������ �����Ͽ� �����ּ���.
SELECT *
FROM PRODUCTS
ORDER BY TRANS_COST DESC,MILEAGE DESC;

SELECT *
FROM PRODUCTS
ORDER BY 7 DESC, 8 DESC;
