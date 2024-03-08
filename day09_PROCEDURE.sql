--day09_PROCEDURE.sql
PL/SQL �� �̿��� ���ν��� �����

[1] �͸� ������ ���ν��� ����
[2] �̸� ���� ���ν��� ����
------------------------------------------
set serveroutput on;
[1] �͸� ������ ���ν��� ����
DECLARE
-- �����
   I_MSG VARCHAR2(100);
   today timestamp;
BEGIN
-- �����
   I_MSG := 'Hello World~'; -- ������ ���� �Ҵ�
   select systimestamp into today
   from dual;   
   dbms_output.put_line(i_msg); -- ������ ���
   dbms_output.put_line(today);
END;
/
----------------------------------------

--���� �ð����� 1 �ð����� 3�ð� ���� �ð��� ���� ����ϴ� ���ν����� �ۼ��ϼ���
declare
    hour1 timestamp;
    hour3 timestamp;
begin
    select systimestamp - 1/24 into hour1 from dual;
    select systimestamp + 3/24 into hour3 from dual;
    dbms_output.put_line('1�ð� ��: '||hour1);
    dbms_output.put_line('3�ð� ��: '||hour3);
end;
/
--------------------------------------------------------------
[2] �̸� ���� ���ν��� ����
java_member ���̺� �����͸� �����ϴ� ���ν����� �ۼ��ϼ���
id,pw,name,tel ==> in parameter
------------------------------------------
create or replace procedure java_member_add(
   p_id in varchar2,
   p_pw in varchar2,
   p_name in varchar2,
   p_tel in varchar2
)
is
begin
    insert into java_member(id,pw,name,tel)
    values(p_id,p_pw,p_name,p_tel);
    commit;
    dbms_output.put_line(p_name||'���� ������ ����߾��');
    --���� ó��
    exception
    when dup_val_on_index then
    dbms_output.put_line(p_id||'���� ���̵� �̹� �����մϴ�- ��Ͻ���!!');    
end;
/
------------------------------------------
EXECUTE JAVA_MEMBER_ADD('CCDD','222','�����','010-4545-7878');
EXEC JAVA_MEMBER_ADD('AABB','333','�ֿ볲','011-5555-6666');
EXEC JAVA_MEMBER_ADD('hong2','333','ȫ�볲','011-7555-6666');

SELECT * FROM JAVA_MEMBER;
--
--[�ǽ�]
--EMP���� �μ���ȣ�� �λ���(10,20) �� �Ķ���ͷ� �޾Ƽ� 
--�ش� �μ��� ������� �޿��� �λ��� ��ŭ �λ��ϴ� ���ν����� �ۼ��ϼ���
--���ν�����: EMP_SALUP

create or replace procedure emp_salup(e_deptno in number, sal_ratio in number)
is
begin
update emp set sal=sal+(sal*sal_ratio/100) where deptno=e_deptno;
-- commit;
dbms_output.put_line(e_deptno||'�μ� ������ �޿��� �λ��߾��');
end;
/
rollback;
exec emp_salup(20,20);
select * from emp where deptno=20;

create or replace procedure EMP_SALUP(
    p_deptno in number,
    p_uprate in number
)
is
begin
    update emp set sal=sal*(1+p_uprate*0.01) where deptno=p_deptno;
    -- commit;
    dbms_output.put_line(p_deptno||'�� �μ��� �޿��� '||p_uprate||'% ��ŭ �λ�ƾ��');
end;
/
select ename,sal from emp where deptno=30;

exec emp_salup(30,10);
rollback;
--------------------------------------------------
PL/SQL�� �ڷ���
- scalar
- composite
- reference
- lob

[1] %type �� ����� �ڷ��� ����
-- ����� �� �Ķ���ͷ� �޾�
-- �ش� ����� �̸�, ������, �޿��� ����ϴ� ���ν���
------------------------------------------------
SET SERVEROUTPUT ON
CREATE OR REPLACE PROCEDURE EMP_INFO(PNO IN EMP.EMPNO%TYPE)
IS
    VNAME EMP.ENAME%TYPE;
    VJOB EMP.JOB%TYPE;
    VSAL EMP.SAL%TYPE;
BEGIN
    SELECT ENAME, JOB, SAL
    INTO VNAME,VJOB,VSAL
    FROM EMP
    WHERE EMPNO = PNO;
    
    DBMS_OUTPUT.PUT_LINE('���  : '||PNO);
    DBMS_OUTPUT.PUT_LINE('����� : '||VNAME);
    DBMS_OUTPUT.PUT_LINE('����  : '||VJOB);
    DBMS_OUTPUT.PUT_LINE('�޿�  : '||VSAL);    
