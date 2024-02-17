--day03_함수.sql
# 단일행함수
[1] 문자형 함수
[2] 숫자형 함수
[3] 날짜형 함수
[4] 변환 함수
[5] 기타 함수

#[1] 문자형 함수
<1> LOWER()/UPPER()=> 소문자로/대문자로 변환
    SELECT LOWER('HAPPY BIRTHDAY') FROM DUAL;
    SELECT UPPER('how are you?') from dual;
    
    SELECT * FROM DUAL;
    SELECT 8*7 FROM DUAL;
    
<2> initcap() => 첫 문자만 대문자, 나머지는 소문자

dept에서 부서번호,부서명, 근무지를 출력하되 첫글자만 대문자로 보여주세요

SELECT DEPTNO, INITCAP(DNAME), INITCAP(LOC) FROM DEPT;
    
<3> CONCAT(컬럼1, 컬럼2)    : 컬럼1과 컬럼2를 연결시켜줌
SELECT CONCAT('ABCD','1234') FROM DUAL;
SELECT CONCAT(EMPNO,ENAME) A FROM EMP;

<4> SUBSTR(변수 또는 컬럼,START,LEN)
SELECT SUBSTR('ABCDEFG', 3,2) FROM DUAL; -- CD
SELECT SUBSTR('ABCDEFG', -3,2) FROM DUAL;-- EF
SELECT SUBSTR('990215-1012345', 8,7 ) FROM DUAL;
SELECT SUBSTR('990215-1012345', -7) FROM DUAL;

<5> LENGTH(변수 또는 컬럼) : 문자열 길이 반환

SELECT LENGTH('990215-1012345') FROM DUAL;


--[문제]
--	 
--	 상품 테이블에서 판매가를 화면에 보여줄 때 금액의 단위를 함께 
--	 붙여서 출력하세요.
    select output_price,concat(output_price, '원'), output_price||'원'
    from products;    
--     고객테이블에서 고객 이름과 나이를 하나의 컬럼으로 만들어 결과값을 화면에
--	       보여주세요.
    SELECT CONCAT(NAME, AGE) FROM MEMBER;      
--  사원 테이블에서 첫글자가 'K'보다 크고 'Y'보다 작은 사원의
--	  사번,이름,업무,급여를 출력하세요. 단 이름순으로 정렬하세요. 
    SELECT EMPNO, ENAME, JOB, SAL FROM EMP 
    WHERE SUBSTR(ENAME, 1,1)>'K' AND SUBSTR(ENAME, 1,1)<'Y';
--      
--  사원테이블에서 부서가 20번인 사원의 사번,이름,이름자릿수,
--	급여,급여의 자릿수를 출력하세요.
    SELECT EMPNO,ENAME,LENGTH(ENAME),SAL,LENGTH(SAL) FROM EMP
	WHERE DEPTNO=20;	
--	
--	사원테이블의 사원이름 중 6자리 이상을 차지하는 사원의이름과 
--	이름자릿수를 보여주세요.   
    SELECT ENAME, LENGTH(ENAME) FROM EMP
    WHERE LENGTH(ENAME)>=6;

<6> LPAD(컬럼,N,C)/RPAD(컬럼,N,C)    
    
    SELECT ENAME, LPAD(ENAME,15,'#') FROM EMP;
    
    SELECT ENAME, SAL, LPAD(CONCAT('$',SAL), 10,' ') 급여 FROM EMP;
    
    SELECT RPAD(DNAME,15,'@') FROM DEPT;

<7> LTRIM(변수,문자)/RTRIM(변수,문자)
: 변수값 중 주어진 문자와 같은 단어가 있을 경우 그 문자를 삭제한 나머지값을 반환

SELECT LTRIM('tttHello test','t'), RTRIM('tttHello test','t') from dual;
    
select '    오늘의 날씨    ' , length('    오늘의 날씨    ') from dual;2   

select length(rtrim(ltrim('    오늘의 날씨    ',' '),' ')) title from dual;    
select trim('    오늘의 날씨    ') from dual;-- => 앞 뒤의 공백문자를 제거함

<8> REPLACE(컬럼,값1,값2) 
컬럼값 중에 값1이 있으면 값2로 교체하는 함수

EMP에서 JOB에서 'A'를 '$'로 바꾸어 출력

SELECT JOB, REPLACE(JOB,'A','$') FROM EMP;
    

--고객 테이블의 직업에 해당하는 컬럼에서 직업 정보가 학생인 정보를 모두
--	 대학생으로 변경해 출력되게 하세요.
    SELECT NAME,JOB, REPLACE(JOB,'학생','대학생') FROM MEMBER;
--
--고객 테이블 주소에서 서울시를 서울특별시로 수정하세요.  
    SELECT NAME,ADDR, REPLACE(ADDR,'서울시','서울특별시') FROM MEMBER;
    
    UPDATE MEMBER SET ADDR=REPLACE(ADDR,'서울시','서울특별시');
    
    SELECT * FROM MEMBER;
    
    ROLLBACK;    
