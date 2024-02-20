--day06_DDL.sql
DDL (DATA DEFINITION LANGUAGE)
- CREATE, ALTER, DROP, RENAME, TRUNCATE

# CREATE 문 
[1] PRIMARY KEY 제약조건
<1>  컬럼 수준
    CREATE TABLE TEST_TAB1(
      ID NUMBER(2) CONSTRAINT TEST_TAB1_ID_PK PRIMARY KEY, --컬럼수준의 제약
      NAME VARCHAR2(10)
    );

    DESC TEST_TAB1;
    
    데이터 사전에서 조회
    SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME='TEST_TAB1';
    
<2> 테이블 수준
    CREATE TABLE TEST_TAB2(
       ID NUMBER(2),
       NAME VARCHAR2(10),
       -- 테이블 수준의 제약
       CONSTRAINT TEST_TAB2_ID_PK PRIMARY KEY (ID)
    );
    
    SELECT * FROM USER_CONSTRAINTS
    WHERE TABLE_NAME='TEST_TAB2';
    
# 제약조건 삭제
    ALTER TABLE 테이블명 DROP CONSTRAINT 제약조건명

# 제약조건 추가
    ALTER TABLE 테이블명 ADD CONSTRAINT 제약조건명  제약조건유형 (컬럼명)
    
# 제약조건명 변경
    ALTER TABLE 테이블명 RENAME CONSTRAINT OLD_제약조건명 TO NEW_제약조건명
    
--- TEST_TAB2 의   TEST_TAB2_ID_PK 제약조건을 삭제하세요
    ALTER TABLE TEST_TAB2 DROP CONSTRAINT TEST_TAB2_ID_PK;
    
    SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME='TEST_TAB2';
    
--- TEST_TAB2에 NAME 컬럼에 PRIMARY 제약조건을 추가하세요
    ALTER TABLE TEST_TAB2 ADD CONSTRAINTS TEST_TAB2_NAME_PK PRIMARY KEY (NAME);

--- TEST_TAB2에 NAME 컬럼에 준 제약조건명을 변경하세요
    ALTER TABLE TEST_TAB2 RENAME CONSTRAINT TEST_TAB2_NAME_PK TO TEST_TAB2_NAME_PRIMARY;


INSERT INTO TEST_TAB1(ID,NAME)
VALUES(NULL,'홍길동');

INSERT INTO TEST_TAB1(ID,NAME)
VALUES(2,'김철수');
COMMIT;

SELECT * FROM TEST_TAB1;

--PK==> UNIQUE + NOT NULL
------------------------------------------------
[2] FOREIGN KEY (외래키)
부모 테이블 - MASTER TABLE
DEPT_TAB
CREATE TABLE DEPT_TAB(
    DEPTNO NUMBER(2),
    DNAME VARCHAR2(15),
    LOC VARCHAR2(20),
    CONSTRAINT DEPT_TAB_DEPTNO_PK PRIMARY KEY(DEPTNO)
);

자식 테이블 - DETAIL TABLE
EMP_TAB

CREATE TABLE EMP_TAB(
    EMPNO NUMBER(4),
    ENAME VARCHAR2(10),
    JOB VARCHAR2(10),
    --컬럼 수준에서 FK 제약
    MGR NUMBER(4) CONSTRAINT EMP_TAB_MGR_FK REFERENCES EMP_TAB(EMPNO),
    HIREDATE DATE,
    SAL NUMBER(7,2),
    COMM NUMBER(7,2),
    DEPTNO NUMBER(2),
    -- 테이블 수준에서 FK 제약
    CONSTRAINT EMP_TAB_DEPTNO_FK FOREIGN KEY (DEPTNO)
    REFERENCES  DEPT_TAB (DEPTNO),
    CONSTRAINT EMP_TAB_EMPNO_PK PRIMARY KEY (EMPNO)
);

-- 데이터사전에서 조회

SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME='EMP_TAB';

