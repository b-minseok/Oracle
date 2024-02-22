--day09_PROCEDURE.sql
PL/SQL 을 이용한 프로시저 만들기
[1] 익명 블럭으로 포로시저 생성
[2] 이름 갖는 프로시저 생성
-------------------------------------
set serveroutput on;

DECLARE
-- 선언부
    I_MSG VARCHAR2(100);
    today timestamp;
BEGIN
--실행부
    I_MSG := 'Hello World~'; -- 변수에 값을 할당
    select SYSTIMESTAMP into today
    from dual;
    dbms_output.put_line(i_msg); --변수값 출력
    dbms_output.put_line(today);
END;
/
----------------------------------------

--현재 시간에서 1 시간전과 3시간 후의 시각을 구해 출력하는 프로시저를 작성하세요

DECLARE
    hour1 timestamp;
    hour3 timestamp;
BEGIN
select systimestamp -1/24 into hour1 from dual;
select systimestamp +3/24 into hour3 from dual;
dbms_output.put_line('1시간 전: '||hour1);
dbms_output.put_line('3시간 전: '||hour3);
END;
/
----------------------------------------------------
[2] 이름 갖는 프로시저 생성
java_member 테이블에 데이터를 삽입하는 프로시저를 작성하세요
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
    dbms_output.put_line(p_name||'님의 정보를 등록했어요');
    --예외 처리
    exception
    when dup_val_on_index then
    dbms_output.put_line(p_id||'님의 아이디가 이미 존재합니다~ 등록실패!!');
end;
/
EXECUTE JAVA_MEMBER_ADD('CCDD','222','김새롬','010-4545-7878');
EXEC JAVA_MEMBER_ADD('AABB','333','최용남','011-5555-6666');
EXEC JAVA_MEMBER_ADD('CCDD2','333','홍용남','011-5555-6666');

SELECT * FROM JAVA_MEMBER;

EMP에서 부서번호와 인상율(10,20) 인 파라미터로 받아서
해당 부서의 사원들의 급여를 인상율 인상하는 프로시저를 작성하세요
프로시저명 EMP_SALUP

create or replace procedure emp_salup(e_deptno in number, sal_ratio in number)
is
begin
update emp set sal=sal+(sal*sal_ratio/100) where deptno=e_deptno;
dbms_output.put_line(e_deptno||'부서 직원의 급여를 인상했어요');
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
    dbms_output.put_line(p_deptno||'번 부서의 급여가 '||p_uprate||'% 만큼 인상됐어요');
end;
/

select ename,sal from emp where deptno=30;

exec emp_salup(30,10);
rollback;