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
    OUT sal2 INTEGER
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

