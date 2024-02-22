--day09_PROCEDURE.sql
PL/SQL �� �̿��� ���ν��� �����
[1] �͸� ������ ���ν��� ����
[2] �̸� ���� ���ν��� ����
-------------------------------------
set serveroutput on;

DECLARE
-- �����
    I_MSG VARCHAR2(100);
    today timestamp;
BEGIN
--�����
    I_MSG := 'Hello World~'; -- ������ ���� �Ҵ�
    select SYSTIMESTAMP into today
    from dual;
    dbms_output.put_line(i_msg); --������ ���
    dbms_output.put_line(today);
END;
/
----------------------------------------

--���� �ð����� 1 �ð����� 3�ð� ���� �ð��� ���� ����ϴ� ���ν����� �ۼ��ϼ���

DECLARE
    hour1 timestamp;
    hour3 timestamp;
BEGIN
select systimestamp -1/24 into hour1 from dual;
select systimestamp +3/24 into hour3 from dual;
dbms_output.put_line('1�ð� ��: '||hour1);
dbms_output.put_line('3�ð� ��: '||hour3);
END;
/
----------------------------------------------------
[2] �̸� ���� ���ν��� ����
java_member ���̺� �����͸� �����ϴ� ���ν����� �ۼ��ϼ���
id,pw,name,tel ==>in parameter
--------------------------------------
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
    dbms_output.put_line(p_id||'���� ���̵� �̹� �����մϴ�~ ��Ͻ���!!');
end;
/
EXECUTE JAVA_MEMBER_ADD('CCDD','222','�����','010-4545-7878');
EXEC JAVA_MEMBER_ADD('AABB','333','�ֿ볲','011-5555-6666');
EXEC JAVA_MEMBER_ADD('CCDD2','333','ȫ�볲','011-5555-6666');

SELECT * FROM JAVA_MEMBER;

EMP���� �μ���ȣ�� �λ���(10,20) �� �Ķ���ͷ� �޾Ƽ�
�ش� �μ��� ������� �޿��� �λ��� �λ��ϴ� ���ν����� �ۼ��ϼ���
���ν����� EMP_SALUP

create or replace procedure emp_salup(e_deptno in number, sal_ratio in number)
is
begin
update emp set sal=sal+(sal*sal_ratio/100) where deptno=e_deptno;
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
    commit;
    dbms_output.put_line(p_deptno||'�� �μ��� �޿��� '||p_uprate||'% ��ŭ �λ�ƾ��');
end;
/

select ename,sal from emp where deptno=30;

exec emp_salup(30,10);
rollback;