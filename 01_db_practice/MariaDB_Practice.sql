DESC employee;
SELECT * FROM employee;
SELECT * FROM department;
SELECT * FROM job;
SELECT * FROM location;
SELECT * FROM national;
SELECT * FROM sal_grade;

-- 1) 모든 사원 모든 컬럼 조회
SELECT
       EMP_ID
     , EMP_NAME
     , EMP_NO
     , EMAIL
     , PHONE
     , DEPT_CODE
     , JOB_CODE
     , SAL_LEVEL
     , SALARY
     , BONUS
     , MANAGER_ID
     , HIRE_DATE
     , ENT_DATE
     , ENT_YN
  FROM employee;
  
-- 2) 사원들의 사번(사원번호), 이름 조회
SELECT
       EMP_NO AS '사번(사원번호)'
     , EMP_NAME AS '이름'
  FROM employee;
  
-- 3) 201번 사번의 사번 및 이름 조회
SELECT
       EMP_NO AS '사번(사원번호)'
     , EMP_NAME AS '이름'
  FROM employee
 WHERE EMP_ID = 201;
 
-- 4) employee 테이블에서 부서 코드가 'D9'인 사원 조회
SELECT
       EMP_ID
     , EMP_NAME
     , EMP_NO
     , EMAIL
     , PHONE
     , DEPT_CODE
     , JOB_CODE
     , SAL_LEVEL
     , SALARY
     , BONUS
     , MANAGER_ID
     , HIRE_DATE
     , ENT_DATE
     , ENT_YN
  FROM employee
 WHERE DEPT_CODE = 'D9';
 
-- 5) employee 테이블에서 직급 코드가 'J1'인 사원 조회
SELECT
       EMP_ID
     , EMP_NAME
     , EMP_NO
     , EMAIL
     , PHONE
     , DEPT_CODE
     , JOB_CODE
     , SAL_LEVEL
     , SALARY
     , BONUS
     , MANAGER_ID
     , HIRE_DATE
     , ENT_DATE
     , ENT_YN
  FROM employee
 WHERE JOB_CODE = 'J1';
 
-- 6) employee 테이블에서 급여가 300만원 이상인 사원의 사번, 이름, 부서코드, 급여를 조회
SELECT
       EMP_NO AS '사번'
     , EMP_NAME AS '이름'
     , DEPT_CODE AS '부서코드'
     , SALARY AS '급여'
  FROM employee
 WHERE SALARY >= 3000000; -- 전에 얘기했듯이 해석 순서에 따라 FROM - WHERE - SELECT 이므로 WHERE에 SELECT 단계에서 실행한 alias 명칭을 써도 제대로 읽을 수 없다.
 
-- 7) 부서코드가 'D6'이고 급여를 300만원보다 많이 받는 직원의 이름, 부서코드, 급여 조회
SELECT
       EMP_NAME AS '이름'
     , DEPT_CODE AS '부서코드'
     , SALARY AS '급여'
  FROM employee
WHERE DEPT_CODE = 'D6' AND SALARY >= 3000000;   -- BETWEEN 어떤 때, 어떻게 사용하는거였는지

-- 8) 보너스를 받지 않는 사원에 대한 사번, 직원명, 급여, 보너스를 조회
SELECT
       EMP_NO
     , EMP_NAME
     , SALARY
     , BONUS
  FROM employee
 WHERE BONUS IS NULL;   -- IS NULL 로 NULL인지 판단해야한다. WHERE BONUS NULL (X)
 
-- 9) 'D9' 부서에서 근무하지 않는 사원의 사번, 이름, 부서코드를 조회
SELECT
       EMP_NO
     , EMP_NAME
     , DEPT_CODE
  FROM employee
 WHERE DEPT_CODE != 'D9'
 ORDER BY 3;
 
-- 10) employee 테이블에서 퇴사 여부가 N인 사원들 조회하고 사번, 이름, 입사일을 별칭으로 설정해 조회하기
SELECT
       EMP_NO AS '사번'
     , EMP_NAME AS '이름'
     , HIRE_DATE AS '입사일'
  FROM employee
 WHERE ENT_YN = 'N'
 ORDER BY EMP_ID;
 
-- 11) employee 테이블에서 급여 350만원 이상 500만원 이하 받는 직원의 사번, 이름, 급여, 부서코드, 직급코드를 별칭으로 설정하여 조회
SELECT
       EMP_NO AS '사번'
     , EMP_NAME AS '이름'
     , SALARY AS '급여'
     , DEPT_CODE AS '부서코드'
     , JOB_CODE AS '직급코드'
  FROM employee
 WHERE SALARY >= 3500000 AND SALARY <= 5000000
 ORDER BY SALARY;
 
-- 12) employee 테이블에서 성이 김씨인 직원의 사번, 이름, 입사일 조회
SELECT
       EMP_NO
     , EMP_NAME
     , HIRE_DATE
  FROM employee
 WHERE EMP_NAME = 김%;
