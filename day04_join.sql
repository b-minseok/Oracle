day04_join.sql

DEPT와 EMP를 JOIN
[1] EQUI JOIN (INNER JOIN)

<1> OLD VERSION

SELECT EMP.DEPTNO,DEPT.DNAME, EMPNO, ENAME, JOB
FROM DEPT, EMP
WHERE DEPT.DEPTNO = EMP.DEPTNO
ORDER BY EMP.DEPTNO ASC;

<2> NEW VERSION - 명시적 JOIN절 이용 (표준 SQL)
SELECT D.*, E.*
FROM DEPT D JOIN EMP E
ON D.DEPTNO = E.DEPTNO
ORDER BY D.DEPTNO;

--[실습]
--	 SALESMAN의 사원번호,이름,급여,부서명,근무지를 출력하여라.
SELECT EMPNO, ENAME, SAL, DNAME, LOC 
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO AND E.JOB='SALESMAN';

SELECT EMPNO, ENAME, SAL, DNAME, LOC 
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO WHERE E.JOB='SALESMAN';

--     서로 연관이 있는 카테고리 테이블과 상품 테이블을 이용하여 각 상품별로 카테고리
--	      이름과 상품 이름을 함께 보여주세요.
SELECT C.CATEGORY_NAME, PRODUCTS_NAME, OUTPUT_PRICE
FROM CATEGORY C JOIN PRODUCTS P
ON C.CATEGORY_CODE = P.CATEGORY_FK ORDER BY CATEGORY_CODE;

--     카테고리 테이블과 상품 테이블을 조인하여 화면에 출력하되 상품의 정보 중
--	      제조업체(COMPANY)가 삼성인 상품의 정보만 추출하여 
--          카테고리 이름과 상품이름, 상품가격
--	      제조사 등의 정보를 화면에 보여주세요.
SELECT CATEGORY_NAME, PRODUCTS_NAME, OUTPUT_PRICE, COMPANY
FROM PRODUCTS P JOIN CATEGORY C
ON P.CATEGORY_FK = C.CATEGORY_CODE
WHERE COMPANY = '삼성';
--
--	     
--
--	각 상품별로 카테고리 및 상품명, 가격을 출력하세요. 단 카테고리가 'TV'인 것은 
--	      제외하고 나머지 정보는 상품의 가격이 저렴한 순으로 정렬하세요.
SELECT CATEGORY_NAME, PRODUCTS_NAME, OUTPUT_PRICE
FROM PRODUCTS P JOIN CATEGORY C
ON P.CATEGORY_FK = C.CATEGORY_CODE
WHERE CATEGORY_NAME <> 'TV'
ORDER BY OUTPUT_PRICE;

[2] NON-EQUI JOIN
- '='가 아닌 연산기호를 사용하여 조인하는 경우

SELECT * FROM SALGRADE;
SELECT * FROM EMP;
사원정보를 보여주되 사번,이름,업무,급여, 급여 등급, 급여등급의 최저구간, 급여등급의 최고구간
    을 함께 보여주세요
    
SELECT EMPNO, ENAME, JOB, SAL ,GRADE, LOSAL, HISAL
FROM EMP E JOIN SALGRADE S
ON E.SAL BETWEEN S.LOSAL AND S.HISAL ORDER BY SAL DESC;

--[문제]
--
---  emp테이블에서 NEW YORK에서 근무하고 있는 사원에 대하여 이름,업무,급여,
--    부서명을 출력하는 SELECT문을 작성하세요.
--
--- EMP테이블에서 보너스를 받는 사원에 대하여 이름,부서명,위치를 출력하는
--    SELECT문을 작성하세요.
--
--- EMP테이블에서 이름 중 L자가 있는 사원에 대해 이름,업무,부서명,위치를 
--   출력하는 문장을 작성하세요.
--
--- 아래의 결과를 출력하는 문장을 작성하에요(관리자가 없는 King을 포함하여
--	모든 사원을 출력)
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
