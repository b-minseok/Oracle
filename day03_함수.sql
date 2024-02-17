--day03_�Լ�.sql
# �������Լ�
[1] ������ �Լ�
[2] ������ �Լ�
[3] ��¥�� �Լ�
[4] ��ȯ �Լ�
[5] ��Ÿ �Լ�

#[1] ������ �Լ�
<1> LOWER()/UPPER()=> �ҹ��ڷ�/�빮�ڷ� ��ȯ
    SELECT LOWER('HAPPY BIRTHDAY') FROM DUAL;
    SELECT UPPER('how are you?') from dual;
    
    SELECT * FROM DUAL;
    SELECT 8*7 FROM DUAL;
    
<2> initcap() => ù ���ڸ� �빮��, �������� �ҹ���

dept���� �μ���ȣ,�μ���, �ٹ����� ����ϵ� ù���ڸ� �빮�ڷ� �����ּ���

SELECT DEPTNO, INITCAP(DNAME), INITCAP(LOC) FROM DEPT;
    
<3> CONCAT(�÷�1, �÷�2)    : �÷�1�� �÷�2�� ���������
SELECT CONCAT('ABCD','1234') FROM DUAL;
SELECT CONCAT(EMPNO,ENAME) A FROM EMP;

<4> SUBSTR(���� �Ǵ� �÷�,START,LEN)
SELECT SUBSTR('ABCDEFG', 3,2) FROM DUAL; -- CD
SELECT SUBSTR('ABCDEFG', -3,2) FROM DUAL;-- EF
SELECT SUBSTR('990215-1012345', 8,7 ) FROM DUAL;
SELECT SUBSTR('990215-1012345', -7) FROM DUAL;

<5> LENGTH(���� �Ǵ� �÷�) : ���ڿ� ���� ��ȯ

SELECT LENGTH('990215-1012345') FROM DUAL;


--[����]
--	 
--	 ��ǰ ���̺��� �ǸŰ��� ȭ�鿡 ������ �� �ݾ��� ������ �Բ� 
--	 �ٿ��� ����ϼ���.
    select output_price,concat(output_price, '��'), output_price||'��'
    from products;    
--     �����̺��� �� �̸��� ���̸� �ϳ��� �÷����� ����� ������� ȭ�鿡
--	       �����ּ���.
    SELECT CONCAT(NAME, AGE) FROM MEMBER;      
--  ��� ���̺��� ù���ڰ� 'K'���� ũ�� 'Y'���� ���� �����
--	  ���,�̸�,����,�޿��� ����ϼ���. �� �̸������� �����ϼ���. 
    SELECT EMPNO, ENAME, JOB, SAL FROM EMP 
    WHERE SUBSTR(ENAME, 1,1)>'K' AND SUBSTR(ENAME, 1,1)<'Y';
--      
--  ������̺��� �μ��� 20���� ����� ���,�̸�,�̸��ڸ���,
--	�޿�,�޿��� �ڸ����� ����ϼ���.
    SELECT EMPNO,ENAME,LENGTH(ENAME),SAL,LENGTH(SAL) FROM EMP
	WHERE DEPTNO=20;	
--	
--	������̺��� ����̸� �� 6�ڸ� �̻��� �����ϴ� ������̸��� 
--	�̸��ڸ����� �����ּ���.   
    SELECT ENAME, LENGTH(ENAME) FROM EMP
    WHERE LENGTH(ENAME)>=6;

<6> LPAD(�÷�,N,C)/RPAD(�÷�,N,C)    
    
    SELECT ENAME, LPAD(ENAME,15,'#') FROM EMP;
    
    SELECT ENAME, SAL, LPAD(CONCAT('$',SAL), 10,' ') �޿� FROM EMP;
    
    SELECT RPAD(DNAME,15,'@') FROM DEPT;

<7> LTRIM(����,����)/RTRIM(����,����)
: ������ �� �־��� ���ڿ� ���� �ܾ ���� ��� �� ���ڸ� ������ ���������� ��ȯ

SELECT LTRIM('tttHello test','t'), RTRIM('tttHello test','t') from dual;
    
select '    ������ ����    ' , length('    ������ ����    ') from dual;2   

