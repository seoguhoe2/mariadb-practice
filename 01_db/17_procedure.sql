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

-- ---------------------------------------------------------------------
-- while 활용
delimiter //

CREATE OR REPLACE PROCEDURE calculateSumUpTo (
    IN max_num INT,
    OUT sum_result INT
)
BEGIN
    DECLARE current_num INT DEFAULT 1;
    DECLARE total_sum INT DEFAULT 0;
    
    while current_num <= max_num DO
        SET total_sum = total_sum + current_num;             -- total_sum = current_num 했더니 무한 로딩이네.
        SET current_num = current_num + 1;                   -- =이 같다가 아니라 공간에 담는거니까 무한 로딩?
    END while;
    
    SET sum_result = total_sum;
END //

delimiter ;

SET @result = 0;
CALL calculateSumUpTo(10, @result);
SELECT @result;

-- -----------------------------------------------------------
-- 예외 처리
delimiter //

CREATE OR REPLACE PROCEDURE divideNumbers (
    IN numberator DOUBLE,
    IN denominator DOUBLE,
    OUT result DOUBLE
)
BEGIN
    DECLARE division_by_zero CONDITION FOR SQLSTATE '45000';
    DECLARE exit handler FOR division_by_zero
    begin
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '0으로 나눌 수 없습니다.'
    END;
    
    if denominator = 0 then
        SIGNAL division_by_zero;
    ELSE
        SET result = numberator / denominator;
    END if;
END //

delimiter ;                                               -- 왜 오류나지?

SET @result = 0;
CALL divideNumbers(10, 2, @result);
SELECT @result;
CALL divideNumbers(10, 0, @result);
SELECT @result;

-- -----------------------------------------------------------------------------------
-- stored function 반환형이 존재하는 진짜 함수 기능
delimiter //

CREATE OR REPLACE FUNCTION getAnnualSalary (
    id VARCHAR(3)
)
RETURNS INTEGER
DETERMINISTIC
BEGIN
    DECLARE before_bonus INTEGER;
    DECLARE monthly_salary INTEGER;
    DECLARE annual_salary INTEGER;
    DECLARE bonus DOUBLE;
    
    SELECT salary INTO before_bonus               -- 보너스를 고려한 monthly_salary를 만들 수 있나?
      FROM employee
     WHERE emp_id = id;
     
    SELECT IFNULL(bonus, 0) INTO bonus
      FROM employee
     WHERE emp_id = id;
     
    SET monthly_salary = before_bonus + before_bonus * bonus;
   
    SET annual_salary = monthly_salary * 12;
    
    RETURN annual_salary;

END //

delimiter ;

SELECT
       emp_name
     , getAnnualSalary(emp_id) AS '연봉'
  FROM employee;

SELECT * FROM employee;
