-- 주석은 ctrl + /

SELECT * FROM tbl_menu;   -- 메뉴 조회   
SELECT * FROM tbl_category;

SELECT category_code, category_name FROM tbl_category;
SELECT category_name, category_code FROM tbl_category;

-- *(asterisk) 쓰면 감리사한테 혼난다

SELECT
       category_code
     ,  category_name                      --코딩 컨벤션에 따라 콤마는 다음 줄에 작성
     ,  category_code 
  FROM tbl_category;
  
-- --------------------------------
-- from절 없는 select 해보기
SELECT 7+3;
SELECT 10*2;
SELECT 6%3, 6%4;                           -- mod, modulus: 나누고 나머지를 구하는
SELECT NOW();
SELECT CONCAT('유', ' ', '관순');

-- 문자 -> 아스키 코드(영어,숫자,특수기호), 유니코드(영어,숫자,특수기호,그외) 기반

SELECT * FROM tbl_menu;
SELECT 
      CONCAT(menu_price, '원') 
	FROM tbl_menu;
	
-- 별칭(alias)
SELECT 7+3;
SELECT 7+3 AS '합';                        -- 가독성을 위해 AS 와 '를 붙여 표기
SELECT 7+3 '합';
SELECT 7+3 합;

-- alias에 띄어쓰기를 포함한 특수기호가 존재하면 ' 생략 불가
SELECT 7+1 '합 계';
-- SELECT 7+1 합 계; -- 에러 발생

SELECT
      menu_name AS '메뉴명'
     ,CONCAT(menu_price, '원') AS '메뉴가격'
  FROM tbl_menu;