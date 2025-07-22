-- subqueries

-- '민트 미역국'과 같은 카테고리의 메뉴를 조회
-- 쿼리를 2번 이상 실행해야 할 것 같다 -> Subqueries 사용을 해야겠다.
SELECT 
       category_code
     , menu_name
  FROM tbl_menu
 WHERE menu_name = '민트미역국';        -- 민트미역국의 카테고리 코드 알아내기
                                        -- 선행돼서 실행해야하는 쿼리 = 서브쿼리

SELECT
       menu_name
  FROM tbl_menu
 WHERE category_code = 4;
 
--  이 둘을 하나의 쿼리로 바꿔보자
SELECT
       menu_name
  FROM tbl_menu
 WHERE category_code = (SELECT category_code
                          FROM tbl_menu
                         WHERE menu_name = '민트미역국'
                       )
	AND menu_name != '민트미역국';
	
SELECT * FROM tbl_menu;
SELECT * FROM tbl_category;
	
--  상관 서브쿼리
-- 메뉴별 각 메뉴가 속한 카테고리의 평균보다 높은 가격의 메뉴

-- 1) 카테고리가 10번인 경우 해당 카테고리에 속한 메뉴들의 평균
SELECT
       AVG(menu_price)
  FROM tbl_menu
 WHERE category_code = 10;

-- 2) 메뉴별 카테고리를 보고 위의 서브쿼리를 활용한 상관 서브쿼리 작성
SELECT
       a.menu_code
     , a.menu_name
     , a.menu_price
     , a.category_code
     , a.orderable_status
  FROM tbl_menu a
 WHERE a.menu_price > (SELECT AVG(b.menu_price)
                         FROM tbl_menu b
                        WHERE b.category_code = a.category_code
                      );

-- --------------------------------------------
-- exists
-- 메뉴로 할당된 카테고리를 조회
SELECT
       a.category_name
  FROM tbl_category a
 WHERE EXISTS (SELECT b.menu_code
                 FROM tbl_menu b
					 WHERE b.category_code = a.category_code
				  );