DEPT_TAB에 데이터 삽입
10 '인사부' '서울'
20 '기획부' '세종'

INSERT INTO DEPT_TAB VALUES(10,'인사부','서울');
INSERT INTO DEPT_TAB VALUES(20,'기획부','세종');

SELECT * FROM DEPT_TAB;
COMMIT;

--EMP_TAB에 데이터 넣기
--10번부서 2명
INSERT INTO EMP_TAB(EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,DEPTNO)
VALUES(1000,'홍길동','MANAGER',NULL,SYSDATE,5000,10);

INSERT INTO EMP_TAB(EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,DEPTNO)
VALUES(1001,'김철수','CLERK',1000,SYSDATE,4000,10);
COMMIT;

SELECT * FROM EMP_TAB;
20번부서 1명
INSERT INTO EMP_TAB(EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,DEPTNO)
VALUES(1002,'김수연','ANALYST',1000,SYSDATE,4000,10);

INSERT INTO EMP_TAB(EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,DEPTNO)
VALUES(1003,'최연호','ANALYST',1001,SYSDATE,4000,20);

INSERT INTO EMP_TAB(EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,DEPTNO)
VALUES(1004,'호치민','OPERATOR',1001,SYSDATE,3000,20);

COMMIT;

SELECT * FROM EMP_TAB;

DEPT_TAB에서 20번 부서 삭제

DELETE FROM DEPT_TAB WHERE DEPTNO=20;
==> child record found
외래키로 참조되는 자식 레코드가 있을 경우 부모 레코드는 삭제 불가

EMP_TAB에서 20번 부서 직원들의 부서번호를 10번으로 수정하세요

UPDATE EMP_TAB SET DEPTNO=10 WHERE DEPTNO=20;

