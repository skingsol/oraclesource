-- scott

-- emp(employee) 테이블 구성보기
DESC emp;
-- 필드명(열이름) 제약조건 데이터타입
-- EMPNO(사원번호) NOT NULL  NUMBER(4)
-- ENAME(사원명),JOB(직책), MGR(직속상관 번호), HIREDATE(입사일), SAL(급여), COMM(수당), DEPTNO(부서번호)
-- NUMBER : 소수점 자릿수를 포함해서 지정 가능
-- NUMBER(4): 4자리 숫자까지 허용, NUMBER(8,2):전체 자릿수는 8이고 소수점 2자리를 포함한다.
-- VARCHAR2 : 가변형 문자열 저장
-- VARCHAR2(10): 10byte 문자까지 저장 가능
-- DATE : 날짜데이터

DESC dept;
-- DEPTNO(부서번호), DNAME(부서명), LOC(부서명)

DESC SALGRADE;
-- GRADE(급여등급), LOSAL(최소 급여액), HISAL(최대 급여액)

-- select : 데이터 조회
-- 조회 방식 : 셀렉션(행 단위로 조회), 프로젝션(열 단위로 조회), 조인(두 개 이상의 테이블을 사용하여 조회)
--SELECT 열이름1, 열이름2...(조회할 열이 전체라면 *로 처리)
--FROM 테이블명;

-- 1. EMP테이블의 전체 열을 조회
SELECT
    *
FROM
    emp;

-- 2. emp테이블에서 사원번호, 이름, 급여 열을 조회
SELECT
    empno,
    ename,
    sal
FROM
    emp;

-- 3. DEPT 테이블 전체 조회
SELECT
    *
FROM
    dept;
-- 4. DEPT 테이블안에 부서번호, 지역만 조회
SELECT
    deptno,
    loc
FROM
    dept;

-- EMP 테이블안에 부서번호 조회
SELECT
    deptno
FROM
    emp;

-- 6. EMP 테이블안에 부서번호 조회(단, 중복된 부서 번호는 제거)
-- DISTINCT : 중복 제거
SELECT DISTINCT
    deptno
FROM
    emp;
    
-- 열이 여러 개인 경우(묶어서 중복이냐 아니냐를 판단)    
SELECT DISTINCT
    job,
    deptno
FROM
    emp;    
    
-- 7. 연산
-- 별칭 : 필드에 별칭을 임의로 부여 ( as 별칭, 혹은  한칸 띄고 별칭, 별칭에 공백이 있다면 ""으로 묶어주기)
-- 사원들의 1년 연봉 구하기 (SAL * 12 + COMM)
SELECT
    empno,
    ename,
    sal * 12 + comm AS annsal
FROM
    emp;

SELECT
    empno,
    ename           사원명,
    job             "직 책",
    sal * 12 + comm annsal
FROM
    emp;
    
-- 8. 정렬 : ORDER BY
-- 내림차순 => DESC, 오름차순 => ASC (오름차순일때는 ORDER BY만 스고 ASC 생략가능)

-- ENAME, SAL 열 추출하고, SAL 내림차순으로 정렬
SELECT
    ename,
    sal
FROM
    emp
ORDER BY
    sal DESC;

-- ENAME, SAL 열 추출하고, SAL 오름차순으로 정렬
SELECT
    ename,
    sal
FROM
    emp
ORDER BY
    sal;

-- 전체 내용 출력하고, 결과가 사원번호의 오름차순으로 정렬
SELECT
    *
FROM
    emp
ORDER BY
    empno;

-- 전체 내용 출력하고, 결과가 부서번호의 오름차순과 급여 내림차순으로 정렬
SELECT
    *
FROM
    emp
ORDER BY
    deptno,
    sal DESC;

--[실습] emp 테이블의 모든 열 출력
-- empno => employee_no
-- ename => employee_name
-- mgr => manager
-- sal => salary
-- comm => commission
-- deptno => department_no
-- 부서 번호를 기준으로 내림차순으로 정렬하되 부서번호가 같다면
-- 사원 이름을 기준으로 오름차순 정렬
SELECT
    empno  employee_no,
    ename  employee_name,
    mgr    "manager",
    sal    salary,
    comm   commission,
    deptno department_no
FROM
    emp
ORDER BY
    deptno DESC,
    ename;

--WHERE : 특정 조건을 기준으로 원하는 행을 조회

-- 부서번호가 30인 데이터만 조회
SELECT
    *
FROM
    emp
WHERE
    deptno = 30; -- (= : 같다)

-- 사원번호가 7782인 사원 조회
SELECT
    *
FROM
    emp
WHERE
    empno = 7782;

-- 부서번호가 30이고, 사원직책이 SALESMAN 정보 조회
SELECT
    *
FROM
    emp
WHERE
        deptno = 30
    AND job = 'SALESMAN';

-- 사원번호가 7499이고, 부서번호가 30인 행 조회
SELECT
    *
FROM
    emp
WHERE
        empno = 7499
    AND deptno = 30;

-- 부서번호가 30이거나, 사원직책이 CLERK 인 행 조회
SELECT
    *
FROM
    emp
WHERE
    deptno = 30
    OR job = 'CLERK';


-- 산술연산자 : +,-,*,/, mod(나머지: 표준아니고 오라클에서만 제공)
-- 비교연산자 : >, >=, <, <= 
-- 등가비교연산자 : =
--               !=, <>, ^= (A값과 B값이 다를 경우 true, 같을경우 false)
-- 논리부정연산자 : NOT
-- IN 연산자
-- BETWEEN A AND B 연산자
-- LIKE연산자와 와일드 카드(ㅡ, %)
-- IS NULL 연산자
-- 집합연산자 : UNION(합집합-중복제거), UNION ALL (합집합-중복포함), MINUS(차집합), INTERSECT(교집합)

-- 연산자 우선순위 
-- 1) 산술연산자 *, /
-- 2) 산술연산자 +,-
-- 3) 비교연산자
-- 4) IS NULL, IS NOT NULL, LIKE, IN
-- 5) BETWEEN A AND B
-- 6) NOT
-- 7) AND
-- 8) OR
--우선순위를 줘야 한다면 소괄호 사용 추천

-- EMP 테이블에서 급여 열에 12를 곱한 값이 36000 인 행 조회
SELECT
    *
FROM
    emp
WHERE
    sal * 12 = 36000;

-- ename 이 F 이후의 문자로 시작하는 사원 조회
-- 문자 표현시 ''만 사용 ("") 사용안함
SELECT
    *
FROM
    emp
WHERE
    ename >= 'F';

-- JOB이 MANAGER, SALESMAN, CLERK 사원 조회
SELECT
    *
FROM
    emp
WHERE
    job = 'MANAGER'
    OR job = 'SALESMAN'
    OR job = 'CLERK';

-- sal 이 3000이 아닌 사원 조회
SELECT
    *
FROM
    emp
WHERE
    sal != 3000;

SELECT
    *
FROM
    emp
WHERE
    sal <> 3000;

SELECT
    *
FROM
    emp
WHERE
    sal^= 3000;

SELECT
    *
FROM
    emp
WHERE
    NOT sal = 3000;

