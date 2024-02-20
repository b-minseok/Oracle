day04_join.sql

DEPT�� EMP�� JOIN
[1] EQUI JOIN (INNER JOIN)

<1> OLD VERSION

SELECT EMP.DEPTNO,DEPT.DNAME, EMPNO, ENAME, JOB
FROM DEPT, EMP
WHERE DEPT.DEPTNO = EMP.DEPTNO
ORDER BY EMP.DEPTNO ASC;

<2> NEW VERSION - ����� JOIN�� �̿� (ǥ�� SQL)
SELECT D.*, E.*
FROM DEPT D JOIN EMP E
ON D.DEPTNO = E.DEPTNO
ORDER BY D.DEPTNO;

--[�ǽ�]
--	 SALESMAN�� �����ȣ,�̸�,�޿�,�μ���,�ٹ����� ����Ͽ���.
SELECT EMPNO, ENAME, SAL, DNAME, LOC 
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO AND E.JOB='SALESMAN';

SELECT EMPNO, ENAME, SAL, DNAME, LOC 
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO WHERE E.JOB='SALESMAN';

--     ���� ������ �ִ� ī�װ� ���̺�� ��ǰ ���̺��� �̿��Ͽ� �� ��ǰ���� ī�װ�
--	      �̸��� ��ǰ �̸��� �Բ� �����ּ���.
SELECT C.CATEGORY_NAME, PRODUCTS_NAME, OUTPUT_PRICE
FROM CATEGORY C JOIN PRODUCTS P
ON C.CATEGORY_CODE = P.CATEGORY_FK ORDER BY CATEGORY_CODE;

--     ī�װ� ���̺�� ��ǰ ���̺��� �����Ͽ� ȭ�鿡 ����ϵ� ��ǰ�� ���� ��
--	      ������ü(COMPANY)�� �Ｚ�� ��ǰ�� ������ �����Ͽ� 
--          ī�װ� �̸��� ��ǰ�̸�, ��ǰ����
--	      ������ ���� ������ ȭ�鿡 �����ּ���.
SELECT CATEGORY_NAME, PRODUCTS_NAME, OUTPUT_PRICE, COMPANY
FROM PRODUCTS P JOIN CATEGORY C
ON P.CATEGORY_FK = C.CATEGORY_CODE
WHERE COMPANY = '�Ｚ';
--
--	     
--
--	�� ��ǰ���� ī�װ� �� ��ǰ��, ������ ����ϼ���. �� ī�װ��� 'TV'�� ���� 
--	      �����ϰ� ������ ������ ��ǰ�� ������ ������ ������ �����ϼ���.
SELECT CATEGORY_NAME, PRODUCTS_NAME, OUTPUT_PRICE
FROM PRODUCTS P JOIN CATEGORY C
ON P.CATEGORY_FK = C.CATEGORY_CODE
WHERE CATEGORY_NAME <> 'TV'
ORDER BY OUTPUT_PRICE;

[2] NON-EQUI JOIN
- '='�� �ƴ� �����ȣ�� ����Ͽ� �����ϴ� ���

SELECT * FROM SALGRADE;
SELECT * FROM EMP;
��������� �����ֵ� ���,�̸�,����,�޿�, �޿� ���, �޿������ ��������, �޿������ �ְ���
    �� �Բ� �����ּ���
    
SELECT EMPNO, ENAME, JOB, SAL ,GRADE, LOSAL, HISAL
FROM EMP E JOIN SALGRADE S
ON E.SAL BETWEEN S.LOSAL AND S.HISAL ORDER BY SAL DESC;

--[����]
--
---  emp���̺��� NEW YORK���� �ٹ��ϰ� �ִ� ����� ���Ͽ� �̸�,����,�޿�,
--    �μ����� ����ϴ� SELECT���� �ۼ��ϼ���.
--
--- EMP���̺��� ���ʽ��� �޴� ����� ���Ͽ� �̸�,�μ���,��ġ�� ����ϴ�
--    SELECT���� �ۼ��ϼ���.
--
--- EMP���̺��� �̸� �� L�ڰ� �ִ� ����� ���� �̸�,����,�μ���,��ġ�� 
--   ����ϴ� ������ �ۼ��ϼ���.
--
--- �Ʒ��� ����� ����ϴ� ������ �ۼ��Ͽ���(�����ڰ� ���� King�� �����Ͽ�
--	��� ����� ���)
--
--	---------------------------------------------
--	Emplyee		Emp#		Manager	Mgr#
--	---------------------------------------------
--	KING		7839
--	BLAKE		7698		KING		7839
--	CKARK		7782		KING		7839
--	.....
--	---------------------------------------------
--	14ROWS SELECTED.
