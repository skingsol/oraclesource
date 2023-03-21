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
-- 입사 45년미만인 사원 데이터 조회
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

-- GROUP BY 표현식이 아닙니다.
-- SELECT avg(sal),deptno,ename FROM emp GROUP BY deptno;

-- GROUP BY + HAVING : group by 절에 조건을 줄 때
-- HAVING : 그룹화된 대상을 출력 제한 걸때

-- 각 부서의 직책별 평균 급여 구하기(단, 평균 급여가 2000이상인 그룹만 출력하기)
-- deptno, job 평균
SELECT deptno, job, avg(sal)
FROM emp
GROUP BY deptno, job HAVING avg(sal) >=2000
ORDER BY deptno, job;

--그룹 함수는 허가되지 않습니다 ( 그룹함수는 WHERE절에 넣을 수 없다.)
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