-- JOB이 MANAGER, SALESMAN, CLERK 사원 조회 ==> IN연산자를 사용하기 
SELECT
    *
FROM
    emp
WHERE
    job IN ( 'MANAGER', 'SALESMAN', 'CLERK' );

-- JOB이 MANAGER, SALESMAN, CLERK 이 아닌 사원 조회 ==>NOT IN연산자를 사용하기 
SELECT
    *
FROM
    emp
WHERE
    job NOT IN ( 'MANAGER', 'SALESMAN', 'CLERK' );

-- 부서번호가 10, 20 사원조회(in 사용)
SELECT
    *
FROM
    emp
WHERE
    deptno IN ( 10, 20 );

-- 급여가 2000 이상 3000 이하인 사원 조회
SELECT
    *
FROM
    emp
WHERE
        sal >= 2000
    AND sal <= 3000;
-- BETWEEN 최소값 AND 최대값;
SELECT
    *
FROM
    emp
WHERE
    sal BETWEEN 2000 AND 3000;

-- 급여가 2000 이상 3000 이하가 아닌 사원 조회
SELECT
    *
FROM
    emp
WHERE
    sal NOT BETWEEN 2000 AND 3000;


-- LIKE 연산자와 와일드 카드(_,%)
-- _ : 어떤 값이든 상관없이 한개의 문자 데이터를 의미
-- % : 길이와 상관없이(문자 없는 경우도 포함) 모든 문자 데이터를 의미

-- 사원 이름이 S로 시작하는 사원 정보 조회
SELECT
    *
FROM
    emp
WHERE
    ename LIKE 'S%';

-- 사원 이름의 두번째 글자 L 인 사원만 조회
SELECT
    *
FROM
    emp
WHERE
    ename LIKE '_L%';

-- 사원 이름이 AM 이 포함된 사원만 조회
SELECT
    *
FROM
    emp
WHERE
    ename LIKE '%AM%';

-- 사원 이름에 AM 이 포함되지 않은 사원만 조회
SELECT
    *
FROM
    emp
WHERE
    ename NOT LIKE '%AM%';


-- NULL : 데이터 값이 완전히 비어 있는 상태 ( is사용)
-- NULL은 = 사용불가

-- comm 이 null인 사원 조회
SELECT
    *
FROM
    emp
WHERE
    comm IS NULL;

-- mgr 이 null인 사원 조회
SELECT
    *
FROM
    emp
WHERE
    mgr IS NULL;

-- mgr 이 null이 아닌 사원 조회
SELECT
    *
FROM
    emp
WHERE
    mgr IS NOT NULL;


-- 집합연산자

-- union(동일한 결과값인 경우 중복 제거), union all(중복 제거 안함) : 합집합

SELECT
    empno,
    ename,
    sal,
    deptno
FROM
    emp
WHERE
    deptno = 10
UNION
SELECT
    empno,
    ename,
    sal,
    deptno
FROM
    emp
WHERE
    deptno = 10;

SELECT
    empno,
    ename,
    sal,
    deptno
FROM
    emp
WHERE
    deptno = 10
UNION ALL
SELECT
    empno,
    ename,
    sal,
    deptno
FROM
    emp
WHERE
    deptno = 10;

-- MINUS(차집합)
SELECT
    empno,
    ename,
    sal,
    deptno
FROM
    emp
MINUS
SELECT
    empno,
    ename,
    sal,
    deptno
FROM
    emp
WHERE
    deptno = 10;

-- INTERSECT(교집합)
SELECT
    empno,
    ename,
    sal,
    deptno
FROM
    emp
INTERSECT
SELECT
    empno,
    ename,
    sal,
    deptno
FROM
    emp
WHERE
    deptno = 10;
    
--EMP 테이블에서 사원이름이 S로 끝나는 사원 데이터 조회
SELECT
    *
FROM
    emp
WHERE
    ename LIKE '%S';

-- EMP 테이블에서 30번 부서에 근무하는 사원 중에서 직책이 SALESMAN인 사원의
-- 사원번호, 이름, 급여 조회(SAL 내림차순)
SELECT
    empno,
    ename,
    sal
FROM
    emp
WHERE
    deptno = 30
ORDER BY
    sal DESC;

-- EMP 테이블을 사용하여 20, 30번 부서에 근무하고 있는 사원 중 급여가 2000초과인 사원 조회
-- 사원번호, 이름, 급여, 부서번호 조회
-- 집합 연산자를 사용하는 방식과 사용하지 않는 방식 두 가지를 사용한다.
SELECT
    empno,
    ename,
    sal,
    deptno
FROM
    emp
WHERE
    deptno IN ( 20, 30 )
    AND sal > 2000;

SELECT
    empno,
    ename,
    sal,
    deptno
FROM
    emp
WHERE
    sal > 2000
MINUS
SELECT
    empno,
    ename,
    sal,
    deptno
FROM
    emp
WHERE
    deptno = 10;

SELECT
    empno,
    ename,
    sal,
    deptno
FROM
    emp
WHERE
        deptno = 20
    AND sal > 2000
UNION
SELECT
    empno,
    ename,
    sal,
    deptno
FROM
    emp
WHERE
        deptno = 30
    AND sal > 2000;

-- 사원 이름에 e가 포함되어 있는 30번 부서 사원 중 급여가 1000~2000 사이가 아닌 사원의 이름
-- 사원번호, 급여, 부서번호를 조회하기
SELECT
    empno,
    ename,
    sal,
    deptno
FROM
    emp
WHERE
    ename LIKE '%E%'
    AND deptno = 30
    AND sal NOT BETWEEN 1000 AND 2000;

-- 추가 수당이 존재하지 않으며, 상급자가 있고 직책이 MANAGER, CLERK 인 사원 중에서 사원 이름의 
-- 두번째 글자가 L이 아닌 사원의 정보 조회
SELECT
    *
FROM
    emp
WHERE
    comm IS NULL
    AND mgr IS NOT NULL
    AND job IN ( 'MANAGER', 'CLERK' )
    AND ename NOT LIKE '_L%';


-- 오라클 함수
-- 오라클에서 기본으로 제공하는 내장 함수와 사용자가 필요에 의해 직접 정의한 사용자 정의 함수

-- 1. 문자열 함수
-- 1) UPPER LOWER INITCAP
-- UPPER : 모두 대문자, LOWER : 모두 소문자, INITCAP : 첫 글자만 대문자
-- LIKE '%ORACLE%' OR LIKE '%oracle%' OR LIKE '%Oracle%' ==> 검색시 사용

-- 1. UPPER, LOWER, INITCAP
SELECT
    ename,
    upper(ename),
    lower(ename),
    initcap(ename)
FROM
    emp;

SELECT *
FROM emp
WHERE upper(ename) = 'FORD';

SELECT *
FROM emp
WHERE upper(ename) LIKE upper('%FORD%');

-- 2) LENGTH : 문자열 길이
SELECT ename, length(ename)
FROM emp;

-- 사원이름의 길이가 5이상인 사원조회
SELECT *
FROM emp
WHERE length(ename) >=5;

