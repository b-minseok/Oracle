--day04_join.sql

DEPT�� EMP�� JOIN
[1] EQUI JOIN (INNER JOIN)

<1> OLD VERSION

SELECT EMP.DEPTNO,DNAME, EMPNO, ENAME, JOB
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

    SELECT E.EMPNO,E.ENAME,E.JOB,E.SAL,E.DEPTNO,D.LOC
    FROM EMP E JOIN DEPT D 
    ON E.DEPTNO=D.DEPTNO WHERE E.JOB='SALESMAN';

--     ���� ������ �ִ� ī�װ� ���̺�� ��ǰ ���̺��� �̿��Ͽ� �� ��ǰ���� ī�װ�
--	      �̸��� ��ǰ �̸��� �Բ� �����ּ���.

    SELECT C.CATEGORY_NAME, PRODUCTS_NAME, OUTPUT_PRICE
    FROM CATEGORY C JOIN PRODUCTS P
    ON C.CATEGORY_CODE = P.CATEGORY_FK ORDER BY CATEGORY_CODE;

--     ī�װ� ���̺�� ��ǰ ���̺��� �����Ͽ� ȭ�鿡 ����ϵ� ��ǰ�� ���� ��
--	      ������ü(COMPANY)�� �Ｚ�� ��ǰ�� ������ �����Ͽ� 
--          ī�װ� �̸��� ��ǰ�̸�, ��ǰ����
--	      ������ ���� ������ ȭ�鿡 �����ּ���.	     
    select category_name, products_name, output_price, company
    from category c join products p
    on c.category_code = p.category_fk
    where company='�Ｚ';
    
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
    
    ��������� �����ֵ� ���,�̸�,����,�޿�, �޿� ���, �޿������ ��������, 
    �޿������ �ְ����� �Բ� �����ּ���
    
    SELECT EMPNO,ENAME,JOB,SAL,GRADE, LOSAL, HISAL
    FROM EMP E JOIN SALGRADE S
    ON E.SAL BETWEEN S.LOSAL AND S.HISAL ORDER BY SAL DESC;
    
[3] OUTER JOIN
- ���� ���̺� ��ġ�ϴ� ���� ������ �ٸ��� ���̺��� NULL�� �Ͽ� ���� ������

    <1> OLD VERSION
    SELECT D.*, ENAME, E.DEPTNO,SAL
    FROM DEPT D, EMP E
    WHERE D.DEPTNO = E.DEPTNO(+)  ORDER BY 1;

   <2> LEFT OUTER JOIN/ RIGHT OUTER JOIN/ FULL OUTER JOIN
   -- LEFT OUTER JOIN
   SELECT D.DEPTNO,DNAME, ENAME, E.DEPTNO, SAL
   FROM DEPT D LEFT OUTER JOIN EMP E
   ON D.DEPTNO = E.DEPTNO ORDER BY 1;
    
    -- RGITH OUTER JOIN
    SELECT DISTINCT(E.DEPTNO), D.DEPTNO
    FROM EMP E RIGHT OUTER JOIN DEPT D
    ON E.DEPTNO = D.DEPTNO ORDER BY 1;
    
    -- FULL OUTER JOIN
    SELECT DISTINCT(E.DEPTNO), D.DEPTNO
    FROM EMP E FULL OUTER JOIN DEPT D
    ON E.DEPTNO = D.DEPTNO ORDER BY 1;
    
--    ����98] ��ǰ���̺��� ��� ��ǰ�� ���޾�ü, ���޾�ü�ڵ�, ��ǰ�̸�, 
--      ��ǰ���ް�, ��ǰ �ǸŰ� ������ ����ϵ� ���޾�ü�� ����
--      ��ǰ�� ����ϼ���(��ǰ�� ��������).
    SELECT EP_NAME, EP_CODE, PRODUCTS_NAME, INPUT_PRICE, OUTPUT_PRICE
    FROM PRODUCTS P LEFT OUTER JOIN SUPPLY_COMP S
    ON P.EP_CODE_FK = S.EP_CODE ORDER BY 1;
    
    SELECT EP_NAME, EP_CODE, PRODUCTS_NAME, INPUT_PRICE, OUTPUT_PRICE
    FROM PRODUCTS P,  SUPPLY_COMP S
    WHERE P.EP_CODE_FK = S.EP_CODE(+) 
    ORDER BY 1;    
