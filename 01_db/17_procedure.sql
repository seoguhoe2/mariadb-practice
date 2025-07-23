-- procedure
-- 쿼리를 나열한 절차를 저장해서 쓰는 것
-- 기능을 정의한 것
-- 반환형이 없는 함수를 만드는 것

delimiter //                                  -- delimiter 시작 후 앞으론 문장(한 프로시저)의 끝을 //로 정의하겠다 라는 의미.
CREATE OR REPLACE PROCEDURE getAllEmployees() -- getAllEmployees()라는 함수 정의하겠다
BEGIN
    SELECT emp_id, emp_name, salary
      FROM employee;
END //

delimiter ;                                   -- delimiter 시작 후 앞으론 문장의 끝을 ;로 다시 정의하겠다 라는 의미.

CALL getAllEmployees();

-- ---------------------------------------------
-- IN 매개변수
delimiter //

CREATE OR REPLACE PROCEDURE getEmployeesByDepartment(
    IN dept CHAR(2)
)
BEGIN
    SELECT emp_id, emp_name, salary, dept_code
      FROM employee
    WHERE dept_code = dept;

END //

delimiter ;

CALL getEmployeesByDepartment('D5');          -- 변수 자료형에 항상 주의하자
CALL getEmployeesByDepartment('D2');

-- -------------------------------------------------
-- out 매개변수
delimiter //
CREATE OR REPLACE PROCEDURE getEmployeeSalary(
    IN id VARCHAR(3),
    OUT sal2 INTEGER                          -- 여기서 out에 integer가 들어간건 반환형이 아닌건가?
)
BEGIN
    SELECT salary INTO sal2
      FROM employee
    WHERE emp_id = id;
END //

delimiter ;

SET @sal1 = 0;
CALL getEmployeeSalary('210', @sal1);
SELECT @sal1;

-- ----------------------------------------------------
-- inout 매개변수
delimiter //

CREATE OR REPLACE PROCEDURE updateAndReturnSalary(
    IN id VARCHAR(3),
    INOUT sal INTEGER
)
BEGIN
    UPDATE employee
       SET salary = sal
     WHERE emp_id = id;
     
    SELECT salary + (salary * IFNULL(bonus, 0)) INTO sal
      FROM employee
     WHERE emp_id = id;
END //

delimiter ;

SET @new_sal = 9000000;
CALL updateAndReturnSalary('200', @new_sal);
SELECT @new_sal;

-- @변수의 의미
-- '사용자 정의형 변수', '이름이 있는 저장 공간'
-- 전역변수의 의미를 가짐

-- ----------------------------------------------------------------
-- if-else 활용
delimiter //

CREATE OR REPLACE PROCEDURE checkEmployeeSalary(
    IN id VARCHAR(3),
    IN threshold INTEGER,
    OUT result VARCHAR(50)
)
BEGIN
    DECLARE sal INTEGER;
    
    SELECT salary INTO sal
      FROM employee
     WHERE emp_id = id;
   
    if sal > threshold then
        SET result = '기준치를 넘는 급여입니다.';
    else
        SET result = '기준치와 같거나 기준치 미만의 급여입니다.';        -- 여기 세미콜론 해야하는거 주의
    END if;
END //

delimiter ;

SET @result = '';
CALL checkEmployeeSalary('200', 3000000, @result);
SELECT @result;

-- ----------------------------------------------------------------------
-- case
delimiter //

CREATE OR REPLACE PROCEDURE getDepartmentMessage(
    IN id VARCHAR(3),
    OUT message VARCHAR(100)
)
BEGIN
    DECLARE dept VARCHAR(50);
    
    SELECT dept_code INTO dept
      FROM employee
     WHERE emp_id = id;
     
    case
        when dept = 'D1' then
            SET message = '인사관리부 직원이시군요!';
        when dept = 'D2' then
            SET message = '회계관리부 직원이시군요!';
        when dept = 'D3' then
            SET message = '마케팅부 직원이시군요!';
        ELSE
            SET message = '어떤 부서 직원이신지 모르겠어요!';
    END case;
END //

delimiter ;

SET @message = '';
SET @result = '';
CALL getDepartmentMessage('211', @result);         -- @message는 왜 들어가는건가? OUT에 들어가는 걸 설정해주는건가?
SELECT @result;                                    -- 맞는 것 같다. 이렇게 하면 result에 결과값이 들어가네.