-- 한글일때
-- dual : sys가 소유하는 테이블(임시 연산이나 함수의 결과 값 확인하는 용도)
-- length, lengthb(문자가 사용하는 바이트 수)
-- 영어 : 문자1 => 1byte, 한글 : 문자 1 => 3 byte
SELECT length('한글'), lengthb('한글'), lengthb('ab')
FROM dual;

-- 3) SUBSTR(문자열데이터, 시작위치, 추출길이) : 추출길이 생략 가능
-- 문자열 일부 추출

SELECT job, SUBSTR(JOB, 1,2), SUBSTR(JOB,3,2), SUBSTR(JOB,5), SUBSTR(JOB,-3)
FROM emp;

-- ENAME, 모든 사원의 이름을 3번째 글짜부터 끝까지 출력
SELECT ename, SUBSTR(ENAME, 3)
FROM emp;

-- 3) INSTR : 문자열 데이터 안에서 특정 문자 위치 찾기
-- INSTR(대상문자열, 위치를 찾으려는 문자열, 대상문자열에서 찾기를 시작할 위치(선택), 시작위치에서 찾으려는 문자가 몇번째인지 지정(선택))

-- HELLO, ORACLE 문자열에서 L 문자열 찾기
SELECT 
       INSTR('HELLO, ORACLE!', 'L') AS INSTR_1, 
       INSTR('HELLO, ORACLE!', 'L', 5) AS INSTR_2, 
       INSTR('HELLO, ORACLE!', 'L', 2, 2) AS INSTR_3
FROM DUAL;

-- 4) REPLACE : 특정 문자를 다른 문자로 변경
-- REPLACE(문자열데이터, 찾는문자, 변경문자)

-- 010-1234-5678 -를 빈 문자열로 변경
SELECT '010-1234-5678' AS 변경전, REPLACE('010-1234-5678','-',' ') AS REPLACE_1, REPLACE('010-1234-5678','-') AS REPLACE_2
FROM DUAL;

-- '이것이 Oracle 이다', '이것이' => This is 변경
SELECT '이것이 Oracle 이다' AS 변경전, REPLACE('이것이 Oracle 이다','이것이','This is') AS REPLACE
FROM DUAL;

-- 5) CONCAT : 두 문자열 데이터 합치기
SELECT CONCAT(empno, ename)
FROM emp;

SELECT CONCAT(empno, concat(':', ename))
FROM emp;

-- || : 문자열 연결 연산자
SELECT empno || ename, empno || ':' || ename
FROM emp;

-- 6) TRIM, LTRIM, RTRIM : 공백포함 특정 문자 제거
-- ' ORACLE' = 'ORACLE' 두개 비교하면 ==> false
SELECT '     이것이      ', TRIM('     이것이      ')
FROM dual;

-- 2. 숫자함수
-- 1) ROUND, TRUNC, CEIL, FLOOR, MOD

-- round : 반올림
-- round(숫자, 반올림 위치(선택))

SELECT round(1234.5678) as round,     -- 소수점 첫째 자리에서 반올림
round(1234.5678,0) as round0,         -- 소수점 첫째 자리에서 반올림
round(1234.5678,1) as round1,         -- 소수점 둘째 자리에서 반올림
round(1234.5678,2) as round2,         -- 소수점 세번째 자리에서 반올림
round(1234.5678,-1) as round1,        -- 자연수 첫째 자리에서 반올림
round(1234.5678,-2) as round2         -- 자연수 둘째 자리에서 반올림
FROM dual;

-- trunc : 특정 위치에서 버리는 함수
-- trunc(숫자, 버림 위치(선택))
SELECT trunc(1234.5678) as trunc,     -- 소수점 첫째 자리에서 버림
trunc(1234.5678,0) as trunc0,         -- 소수점 첫째 자리에서 버림
trunc(1234.5678,1) as trunc1,         -- 소수점 둘째 자리에서 버림
trunc(1234.5678,2) as trunc2,         -- 소수점 세번째 자리에서 버림
trunc(1234.5678,-1) as trunc1,        -- 자연수 첫째 자리에서 버림
trunc(1234.5678,-2) as trunc2         -- 자연수 둘째 자리에서 버림
FROM dual;

-- ceil(숫자), floor(숫자) : 입력된 숫자와 가까운 큰 정수, 작은정수

SELECT ceil(3.14), floor(3.14),ceil(-3.14), floor(-3.14)
FROM dual;

-- mod(숫자, 나눌수) : 나머지 값
SELECT mod(15, 6),mod(10,2),mod(11,2)
FROM dual;



-- 날짜 함수
-- 날짜 데이터 + 숫자 : 날터보다 숫자만큼 일수 이후의 날짜
-- 날자 데이터 - 날짜데이터 : 두 날짜 데이터 간의 일수 차이

-- 날짜 데이터 + 날짜데이터 : 연산불가

-- 1) sysdate 함수 : 오라클 데이터베이스 서버가 설치된 OS의 현재날짜와 시간을 가져옴
SELECT sysdate, sysdate -1 as yesterday, sysdate +1 as tomorrow
FROM dual;

-- 2) add_months(날짜, 더할 개월수) : 몇 개월 이후 날짜 구하기
SELECT sysdate, add_months(sysdate, 3)
FROM dual;

-- 입사 50주년이 되는 날짜 구하기
-- empno, ename, hiredate, 입사50주년 날짜 조회
SELECT empno, ename, hiredate, add_months(hiredate, 600)
FROM emp;

-- 3) MONTHS_BETWEEN(최근 날짜, 옛날 날짜) : 두 날짜 데이터 간의 날짜 차이를 개월수로 계산하여 출력
--  45년미만인 사원 데이터 조회
-- empno, ename, hiredate
SELECT empno, ename, hiredate 
FROM emp
WHERE months_between(sysdate, hiredate) < 540;

-- 현재 날짜와 6개월 후 날짜 출력
SELECT sysdate, add_months(sysdate, 6)
FROM dual;

SELECT empno, ename, hiredate, sysdate, 
months_between(hiredate, sysdate) as months1,
months_between(sysdate, hiredate) as months2,
trunc( months_between(sysdate, hiredate)) as months3
FROM emp;

-- 4) next_day(날짜, 요일) : 특정 날짜를 기준으로 돌아오는 요일의 날짜 출력 
--    last_day(날짜) : 특정 날짜가 속한 달의 마지막 날짜를 출력
SELECT sysdate, next_day(sysdate, '금요일'), last_day(sysdate)
FROM dual;

-- 날짜의 반올림, 버림 : ROUND, TRUNC
-- CC : 네 자리 연도의 끝 두자리를 기준으로 사용 2023년인 경우 2050 이하이므로 2001년 으로 반내림 처리
SELECT sysdate,
round(sysdate, 'CC') AS format_cc,
round(sysdate, 'YYYY') AS format_YYYY,
round(sysdate, 'DDD') AS format_DDD,
round(sysdate, 'HH') AS format_HH
FROM dual;


-- 형변환 함수 : 자료형을 형 변환
-- NUMBER, VARCHAR2, DATE
SELECT empno, ename, empno+'500'
FROM emp
WHERE ename = 'FORD';


