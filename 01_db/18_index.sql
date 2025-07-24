-- index
-- 사전(clustering, 고유 인덱스) 또는 용어 검색(non-clustering, 비고유 인덱스)

DROP TABLE if exists phone;
CREATE TABLE if NOT exists phone(
    phone_number INTeger,
    phone_code INT PRIMARY key,
    phone_name VARCHAR(100) unique,
    phone_price INTEGER
);

INSERT
  INTO phone
VALUES
(1, 3, 'galaxyS24', 1200000),
(2, 2, 'iphone17pro', 1430000),
(3, 1, 'galaxyfold8', 1730000);

SELECT * FROM phone;                      -- 무조건 primary key로 정렬해주네
SHOW INDEX FROM phone;
-- Cardinality : phone_code에 들어있는 값들이 중복되지 않는 갯수(종류)

SELECT * FROM phone WHERE phone_code = 1;
-- phone으로 검색하지 않고 name으로 검색하면서도 index 속도를 유지하고 싶으면?
-- non-clustering 사용, 저장 공간을 더 낭비하게 되기는 함
explain SELECT * FROM phone WHERE phone_name = 'iphone17pro';

-- 일반 컬럼에 비고유 인덱스 추가(해당 컬럼의 값으로 별도의 공간을 마련해 정렬해둠)
CREATE INDEX idx_name ON phone (phone_name);
explain SELECT * FROM phone WHERE phone_name = 'iphone17pro';

-- where 조건에 따른 index 활용 확인
explain SELECT * FROM phone WHERE phone_code = 1;
explain SELECT * FROM phone WHERE phone_name = 'iphone17pro';
explain SELECT * FROM phone WHERE phone_price = 1730000;
 





