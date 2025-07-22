-- 오름차순(ASC), 내림차순(DESC)

SELECT
       menu_code
     , menu_name
     , menu_price
   FROM tbl_menu                             -- Troubleshooting From절에 ; 빼기
-- ORDER BY menu_name DESC;
-- ORDER BY menu_name                        -- ASC는 생략 가능(기본 설정)
-- ORDER BY 2 DESC;                          -- SELECT절에 적힌 컬럼 순서를 기반으로
ORDER BY menu_price, menu_name DESC;         -- 앞의 기준에 해당하는 컬럼 값이 같으면 뒤의 기준 적용


SELECT 
       category_code
	  , category_name
	  , ref_category_code
FROM tbl_category                            -- Troubleshooting 절대 주석 달 때 -- 뒤에 띄어쓰기를 꼭 해
ORDER BY 1 DESC;

-- 주문 불가능한 메뉴부터 보기
SELECT *
   FROM tbl_menu;
DESC tbl_menu;                               -- DESC로 컬럼 분석이 용이, DESC = DESCRIBE

SELECT 
       menu_name
     , orderable_status
   FROM tbl_menu
ORDER BY 2 DESC;                             -- Y가 N보다 크므로 내림차순해야 Y부터 봄

SELECT 
       menu_name AS '메뉴명'
     , orderable_status AS '주문가능상태'
   FROM tbl_menu
ORDER BY 주문가능상태;                       -- alias가 인지되고 나서 ORDER BY가 들어가기 때문에 별칭으로도 정렬이 가능하다

-- null값 정렬
SELECT *
   FROM tbl_category
ORDER BY 3;                                  -- null값은 값이 없겠지만 어떤 값으로 취급할까? (0일까 가장 작은 값일까?)

-- null부터 보고싶거나 null을 맨 나중으로 정렬시키고 싶을 때
SELECT *
   FROM tbl_category
ORDER BY -ref_category_code DESC;            -- -를 붙이면 어떻게 되는거야? null이 뒤에 나오는 오름차순이 된다.

SELECT *
   FROM tbl_categorymysqlmysqlmysql
ORDER BY -ref_category_code; 

