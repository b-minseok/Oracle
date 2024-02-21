--day08_object.sql_
# ORACLE의 객체
[1] TABLE
[2] SEQUENCE
[3] VIEW
[4] INDEX
[5] SYNONYM
....
# SEQUENCE
--DEPT 의 pk로 사용되는 DEPTNO 값으로 사용할 시퀀스를 만들어보자

CREATE SEQUENCE DEPT_DEPTNO_SEQ
START WITH 30 --시작값
INCREMENT BY 10 --증가치
MAXVALUE 99-- 최대값
MINVALUE 30
NOCACHE
NOCYCLE;

데이터 사전에서 조회

SELECT * FROM USER_SEQUENCES WHERE SEQUENCE_NAME='DEPT_DEPTNO_SEQ';
SELECT * FROM USER_OBJECTS WHERE OBJECT_TYPE='SEQUENCE';

# 시퀀스 사용법
- NEXTVAL : 시퀀스의 다음값을 반환
- CURRVAL : 시퀀스의 현재값을 반환
- [주의사항] NEXTVAL을 하지 않은 채로 CURRVAL 을 먼저 사용할 수 없다

INSERT INTO DEPT(DEPTNO,DNAME,LOC)
VALUES(DEPT_DEPTNO_SEQ.NEXTVAL,'홍보부','인천');

INSERT INTO DEPT(DEPTNO,DNAME,LOC)
VALUES(DEPT_DEPTNO_SEQ.NEXTVAL,'영업부3','수원');

SELECT * FROM DEPT;

SELECT DEPT_DEPTNO_SEQ.CURRVAL FROM DUAL;

<1> BBS 테이블(게시판)에 사용할 시퀀스를 생성하세요
시작값: n
증가치: 1
최소값: n
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
==> ERROR 발생

<2> BBS에 시퀀스를 이용해서 게시글을 삽입하세요
SELECT * FROM JAVA_MEMBER;

INSERT INTO BBS(NO,TITLE,WRITER,CONTENT)
VALUES(BBS_SEQ.NEXTVAL,'또 또 써요','','시퀀스를 이용합니다');

SELECT * FROM BBS;
-----------------------------------
DEPT_DEPTNO_SEQ

SELECT * FROM USER_SEQUENCES
WHERE SEQUENCE_NAME='DEPT_DEPTNO_SEQ';

DEPT_DEPTNO_SEQ를 아래와 같이 수정하세요
증가치 : 5
CYCLE 옵션 주기
캐시 사이즈: 20
으로 수정하세요

ALTER SEQUENCE 시퀀스명
INCREMENT BY N
MINVALUE N
MAXVALUE N
CYCLE|NOCYCLE
CACHE N|NOCACHE;
[주의]시작값은 수정할 수 없음

ALTER SEQUENCE DEPT_DEPTNO_SEQ
--START WITH 60 [X] ERROR발생
INCREMENT BY 5
MAXVALUE 150
CYCLE
NOCACHE;

SELECT * FROM USER_SEQUENCES
WHERE SEQUENCE_NAME='DEPT_DEPTNO_SEQ';

SELECT DEPT_DEPTNO_SEQ.NEXTVAL FROM DUAL;

# 시퀀스 삭제
DROP SEQUENCE 시퀀스명;

DEPT_DEPTNO_SEQ를 삭제하세요

DROP SEQUENCE DEPT_DEPTNO_SEQ;
------------------------------------

# VIEW
- 가상의 테이블

CREATE [OR REPLACE] VIEW 뷰이름
AS
SELECT문

CREATE VIEW EMP20_VIEW
AS
SELECT * FROM EMP
WHERE DEPTNO=20;

==> ORA-01031: insufficient privileges 에러 발생

system/oracle로 접속해서 권한을 부여한다
grant create view to scott;

뷰 조회
SELECT * FROM emp20_view;

--EMP테이블에서 30번 부서만 EMPNO를 EMP_NO로 ENAME을 NAME으로
--	SAL를 SALARY로 바꾸어 EMP30_VIEW를 생성하여라.

CREATE OR REPLACE VIEW EMP30_VIEW
AS
SELECT EMPNO EMP_NO, ENAME NAME, SAL SALARY, DEPTNO DNO
FROM EMP WHERE DEPTNO=30; 

SELECT * FROM EMP30_VIEW;

update emp set deptno=10 where ename=upper('allen');

update emp30_view set salary=1550 where name=upper('ward');

SELECT * FROM EMP30_VIEW;
select * from emp;

뷰를 수정하면 => 원 테이블도 수정됨
테이블 수정 => 뷰도 수정됨

만약 뷰를 수정 못하게 하려면 with read only 옵션을 준다

--고객테이블의 고객 정보 중 나이가 19세 이상인
--	고객의 정보를
--	확인하는 뷰를 만들어보세요.
--	단 뷰의 이름은 MEMBER_19VIEW로 하세요

CREATE OR REPLACE VIEW MEMBER_19VIEW
AS
SELECT * FROM MEMBER
WHERE AGE >= 19
WITH READ ONLY;

SELECT * FROM MEMBER_19VIEW ORDER BY AGE;

member에서 id1인 회원의 나이를 17세로 수정하세요

UPDATE MEMBER SET AGE=17 WHERE USERID='id1';
SELECT * FROM MEMBER_19VIEW;

MEMBER_19VIEW에서 'id3' 인 회원의 마일리지를 500점을 부여하세요
UPDATE MEMBER_19VIEW SET MILEAGE = MILEAGE + 500 
WHERE USERID='id3';
==> error 발생. with read only 옵션을 주었으므로

- 카테고리,상품,공급업체를 join한 뷰를 만드세요
- 뷰이름 : prod_view

CREATE OR REPLACE VIEW prod_view
AS
SELECT * FROM CATEGORY C JOIN PRODUCTS P
ON c.category_code = p.category_fk
JOIN SUPPLY_COMP S
ON p.ep_code_fk = s.ep_code;

select category_name,products_name,output_price,ep_name
from prod_view;

join문으로 생성한 뷰는 읽기 전용으로만 사용 가능

#with check option
=>where 절의 조건을 엄격하게 유지하도록 제한함

create or replace view emp20vw
as
select * from emp
where deptno=20
with check option constraint emp20vw_ck;

select * from emp20vw;

update emp20vw set sal=sal+500 where empno=7369;

update emp20vw set deptno=30 where empno=7369;
==> ORA-01402: view WITH CHECK OPTION where-clause violation

# 데이터 사전 조회
- user_views
- user_objects
select * from user_views where view_name=upper('emp20vw');
select * from user_objects where object_name=upper('emp20vw');

select text from user_views where view_name=upper('emp20vw');

# View 삭제
drop view 뷰이름;

drop view emp20vw;
--------------------------------------
# Index


# Synonym

---------------------------
# 프로시저 - crud

# db설계 - 개념설계/논리설계/물리설계 , 정규화
---------------------