-- TO_CHAR() : 숫자 또는 날짜 데이터를 문자 데이터로 변환
-- TO_NUMBER() : 문자 데이터를 숫자 데이터로 변환
-- TO_DATE() : 문자 데이터를 날짜 데이터로 변환

-- 원하는 출력 형태로 날짜 출력하기 to_char 주로 사용됨
SELECT sysdate, to_char(SYSDATE, 'YYYY/MM/DD HH24:MI:SS') AS 현재날짜시간
FROM dual;

-- MON, MONTH
SELECT sysdate, to_char(sysdate, 'YYYY/MM/DD') AS 현재날짜,
to_char(sysdate, 'yyyy') AS 현재년도,
to_char(sysdate, 'mm') AS 현재월,
to_char(sysdate, 'mon') AS 현재월1,
to_char(sysdate, 'month') AS 현재월2,
to_char(sysdate, 'dd') AS 현재일짜,
to_char(sysdate, 'ddd') AS 현재일짜2,      -- ddd 현재 년도 365일중 몇일째인지 표기
to_char(sysdate, 'hh24:mi:ss am') AS 현재날짜시간 
FROM dual;

-- sal 필드에 ,(콤마)나 통화표시를 하고 싶다면?
-- L(Locale) 지역 화폐 단위 기호 붙여줌
SELECT sal, to_char(sal, '$999,999') AS sal_$, sal, to_char(sal, 'L999,999') AS sal_L
FROM emp;


-- to_number(숫자로 바꿀 문자열데이터, 인식될 숫자형태)

-- 자동형변환
SELECT 1300 - '1500', '1300' + 1500 
FROM dual;

-- 자동형변환안되는 상황
SELECT to_number('1,300','999,999') - to_number('1,500','999,999')
FROM dual;


-- to_date(문자열데이터, '인신될 날짜 형태')
SELECT to_date('2018-07-14', 'yyyy-hh-dd') AS todate1,
to_date('20230320', 'yyyy-hh-dd') AS todate2
FROM dual;

-- ORA-01722: 수치가 부적합합니다 오류
--SELECT '2023-03-21' - '2023-02-01'
--FROM dual;

SELECT to_date('2023-03-21') - to_date('2023-02-01')
FROM dual;

-- 널처리 함수
-- null + 300 = null

-- NVL(데이터, null일 경우 반환할 데이터)
SELECT empno, ename, sal, comm, sal+comm, nvl(comm, 0), sal+nvl(comm,0)
FROM emp;

-- NVL(데이터, null이 아닐 경우 반환할 데이터, null일 경우 반환할 데이터)
SELECT empno, ename, sal, comm, nvl2(comm, 'O', 'X'), nvl2(comm, sal * 12 + comm, sal * 12) AS annsal
FROM emp;

-- DECODE 함수 / CASE 문

-- DECODE(검사대상이 될 데이터, 
--                           조건1, 조건1이 일치할때 실행할 구문,
--                           조건2, 조건2이 일치할때 실행할 구문)

-- emp 테이블에 직책이 MANAGER 인 사람은 급여의 10% 인상,
-- SALESMAN 인 사람은 5%, ANALYST 인 사람은 그대로, 나머지는 3% 인상된 급여 출력
SELECT empno, ename, job, sal, decode(job, 'MANAGER', sal * 1.1,
                                           'SALESMAN', sal * 1.05,
                                           'ANALYST', sal, sal * 1.03) AS upsal
FROM emp;

-- CASE 문
SELECT empno, ename, job, sal, case job when 'MANAGER' then sal * 1.1
                                        when 'SALESMAN' then sal * 1.05
                                        when 'ANALYST' then sal else sal * 1.03 end AS upsal
FROM emp;

SELECT empno, ename, job, sal, case when comm is null then '해당사항이 없음'
                                    when comm = 0 then '수당없음'
                                    when comm > 0 then '수당 : ' || comm end AS comm_text
FROM emp;

--[실습] sql 작성
-- EMP 테이블에서 사원들의 월 평균 근무일수는 21.5일이다. 하루 근무 시간을 8시간으로 보았을 때 
-- 사원들의 하루 급여(DAY_PAY)와 시급(TIME_PAY)를 계산하여 결과를 출력한다. 
-- 단, 하루 급여는 소수점 셋째 자리에서 버리고, 시급은 두번째 소수점에서 반올림 하시오.
SELECT empno, ename, sal, trunc(sal/21.5,2) AS DAY_PAY, round(sal/21.5/8,1) AS TIME_PAY
FROM emp;

--[실습] sql 작성
-- EMP 테이블에서 사원들은 입사일(HOREDATE)을 기준으로
-- 3개월이 지난 후 첫 월일에 정직원이 된다. 사원들의 
-- 정직원이 되는 날짜(R_JOB)를 YYYY-MM-DD 형식으로 아래와 같이 출력하시오.
-- 단, 추가수당(COMM)이 없는 사원의 추가 수당은 N/A로 출력하시오.
SELECT empno, ename, hiredate, next_day(add_months(hiredate, 3), '월요일')AS R_job, nvl(to_char(comm), 'N/A') AS comm
FROM emp;

--[실습] sql 작성
-- EMP 테이블의 모든 사원을 대상으로 직속 상관의 사원번호(MGR)를 다음과 같은 조건을 기준으로 변환해서 CHG_MGR 열에 출력하시오.
SELECT empno, ename, mgr, decode(substr(to_char(mgr),1,2),
                                null, '0000',
                                '75', '5555',
                                '76', '6666',
                                '77', '7777',
                                '78', '8888',
                                substr(to_char(mgr),1)) AS chg_mgr
FROM emp;

SELECT empno, ename, mgr, case when mgr is null then '0000'
                                when substr(to_char(mgr), 1,2)='75' then '5555'
                                when substr(to_char(mgr), 1,2)='76' then '6666'
                                when substr(to_char(mgr), 1,2)='77' then '7777'
                                when substr(to_char(mgr), 1,2)='78' then '8888'
                                else to_char(mgr) end AS chg_mgr
FROM emp;


-- 다중행 (집계) 함수 : sum, count, max, min, avg
SELECT SUM(sal)
FROM emp;

SELECT SUM(distinct sal), SUM(all sal), SUM(sal)
FROM emp;

-- sum() : null은 제외하고 합계를 구해줌
SELECT SUM(comm)
FROM emp;

SELECT count(sal)
FROM emp;

SELECT count(comm)   -- emp 테이블의 comm행의 개수가 몇개야?
FROM emp;

SELECT count(*)     -- emp 테이블의 행의 개수가 몇개야?
FROM emp;

SELECT count(*)
FROM emp
WHERE deptno = 30;  -- emp 테이블 사원번호가 30인 사람이 몇명이야?

-- MAX
SELECT max(sal)
FROM emp;

SELECT max(hiredate)   -- 입사날짜의 가장 최신날짜가 머야?
FROM emp;

SELECT max(hiredate)   -- 부서번호가20인 입사자의 가장 최근 입사일은?
FROM emp
WHERE deptno = 20; 

-- MIN
SELECT min(hiredate)   -- 입사날짜의 가장 오래된 날짜가 머야?
FROM emp;

