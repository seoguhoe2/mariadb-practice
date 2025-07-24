-- trigger
-- 특정 테이블 또는 데이터에 변화가 생기면 실행할 내용을 저장하는 DB의 오브젝트
-- user, table, view, index, procedure, stored function, trigger - 우리가 배운 오브젝트
-- create, alter, drop - DDL 명령어들을 사용해야한다.
-- update와 insert가 동시에 일어나는 것들은 trigger를 사용할 수 있다.

delimiter //

CREATE OR REPLACE TRIGGER after_order_menu_insert
    AFTER INSERT           
    ON tbl_order_menu       -- 주문 메뉴 테이블에 insert가 발생하고 나서
    FOR EACH ROW            -- 한 행 한 행 insert할 때 마다
BEGIN
    UPDATE tbl_order
       SET total_order_price = total_order_price + NEW.order_amount *  -- tbl_order 테이블의 total_order_price를 계속 update
   (SELECT menu_price FROM tbl_menu WHERE menu_code = NEW.menu_code)   -- 새로 들어온 menu_code와 동일한 menu_code를 tbl_menu 테이블에서 찾아서 가격이 얼마인지 찾기
     WHERE order_code = NEW.order_code;                                
END //

delimiter ;

-- 부모 테이블인 tbl_order부터 insert해서 total_order_price가 잘 업데이트 되는지 확인하자
INSERT
  INTO tbl_order
(
  order_code, order_date
, order_time, total_order_price
)
VALUES
(
  NULL
, CONCAT(CAST(YEAR(NOW()) AS VARCHAR(4))
       , CAST(LPAD(MONTH(NOW()), 2, 0) AS VARCHAR(2))
       , CAST(LPAD(MONTH(NOW()), 2, 0) AS VARCHAR(2)))
, CONCAT(CAST(LPAD(HOUR(NOW()), 2, 0) AS VARCHAR(2))
       , CAST(LPAD(MINUTE(NOW()), 2, 0) AS VARCHAR(2))
       , CAST(LPAD(SECOND(NOW()), 2, 0) AS VARCHAR(2)))
, 0
);

DESC tbl_order_menu;
DESC tbl_order;

SELECT MONTH(NOW());                                -- 7만 나오는게 아닌 공백이 있다면 07로 나오게 하고 싶어 -> LPAD 활용
SELECT DAYOFMONTH(NOW());

SELECT * FROM tbl_order;

-- 2) 자식 테이블인 tbl_order_menu에 메뉴 추가
SELECT * FROM tbl_menu;
INSERT
  INTO tbl_order_menu
(order_code, menu_code, order_amount)
VALUES
(1, 4, 3);                                           -- 1번 그룹에서 4번 메뉴를 3개 시키겠다

DESC tbl_order_menu;

SELECT * FROM tbl_order_menu;
SELECT * FROM tbl_order;

-- 추가 주문
INSERT
  INTO tbl_order_menu
(order_code, menu_code, order_amount)
VALUES
(1, 2, 2);

-- insert만 해도 자동으로 문제없이 유도속성이 update 됨(업무 무결성 만족)

-- 입출고용 트리거 생성
-- 1) 이력 테이블
CREATE TABLE if NOT EXISTS product (
    pcode INT PRIMARY KEY AUTO_INCREMENT,
    pname VARCHAR(30),
    brand VARCHAR(30),
    price INT,
    stock INT DEFAULT 0,
    CHECK(stock >= 0)
);

DESC product;

-- 2) 내역 테이블
CREATE TABLE if NOT EXISTS pro_detail(
    dcode INT PRIMARY KEY AUTO_INCREMENT,
    pcode INT,
    pdate DATE,
    amount INT,
    STATUS VARCHAR(10) CHECK(STATUS IN('입고','출고')),
    FOREIGN KEY(pcode) REFERENCES product    
);

DESC pro_detail;

-- 3)트리거 생성
delimiter //

CREATE OR REPLACE TRIGGER trg_productafter
    AFTER insert
    ON pro_detail
    FOR EACH row
BEGIN
    if NEW.status = '입고' then
        UPDATE product
           SET stock = stock + NEW.amount
         WHERE pcode = NEW.pcode;
    ELSEIF NEW. STATUS = '출고' then
        UPDATE product
           SET stock = stock - NEW.amount
         WHERE pcode = NEW.pcode;
    END if;
END //

delimiter ;

-- 1) 상품 등록(초기 수량 부여)
INSERT
  INTO product
(
  pcode, pname, brand
, price, stock
)
VALUES
(
  NULL, '갤럭시플립', '삼성'
, 900000, 5
),
(
  NULL, '아이폰17', '애플'
, 1100000, 3
),
(
  NULL, '투명폰', '삼성'
, 2100000, 4
);

SELECT * FROM product;

-- 2) 출고 진행
INSERT
  INTO pro_detail
(
  dcode, pcode, pdate, amount, status
)
VALUES
(
  NULL, 3, CURDATE()
, 3, '출고'
);

SELECT * FROM product;
SELECT * FROM pro_detail;

-- 3) 입고 진행
INSERT
  INTO pro_detail
(
  dcode, pcode, pdate, amount, STATUS
)
VALUES
(
  NULL, 1, CURDATE()
, 9, '입고'
);

-- insert 시 동작할 trigger -> NEW.컬럼명
-- update 시 동작할 trigger -> NEW.컬럼명 or OLD.컬럼명 둘 다 가능
-- delete 시 동작할 trigger -> OLD.컬럼명


