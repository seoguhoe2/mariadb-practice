-- group by절
-- From 또는 Where 절 통과 이후 그룹핑을 묶고자 할 때 사용하는 절

SELECT
       DISTINCT category_code
  FROM tbl_menu;

SELECT
       category_code
     , COUNT(*)
--      , menu_name        -- 결과는 나오는데 잘못된 결과가 나옴. 유의해야함
  FROM tbl_menu
 GROUP BY category_code;
 
-- COUNT(컬럼명 또는 *) 로 사용
-- 1) *일 경우:  결과로 나온 모든 행의 갯수를 카운팅
-- 2) 컬럼명일 경우: 해당 컬럼 내 값이 있는 경우만 카운팅

-- AVG 함수

SELECT 
       category_code
     , FLOOR(AVG(menu_price))
  FROM tbl_menu
 GROUP BY category_code;

-- having 절
-- group에 대한 조건을 작성하는 절

SELECT
       SUM(menu_price)
     , category_code
  FROM tbl_menu
 GROUP BY category_code
-- HAVING SUM(menu_price) >= 20000;
HAVING category_code BETWEEN 5 AND 9;

-- 6가지 절을 모두 확인
SELECT                          -- 5
       category_code
     , AVG(menu_price)
  FROM tbl_menu                 -- 1
 WHERE menu_price >= 15000      -- 2
 GROUP BY category_code         -- 3
HAVING AVG(menu_price) > 12000  -- 4
 ORDER BY 1 DESC;               -- 6 해석 순서
 
--  rollup

SELECT
       SUM(menu_price) AS '합계'
     , category_code AS '코드명'
  FROM tbl_menu
 GROUP BY category_code
  WITH ROLLUP;
  
-- 두 개 이상의 컬럼으로도 그룹을 나눌 수 있고, rollup도 할 수 있다.
SELECT
       SUM(menu_price)
     , menu_price
     , category_code
  FROM tbl_menu
 GROUP BY menu_price, category_code
  WITH ROLLUP;
  