SELECT min(hiredate)   -- 부서번호가20인 입사자의 가장 오래된 입사일은?
FROM emp
WHERE deptno = 20;

-- AVG
SELECT avg(sal)   -- 연봉 평균
FROM emp;



-- group by : 결과 값을 원하는 열로 묶어 출력

-- 부서별 sal 평균 구하기
SELECT avg(sal)FROM emp WHERE deptno=10;
SELECT avg(sal)FROM emp WHERE deptno=20;
SELECT avg(sal)FROM emp WHERE deptno=30;
-- 위에 식을 group by를 사용하여 한줄로 만들기
SELECT avg(sal), deptno FROM emp GROUP BY deptno;

-- 부서별 추가수당 평균 구하기
SELECT deptno, avg(comm) 
FROM emp 
GROUP BY deptno;

--오류: GROUP BY 표현식이 아닙니다.
--SELECT avg(sal),deptno,ename FROM emp GROUP BY deptno;



-- GROUP BY + HAVING : group by 절에 조건을 줄 때
-- HAVING : 그룹화된 대상을 출력 제한 걸때

-- 각 부서의 직책별 평균 급여 구하기(단, 평균 급여가 2000이상인 그룹만 출력하기)
-- deptno, job 평균
SELECT deptno, job, avg(sal)
FROM emp
GROUP BY deptno, job HAVING avg(sal) >=2000
ORDER BY deptno, job;

--오류 : 그룹 함수는 허가되지 않습니다 ( 그룹함수는 WHERE절에 넣을 수 없다.)
--SELECT deptno, job, avg(sal) 
--FROM emp
--WHERE avg(sal) >=2000 
--GROUP BY deptno, job 
--ORDER BY deptno, job;

-- 1)from구문 실행 2)where 실행 3)group by 실행 4) having 실행  5)select 실행  6)order by 실행 
SELECT deptno, job, avg(sal)
FROM emp
WHERE sal <= 3000
GROUP BY deptno, job 
HAVING avg(sal) >=2000
ORDER BY deptno, job;

--[실습] SQL 작성
--EMP 테이블을 이용하여 부서번호(DEPTNO), 평균급여(AVG_SAL), 최고급여(MAX_SAL), 최저급여(MIN_SAL), 사원수(CNT)를 출력한다.
--단, 평균 급여를 출력할 때 소수점을 제외하고 각 부서번호별로 출력하는 SQL 문을 작성하시오.
SELECT deptno, floor (avg(sal))AS AVG_SAL, max(sal)AS AVG_SAL, min(sal)AS MIN_SAL, count(deptno) AS CNT
FROM emp
GROUP BY deptno
ORDER BY deptno DESC;
--같은 직책에 종사하는 사원이 3명 이상인 직책과 인원수를 출력하는 SQL문을 작성하시오.
SELECT job, count(*)
FROM emp
GROUP BY job 
HAVING count(job)>=3;
--사원들의 입사연도(HIRE_YEAR)를 기준으로 부서별로 몇 명이 입사했는지 출력하는 SQL문 작성하시오.
SELECT to_char(hiredate, 'yyyy') AS HIRE_YEAR , deptno, count(*) AS CNT 
FROM emp
GROUP BY to_char(hiredate, 'yyyy'), deptno;

-- 조인 : 여러 테이블을 하나의 테이블 처럼 사용
-- 1) 내부조인 (inner join) : 여러 개의 테이블에서 공통된 부분만 추출
--   1번 등가조인 : 두개의 열이 일치할 때 값 추출
--   2번 비등가조인 : 범위에 해당할 때 값 추출

-- 2) 외부조인(outer join)
--   1번 left outer join
--   2번 outer join
--   3번 full outer join

-- dept : 4 행, emp : 12행 => 4*12= 48god
-- 크로스 조인(나올 수 있는 모든 조합 추출)
SELECT *
FROM emp, dept
ORDER BY empno;



-- inner join
SELECT e.empno, e.ename, d.deptno, d.dname, d.loc
FROM emp e, dept d
WHERE e.deptno = d.deptno;

-- SQL-99 표준
-- join ~ on
SELECT e.empno, e.ename, d.deptno, d.dname, d.loc
FROM emp e JOIN dept d ON e.deptno = d.deptno;




SELECT e.empno, e.ename, d.deptno, d.dname, d.loc
FROM emp e, dept d
WHERE e.deptno = d.deptno AND sal >= 3000;

-- SQL-99 표준
-- join ~ on
SELECT e.empno, e.ename, d.deptno, d.dname, d.loc
FROM emp e JOIN dept d ON e.deptno = d.deptno 
WHERE sal >= 3000;




-- emp, dept inner join, 급여가 2500 이하이고 , 사원번호가 9999 이하인 사원 정보 조회
SELECT e.empno, e.ename, e.sal, d.deptno, d.dname, d.loc
FROM emp e, dept d
WHERE e.deptno = d.deptno AND e.sal <= 2500 AND e.empno <= 9999;

-- SQL-99 표준
-- join ~ on
SELECT e.empno, e.ename, e.sal, d.deptno, d.dname, d.loc
FROM emp e JOIN dept d ON e.deptno = d.deptno
WHERE e.sal <= 2500 AND e.empno <= 9999;




-- emp와 SALGRADE 조인
-- emp 테이블의 sal 이 salgrade 테이블의 losal 과 hisal 범위에 들어가는 형태로 조인
SELECT *
FROM emp e, salgrade s
WHERE e.sal BETWEEN s.losal AND s.hisal;

-- SQL-99 표준
-- join ~ on
SELECT *
FROM emp e JOIN salgrade s on e.sal BETWEEN s.losal AND s.hisal;


-- self join : 자기 자신 테이블과 조인
SELECT e1.empno, e1.ename, e1.mgr, e2.empno AS mgr_empno, e2.ename AS mgr_ename
FROM emp e1, emp e2
WHERE e1.mgr = e2.empno;


-- outer join

-- 1번 left outer join (일때는 오른쪽에(+)넣으면 됨)
SELECT e1.empno, e1.ename, e1.mgr, e2.empno AS mgr_empno, e2.ename AS mgr_ename
FROM emp e1, emp e2
WHERE e1.mgr = e2.empno(+);
-- SQL-99 표준
-- join ~ on
SELECT e1.empno, e1.ename, e1.mgr, e2.empno AS mgr_empno, e2.ename AS mgr_ename
FROM emp e1 LEFT OUTER JOIN emp e2 ON e1.mgr = e2.empno;



-- 1번 right outer join (일때는 왼쪽에(+)넣으면 됨)
SELECT e1.empno, e1.ename, e1.mgr, e2.empno AS mgr_empno, e2.ename AS mgr_ename
FROM emp e1, emp e2
WHERE e1.mgr(+) = e2.empno;
-- SQL-99 표준
-- join ~ on
SELECT e1.empno, e1.ename, e1.mgr, e2.empno AS mgr_empno, e2.ename AS mgr_ename
FROM emp e1 RIGHT OUTER JOIN emp e2 ON e1.mgr = e2.empno;



