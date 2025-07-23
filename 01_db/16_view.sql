-- view
-- 가상 테이블
CREATE VIEW v_menu
AS
SELECT
       menu_name AS '메뉴명'
     , menu_price AS '메뉴단가'
  FROM tbl_menu;                       -- VIEW의 기반이 되는 테이블을 BASE TABLE이라고 한다.

SELECT * FROM v_menu;

CREATE VIEW hansik
AS
SELECT
       menu_code AS '메뉴번호'
     , menu_name AS '메뉴명'
  FROM tbl_menu
 WHERE category_code = 4;
 
INSERT
  INTO hansik
VALUES
(NULL, '민트초코국밥');

DESC tbl_menu; -- 모든 column이 NOT NULL 제약인데 hansik에 넣으면 menu_code, menu_name 말고 다른걸 넣을수가 없어서 오류

CREATE VIEW hansik
AS
SELECT
       menu_code AS '메뉴번호'
     , menu_name AS '메뉴명'
     , menu_price AS '메뉴 가격'
     , category_code AS '카테고리코드'
     , orderable_status AS '주문가능상태'
  FROM tbl_menu
 WHERE category_code = 4;         -- view도 table처럼 이미 hansik이 있으므로 만들 수가 없다고 나옴


-- DROP VIEW hansik;
CREATE OR REPLACE VIEW hansik     -- view는 자주 만드는 경우가 많아 view를 새로 replace해주는 option을 제공한다
AS
SELECT
       menu_code AS '메뉴번호'
     , menu_name AS '메뉴명'
     , menu_price AS '메뉴가격'
     , category_code AS '카테고리코드'
     , orderable_status AS '주문가능상태'
  FROM tbl_menu
 WHERE category_code = 4;

-- VIEW를 통해 특정 조건을 만족하면 베이스 테이블에 영향을 줄 수 있지만 지양해야 한다.
INSERT
  INTO hansik
VALUES
(NULL, '민트초코국밥', 2000, 4, 'Y');

SELECT * FROM hansik;

UPDATE hansik
   SET 메뉴명 = '민트초코국밥'
     , 메뉴가격  = 4000
 WHERE 메뉴번호 = 24;

-- 후에 Join이나 Subquery 등 관계가 생기게 되면
CREATE OR REPLACE VIEW test_v
AS
SELECT
       menu_name
     , a.category_code
  FROM tbl_menu a
  JOIN tbl_category b ON a.category_code = b.category_code;
