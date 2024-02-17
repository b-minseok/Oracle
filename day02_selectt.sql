--day02_select.sql
desc dept;
select * from dept;

desc emp;
select * from emp;
SELECT ENAME, JOB, SAL, (SAL+300)*2 AS SALUP FROM EMP ORDER BY SALUP DESC;
--[1] EMP테이블에서 사번(EMPNO), 이름(ENAME), 급여(SAL), 보너스(COMM)를 가져와 
--   보여주세요
SELECT EMPNO, ENAME, SAL, COMM FROM EMP;
--[2] 사원테이블에서 사원명, 급여, 급여의 10%인상액을 가져와 보여주세요
SELECT ENAME, SAL, SAL+SAL*0.1 SALUP_10, SAL *1.1 "10% 급여 인상액" FROM EMP;
--[3]  사원테이블에서 사원명, 급여,보너스, 1년 연봉을 계산해 보여주세요
--1년 연봉=급여*12 +보너스(COMM)
SELECT ENAME, SAL, COMM, SAL*12+COMM "1년 연봉"
FROM EMP;

--NVL(컬럼명, 값) 함수 활용
--=> 해당컬럼값이 NULL일때 지정된 값으로 변환하는 함수

SELECT ENAME, SAL, COMM, SAL*12+NVL(COMM,0) "1년 연봉"
FROM EMP; --??????????? 

NVL2함수
NVL2(컬럼명, 값1, 값2)
컬럼값이 NULL이 아니면 값1을 반환, NULL이면 값2를 반환하는 함수

--사원 테이블에서 관리자(MGR)이 있는 경우는 1, 없으면 0을
--사원명과 함꼐 출력하시오
SELECT ENAME, MGR, NVL2(MGR,1,0) "관리자 존재 여부" FROM EMP;

--"SMITH IS A CLERK"
SELECT ENAME||' IS A '||JOB "EMPLOYEES DETAIL"FROM EMP;

--DISTINCT - 중복행 제거
SELECT JOB FROM EMP;
SELECT DISTINCT JOB FROM EMP;

--부서 별로 담당하는 업무
SELECT DISTINCT DEPTNO, JOB FROM EMP ORDER BY DEPTNO ASC;

[문제]
--	 1] EMP테이블에서 중복되지 않는 부서번호를 출력하세요.
SELECT DISTINCT DEPTNO
FROM EMP
ORDER BY DEPTNO;
--	 2] MEMBER테이블에서 회원의 이름과 나이 직업을 보여주세요.
SELECT NAME, AGE, JOB
FROM MEMBER;
--	 3] CATEGORY 테이블에 저장된 모든 내용을 보여주세요.
SELECT * 
FROM CATEGORY;
--	 4] MEMBER테이블에서 회원의 이름과 적립된 마일리지를 보여주되,
--	      마일리지에 13을 곱한 결과를 "MILE_UP"이라는 별칭으로
--	      함께 보여주세요.
SELECT NAME, MILEAGE, MILEAGE * 13 AS "MILE_UP"
FROM MEMBER;
--
--    5] EMP테이블에서 이름과 연봉을 "KING: 1 YEAR SALARY = 60000"
--	형식으로 출력하라
SELECT ENAME||': 1 YEAR SALARY = '||SAL*12 AS anual_sal
FROM EMP;

# WHERE 절을 이용한 특정행 검색
--EMP에서 급여가 3000이상인 사원의 사번,이름 업무, 급여룰 보여주세요
SELECT EMPNO, ENAME, JOB, SAL
FROM EMP
WHERE SAL >= 3000;
--EMP테이블에서 담당업무가 MANAGER인 사원의
--	정보를 사원번호,이름,업무,급여,부서번호로 출력하세요.
SELECT EMPNO, ENAME, JOB, SAL, DEPTNO
FROM EMP
WHERE LOWER(JOB) = 'manager';
--EMP테이블에서 1982년 1월1일 이후에 입사한 사원의 
--사원번호,성명,업무,급여,입사일자를 출력하세요. (HIREDATE-입사일)
SELECT EMPNO, ENAME, JOB, SAL, HIREDATE
FROM EMP
WHERE HIREDATE >= '82/01/01' ORDER BY HIREDATE;