--오류 : outer-join된 테이블은 1개만 지정할 수 있습니다
--SELECT e1.empno, e1.ename, e1.mgr, e2.empno AS mgr_empno, e2.ename AS mgr_ename
--FROM emp e1, emp e2
--WHERE e1.mgr(+) = e2.empno(+);

-- SQL-99 표준 (위의 오류문)
-- join ~ on
SELECT e1.empno, e1.ename, e1.mgr, e2.empno AS mgr_empno, e2.ename AS mgr_ename
FROM emp e1 FULL OUTER JOIN emp e2 ON e1.mgr = e2.empno;



-- 연결해야 할 테이블이 세개일때 (예시, 실행 안됨 자료없음)
--SELECT *
--FROM table1 t1, table2, table3 t3
--WHERE t1.empno = t2.empno AND t2.deptno = t3.deptno;

-- SQL-99 표준
-- join ~ on
--SELECT *
--FROM table1 t1 JOIN table2 ON t1.empno = t2.empno JOIN table3 t3 ON t2.deptno = t3.deptno;



-- [실습] SQL작성
-- 급여가 2000초과인 사원들의 부서 정보, 사원정보를 아래와 같이 출력하는 SQL문을 작성하시오.
SELECT d.deptno, d.dname, e.empno, e.ename, e.sal
FROM emp e, dept d
WHERE e.deptno = d.deptno AND e.sal>2000;

SELECT d.deptno, d.dname, e.empno, e.ename, e.sal
FROM emp e JOIN dept d ON e.deptno = d.deptno AND e.sal>2000;

-- 각 부서별 평균 급여, 최대급여, 최소급여, 사원수를 출력하는 SQL문을 작성하시오.
SELECT e.deptno, d.dname, floor( avg(sal)) AS avg_sal, max(sal) AS max_sal, min(sal) AS min_sal, count(e.deptno) AS cnt
FROM emp e, dept d
WHERE e.deptno = d.deptno
GROUP BY e.deptno, d.dname;

-- 모든 부서정보와 사원 정보를 아래와 같이 부서번호, 사원이름 순으로 정렬하여 출력하는 SQL문을 작성하시오.
SELECT d.deptno, d.dname, e.empno, e.ename, e.job, e.sal
FROM emp e, dept d
WHERE  d.deptno = e.deptno(+)
ORDER BY d.deptno;

-- 서브쿼리
-- SQL 문을 실행하는 데 필요한 데이터를 추가로 조회하기  위해 SQL 문 내부에서 사용하는 select문
-- 1) 단일행 서브쿼리 2) 다중행 서브쿼리 3) 다중열 서브쿼리

--SELECT 조회할 열
--FROM 티이블명
--WHGERE 조건식(SELECT 조회할 열 FROM 테이블 WHERE 조건식)

-- 존스의 급여보다 높은 급여를 받는 사원 조회
-- JONES 급여 알아내기 / 알아낸 JONES 급여를 가지고 조건식
SELECT sal
FROM emp
WHERE ename = 'JONES'; -- 2975

SELECT sal
FROM emp
WHERE ename = 'JONES';

-- 단일행 서브쿼리 : 서브쿼리의 결과로 하나의 행 반환
-- =, >, <, >=, <>, ^=, != 연산자 허용

 -- 존스의 급여보다 높은 급여를 받는 사원 조회(서브쿼리 사용하기)
SELECT *
FROM emp
WHERE sal > (SELECT sal FROM emp WHERE ename = 'JONES');

-- 사원이름이 ALLEN 인 사원의 추가수당 보다 많은 추가수당을 받는 사원 조회
SELECT *
FROM emp
WHERE comm > (SELECT comm FROM emp WHERE ename = 'ALLEN');

-- 사원이름이 WARD 인 사원의 입사일보다 빨리 입사한 사원조회
SELECT *
FROM emp
WHERE hiredate > (SELECT hiredate FROM emp WHERE ename = 'WARD');

-- 20번 부서에 속한 사원 중 전체 사원의 평균 급여보다 높은 급여를 받는 사원정보 및 부서정보 조회
-- 사원번호, 사원명, 직무, 급여, 부서번호, 부서명, 지역
SELECT e.empno, e.ename, e.job, e.sal, d.deptno, d.dname, d.loc
FROM emp e JOIN dept d ON e.deptno = d.deptno
WHERE e.deptno = 20 AND e.sal >  (SELECT avg(sal) FROM emp);

-- 20번 부서에 속한 사원 중 전체 사원의 평균 급여보다 작거나 같은 급여를 받는 사원정보 및 부서정보 조회
-- 사원번호, 사원명, 직무, 급여, 부서번호, 부서명, 지역
SELECT e.empno, e.ename, e.job, e.sal, d.deptno, d.dname, d.loc
FROM emp e JOIN dept d ON e.deptno = d.deptno
WHERE e.deptno = 20 AND e.sal <=  (SELECT avg(sal) FROM emp);

-- 다중행 서브쿼리 : 서브쿼리 결과로 여러개의 행 반환
-- IN, ANY(SOME), ALL, EXISTS 연산자 허용(단일행 서브쿼리에 쓰는 연산자 사용 불가)

-- 각 부서별 최고 급여와 동일한 급여를 받는 사원정보 조회
-- IN : 메인쿼리 결과가 서브쿼리 결과 중 하나라도 일치하면 TRUE

SELECT *
FROM emp
WHERE sal IN (SELECT max(sal) FROM emp GROUP BY deptno);

-- 30번 부서 사원들의 급여보다 적은 급여를 받는 사원 정보 조회
-- ANY(SOME) : 메인쿼리 결과중 서브쿼리 결과가 하나이상이면 TRUE
SELECT * FROM emp WHERE sal < ANY (SELECT sal FROM emp WHERE deptno = 30);
SELECT * FROM emp WHERE sal < SOME (SELECT sal FROM emp WHERE deptno = 30);

-- 위 결과는 단일행 쿼리로 작성이 가능한 상황임
-- 30번 부서 사원들의 최대 급여보다 적은 급여를 받는 사원 정보 조회
SELECT * FROM emp WHERE sal < (SELECT max(sal) FROM emp WHERE deptno = 30);

-- 30번 부서 사원들의 최소 급여보다 많은 급여를 받는 사원 정보 조회
-- 단일행 서브쿼리
SELECT * FROM emp WHERE sal > (SELECT min(sal) FROM emp WHERE deptno = 30);
-- 다중행 서브쿼리
SELECT * FROM emp WHERE sal > any (SELECT sal FROM emp WHERE deptno = 30);

-- ALL : 서브쿼리 모든 결과가 조건식에 맞아 떨어져야만 메인쿼리 조건식이 TRUE
SELECT * FROM emp WHERE sal < ALL (SELECT sal FROM emp WHERE deptno = 30);

-- EXISTIS :  서브쿼리에 결과값이 하나 이상 존재하면 조건식이 모두 TRUE, 존재하지 않으면 FALSE
SELECT *
FROM emp
WHERE exists (SELECT dname FROM dept WHERE deptno = 10);


-- [실습] SQL작성
-- 전체 사원 중 ALLENRHK 과 같은 직책인 사원들의 사원정보, 부서 정보를 다음과 같이 출력하는ㄷ SQL문을 작성하시오
SELECT e.job, empno, ename, e.sal, d.deptno, d.dname
FROM emp e, dept d
WHERE e.deptno = d.deptno AND e.job = (SELECT job FROM emp WHERE ename = 'ALLEN');