SELECT * FROM EMP_TAB;
COMMIT;
DELETE FROM DEPT_TAB WHERE DEPTNO=20;
/*
게시판 테이블
테이블명: bbs
no number(4) pk
title varchar2(200) not null
writer  ===> java_member테이블의 id를 참조하도록 하되 on delete cascade 옵션을 주어 fk를 주자
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
--게시글 2개 삽입하세요

insert into bbs(no,title,writer,content)
values(1,'처음 쓰는 글','hong','오늘 처음 글을 써요');

insert into bbs(no,title,writer,content)
values(2,'두번째 쓰는 글','haha','하하 호호 히히');

insert into bbs(no,title,writer,content)
values(3,'오늘도 반가워요','hong','오늘도 즐겁게...');
commit;
select * from bbs;

-- hong아이디 회원을 삭제하세요
DELETE FROM java_member WHERE id='hong';

select * from java_member; --'hong'삭제

-- hong이 쓴 게시글은?
select * from bbs;

rollback;

SELECT * FROM DEPT_TAB;

[3] UNIQUE 제약조건
- 유일한 값을 갖도록 제한
- NULL은 허용된다

CREATE TABLE UNI_TAB(
   DEPTNO NUMBER(2) CONSTRAINT UNI_TAB_DEPTNO_UK UNIQUE,
   DNAME CHAR(14),
   LOC CHAR(10)
);
INSERT INTO UNI_TAB
VALUES(10,'노무부','서울');

INSERT INTO UNI_TAB
VALUES(NULL,'행정부','서울');

INSERT INTO UNI_TAB
VALUES(20,'기획부','서울');

SELECT * FROM UNI_TAB;

COMMIT;

UNI_TAB2
DEPTNO ==> 테이블 수준에서 UNIQUE 주기
DNAME
LOC

CREATE TABLE UNI_TAB2(
  DEPTNO NUMBER(2),
  DNAME CHAR(14),
  LOC CHAR(10),
  CONSTRAINT UNI_TAB2_DEPTNO_UK UNIQUE(DEPTNO)
);

데이터 사전에서 조회
SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME='UNI_TAB2';
------------------------------------------------------------
[4] NOT NULL
- NULL값을 허용하지 않음
- 컬럼 수준에서만 제약 가능

CREATE TABLE NN_TAB(
   DEPTNO NUMBER(2) CONSTRAINT NN_TAB_DEPTNO_NN NOT NULL,
   DNAME CHAR(14)
);
INSERT INTO NN_TAB VALUES(1,'인사부');

INSERT INTO NN_TAB VALUES(NULL,'인사부');

[5] CHECK 제약조건 
- 행이 만족해야 할 조건을 기술

CREATE TABLE CK_TAB(
   DEPTNO NUMBER(2) CONSTRAINT CK_TAB_DEPTNO_CK  CHECK ( DEPTNO >10 AND DEPTNO <=20),
   DNAME CHAR(16)
);
INSERT INTO CK_TAB VALUES(20,'기획부');
INSERT INTO CK_TAB VALUES(21,'기획부');
SELECT * FROM CK_TAB;
-- ===================================================
실습
ZIPCODE 테이블
MEMBER_TAB 테이블 생성하기

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

# SUBQUERY 를 이용한 테이블 생성

CREATE TABLE 테이블명(컬럼명1,...) 
AS
SUBQUERY

--EMP에서 30번부서에 근무하는 사원정보만 가져와서
--EMP_30 테이블을 생성하세요

CREATE TABLE EMP_30(ENO, ENAME, JOB, HDATE, SAL,COMM,DNO)
AS
SELECT EMPNO, ENAME, JOB, HIREDATE,SAL,COMM,DEPTNO
FROM EMP
WHERE DEPTNO=30;

SELECT * FROM TAB;

DESC EMP_30;

SELECT * FROM EMP_30;

--
--[문제1]
--		EMP테이블에서 부서별로 인원수,평균 급여, 급여의 합, 최소 급여,
--		최대 급여를 포함하는 EMP_DEPTNO 테이블을 생성하라.
CREATE TABLE EMP_DEPTNO
AS
SELECT DEPTNO, COUNT(EMPNO) CNT, ROUND(AVG(SAL),1) AVG_SAL, SUM(SAL) SUM_SAL, 
MIN(SAL) MIN_SAL, MAX(SAL) MAX_SAL
FROM EMP
GROUP BY DEPTNO;

SELECT * FROM EMP_DEPTNO;

--[문제2]	EMP테이블에서 사번,이름,업무,입사일자,부서번호만 포함하는
--		EMP_TEMP 테이블을 생성하는데 자료는 포함하지 않고 구조만
--		생성하여라.

CREATE TABLE EMP_TEMP2
AS
SELECT EMPNO, ENAME, JOB, HIREDATE, DEPTNO FROM EMP
WHERE 1=0; -- 항상 거짓인 조건을 둔다

SELECT * FROM EMP_TEMP2;
-- ====================================================================
# 컬럼 추가/변경/삭제
[1] 컬럼 추가
ALTER TABLE 테이블명 ADD 추가할 컬럼정보(컬럼명 자료형 기본값)
[2] 컬럼 정보 수정
ALTER TABLE 테이블명  MODIFY 수정할 컬럼정보

[3] 컬럼 삭제
ALTER TABLE 테이블명  DROP COLUMN 삭제할 컬럼명

[4] 컬럼명 수정
ALTER TABLE 테이블명  RENAME COLUMN OLD_컬럼명 TO NEW_컬럼명;

CREATE TABLE SAMPLE_TAB(
    NO NUMBER(4)
);
DESC SAMPLE_TAB;

<1> SAMPLE_TAB에 
NAME VARCHAR2(20) 추가하세요

ALTER TABLE SAMPLE_TAB
ADD NAME VARCHAR2(20) NOT NULL;

DESC SAMPLE_TAB;

<2> NO 컬럼의 자료형 CHAR(4) 로 변경하세요

ALTER TABLE SAMPLE_TAB MODIFY NO CHAR(4);

DESC SAMPLE_TAB;