#문자값은 대소문자를 구분함에 주의
#날짜값은 날짜 형식을 구분한다

--[실습]
--	[1] emp테이블에서 급여가 1300에서 1500사이의 사원의 이름,업무,급여,
--	부서번호를 출력하세요
SELECT ENAME, JOB, SAL, DEPTNO
FROM emp
WHERE SAL BETWEEN 1300 AND 1500;
    -- WHERE SAL >=1300 AND SAL <=1500;
--  [2] emp테이블에서 사원번호가 7902,7788,7566인 사원의 사원번호,
--	이름,업무,급여,입사일자를 출력하세요.
SELECT EMPNO, ENAME, JOB, SAL, HIREDATE
FROM emp
WHERE EMPNO IN (7902, 7788, 7566);
--WHERE EMPNO=7902 OR EMPNO=7788 OR EMPNO=7566;
--    
-- [3] 10번 부서가 아닌 사원의 이름,업무,부서번호를 출력하세요
SELECT ENAME, JOB, DEPTNO
FROM emp
WHERE DEPTNO <> 10 ORDER BY 3;
--WHERE DEPTNO NOT IN (10);

--[4] emp테이블에서 업무가 SALESMAN 이거나 PRESIDENT인
--	사원의 사원번호,이름,업무,급여를 출력하세요.
    SELECT EMPNO, ENAME, JOB, SAL
    FROM emp
    WHERE JOB = 'SALESMAN' OR JOB = 'PRESIDENT';
    --WHERE JOB IN ('SALESMAN', 'PRESIDENT');
--	[5] 커미션(COMM)이 300이거나 500이거나 1400인 사원정보를 출력하세요
    SELECT *
    FROM emp
    where COMM = 300 OR COMM = 500 OR COMM = 1400;
    --WHERE COMM IN (300, 500, 1400);
--	[6] 커미션이 300,500,1400이 아닌 사원의 정보를 출력하세요
    SELECT *
    FROM emp
    where COMM NOT IN (300,500,1400);
    
   -- EMP에서 이름이 S로 시작하는 사원 정보를 보여주세요
    SELECT * FROM EMP
    WHERE ENAME LIKE 'S%';
    
--    EMP에서 이름이 S로 끝나는 사원 정보를 보여주세요
    SELECT * FROM EMP
    WHERE ENAME LIKE '%S';
--    S자가 들어있는 사원 정보 출력
    SELECT * FROM EMP
    WHERE ENAME LIKE '%S%';
    
--    이름 두번째 글자에 'O'자가 들어간 사원 정보
    SELECT * FROM EMP
    WHERE ENAME LIKE '_O%';
--    --[문제]
--	
--	- 고객(MEMBER) 테이블 가운데 성이 김씨인 사람의 정보를 보여주세요.
SELECT *
FROM MEMBER
WHERE NAME LIKE '김%';
--	- 고객 테이블 가운데 '강북'가 포함된 정보를 보여주세요.
SELECT *
FROM MEMBER
WHERE ADDR LIKE '%강북%';
--
--	- 카테고리 테이블 가운데 category_code가 0000로 끝나는 상품정보를 보여주세요.
SELECT *
FROM CATEGORY
WHERE category_code LIKE '%0000';
--	- EMP테이블에서 입사일자가 82년도에 입사한 사원의 사번,이름,업무
--	   입사일자를 출력하세요.
SELECT EMPNO, ENAME, JOB, HIREDATE
FROM EMP
WHERE HIREDATE LIKE '82%';