--사원테이블에서 10번 부서의 사원에 대해 담당업무 중 우측에'T'를
--	삭제하고 급여중 우측의 0을 삭제하여 출력하세요.     
SELECT JOB, RTRIM(JOB,'T'), SAL, RTRIM(SAL,0)
FROM EMP
WHERE DEPTNO=10;
-----------------------------------------------------
[2] 숫자형 함수
<1> ROUND(값), ROUND(X, Y) : 반올림 함수
소수점의 오른쪽(왼쪽)에서 Y자리만큼 반올림된 X를 출력

SELECT ROUND(456.678), ROUND(456.478,0),
ROUND(456.678,2), ROUND(456.678,-2) FROM DUAL;

<2> TRUNC(값), TRUNC(X,Y) : 버림 함수. 절삭

SELECT TRUNC(456.678), TRUNC(456.678,0),
TRUNC(456.678,2), TRUNC(456.678,-2) FROM DUAL;

<3> MOD(X,Y): 나머지값을 구하는 함수
SELECT MOD(10,3) FROM DUAL;
<4> ABS(값): 절대값 구하는 함수
SELECT ABS(-9), ABS(9) FROM DUAL;

<5> CEIL(값)/FLOOR(값): 올림함수/내림함수
SELECT CEIL(123.0001), FLOOR(123.0001) FROM DUAL;

<6> CHR(값)/ASCII(값)
SELECT CHR(65), ASCII('F') FROM DUAL;

--- 회원 테이블에서 회원의 이름, 마일리지,나이, 마일리지를 나이로 나눈 값을 반올림하여
--보여주세요
    SELECT NAME, MILEAGE, AGE, ROUND(MILEAGE/AGE)
    FROM MEMBER;

--- 상품 테이블의 상품 정보가운데 백원단위까지 버린 배송비를 비교하여 출력하세요.
    SELECT PRODUCTS_NAME, TRANS_COST, TRUNC(TRANS_COST,-3)
    FROM PRODUCTS;

---사원테이블에서 부서번호가 10인 사원의 급여를 
--	30으로 나눈 나머지를 출력하세요.
    SELECT ENAME, SAL, MOD(SAL,30)
    FROM EMP
    WHERE DEPTNO=10;
    
    SELECT NAME, AGE, ABS(AGE-40) FROM MEMBER;
----------------------------------------------------------------
[3] 날짜 함수

SELECT SYSDATE,SYSDATE +3, SYSDATE-3, TO_CHAR(SYSDATE +3/24,'YY/MM/DD HH:MI:SS') FROM DUAL;

dATE+(-)숫자: 일수를 더하거나 뺀다

DATE-DATE : 일수

SELECT NAME, REG_DATE, FLOOR(SYSDATE -REG_DATE) "등록 이후 일수" FROM MEMBER;

--[실습]
--	사원테이블에서 현재까지의 근무 일수가 몇 주 몇일인가를 출력하세요.
--	단 근무일수가 많은 사람순으로 출려하세요.
select ename, trunc((sysdate-hiredate)/7) WEEKS, trunc(mod(sysdate-hiredate,7)) days
from emp ORDER BY 2 DESC;

<1> months_between(date1, date2)
: 두 날짜 사이의 월수를 구함
  정수 부분=> 월, 소수 부분=> 일
  
  SELECT ENAME,MONTHS_BETWEEN(SYSDATE, HIREDATE) FROM EMP
  ORDER BY 2 DESC;
  
  SELECT NAME, REG_DATE, MONTHS_BETWEEN(SYSDATE,REG_DATE) FROM MEMBER;
  
<2> ADD_MONTHS(DATE,M) : 월을 더함  
SELECT ADD_MONTHS(SYSDATE,5) "5개월 뒤", ADD_MONTHS(SYSDATE,-3) "석달 전" FROM DUAL;

SELECT ADD_MONTHS('22/01/31', 8) FROM DUAL;

<3> LAST_DAY(DATE) : 월의 마지막 날짜를 구함
SELECT LAST_DAY(SYSDATE), LAST_DAY('23/02/01') FROM DUAL;

<4> SYSDATE, SYSTIMESTAMP
SELECT SYSDATE, SYSTIMESTAMP FROM DUAL;

SELECT TO_CHAR(SYSDATE,'YYYY-MM-DD HH24:MI:SS') FROM DUAL;

SELECT TO_CHAR(SYSDATE,'CC YEAR-MONTH-DDD DY') FROM DUAL;
--------------------------------------------
[4] 변환 함수

<1> TO_CHAR(날짜) 
<2> TO_DATE(문자)
<3> TO_CHAR(숫자)
<4> TO_NUMBER(문자)

- 고객테이블의 등록일자를 0000-00-00 의 형태로 출력하세요.
    SELECT NAME, TO_CHAR(REG_DATE, 'YYYY-MM-DD') FROM MEMBER;
    
-  고객테이블에 있는 고객 정보 중 등록연도가 2023년인 
-	 고객의 정보를 보여주세요.
    SELECT NAME, REG_DATE FROM MEMBER 
    WHERE TO_CHAR(REG_DATE, 'YYYY')='2023';
    