END;
/
EXEC EMP_INFO(7369);
----------------------------------------
[2] %ROWTYPE
--��ǰ��ȣ�� IN �Ķ���ͷ� �����ϸ�
--�ش��ǰ ����(��ǰ��, �ǸŰ�, ��ۺ�)�� 
--������ ����ϴ� ���ν���
----------------------------------------------
CREATE OR REPLACE PROCEDURE PROD_INFO
(PNO IN PRODUCTS.PNUM%TYPE)
IS
  VPROD PRODUCTS%ROWTYPE; -- ���̺��� ROW�� ���� Ÿ��
BEGIN
    SELECT PRODUCTS_NAME, OUTPUT_PRICE, TRANS_COST
    INTO VPROD.PRODUCTS_NAME, VPROD.OUTPUT_PRICE, VPROD.TRANS_COST
    FROM PRODUCTS
    WHERE PNUM = PNO;
    
    DBMS_OUTPUT.PUT_LINE(VPROD.PRODUCTS_NAME||'  '||VPROD.OUTPUT_PRICE||'  '||VPROD.TRANS_COST);
    
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE(PNO||'�� ��ǰ�� �����ϴ�');
END;
/
----------------------------------------------
EXEC PROD_INFO(19);

# ���� ������ Ÿ��
[1] TABLE
[2] RECORD
------------------------------------------
[1] TABLE
- TYPE ���̺�Ÿ�Ը� IS TABLE OF �÷��ڷ���
  INDEX BY BINARY_INTEGER;

  ������ ���̺�Ÿ�Ը�;
  ������ BINARY_INTEGER :=�⺻��
--  
--  [�ǽ�]
--  �μ���ȣ�� ���Ķ���ͷ� �����ϸ�
--  �ش� �μ��� �����, �������� ������ ���
----------------------------------------------
CREATE OR REPLACE PROCEDURE TABLE_TYPE
(PNO IN EMP.DEPTNO%TYPE)
IS
    --���̺� ����
    TYPE ENAME_ARR IS TABLE OF EMP.ENAME%TYPE
    INDEX BY BINARY_INTEGER;
    
    TYPE JOB_ARR IS TABLE OF EMP.JOB%TYPE
    INDEX BY BINARY_INTEGER;
    
    -- ���̺� Ÿ���� ���� ����
    ENAME_TAB ENAME_ARR;
    JOB_TAB JOB_ARR;
    I BINARY_INTEGER :=0;
BEGIN
    FOR K IN (SELECT ENAME,JOB FROM EMP WHERE DEPTNO = PNO) LOOP
    I := I+1; -- I�� ����
    -- ���̺� Ÿ�� ������ ����� ����
    ENAME_TAB(I) := K.ENAME;
    JOB_TAB(I) := K.JOB;
    END LOOP;
    -- ����� ���� ����غ���
    FOR J IN 1 .. I LOOP
      DBMS_OUTPUT.PUT_LINE(RPAD(ENAME_TAB(J),12)|| RPAD(JOB_TAB(J),10));
    END LOOP;
END;
/
EXEC TABLE_TYPE(30);

------------------------------------------------
[2] RECORD TYPE

- TYPE ���ڵ�Ÿ�Ը� IS RECORD
  (�ʵ��1 �ڷ���,
    �ʵ��2 �ڷ���,...)

- ������ ���ڵ�Ÿ�Ը�;

- ���ڵ�Ÿ�Ը�.�ʵ��1,... ������ ���
--
--[�ǽ�]
--�Խ���(BBS)�� �ۼ��ڸ��� �� �Ķ���ͷ� �����ϸ�
--�ش� �ۼ��ڰ� �� ���� ������ ���

SELECT * FROM BBS;
-------------------------------------------
CREATE OR REPLACE PROCEDURE REC_TYPE
(PNAME IN BBS.WRITER%TYPE)
IS
    -- ���ڵ� Ÿ�� ����
    TYPE BBS_REC IS RECORD(
        VNO BBS.NO%TYPE,
        VTITLE BBS.TITLE%TYPE,
        VWRITER BBS.WRITER%TYPE,
        VCONTENT BBS.CONTENT%TYPE,
        VWDATE BBS.WDATE%TYPE
    );
    -- ���ڵ� Ÿ���� ���� ����
    K BBS_REC;    
BEGIN
    SELECT * 
    INTO K
    FROM BBS
    WHERE WRITER=PNAME;    
    DBMS_OUTPUT.PUT_LINE(rpad(K.VNO,6)||RPAD(K.VTITLE,20)||RPAD(K.VWRITER,9)||RPAD(K.VCONTENT,30)||K.VWDATE);
    -- ���� ó��
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE(PNAME||'���� ���� �����ϴ�');
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE(PNAME||'�� ���� 2�� �̻��̿���');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('��Ÿ ���� �߻�');
END;
/
----------------------------
EXEC REC_TYPE('haha');