#날짜 포맷 변경
ALTER SESSION SET NLS_DATE_FORMAT='YYYY-MM-DD';
ALTER SESSION SET NLS_DATE_FORMAT='DD-MON=YY';
ALTER SESSION SET NLS_DATE_FORMAT='YY/MM/DD';
SELECT ENAME, HIREDATE FROM EMP;

보너스 적용을 못받는 직업군의 사원정보를 보여주세요
SELECT * FROM EMP
WHERE COMM = NULL;

#주의 : NULL 값은 등호(=)로 비교할 수 없다
IS NULL
IS NOT NULL

SELECT * FROM EMP
WHERE COMM IS NULL;

SELECT * FROM EMP
WHERE COMM <> NULL; --[X]

SELECT * FROM EMP
WHERE COMM IS NOT NULL; --[O]

#논리 연산자
AND 
OR 
NOT

--[문제]
--	- EMP테이블에서 급여가 1000이상 1500이하가 아닌 사원의
SELECT *
FROM EMP
WHERE NOT (SAL >=1000 AND SAL <= 1500);

SELECT * FROM EMP
WHERE SAL NOT BETWEEN 1000 AND 1500;
--
-- EMP테이블에서 이름에 'S'자가 들어가지 않은 사람의 이름을 모두
--	  출력하세요.
SELECT ENAME
FROM EMP
WHERE ENAME NOT LIKE '%S%';
--사원테이블에서 업무가 PRESIDENT이고 급여가 1500이상이거나
--업무가 SALESMAN인 사원의 사번,이름,업무,급여를 출력하세요.
SELECT EMPNO, ENAME, JOB, SAL
FROM EMP
WHERE JOB = 'PRESIDENT' AND SAL >= 1500 OR JOB = 'SALESMAN';

--- 고객 테이블에서 이름이 홍길동이면서 직업이 학생이 정보를 
--	    모두 보여주세요.
SELECT *
FROM MEMBER
WHERE NAME = '홍길동' AND JOB = '학생';
--	- 고객 테이블에서 이름이 홍길동이거나 직업이 학생이 정보를 
--	모두 보여주세요.
SELECT *
FROM MEMBER
WHERE NAME = '홍길동' OR JOB = '학생';
--	- 상품 테이블에서 제조사가 S사 또는 D사이면서 
--	   판매가가 100만원 미만의 상품 목록을 보여주세요
SELECT *
FROM PRODUCTS
WHERE (COMPANY = '삼성' OR COMPANY ='대우') AND OUTPUT_PRICE < 1000000;

# ORDER BY
    -ASC: 오름차순
    -DESC: 내림차순
    
EMP에서 최근 입사한 순으로 사번,이름,업무,입사일차를 보여주세요

SELECT EMPNO, ENAME, JOB, HIREDATE
FROM EMP
ORDER BY HIREDATE DESC;

--사원 테이블에서 부서번호로 정렬한 후 부서번호가 같을 경우
--	급여가 많은 순으로 정렬하여 사번,이름,업무,부서번호,급여를
--	출력하세요.
SELECT EMPNO, ENAME,JOB, DEPTNO, SAL
FROM EMP
ORDER BY DEPTNO ASC,SAL DESC;
--    
--    사원 테이블에서 첫번째 정렬은 부서번호로, 두번째 정렬은
--	업무로, 세번째 정렬은 급여가 많은 순으로 정렬하여
--	사번,이름,입사일자,부서번호,업무,급여를 출력하세요.
SELECT EMPNO, ENAME, HIREDATE, DEPTNO, JOB, SAL
FROM EMP
ORDER BY DEPTNO, JOB, SAL DESC;
--상품 테이블에서 배송비의 내림차순으로 정렬하되, 
--	    같은 배송비가 있는 경우에는
--		마일리지의 내림차순으로 정렬하여 보여주세요.
SELECT *
FROM PRODUCTS
ORDER BY TRANS_COST DESC,MILEAGE DESC;

SELECT *
FROM PRODUCTS
ORDER BY 7 DESC, 8 DESC;
