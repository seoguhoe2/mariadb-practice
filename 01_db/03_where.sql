-- where 절
-- 테이블에 들어있는 row마다 조건을 확인하는 절

-- 주문 가능한 메뉴만 조회(메뉴명만 조회)
SELECT * FROM tbl_menu;

SELECT
      *
   FROM tbl_menu                                   -- 해석 순서는 From 절 다음
WHERE orderable_status = 'Y'                       -- 조건이 True면 통과
ORDER BY 3 DESC;

SELECT
      *
   FROM tbl_menu                                   
WHERE orderable_status <> 'Y'                      -- 일부 SQL 언어에선 <>도 !=와 같이 쓸 수 있다
   && menu_price <= 15000;                         -- &&도 작용하는 걸 보니 연산자 관련 학습을 하면 다양하게 쓸 수 있을듯


-- Q) 기타 카테고리 해당 안되는 메뉴 조회

SELECT * FROM tbl_category;
SELECT * FROM tbl_menu;

SELECT
       *
   FROM tbl_menu
WHERE category_code != 10;

-- 서브 쿼리를 배우게 되면 1개의 쿼리로 문제를 해결할 수 있다.

SELECT
       *
   FROM tbl_menu
 WHERE category_code = (
                        SELECT category_code
                          FROM tbl_category
                         WHERE category_name = '기타'
                        ); 

-- AND, OR와 같은 논리연산자

-- 5000원 이상 7000원 미만인 메뉴 조회

SELECT * FROM tbl_menu;

-- SELECT
--        menu_price AS '가격'  
--      , menu_name AS '메뉴'
--   FROM tbl_menu                                     -- 여기까지는 table에 가격과 메뉴로 뽑아오는데
--  WHERE '가격' >= 5000;                             -- 여기서부터 못 읽네 이유가 뭘까?  
--    AND '가격' < 7000;                               -- TROUBLESHOOTING FROM 문 이후로 WHERE 문이 해석되는 순서인데 이 때 alias 되기 전이므로 WHERE문이 '가격' 항목을 찾지 못해 제대로 기능하지 않게 된다. 
--    
SELECT
       *
  FROM tbl_menu
 WHERE menu_price >= 5000  
   AND menu_price < 7000;
   
-- BETWEEN 연산자 활용

DESC tbl_menu;

SELECT 
       menu_code
     , menu_name
     , menu_price
     , category_code
     , orderable_status
  FROM tbl_menu
--  WHERE menu_price >= 5000
--    AND menu_price <= 9000;                      -- AND 이면서 이상/이하만 쓰일 경우 BETWEEN 사용 가능
--  WHERE menu_price BETWEEN 5000 AND 9000;

-- 만약 반대 결과를 얻고 싶다면 NOT을 붙이면 된다
 WHERE menu_price NOT BETWEEN 5000 AND 9000;
 
-- ---------------------------------------
-- Like문
-- 주로 검색할 때 사용
SELECT 
       *
  FROM tbl_menu
 WHERE menu_name LIKE '%밥%';                      -- %와일드카드를 써서 Like문 작성
--  WHERE menu_name LIKE '밥%';                    -- 밥으로 시작하는 메뉴만 검색
--  WHERE menu_name LIKE '%밥';                    -- 밥으로 끝나는 메뉴만 검색

-- IN 연산자
-- 카테고리가 '중식', '커피', '기타'인 메뉴 조회하기
SELECT
       *
  FROM tbl_menu
--  WHERE category_code = 5
--     OR category_code = 8
-- 	 OR category_code = 10
 WHERE category_code IN (5, 8, 10);
 
 -- Is null 연산자 사용
 SELECT
       *
 
   FROM tbl_category;

SELECT
       *
  FROM tbl_category
 WHERE ref_category_code IS NULL;