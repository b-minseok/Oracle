--day07_DML.sql

EMP_10 테이블을 서브쿼리 이용해 생성하되 구조만

CREATE TABLE EMP_10(ID, NAME, SALARY, HDATE)
AS
SELECT EMPNO,ENAME,SAL,HIREDATE FROM EMP
WHERE 1=2;

DESC EMP_10;

SELECT * FROM EMP_10;

# INSERT문에서 서브쿼리 사용

INSERT IN 테이블명
SUBQUERY

--EMP에서 10번부서 사원의 정보를 가져와
--EMP_10에 INSERT 하세요

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
#UADATE 문
UPDATE 테이블명 SET 컬럼명1=값1,컬럼명2=값2,...;
==> 모든 데이터가 다 수정된다
UPDATE 테이블명 SET 컬럼명1=값1,컬럼명2=값2,... WHERE 조건절;
==> 조건에 맞는 데이터만 수정

--[실습]
--- EMP2테이블을 생성하고 EMP의 데이터까지 포함시켜 생성하세요
CREATE TABLE EMP2
AS
SELECT * FROM EMP;

SELECT * FROM EMP2;
--- emp2테이블에서 사번이 7788인 사원의 부서번호를 10으로 
--	수정하세요.
UPDATE EMP2 SET DEPTNO=10 WHERE EMPNO=7788;
--- emp2 테이블에서 사번이 7499인 사원의 부서를 20,
--	급여를 3500으로 변경하여라.    
UPDATE EMP2 SET DEPTNO=20, SAL=3500 WHERE EMPNO=7499;
SELECT * FROM EMP2;
--- emp2테이블에서 부서를 모두 10으로 변경하여라.
UPDATE EMP2 SET DEPTNO = 10;

ROLLBACK;

--2] 등록된 고객 정보 중 고객의 나이를 현재 나이에서 모두 5를 더한 값으로 
--	      수정하세요.
SELECT * FROM MEMBER;
UPDATE MEMBER SET AGE = AGE+5;
ROLLBACK;

--	 2_1] 고객 중 23/09/01이후 등록한 고객들의 마일리지를 350점씩 올려주세요.
UPDATE MEMBER SET MILEAGE = MILEAGE + 350 WHERE REG_DATE > '23/09/01';
--     4] 등록되어 있는 고객 정보 중 이름에 '김'자가 들어있는 모든 이름을 '김' 대신
--	     '최'로 변경하세요. REPLACE()함수 활용
UPDATE MEMBER SET NAME = REPLACE(NAME,'김','최')
WHERE NAME LIKE '%김%';

UPDATE MEMBER SET NAME='최'||LTRIM(NAME,'김') WHERE NAME LIKE '%김%';
SELECT * FROM MEMBER;

ROLLBACK;

#UPDATE 문에서 SUBQUERY 사용
--EMP2테이블에서 SCOTT의 업무와 급여가 일치하도록
--		JONES의 업무와 급여를 변경하여라.
SELECT * FROM EMP2;
-----------------------이해안감
UPDATE EMP2 SET (JOB, SAL)=
(SELECT JOB,SAL FROM EMP2 WHERE ENAME='SCOTT')
WHERE ENAME='JONES';
-- 다중열 서브쿼리
ROLLBACK;

#UPDATE시 무결성 제약조건 에러

CREATE TABLE DEPT2
AS
SELECT * FROM DEPT;

SELECT * FROM DEPT2;

-- -DEPT2의 DEPTNO컬럼에 대해 PRIMARY KEY 제약조건을 추가하세요

ALTER TABLE DEPT2 ADD CONSTRAINT DEPT2_DEPTNO_PK PRIMARY KEY (DEPTNO);

SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME='DEPT2';

-- -EMP2의 DEPTNO 컬럼에 대해 FOREIGN KEY 추가하되 DEPT2의 DEPTNO를 외래키로 참조하도록
ALTER TABLE EMP2 ADD CONSTRAINT EMP2_DEPTNO_FK FOREIGN KEY (DEPTNO)
REFERENCES DEPT2(DEPTNO);

SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME='EMP2';


--EMP2에서 부서번호가 10번인 사원들의 부서번호를 40번으로 수정하세요
UPDATE EMP2 SET DEPTNO = 40 WHERE DEPTNO=10;

SELECT * FROM EMP2 ORDER BY DEPTNO DESC;
--    
--   EMP2에서 'WARD'의 부서번호를 90번으로 수정하세요
UPDATE EMP2 SET DEPTNO=90 WHERE ENAME='WARD';

==>ERROR 발생 부모키 안에 없는 값으로 변경해서

ROLLBACK;
-----------------------------------------
#DELETE 문
-DELETE FROM 테이블명;
==>모든 데이터 삭제
-DELETE FROM 테이블명 WHERE 조건절;
==>조건에 맞는 데이터만 삭제
-- 1] 상품 테이블에 있는 상품 중 상품의 판매 가격이 10000원 이하인 상품을 모두 
--	      삭제하세요.
DELETE FROM PRODUCTS WHERE OUTPUT_PRICE <= 10000;
SELECT * FROM PRODUCTS;
ROLLBACK;

--	2] 상품 테이블에 있는 상품 중 상품의 대분류가 도서인 상품을 삭제하세요.
-----------이해안감
DELETE FROM PRODUCTS
WHERE CATEGORY_FK =
(SELECT CATEGORY_CODE FROM CATEGORY WHERE CATEGORY_NAME='도서');
--
--	3] 상품 테이블에 있는 모든 내용을 삭제하세요.
DELETE FROM PRODUCTS;
SELECT * FROM PRODUCTS;
ROLLBACK;

#DELETE 문에서 SUBQUERY 사용
--- EMP2에서 NEW YORK에 근무하는 사원들의 정보를 삭제하세요
--------이해안감
DELETE FROM EMP2
WHERE DEPTNO=
(SELECT DEPTNO FROM DEPT2 WHERE LOC ='NEW YORK');

SELECT * FROM EMP2;

ROLLBACK;

#DELETE 시 무결성 제약조건 에러
-DEPT2에서 30번 부서를 삭제하세요
--------이해안감 왜?30번은 삭제안되고 40번으로 변경해서 삭제됨?
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
- SAVEPOINT (ORCLE에만 있음)

# SAVEPOINT 사용 - 표준 SQL문은 아님

UPDATE EMP2 SET ENAME='CHARSE' WHERE EMPNO=7788;
SELECT * FROM EMP2;

UPDATE EMP2 SET DEPTNO=30 WHERE EMPNO=7788;

--저장점 설정
--SAVEPOINT 저장점이름;
SAVEPOINT POINT1;

UPDATE EMP2 SET JOB='MANAGER';

SELECT * FROM EMP2;

--ROLLBACK ===>이전 작업 모두 취소된다
ROLLBACK TO SAVEPOINT POINT1; -- ==>POINT1 저장점까지만 취소

ROLLBACK;

