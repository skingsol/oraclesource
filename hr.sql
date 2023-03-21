-- employee 테이블 전체 내용 조회
SELECT * FROM employees;

-- employee 테이블 first_name, last_name, job_id 만 조회
SELECT first_name, last_name, job_id FROM employees;

-- 사원번호가 176인 사람의 LAST_NAME 조회
SELECT last_name FROM employees WHERE employee_id=176;

-- 연봉이 12000 이상 되는 직원들의 LAST_NAME, SALARY 조회
SELECT last_name, salary FROM employees WHERE salary>=12000;

-- 연봉이 5000 에서 12000 범위가 아닌 사람들의 LAST_NAME, SALARY 조회
SELECT last_name, salary FROM employees WHERE salary<5000 or salary>12000 ORDER BY last_name DESC;


-- 20, 50 번 부서에서 근무하는 모든 사원들의 LAST_NAME, 부서번호를 오름차순으로 조회
SELECT last_name, department_id
FROM employees WHERE department_id IN('20', '50') ORDER BY last_name, department_id;

-- 커미션을 받는 모든 사원들의 LAST_NANE, 연봉, 커미션 조회(연봉의 내림차순, 커미션 내림차순)
SELECT last_name, salary, commission_pct 
FROM employees WHERE commission_pct > 0 ORDER BY salary DESC, commission_pct DESC;

-- 연봉이 2500, 3500, 7000이 아니며 직업이 SA_REP 나 ST_CLERK 인 사원 조회
SELECT * FROM employees WHERE salary NOT IN (2500, 3500, 7000) AND job_id IN('SA_REP', 'ST_CLERK');

-- 2008/02/20 ~ 2008/05/01 사이에 고용된 사원들의 last_name, 사번, 고용일자 조회
-- 고용일자 내림차순 정렬
-- 날짜 표현시 홀따옴표 안에 표현 - OR / 사용 가능
SELECT last_name, employee_id, hire_date 
FROM employees WHERE hire_date >= '2008-02-20' AND hire_date <= '2008-05-01' ORDER BY hire_date DESC;

SELECT last_name, employee_id, hire_date 
FROM employees WHERE hire_date BETWEEN '2008-02-20' AND '2008-05-01' ORDER BY hire_date DESC;

-- 2004년도에 고용된 사원들의 last_name, hire_date 조회
-- 고용일자 오름차순 정렬
SELECT last_name, hire_date 
FROM employees WHERE hire_date >= '2004-01-01' AND hire_date <= '2004-12-31' ORDER BY hire_date;

-- 부서가 20,50이고 연봉이 5000 에서 12000 범위인 사람들의 LAST_NAME, SALARY 조회
-- 연봉 오름차순 정렬
SELECT last_name, salary FROM employees WHERE department_id IN(20,50) AND salary BETWEEN 5000 AND 12000 ORDER BY salary;

--LAST_NAME 에 u가 포함된 사원들의 사번, last_number 조회
SELECT employee_id, last_name FROM employees WHERE last_name LIKE '%u%';

--LAST_NAME 에 네번째 글자가 a인 사원들의 last_name 조회
SELECT last_name FROM employees WHERE last_name LIKE '___a%';

--LAST_NAME 에 a혹은 e 글자가 포함된 사원들의 last_name 조회
--last_name 오름차순 정렬
SELECT last_name FROM employees WHERE last_name LIKE '%a%' OR last_name LIKE '%e%' ORDER BY last_name;

--LAST_NAME 에 a와 e 글자가 포함된 사원들의 last_name 조회
--last_name 오름차순 정렬
SELECT last_name FROM employees WHERE last_name LIKE '%a%e%' OR last_name LIKE '%e%a%' ORDER BY last_name;

-- 매니저(manager_id)가 없는 사람을의 last_name, job_id 조회
SELECT last_name, job_id FROM employees WHERE manager_id IS null OR manager_id = '';

-- job_id가 ST_CLERK 인 사원 조회( 단 부서번호가 NULL인 사원은 제외한다.)
-- 중복을 제거한 후 부서번호만 조회
SELECT DISTINCT department_id 
FROM employees WHERE job_id = 'ST_CLERK' AND department_id IS NOT null;

-- commission_pct가 null이 아닌 사원들 중에서 commission = salary * commission_pct 를 구하여
-- employee_id, first_name, job_id 출력
SELECT DISTINCT department_id , first_name, job_id, salary * commission_pct AS commission
FROM employees WHERE commission_pct IS NOT null;

-- first_name 이 Curtis 인 사람의 first_name, last_name, email, phone_number, job_id 를 조회한다.
-- 단 , job_id 의 결과는 소문자로 출력되도록 한다.
SELECT first_name, last_name, email, phone_number, LOWER (job_id)
FROM employees
WHERE first_name = 'Curtis';

-- 부서번호가 60,70,80,90 인 사원들의 employee_id, first_name, hire_date, job_id 조회
-- 단, job_id가 IT_PROG 인 사원의 경우 프로그래머로 변경한 후 출력 
SELECT employee_id, first_name, hire_date, REPLACE (job_id,'IT_PROG','프로그래머')
FROM employees
WHERE department_id IN(60,70,80,90);

-- job_id 가 ad_pres, pu_clerk 인 사원들의 employee_id, first_name, last_name, department_id, job_id를 조회한다.
-- 단 사원명은 first_name과 last_name을 연결하여 출력하시오
SELECT employee_id, CONCAT (first_name,CONCAT(' ',last_name)), department_id, job_id
FROM employees
WHERE job_id IN ('AD_PRES', 'PU_CLERK');
-- 위와 같은 표현 || 사용하여 공백만들기
SELECT employee_id, first_name||' '||last_name, department_id, job_id
FROM employees
WHERE job_id IN ('AD_PRES', 'PU_CLERK');


--[실습] sql 작성
--부서 80의 각 사원에 대해 적용 가능한 세율을 표시하시오.
SELECT last_name, salary, decode(trunc(salary / 2000, 0),
                                0,
                                0.00,
                                1,
                                0.09,
                                2,
                                0.20,
                                3,
                                0.30,
                                4,
                                0.40,
                                5,
                                0.42,
                                6,
                                0.44,
                                0.45) AS tax_rate
FROM employees
WHERE department_id = 80;


-- 회사 내의 최대 연봉 및 최소 연봉의 차이를 출력
SELECT max(salary)-min(salary)
FROM employees;

-- 매니저로 근무하는 사원들의 총 숫자 출력(매니저 중복 제거)
SELECT count (DISTINCT manager_Id)
FROM employees;