select length(rtrim(ltrim('    ������ ����    ',' '),' ')) title from dual;    
select trim('    ������ ����    ') from dual;-- => �� ���� ���鹮�ڸ� ������

<8> REPLACE(�÷�,��1,��2) 
�÷��� �߿� ��1�� ������ ��2�� ��ü�ϴ� �Լ�

EMP���� JOB���� 'A'�� '$'�� �ٲپ� ���

SELECT JOB, REPLACE(JOB,'A','$') FROM EMP;
    

--�� ���̺��� ������ �ش��ϴ� �÷����� ���� ������ �л��� ������ ���
--	 ���л����� ������ ��µǰ� �ϼ���.
    SELECT NAME,JOB, REPLACE(JOB,'�л�','���л�') FROM MEMBER;
--
--�� ���̺� �ּҿ��� ����ø� ����Ư���÷� �����ϼ���.  
    SELECT NAME,ADDR, REPLACE(ADDR,'�����','����Ư����') FROM MEMBER;
    
    UPDATE MEMBER SET ADDR=REPLACE(ADDR,'�����','����Ư����');
    
    SELECT * FROM MEMBER;
    
    ROLLBACK;    
--������̺��� 10�� �μ��� ����� ���� ������ �� ������'T'��
--	�����ϰ� �޿��� ������ 0�� �����Ͽ� ����ϼ���.     
SELECT JOB, RTRIM(JOB,'T'), SAL, RTRIM(SAL,0)
FROM EMP
WHERE DEPTNO=10;
-----------------------------------------------------
[2] ������ �Լ�
<1> ROUND(��), ROUND(X, Y) : �ݿø� �Լ�
�Ҽ����� ������(����)���� Y�ڸ���ŭ �ݿø��� X�� ���

SELECT ROUND(456.678), ROUND(456.478,0),
ROUND(456.678,2), ROUND(456.678,-2) FROM DUAL;

<2> TRUNC(��), TRUNC(X,Y) : ���� �Լ�. ����

SELECT TRUNC(456.678), TRUNC(456.678,0),
TRUNC(456.678,2), TRUNC(456.678,-2) FROM DUAL;

<3> MOD(X,Y): ���������� ���ϴ� �Լ�
SELECT MOD(10,3) FROM DUAL;
<4> ABS(��): ���밪 ���ϴ� �Լ�
SELECT ABS(-9), ABS(9) FROM DUAL;

<5> CEIL(��)/FLOOR(��): �ø��Լ�/�����Լ�
SELECT CEIL(123.0001), FLOOR(123.0001) FROM DUAL;

<6> CHR(��)/ASCII(��)
SELECT CHR(65), ASCII('F') FROM DUAL;

--- ȸ�� ���̺��� ȸ���� �̸�, ���ϸ���,����, ���ϸ����� ���̷� ���� ���� �ݿø��Ͽ�
--�����ּ���
    SELECT NAME, MILEAGE, AGE, ROUND(MILEAGE/AGE)
    FROM MEMBER;

--- ��ǰ ���̺��� ��ǰ ������� ����������� ���� ��ۺ� ���Ͽ� ����ϼ���.
    SELECT PRODUCTS_NAME, TRANS_COST, TRUNC(TRANS_COST,-3)
    FROM PRODUCTS;

---������̺��� �μ���ȣ�� 10�� ����� �޿��� 
--	30���� ���� �������� ����ϼ���.
    SELECT ENAME, SAL, MOD(SAL,30)
    FROM EMP
    WHERE DEPTNO=10;
    
    SELECT NAME, AGE, ABS(AGE-40) FROM MEMBER;
----------------------------------------------------------------
[3] ��¥ �Լ�

SELECT SYSDATE,SYSDATE +3, SYSDATE-3, TO_CHAR(SYSDATE +3/24,'YY/MM/DD HH:MI:SS') FROM DUAL;

dATE+(-)����: �ϼ��� ���ϰų� ����

DATE-DATE : �ϼ�

SELECT NAME, REG_DATE, FLOOR(SYSDATE -REG_DATE) "��� ���� �ϼ�" FROM MEMBER;

