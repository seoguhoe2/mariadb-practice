-- Type casting
-- 명시적 형변환

-- 1) 숫자 -> 숫자
SELECT 
       AVG(menu_price)
     , CAST(AVG(menu_price) AS UNSIGNED INTEGER) AS '가격 평균'
     , CONVERT(AVG(menu_price), DOUBLE) AS '가격 평균2'
  FROM tbl_menu
 GROUP BY category_code;
 
DESC tbl_menu;

-- 2) 문자 -> 날짜
SELECT CAST('2025%07%23' AS DATE);             -- %같은 구문자도 알아서 바꿔주네?
SELECT CAST('2025*07#23' AS DATE);             -- 오 이것도 바꾸네...

-- 3) 숫자 -> 문자
SELECT CAST(1000 AS CHAR);                     -- 1000 -> '1000' 으로 문자열 변환이 수행됨

SELECT CONCAT(CAST(1000 AS CHAR), '원');       -- '1000' + '원'
SELECT CONCAT(1000, '원');                     -- CONCAT에 1000이 '1000'이 되야함을 컴파일러가 알고 암시적으로 형변환 해줌

-- 암시적 형변환
SELECT
       *
  FROM employee
 WHERE emp_id = 200;                           -- 200 -> '200'
 
DESC employee;                                 -- EMP_ID의 TYPE은 varchar(3)이나 emp_id의 200을 형변환해준 것

SELECT 1 + '2';                                -- '2' -> 2로 바꿔서 연산을 수행

SELECT 5 > '반가워';                           -- true -> 1, false -> 0    5가 '반가워'보다 크다는 True다?
                                               -- '반가워' 문자열을 숫자로 바꿀 땐 0으로 받아들이도록 MariaDB는 설정해놨다.