-- 전체 사원의 평균 급여보다 높은 급여를 받는 사원들의 사원정보, 부서정보, 급여 등급 정보를 출력하는 SQL문 작성하시오
--(단, 출력할 때 급여가 많은 순으로 정렬하되, 급여가 같을 경우에는 사원 번호를 기준으로 오름 차순으로 정렬)
SELECT e.empno, e.ename, d.dname, e.hiredate, d.loc, e.sal, s.grade
FROM emp e, dept d, salgrade s
WHERE e.deptno = d.deptno AND e.sal BETWEEN s.losal AND s.hisal AND e.sal > (SELECT avg(sal) FROM emp)
ORDER BY e.sal DESC, e.empno ASC;

-- 다중열 서브쿼리 : 서브쿼리의 select 절에 비교할 데이터를 여러 개 지정
SELECT *
FROM emp
WHERE (deptno, sal) IN (SELECT deptno, max(sal) FROM emp GROUP BY deptno);


-- FROM 절에 사용하는 서브쿼리(인라인 뷰)
-- FROM 절에 직접 테이블을 명시해서 사용하기에는 테이블 내 데이터 규모가 클 때, 불필요한 열이 많을 때
SELECT e10.empno, e10.ename, e10. deptno, d.dname, d.loc
FROM (SELECT * FROM emp WHERE deptno = 10) e10,
     (SELECT * FROM dept) d
WHERE e10.deptno = d.deptno;


-- SELECT 절에 사용하는 서브쿼리(스칼라 서브쿼리)
-- SELECT 절에 사용하는 서브쿼리는 반드시 하나의 결과만 반환해야 함
SELECT empno, ename, job, sal, 
    (SELECT grade FROM salgrade WHERE e.sal BETWEEN losal AND hisal) AS salgrade, 
    deptno,
    (SELECT dname FROM dept WHERE e.deptno = dept.deptno) AS dname
    FROM emp e;
    
--[실습] SQL작성
-- 10번 부서에 근무하는 사원 중 30번 부서에는 존재하지 않는 직책을 가진 사원들의 사원정보, 
-- 부서 정보를 다음과 같이 출력하는 SQL문을 작성하시오.
SELECT e.empno, e.ename, e.job, d.deptno, d.dname, d.loc
FROM emp e, dept d
WHERE e.deptno = d.deptno AND e.job NOT IN (SELECT job FROM emp WHERE deptno = 30) AND e.deptno = 10;

-- 직책이 SALESMAN인 사람들의 최고 급여보다 높은 급여를 받는 사원들의 사원정보, 급여등급 정보를 출력하는
-- SQL문을 작성하시오(단, 서브쿼리를 활용할 때 다중행 함수를 사용하는 방법과 사용하지 않는 방법을
-- 통해 사원번호를 기준으로 오름차순 정렬하여 출력하시오.)
-- 1번 방법
SELECT e.empno, e.ename, e.sal, s.grade
FROM emp e, salgrade s
WHERE e.sal BETWEEN s.losal AND s.hisal AND e.sal > (SELECT max(sal) FROM emp WHERE job = 'SALESMAN')
ORDER BY e.empno;
-- 2번 방법
SELECT e.empno, e.ename, e.sal,
    (SELECT grade FROM salgrade WHERE e.sal BETWEEN losal AND hisal) AS grade
FROM emp e
WHERE e.sal > (SELECT max(sal) FROM emp WHERE job = 'SALESMAN')
ORDER BY e.empno;
-- 3번 방법
SELECT e.empno, e.ename, e.sal,
    (SELECT grade FROM salgrade WHERE e.sal BETWEEN losal AND hisal) AS grade
FROM emp e
WHERE e.sal > ALL (SELECT sal FROM emp WHERE job = 'SALESMAN')
ORDER BY e.empno;





-- DML(Data Manipulation Language) : 데이터 추가(INSERT), 수정(UPDATE), 삭제 (DELETE)하는 데이터 조작어
-- COMMIT :  DML 작업을 데이터베이스에 최종 방영
-- ROLLBACK : DML 작업을 취소
-- select + DML ==>  자주 사용하는 SQL 임

-- 연습용 테이블 생성
-- 기존 테이블 복사
CREATE TABLE dept_temp AS SELECT * FROM dept;

DROP TABLE dept_temp;

-- insert into 테이블이름(열이름1, 열이름2, ...)
-- values(데이터1, 데이터2,...);

-- dept_temp 새로운 부서 추가하기
INSERT INTO dept_temp(deptno, dname, loc)
VALUES(50,'DATABASE','SEOUL');

-- 열 이름 제거할 때
INSERT INTO dept_temp
VALUES(60,'NETWORK','BUSAN');

-- INSERT 시 오류상황

--오류 : 이 열에 대해 지정된 전체 자릿수보다 큰 값이 허용됩니다.
--INSERT INTO dept_temp
--VALUES(600,'NETWORK','BUSAN');

--수치가 부적합합니다
--INSERT INTO dept_temp
--VALUES('NO','NETWORK','BUSAN');

--오류 : 값의 수가 충분하지 않습니다
--INSERT INTO dept_temp(deptno, dname, loc)
--VALUES(70,'DATABASE');

-- NULL 삽입
INSERT INTO dept_temp(deptno, dname, loc)
VALUES(80,'WEB',NULL);

INSERT INTO dept_temp(deptno, dname, loc)
VALUES(90,'MOBILE','');

-- NULL 삽입할 컬럼명을 지정하지 않았음
-- 삽입시 전체 컬럼을 삽입하지 않는다면 필드명 필수
INSERT INTO dept_temp(deptno, loc)
VALUES(91,'INCHEON');


-- emp_temp 생성(emp 테이블 복사 - 데이터는 복사를 하지 않을 때)
-- 구조만 복사 
CREATE TABLE emp_temp AS SELECT * FROM emp WHERE 1 <> 1;

INSERT INTO emp_temp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
VALUES (9999, '홍길동', 'PRESIDENT', NULL, '2001/01/01', 5000, 1000, 10);

INSERT INTO emp_temp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
VALUES (1111, '성춘향', 'MANAGER', 9999, '2002-01-05', 4000, NULL, 20);

--날짜 입력 시 년/월/일 순서 => 일/월/년 삽입
--오류 : 날짜 형식의 지정에 불필요한 데이터가 포함되어 있습니다
--INSERT INTO emp_temp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
--VALUES (2222, '이순신', 'MANAGER', 9999, '07/01/2001', 4000, NULL, 20);

INSERT INTO emp_temp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
VALUES (2222, '이순신', 'MANAGER', 9999, TO_DATE('07/01/2001','DD/MM/YYYY'), 4000, NULL, 20);

INSERT INTO emp_temp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
VALUES (3333, '심봉사', 'MANAGER', 9999, SYSDATE, 4000, NULL, 30);

