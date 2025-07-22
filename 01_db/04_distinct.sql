-- Distinct
-- 메뉴가 할당된 카테고리를 조회하기
SELECT * FROM tbl_menu;
SELECT * FROM tbl_category;

-- 카테고리가 할당돼있는 메뉴들을 확인하고 할당 안 된 category code를 찾는거구나
-- Distinct를 통해 중복을 제거하고 종류가 뭐가 있는지 알아보자

SELECT
       distinct category_code
  FROM tbl_menu;
  
SELECT
       category_name
  FROM tbl_category                                            -- TRSH 항상 어떤 테이블을 이용하고 있는지 꼭 확인하자.
 WHERE category_code IN( 4, 5, 6, 8, 9, 10, 11, 12);
 
-- Distinct를 사용할 땐 일반적으론 추출할 1개의 Column 에서만 적용하는게 낫다.
-- Column이 2개 이상인 열을 다중열 이라고 하는데, 다중열 Distinct에 대해 알아보자.

SELECT
       distinct 
		 category_code
     , orderable_status
  FROM tbl_menu;