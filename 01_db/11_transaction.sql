-- transaction
-- 논리적 일의 단위
-- 예) 주문 = 배송 + 결제 + 재고
SELECT @@autocommit;            -- autocommit 상태 확인(1 = on, 0 = off)
                               -- insert, update, delete 각각마다 commit하지않음.
SET autocommit = 0;

START TRANSACTION;

INSERT
  INTO tbl_menu
VALUES
(
  NULL, '바나나해장국', 8500
  , 4, 'Y'
);

SAVEPOINT sp1; -- insert 이후 sp1으로 저장

UPDATE tbl_menu
   SET menu_name = '수정된 메뉴'
 WHERE menu_code = 5;
 
DELETE FROM tbl_menu WHERE menu_code = 10;

-- ROLLBACK;
-- COMMIT;
ROLLBACK TO sp1; -- 중간 저장지점까지 rollback 가능

SELECT * FROM tbl_menu;

-- start transaction 부터 rollback/commit 까지의 묶음이 끝나고 나면 다시 autocommit 상태가 된다.
DELETE
  FROM tbl_menu
 WHERE menu_code = 11;
 
ROLLBACK;
SELECT * FROM tbl_menu;
-- autocommit은 기본적으로 꺼져있는게 맞다.

-- autocommit을 꺼주려면?
SET autocommit = 0;

-- 아니면 이런 방법도 가능 -- SET autocommit = FALSE
DELETE
  FROM tbl_menu
 WHERE menu_code = 13;
ROLLBACK;
SELECT * FROM tbl_menu;

-- 번호발생기인 auto increment를 다시 원하는 숫자로 초기화
ALTER TABLE tbl_menu AUTO_INCREMENT = 23;        -- 다음 번호 발생을 23번으로 고정