3

select * from bbs where writer='kim';

----------------------------------------------
# ���ε� ���� ���� �� ���

  VAR[IABLE] [variable [NUMBER| CHAR(n)| VARCHAR2(n)]]
  
variable rvar number
-----------------------------------------
declare
begin
  -- ���ε庯�� �����Ҷ��� �ݷ�(:)�� �տ� ���δ�
  :rvar := 100;
end;
/
-----------------------------------------
print rvar
--------------------------------------------
# FUNCTION - �Լ�
��ȯ���� ������ �Լ��� ����Ѵ�
CREATE OR REPLACE FUNCTION �Լ���(���Ķ����)
RETURN ��ȯŸ���ڷ���
IS|AS
BEGIN
  ���๮
  RETURN ��ȯ��;
END;
/
-----------------------------------------
--
--������� ���Ķ���ͷ� �����ϸ�
--�ش����� ����� ��ȯ�ϴ� �Լ��� �����غ���
---------------------------------------------------
CREATE OR REPLACE FUNCTION GET_EMPNO(PNAME IN EMP.ENAME%TYPE)
RETURN EMP.EMPNO%TYPE
IS
  VNO EMP.EMPNO%TYPE;
BEGIN
    SELECT EMPNO
    INTO VNO
    FROM EMP WHERE ENAME=UPPER(PNAME);
    DBMS_OUTPUT.PUT_LINE(PNAME||'���� ����� '||VNO||'�Դϴ�');
    RETURN VNO;
END;
/
----------------------------------------------
�Լ��� �����ϱ� ���ؼ� ���� ���ε� ������ �����Ѵ� (��ȯ���� �ޱ� ����)

VAR GNO NUMBER

EXEC :GNO := GET_EMPNO('KING')

PRINT GNO
--------------------------------------
# Ŀ��
[1] �Ͻ��� Ŀ��
[2] ����� Ŀ��

[1] �Ͻ��� Ŀ��
--
--[�ǽ�] ����� ���Ķ���ͷ� �����ϸ�
--�ش� ����� �޿��� ����ϰ�
--�޿��� 10% �λ��� ��, �޿��� �λ�� �������
--����ϴ� ���ν���
--------------------------------
CREATE OR REPLACE PROCEDURE IMPLICIT_CR
(PNO IN EMP.EMPNO%TYPE)
IS
    VSAL EMP.SAL%TYPE;
    V_CNT NUMBER;
BEGIN
    SELECT SAL
    INTO VSAL
    FROM EMP WHERE EMPNO = PNO;
    -- �˻��� �����Ͱ� �ִٸ�
    IF SQL%FOUND THEN
        DBMS_OUTPUT.PUT_LINE('�˻��� �����Ͱ� �־�� �޿��� '||VSAL||'�Դϴ�');
    END IF;
    UPDATE EMP SET SAL=SAL*1.1 WHERE EMPNO=PNO;
    --�Ͻ��� Ŀ�� �̿��� ������ ���� ���� ����
    V_CNT := SQL%ROWCOUNT;
    DBMS_OUTPUT.PUT_LINE('�޿��� 10% �λ�� ������� '||V_CNT||'�� �Դϴ�');
END;
/
---------------------------------
EXEC IMPLICIT_CR(7788);

SELECT * FROM EMP WHERE EMPNO=7788;

ROLLBACK;
-----------------------------------------
--
--BBS�� ��ϵ� ��� �Խñ��� �����ͼ� NO TITLE WRITER 
--����ؼ� �����ִ� ���ν����� �ۼ��ϼ���
-------------------------------------------
CREATE OR REPLACE PROCEDURE BBS_ALL
IS
K BBS%ROWTYPE;
BEGIN
    SELECT NO,TITLE,WRITER
    INTO K.NO, K.TITLE, K.WRITER
    FROM BBS ORDER BY NO DESC;
    DBMS_OUTPUT.PUT_LINE(K.NO||'  '||K.TITLE||'  '||K.WRITER);
END;
/
-------------------------------------------
EXEC BBS_ALL;

==>RUNTIME  ERROR �߻�

�������� ����� �޾ƿ��� ���� ����� Ŀ���� �̿��ϴ���
FOR������ �̿��ϴ���...

# ����� Ŀ�� ����
- CURSOR Ŀ���� IS
  SELECT��
# ����� Ŀ���� �̿��Ͽ� ������ ������
<1> Ŀ�� ���� - OPEN Ŀ����
<2> ������ ���� - FETCH Ŀ���� INTO ����
<3> Ŀ�� �ݱ�  - CLOSE Ŀ����
FETCH�Ҷ� �ݺ��� �ʿ��� - LOOP��, WHILE LOOP��, FOR LOOP �� �� �̿�
----------------------------------------
CREATE OR REPLACE PROCEDURE BBS_ALL
IS
    K BBS%ROWTYPE;
    --Ŀ�� ����
    CURSOR BCR IS
    SELECT NO, TITLE, WRITER FROM BBS
    ORDER BY NO DESC;    
BEGIN
   -- Ŀ�� ����
   OPEN BCR;
   -- �ݺ��� ���鼭 ������ ����
   LOOP
   -- FETCH  INTO
   FETCH BCR INTO K.NO, K.TITLE, K.WRITER;
   
   EXIT WHEN BCR%NOTFOUND;
   DBMS_OUTPUT.PUT_LINE(RPAD(K.NO,6)|| RPAD(K.TITLE,20)|| RPAD(K.WRITER,10));
   END LOOP;
   -- Ŀ�� �ݱ�
   CLOSE BCR;
END;
/
-------------------------------
EXEC BBS_ALL;
--
--[����]
--�μ��� ������� �޿� �հ�, ��ձ޿�, �ִ�޿�, �ּұ޿��� ���ϴ� ���ν����� ��������.

���ν�����: DEPT_SAL_CR
----------------------------------------------
CREATE OR REPLACE PROCEDURE DEPT_SAL_CR
IS
    CURSOR CR IS
    SELECT DEPTNO, COUNT(EMPNO) CNT,
    ROUND(AVG(SAL)) AVG_SAL,
    MAX(SAL) MX_SAL,
    MIN(SAL) MN_SAL
    FROM EMP GROUP BY DEPTNO ORDER BY DEPTNO;    
BEGIN
    -- FOR LOOP���� Ŀ�� ���
    FOR K IN CR LOOP
        DBMS_OUTPUT.PUT_LINE(LPAD(K.DEPTNO,6)||LPAD(K.CNT,10)
        ||LPAD(K.AVG_SAL,10)||LPAD(K.MX_SAL,10)||LPAD(K.MN_SAL,10));
    END LOOP;
END;
/
----------------------------------------------
EXEC DEPT_SAL_CR
----------------------------------------
FOR ������ IN Ŀ���� LOOP
...
END LOOP
==> FOR���� ���� ������ RECORD Ÿ�԰� ����
-------------------------------------
FOR ������ IN (��������) LOOP
END LOOP;
------------------------------------
DECLARE
BEGIN
    FOR K IN (SELECT * FROM DEPT) LOOP
        DBMS_OUTPUT.PUT_LINE('-------------------');
        DBMS_OUTPUT.PUT_LINE(LPAD(K.DEPTNO,10)||LPAD(K.DNAME,20)||LPAD(K.LOC,10));
    END LOOP;
END;
/
------------------------------------
--SQL�� �̿��ؼ� EMP���� 
--10�� �μ� ����̸� 'ȸ��μ�', 20 '�����μ�', 30 '�����μ�' �׿� '��Ÿ �μ�'
===> DECODE()�Լ� Ȱ��

SELECT EMPNO,ENAME,DEPTNO,
DECODE(DEPTNO,10,'ȸ��μ�',20,'�����μ�',30,'�����μ�','��Ÿ�μ�') "�μ���"
FROM EMP ORDER BY DEPTNO;
----------------------------------------------
PL/SQL������ IF�� ��� ����

    IF ����1 THEN ���๮;
    ELSIF ����2 THEN ���๮;
    ELSIF ����3 THEN ���๮;
    ELSE ���๮;
    END IF;
----------------------------------------------
--����� ���Ķ���ͷ� �����ϸ�
--�ش� ����� �μ���ȣ,�����, �μ����� ������ ����ϴ� ���ν���
----------------------------------------------
CREATE OR REPLACE PROCEDURE EMP_DNAME_INFO
(PNO IN NUMBER)
IS
VDNO EMP.DEPTNO%TYPE;
VNAME EMP.ENAME%TYPE;
VDNAME VARCHAR2(20);
BEGIN
    SELECT DEPTNO,ENAME
    INTO VDNO,VNAME
    FROM EMP WHERE EMPNO=PNO;
    IF VDNO = 10 THEN
        VDNAME :='ȸ��μ�';
    ELSIF VDNO = 20 THEN
        VDNAME :='�����μ�';
    ELSIF VDNO = 30 THEN
        VDNAME :='�����μ�';
    ELSE
        VDNAME :='��Ÿ�μ�';
    END IF;  
    DBMS_OUTPUT.PUT_LINE(PNO||'��: '||VNAME||'�� �μ��� '||VDNAME||'�Դϴ�');
END;
/
EXEC EMP_DNAME_INFO(7900);


  
  
















