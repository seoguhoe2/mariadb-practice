-- JOIN
-- 관계를 맺은 2개 이상의 테이블을 한번에 조회하고 싶을 때
-- 노란색 Key와 초록색 Key가 관계가 있는지 확인하면 된다

SELECT * FROM tbl_menu;
SELECT * FROM tbl_category;

-- 메뉴명과 카테고리명을 한번에 보고 싶다
-- > '메뉴명'과 '카테고리명'이 각각 어떤 테이블에 존재하나? (2개 이상이면 Join 고려)
-- > tbl_menu와 tbl_category를 확인해 서로 관계가 있는지 확인
-- > Join으로 해결 가능함을 확인

SELECT 
       *
  FROM tbl_menu JOIN tbl_category ON tbl_menu.category_code = tbl_category.category_code;   
  
-- ON은 어떻게 매칭할건지에 대한 조건
-- 왼쪽에 있는 Table이 기준이 된다.

SELECT 
       a.menu_name
     , a.menu_price
     , b.category_name -- 이왕 Alias로 별칭 달았으면 다른 것들도 달자. 오류가 덜 나도록 코딩 컨벤션이다.
     , a.category_code -- 두 테이블에 같은 이름으로 존재하는 column이 있으면 ambiguous(애매모호한) 에러 발생.
  FROM tbl_menu a      -- MariaDB는 table에 AS를 쓸 경우 '을 붙이면 오류가 난다. '를 빼거나 AS를 빼야한다.
 INNER JOIN tbl_category b ON (a.category_code = b.category_code);

DESC tbl_menu;
DESC tbl_category;

                       -- 코딩 컨벤션으르 신경쓰자
                       -- 별칭은 별칭을 다 추가하는 방향으로 하자.
                       --  MariaDB는 싱글 쿼테이션'' 적용 안되니까 쓰지 말자.

SELECT 
       a.menu_name
     , b.category_name
  FROM tbl_menu a
  JOIN tbl_category b USING (category_code);

-- using  활용, Column명이 다르면 Using 사용 불가능
-- 위에 대로 푸는게 할배들을 위한 기회에고 탱템 상향
-- Using은 소괄호 반드시 사용해야함
-- 보통 주석이 코드한 줄 뒤에 나오면 한 줄 띄어서 작성한다

-- Outer join
-- join 시에 기준이 될 테이블의 모든 행을 보고자 하는 경우 사용
-- (매칭이 안되도 다 보고싶을때)

-- 1)Left join
SELECT
       a.category_name
     , b.menu_name
  FROM tbl_category a
  LEFT JOIN tbl_menu b ON a.category_code = b.category_code;

-- 2)Right join  
SELECT
       a.category_name
     , b.menu_name
  FROM tbl_category a
  RIGHT JOIN tbl_menu b ON a.category_code = b.category_code;
  
-- cross join
SELECT
       *
  FROM tbl_menu
 CROSS JOIN tbl_category;
 
-- self join
SELECT
       a.category_name AS '하위 카테고리'
     , b.category_name AS '상위 카테고리'
  FROM tbl_category a
  JOIN tbl_category b ON (a.ref_category_code = b.category_code);
  