--[�ǽ�]
--	������̺��� ��������� �ٹ� �ϼ��� �� �� �����ΰ��� ����ϼ���.
--	�� �ٹ��ϼ��� ���� ��������� ����ϼ���.
select ename, trunc((sysdate-hiredate)/7) WEEKS, trunc(mod(sysdate-hiredate,7)) days
from emp ORDER BY 2 DESC;

<1> months_between(date1, date2)
: �� ��¥ ������ ������ ����
  ���� �κ�=> ��, �Ҽ� �κ�=> ��
  
  SELECT ENAME,MONTHS_BETWEEN(SYSDATE, HIREDATE) FROM EMP
  ORDER BY 2 DESC;
  
  SELECT NAME, REG_DATE, MONTHS_BETWEEN(SYSDATE,REG_DATE) FROM MEMBER;
  
<2> ADD_MONTHS(DATE,M) : ���� ����  
SELECT ADD_MONTHS(SYSDATE,5) "5���� ��", ADD_MONTHS(SYSDATE,-3) "���� ��" FROM DUAL;

SELECT ADD_MONTHS('22/01/31', 8) FROM DUAL;

<3> LAST_DAY(DATE) : ���� ������ ��¥�� ����
SELECT LAST_DAY(SYSDATE), LAST_DAY('23/02/01') FROM DUAL;

<4> SYSDATE, SYSTIMESTAMP
SELECT SYSDATE, SYSTIMESTAMP FROM DUAL;

SELECT TO_CHAR(SYSDATE,'YYYY-MM-DD HH24:MI:SS') FROM DUAL;

SELECT TO_CHAR(SYSDATE,'CC YEAR-MONTH-DDD DY') FROM DUAL;
--------------------------------------------
[4] ��ȯ �Լ�

<1> TO_CHAR(��¥) 
<2> TO_DATE(����)
<3> TO_CHAR(����)
<4> TO_NUMBER(����)

- �����̺��� ������ڸ� 0000-00-00 �� ���·� ����ϼ���.
    SELECT NAME, TO_CHAR(REG_DATE, 'YYYY-MM-DD') FROM MEMBER;
    
-  �����̺� �ִ� �� ���� �� ��Ͽ����� 2023���� 
-	 ���� ������ �����ּ���.
    SELECT NAME, REG_DATE FROM MEMBER 
    WHERE TO_CHAR(REG_DATE, 'YYYY')='2023';
    
- �����̺� �ִ� �� ���� �� ������ڰ� 2023�� 5��1�Ϻ��� 
-	 ���� ������ ����ϼ���. 
-	 ��, ����� ������ ��, ���� ���̵��� �մϴ�.
    select NAME, to_char(reg_date,'YY/MM')
    from member
    where reg_date > to_date('2023/05/01','YYYY/MM/DD');
    
# TO_DATE(����,����): ���ڿ��� DATE�������� ��ȯ�ϴ� �Լ�

    SELECT TO_DATE('22-08-19','YY-MM-DD') +3 FROM DUAL;
    SELECT SYSDATE - TO_DATE('20191107','YYYYMMDD') FROM DUAL;
    
# TO_CHAR(����,����)
SELECT TO_CHAR(1500000,'L9,999,999') FROM DUAL;
    
-- 73] ��ǰ ���̺��� ��ǰ�� ���� �ݾ��� ���� ǥ�� ������� ǥ���ϼ���.
--	  õ�ڸ� ���� , �� ǥ���մϴ�
    SELECT PRODUCTS_NAME, TO_CHAR(INPUT_PRICE,'9,999,999') ���ް� FROM PRODUCTS;    
--  74] ��ǰ ���̺��� ��ǰ�� �ǸŰ��� ����ϵ� ��ȭ�� ǥ���� �� ����ϴ� �����
--	  ����Ͽ� ����ϼ���.[��: \10,000]  
    select products_name,to_char(output_price,'c9,999,999')
    from products;
# TO_NUMBER(����,����): CHAR,VARCHAR2�� ���ڷ� ��ȯ
SELECT TO_NUMBER('150,000','999,999') * 2 FROM DUAL;

-- '$450.25' �� 3�谪�� ���ϼ���
SELECT TO_NUMBER('$450.25','$999D99')*3 FROM DUAL;