-- 서브쿼리로 INSERT 구현
-- emp, salgrade 테이블을 조인 후 급여 등급이 1인 사원만 emp_temp에 추가
INSERT INTO emp_temp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
SELECT e.empno, e.ename, e.job, e.mgr, e.hiredate, e.sal, e.comm, e.deptno
FROM emp e, salgrade s
WHERE e.sal BETWEEN s.losal AND s.hisal AND s.grade = 1;

SELECT * FROM emp_temp;

COMMIT;


--UPDATE : 테이블에 있는 데이터 수정

--UPDATE 테이블명
--SET 변경할 열 이름 = 데이터, 변경할열이름 = 데이터....
--WHERE 변경을 위한 대상 행을 선별하기 위한 조건

-- dept_temp loc 열의 모든 값을 seoul 로 변경
UPDATE dept_temp
SET loc = 'SEOUL';

ROLLBACK;

-- 데이터 일부분 수정 : where 사용
-- dept_temp 부서번호가 40번인 loc열의 값을 seoul 로 변경
UPDATE dept_temp
SET loc = 'SEOUL'
WHERE deptno = 40;

-- dept_temp 부서번호가 80번인 dname은 SALES, LOC는 CHICAGO로 변경
UPDATE dept_temp
SET dname='SALES', loc = 'CHICAGO'
WHERE deptno = 80;

SELECT * FROM dept_temp;

-- emp_temp 사원들 중에서 급여가 2500이하인 사원만 추가수당을 50으로 수정
UPDATE emp_temp
SET comm = 50
WHERE sal <= 2500;

-- 서브쿼리를 사용하여 데이터수정
-- dept 테이블의 40번 부서의 dname, loc를 dept_temp 40번 부서의 dname, loc로 업데이트
UPDATE dept_temp
SET (dname, loc)=(SELECT dname, loc 
                    FROM dept 
                    WHERE deptno = 40)
WHERE deptno = 40;

COMMIT;



-- DELETE : 테이블에 있는 데이터 삭제
--DELETE 테이블명
--FROM(선택)
--WHERE 삭제 데이터를 선별하기 위한 조건식

CREATE TABLE emp_temp2 AS SELECT * FROM emp;

-- job이 MANAGER인 사원 삭제
DELETE FROM emp_temp2
WHERE job = 'MANAGER';

DELETE emp_temp2
WHERE job = 'SALESMAN';

-- 전체 데이터 삭제
DELETE emp_temp2;

ROLLBACK;


-- 서브쿼리를 사용하여 삭제
-- 급여등급이 3등급이고, 30번 부서의 사원 삭제
DELETE FROM emp_temp2 WHERE empno IN (SELECT e.empno
                                        FROM emp_temp2 e, salgrade s
                                       WHERE e.sal BETWEEN s.losal AND s.hisal AND s.grade=3 AND e.deptno=30);


SELECT * FROM emp_temp2;

COMMIT;

--[실습] SQL작성
CREATE TABLE EXAM_EMP AS SELECT * FROM emp WHERE 1 != 1;
CREATE TABLE EXAM_DEPT AS SELECT * FROM dept WHERE 1 != 1;
CREATE TABLE EXAM_SALGRADE AS SELECT * FROM salgrade WHERE 1 != 1;


INSERT INTO EXAM_EMP(empno, ename, job, mgr, hiredate, sal, comm, deptno)
VALUES (7201, 'TEST_USER1', 'MANAGER', 7788, '2016/01/02', 4500, NULL, 50);

INSERT INTO EXAM_EMP(empno, ename, job, mgr, hiredate, sal, comm, deptno)
VALUES (7202, 'TEST_USER2', 'CLERK', 7201, '2016/02/21', 1800, NULL, 50);

INSERT INTO EXAM_EMP(empno, ename, job, mgr, hiredate, sal, comm, deptno)
VALUES (7203, 'TEST_USER3', 'ANALYST', 7201, '2016/04/11', 3400, NULL, 60);

INSERT INTO EXAM_EMP(empno, ename, job, mgr, hiredate, sal, comm, deptno)
VALUES (7204, 'TEST_USER4', 'SALESMAN', 7201, '2016/05/31', 2700, 300, 60);

INSERT INTO EXAM_EMP(empno, ename, job, mgr, hiredate, sal, comm, deptno)
VALUES (7205, 'TEST_USER5', 'CLERK', 7201, '2016/07/20', 2600, NULL, 70);

INSERT INTO EXAM_EMP(empno, ename, job, mgr, hiredate, sal, comm, deptno)
VALUES (7206, 'TEST_USER6', 'CLERK', 7201, '2016/09/08', 2600, NULL, 70);

INSERT INTO EXAM_EMP(empno, ename, job, mgr, hiredate, sal, comm, deptno)
VALUES (7207, 'TEST_USER7', 'LECTURER', 7201, '2016/10/28', 2300, NULL, 80);

INSERT INTO EXAM_EMP(empno, ename, job, mgr, hiredate, sal, comm, deptno)
VALUES (7208, 'TEST_USER8', 'STUDENT', 7201, '2018/03/09', 1200, NULL, 80);

SELECT * FROM EXAM_EMP;

-- EXAM_EMP에 속한 사원 중 50번 부서에서 근무하는 사원들의 평균 급여보다 
-- 많은 급여를 받고 있는 사원들을 70번 부서로 옮기는 SQL문 작성하기
UPDATE exam_emp
SET deptno=70
WHERE sal >(SELECT avg(sal) FROM exam_emp WHERE deptno = 50);

-- EXAM_EMP에 속한 사원 중 60번 부서의 사원 중에서 입사일이 가장 빠른 사원보다
-- 늦게 입사한 사원의 급여를 10% 인상하고 80번 부서로 옮기는 SQL 문 작성하기
UPDATE exam_emp
SET sal=sal*1.1, deptno=80
WHERE hiredate > (SELECT min(hiredate) FROM exam_emp WHERE deptno=60);

-- EXAM_EMP에 속한 사원 중, 급여 등급이 5인 사원을 삭제하는 SQL문을 작성하기
DELETE FROM exam_emp
WHERE empno IN (SELECT empno
                FROM exam_emp, salgrade
                WHERE sal BETWEEN losal AND hisal AND grade=5);
                
-- 트랜잭션(transaction) : 최소 수행 단위
-- 트랜잭션 제어하는 구문 TCL(Transaction Control Language) : commit, rollback

CREATE TABLE dept_tcl AS SELECT * FROM dept;

INSERT INTO dept_tcl VALUES(50,'DATABASE','SEOUL');

UPDATE dept_tcl SET loc= 'BUSAN' WHERE deptno=40;

DELETE FROM dept_tcl WHERE dname = 'RESEARCH';



-- 트랜잭션 취소
ROLLBACK;

-- 트랜잭션 최종 반영
COMMIT;

-- 세션 : 어떤 활동을 위한 시간이나 시간
-- 데이터베이스 세션 : 데이터베이스 접속을 시작으로 관련작업 수행한 후 접속 종료
-- LOCK : 잠금(수정 중인 데이터 접근 막기)
DELETE FROM dept_tcl WHERE deptno = 50;

UPDATE dept_tcl SET loc= 'SEOUL' WHERE deptno=30;


SELECT * FROM dept_tcl;