--
--	����99] ��ǰ���̺��� ��� ��ǰ�� ���޾�ü, ī�װ���, ��ǰ��, ��ǰ�ǸŰ�
--		������ ����ϼ���. ��, ���޾�ü�� ��ǰ ī�װ��� ���� ��ǰ��
--		����մϴ�.

    SELECT EP_NAME,CATEGORY_NAME, PRODUCTS_NAME, OUTPUT_PRICE
    FROM SUPPLY_COMP S RIGHT OUTER JOIN PRODUCTS P
    ON S.EP_CODE = P.EP_CODE_FK
    LEFT OUTER JOIN CATEGORY C
    ON C.CATEGORY_CODE = P.CATEGORY_FK;
    
[4] SELF JOIN
- �ڱ��ڽ��� ���̺�� JOIN�ϴ� ���

SELECT E.EMPNO, E.ENAME, E.MGR "MGR NO", M.ENAME "MGR NAME"
FROM EMP E JOIN EMP M
ON E.MGR = M.EMPNO;
    
--    [����] emp���̺��� "������ �����ڴ� �����̴�"�� ������ ����ϼ���.
SELECT E.ENAME||'�� �����ڴ� '||M.ENAME||'�Դϴ�'
FROM EMP E JOIN EMP M
ON E.MGR = M.EMPNO ORDER BY 1;

[5] CARTESIAN PRODUCT �Ǵ� CROSS JOIN
    - ��� ����� ���� ==> ���ʿ��� �����Ͱ� ����
    - ���� ������ ������ ���
    - ���� ������ �߸��� ���

SELECT D.DEPTNO,DNAME, E.DEPTNO, ENAME
FROM
DEPT D , EMP E ORDER BY 1 ASC,3 ASC;
-- => DEPT�� 4�� ��� X EMO�� 14�� �� ==> 56���� ���� ��µ�

[6] ���� ������ - SET OPERATOR

    SELECT �÷���1,... FROM TABLE1
    ���� ������ (UNION,INTERSECT, MINUS)
    SELECT �÷���1,... FROM TABLE2
    
    <1> UNION/ UNION ALL : ������
   -- UNION : �ߺ��Ǵ� ���� �ѹ��� ���
    SELECT DEPTNO FROM DEPT
    UNION
    SELECT DEPTNO FROM EMP;
    
  -- UNION ALL : ��� ������ ������
    SELECT DEPTNO FROM DEPT
    UNION ALL
    SELECT DEPTNO FROM EMP;
    
  =>  DEPT�� 4�� + EMP 14�� =>18�� �� ���
  
  <2> ������ (INERSECT)
  SELECT DEPTNO FROM DEPT
  INTERSECT
  SELECT DEPTNO FROM EMP;
  
  <3> ������ (MINUS)
  SELECT DEPTNO FROM DEPT
  MINUS
  SELECT DEPTNO FROM EMP;
  
--[����]
--
---  emp���̺��� NEW YORK���� �ٹ��ϰ� �ִ� ����� ���Ͽ� �̸�,����,�޿�,
--    �μ����� ����ϴ� SELECT���� �ۼ��ϼ���.

    SELECT ENAME,JOB,SAL, DNAME, LOC
    FROM EMP E JOIN DEPT D
    ON E.DEPTNO = D.DEPTNO AND D.LOC='NEW YORK';

--- EMP���̺��� ���ʽ��� �޴� ����� ���Ͽ� �̸�,�μ���,��ġ�� ����ϴ�
--    SELECT���� �ۼ��ϼ���.
    SELECT ENAME, DNAME, LOC, COMM
    FROM EMP E, DEPT D
    WHERE E.DEPTNO = D.DEPTNO AND COMM IS NOT NULL;

--- EMP���̺��� �̸� �� L�ڰ� �ִ� ����� ���� �̸�,����,�μ���,��ġ�� 
--   ����ϴ� ������ �ۼ��ϼ���.
    SELECT ENAME, JOB, DNAME, LOC
    FROM EMP E JOIN DEPT D
    ON E.DEPTNO = D.DEPTNO
    WHERE ENAME LIKE '%L%';

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

SELECT E.ENAME Employee, E.EMPNO "Emp#",
nvl(M.ENAME,' ') Manager, nvl(to_char(M.empno),' ') "Mgr#"
FROM EMP E left outer JOIN EMP M
ON E.MGR = M.EMPNO
ORDER BY 3 ;





