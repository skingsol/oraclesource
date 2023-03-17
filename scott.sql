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