- 고객테이블에 있는 고객 정보 중 등록일자가 2023년 5월1일보다 
-	 늦은 정보를 출력하세요. 
-	 단, 고객등록 정보는 년, 월만 보이도록 합니다.
    select NAME, to_char(reg_date,'YY/MM')
    from member
    where reg_date > to_date('2023/05/01','YYYY/MM/DD');
    
# TO_DATE(문자,포맷): 문자열을 DATE유형으로 변환하는 함수

    SELECT TO_DATE('22-08-19','YY-MM-DD') +3 FROM DUAL;
    SELECT SYSDATE - TO_DATE('20191107','YYYYMMDD') FROM DUAL;
    
# TO_CHAR(숫자,포맷)
SELECT TO_CHAR(1500000,'L9,999,999') FROM DUAL;
    
-- 73] 상품 테이블에서 상품의 공급 금액을 가격 표시 방법으로 표시하세요.
--	  천자리 마다 , 를 표시합니다
    SELECT PRODUCTS_NAME, TO_CHAR(INPUT_PRICE,'9,999,999') 공급가 FROM PRODUCTS;    
--  74] 상품 테이블에서 상품의 판매가를 출력하되 주화를 표시할 때 사용하는 방법을
--	  사용하여 출력하세요.[예: \10,000]  
    select products_name,to_char(output_price,'c9,999,999')
    from products;
# TO_NUMBER(문자,포맷): CHAR,VARCHAR2를 숫자로 변환
SELECT TO_NUMBER('150,000','999,999') * 2 FROM DUAL;

-- '$450.25' 의 3배값을 구하세요
SELECT TO_NUMBER('$450.25','$999D99')*3 FROM DUAL;

SELECT TO_CHAR(-23,'99S'), TO_CHAR(23,'99D99'), TO_CHAR(23,'99.99EEEE') FROM DUAL;
------------------------------------------------------------------------------
# 그룹 함수
: 여러 행 또는 테이블 전체에 함수가 적용되어 하나의 결과를 가져오는 함수를 의미
<1> COUNT(컬럼명) : NULL값을 무시하고 카운트를 센다
    COUNT(*) : NULL값도 포함하여 카운트를 센다
    SELECT * FROM EMP;
    SELECT COUNT(MGR) "관리자가 있는 사원수", COUNT(COMM) "보너스를 받는 사원수" FROM EMP;
    SELECT COUNT(DISTINCT MGR) "관리자수" FROM EMP;
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
    
--     [실습]
--		 emp테이블에서 모든 SALESMAN에 대하여 급여의 평균,
--		 최고액,최저액,합계를 구하여 출력하세요.
        
        SELECT ROUND(AVG(SAL)), MAX(SAL), MIN(SAL), SUM(SAL) 
        FROM EMP WHERE JOB='SALESMAN';        
        
--         EMP테이블에 등록되어 있는 인원수, 보너스에 NULL이 아닌 인원수,
--		보너스의 평균,등록되어 있는 부서의 수를 구하여 출력하세요.
        select count(*),count(comm),avg(comm),count(DISTINCT deptno)
            from emp;
어순: WGHO 순
# GROUP BY 절
: GROUP BY절에서는 그룹함수와 GROUP BY에서 사용한 컬럼만 SELECT할 수 있음에 유의하자

SELECT JOB,COUNT(*)
FROM MEMBER
GROUP BY JOB
ORDER BY COUNT(*) DESC;

--17] 고객 테이블에서 직업의 종류, 각 직업에 속한 최대 마일리지 정보를 보여주세요.
    SELECT JOB , MAX(MILEAGE)
    FROM MEMBER
    GROUP BY JOB;
--18] 상품 테이블에서 각 상품카테고리별로 총 몇 개의 상품이 있는지 보여주세요.
    select category_fk,count(category_fk)
    from products
    group by category_fk ORDER BY 1;
--19] 상품 테이블에서 각 공급업체 코드별(EP_CODE_FK)로 
-- 공급한 상품의 평균입고가를 보여주세요.
    select ep_code_fk, ROUND(avg(input_price))
    from products
    group by ep_code_fk;

    
--    문제1] 사원 테이블에서 입사한 년도별로 사원 수를 보여주세요.
    select to_char(hiredate, 'yy') as year, count(*)
    from emp
    group by to_char(hiredate, 'yy') order by year asc;

--	문제2] 사원 테이블에서 해당년도 각 월별로 입사한 사원수를 보여주세요.
    
    SELECT TO_CHAR(HIREDATE, 'YYYY-MM'), COUNT(*) 
    FROM EMP GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM') 
    ORDER BY TO_CHAR(HIREDATE, 'YYYY-MM');
    
--	문제3] 사원 테이블에서 업무별 최대 연봉, 최소 연봉을 출력하세요.
    select job,max(sal),min(sal)
    from emp
    group by job;

    SELECT job, MAX(sal * 12 + nvl(comm, 0)), MIN(sal * 12 + nvl(comm, 0))
    FROM emp
    GROUP BY job;
    
    