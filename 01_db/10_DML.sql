-- DML(Data Manipulation Language)
-- insert, update, delete

-- insert
-- 새로운 행을 추가하는 구문
-- 후보 키
SELECT * FROM tbl_menu;
INSERT
  INTO tbl_menu
(
  menu_name
, menu_price
, category_code
, orderable_status
)
VALUES
(
  '32번째 초콜릿죽'
, 6500
, 7
, 'Y'
);

DESC tbl_menu;
SELECT * FROM tbl_menu ORDER BY 1 DESC;
ROLLBACK;

-- ---------------------------------------------------
-- multi insert
-- 하나의 insert 구문으로 여러 데이터를 insert할 수도 있다.
INSERT
  INTO tbl_menu
VALUES
(NULL, '참치맛아이스크림', 1700, 12, 'Y'),
(NULL, '멸치맛아이스크림', 1500, 11, 'Y'),
(NULL, '소시지맛커피', 2500, 8, 'Y');

SELECT * FROM tbl_menu ORDER BY 1 DESC;

-- -----------------------------------------------------------
-- update
-- 원하는 컬럼에 있는 컬럼값을 바꾸는 것
-- 주의) 조건을 걸어 행을 필터링하지 않으면 모든 데이터가 수정될 수 있음. Where 조건으로 잘 추릴 것
SELECT * FROM tbl_menu;
UPDATE tbl_menu
   SET category_code = 7
     , menu_price = 3000
 WHERE menu_code = 30;

-- 서브쿼리 활용해 UPDATE 
-- '멸치맛아이스크림'의 가격을 2000원으로 수정
UPDATE tbl_menu
   SET menu_price = 2000
 WHERE menu_code = (SELECT menu_code
                      FROM tbl_menu
                     WHERE menu_name = '멸치맛아이스크림'
                   );
SELECT * FROM tbl_menu ORDER BY 1 DESC;

INSERT
  INTO tbl_menu
VALUES
(NULL, NULL, NULL, NULL, NULL); -- auto increment는 오류가 생겨도 menu code를 +1하는가?

SELECT *
  FROM tbl_menu
 ORDER BY 1 DESC;

-- ---------------------------------------------------------
-- Delete
-- soft delete(업데이트), hard delete(삭제)
-- 회원탈퇴 = soft delete
-- 지울 데이터를 WHERE절로 잘 찾지 않으면 다 지워진다!
DELETE
  FROM tbl_menu
 WHERE 1 = 1;   -- 1=1? 1=0?

-- order by 및 limit 활용
DELETE
  FROM tbl_menu
 ORDER BY menu_price
 LIMIT 2;
 
SELECT * FROM tbl_menu ORDER BY 3;

-- -----------------------------------------
-- replace(치환)
-- 덮어씌우기, pk(primary key)에 해당하는 값으로 기존과 새로움을 구분
-- 1) 기존에 있는 메뉴는 수정
REPLACE
   INTO tbl_menu
 VALUES
(
  17
, '참기름소주'
, 5000
, 10
, 'Y'
);

SELECT * FROM tbl_menu;

-- 2) 기존에 없는 메뉴는 추가
REPLACE
   INTO tbl_menu
 VALUES
(
  54
, '참기름소주'
, 5000
, 10
, 'Y'
);

SELECT * FROM tbl_menu;