SELECT TO_CHAR(-23,'99S'), TO_CHAR(23,'99D99'), TO_CHAR(23,'99.99EEEE') FROM DUAL;
------------------------------------------------------------------------------
# �׷� �Լ�
: ���� �� �Ǵ� ���̺� ��ü�� �Լ��� ����Ǿ� �ϳ��� ����� �������� �Լ��� �ǹ�
<1> COUNT(�÷���) : NULL���� �����ϰ� ī��Ʈ�� ����
    COUNT(*) : NULL���� �����Ͽ� ī��Ʈ�� ����
    SELECT * FROM EMP;
    SELECT COUNT(MGR) "�����ڰ� �ִ� �����", COUNT(COMM) "���ʽ��� �޴� �����" FROM EMP;
    SELECT COUNT(DISTINCT MGR) "�����ڼ�" FROM EMP;
    SELECT COUNT(EMPNO) FROM EMP;
    SELECT COUNT(*) FROM EMP;
    
    CREATE TABLE TEST(
    A NUMBER(2),
    B CHAR(3),
    C VARCHAR2(10)
    );
    DESC TEST;
    SELECT COUNT(*) FROM TEST;
    INSERT INTO TEST VALUES(NULL,NULL,NULL);
    INSERT INTO TEST VALUES(NULL,NULL,NULL);
    SELECT * FROM TEST;
    
    SELECT COUNT(A) FROM TEST; -- 0
    SELECT COUNT(*) FROM TEST; -- 2
    COMMIT;
    
--     [�ǽ�]
--		 emp���̺��� ��� SALESMAN�� ���Ͽ� �޿��� ���,
--		 �ְ��,������,�հ踦 ���Ͽ� ����ϼ���.
        
        SELECT ROUND(AVG(SAL)), MAX(SAL), MIN(SAL), SUM(SAL) 
        FROM EMP WHERE JOB='SALESMAN';        
        
--         EMP���̺� ��ϵǾ� �ִ� �ο���, ���ʽ��� NULL�� �ƴ� �ο���,
--		���ʽ��� ���,��ϵǾ� �ִ� �μ��� ���� ���Ͽ� ����ϼ���.
        select count(*),count(comm),avg(comm),count(DISTINCT deptno)
            from emp;
���: WGHO ��
# GROUP BY ��
: GROUP BY�������� �׷��Լ��� GROUP BY���� ����� �÷��� SELECT�� �� ������ ��������

SELECT JOB,COUNT(*)
FROM MEMBER
GROUP BY JOB
ORDER BY COUNT(*) DESC;

--17] �� ���̺��� ������ ����, �� ������ ���� �ִ� ���ϸ��� ������ �����ּ���.
    SELECT JOB , MAX(MILEAGE)
    FROM MEMBER
    GROUP BY JOB;
--18] ��ǰ ���̺��� �� ��ǰī�װ����� �� �� ���� ��ǰ�� �ִ��� �����ּ���.
    select category_fk,count(category_fk)
    from products
    group by category_fk ORDER BY 1;
--19] ��ǰ ���̺��� �� ���޾�ü �ڵ庰(EP_CODE_FK)�� 
-- ������ ��ǰ�� ����԰��� �����ּ���.
    select ep_code_fk, ROUND(avg(input_price))
    from products
    group by ep_code_fk;

    
--    ����1] ��� ���̺��� �Ի��� �⵵���� ��� ���� �����ּ���.
    select to_char(hiredate, 'yy') as year, count(*)
    from emp
    group by to_char(hiredate, 'yy') order by year asc;

--	����2] ��� ���̺��� �ش�⵵ �� ������ �Ի��� ������� �����ּ���.
    
    SELECT TO_CHAR(HIREDATE, 'YYYY-MM'), COUNT(*) 
    FROM EMP GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM') 
    ORDER BY TO_CHAR(HIREDATE, 'YYYY-MM');
    
--	����3] ��� ���̺��� ������ �ִ� ����, �ּ� ������ ����ϼ���.
    select job,max(sal),min(sal)
    from emp
    group by job;

    SELECT job, MAX(sal * 12 + nvl(comm, 0)), MIN(sal * 12 + nvl(comm, 0))
    FROM emp
    GROUP BY job;
    
    