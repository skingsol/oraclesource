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



-- join
-- 자신의 담당 매니저의 고용일보다 빠른 입사자 찾기(self join - employees)
-- hire_date,last_name, manager_id 조회
SELECT e1.hire_date, e1.last_name, e1.manager_id  
FROM employees e1, employees e2
WHERE e1.manager_id = e2.employee_id AND e1.hire_date < e2.hire_date; 

-- 도시 이름이 T로 시작하는 지역에 사는 사원들의 사번, last_name, 부서번호, 도시 조회
-- employees, departments, locations inner join
SELECT e.employee_id, e.last_name, e.department_id, l.city
FROM employees e, departments d, locations l
WHERE e.department_id = d.department_id AND d.location_id = l.location_id AND l.city  LIKE  'T%';

SELECT e.employee_id, e.last_name, e.department_id, l.city
FROM employees e
INNER JOIN departments d  ON e.department_id = d.department_id
INNER JOIN locations l  ON d.location_id = l.location_id
WHERE l.city LIKE 'T%';

-- 위치 id가 1700인 사원들의 사번, last_name, 부서번호, 급여 조회
-- employees, departments inner join
SELECT e.employee_id, e.last_name, d.department_id, e.salary
FROM employees e, departments d
WHERE e.department_id = d.department_id AND d.location_id = 1700;

-- 부서명, 위치id, 각 부서별 사원 총 수, 각 부서별 평균 연봉 조회
-- 평균 연봉은 소수점 2자리까지만
-- employees, departments inner join
SELECT d.department_name, d.location_id, count(e.employee_id), round(avg(e.salary),2)
FROM employees e, departments d
WHERE e.department_id = d.department_id
GROUP BY d.department_name, d.location_id;

-- Executive 부서에 근무하는 사원들의 부서번호, last_name, job_id 조회
-- employees, departments inner join
SELECT d.department_id, e.last_name, e.job_id
FROM employees e, departments d
WHERE e.department_id = d.department_id AND d.department_name = 'Executive';

-- 각 사원별 소속부서에서 자신보다 늦게 고용되었으나 보다 많은 연봉을 받는 사원이 존재하는 모든 사원들의 
-- 부서번호, 이름(frist_name과 last_name 연결하기), salary, hire_date 조회
-- employees self join
SELECT DISTINCT e1.department_id, e1.first_name||' '||e1.last_name AS name, e1.salary, e1.hire_date  
FROM employees e1, employees e2
WHERE e1.department_id = e2.department_id AND e1.hire_date < e2.hire_date AND e1.salary < e2.salary; 


-- 서브쿼리
-- LAST_NAME 에 u가 포함된 사원들과 동일 부서에 근무하는 사원들의 사번, last_name 조회
SELECT department_id, last_name
FROM employees
WHERE department_id IN (SELECT department_id FROM employees WHERE last_name LIKE '%u%');

-- job_id 가 SA_MAN 인 사원들의 최대 연봉보다 높게 받는 사원들의 last_name, job_id, salary 조회
SELECT last_name, job_id, salary
FROM employees
WHERE salary > (SELECT MAX(salary) FROM employees WHERE job_id = 'SA_MAN');


-- 커미션을 버는 사원들의 부서와 연봉이 동일한 사원들의 last_name, department_id, salary 조회
SELECT last_name, department_id, salary
FROM employees
WHERE (department_id, salary) IN (SELECT department_id, salary FROM employees WHERE commission_pct>0);

-- 회사 전체 평균 연봉보다 더 받는 사원들 중 last_name에 u가 있는 사원들의 근무하는 부서에서 
-- 근무하는 사원들의 employee_id, last_name, salary 조회
SELECT employee_id, last_name,salary
FROM (SELECT DISTINCT department_id 
         FROM employees 
         WHERE salary 
    >(SELECT ROUND(AVG(SALARY),0) FROM employees) AND last_name like '%u%') dept, employees e
WHERE e.department_id = dept.department_id
ORDER BY employee_id;

-- last_name이 DAVIES 인 사람보다 나중에 고용된 사원들의 last_name, hire_date 조회
SELECT last_name, hire_date 
FROM employees 
WHERE hire_date >
(SELECT hire_date FROM employees WHERE last_name = 'Davies')
ORDER BY hire_date;

-- last_name이 King 인 사원을 매니저로 두고 있는 모든 사원들의 last_name, salary 조회
SELECT last_name, salary 
FROM employees
WHERE manager_id IN
    (SELECT employee_id FROM employees WHERE last_name='King');