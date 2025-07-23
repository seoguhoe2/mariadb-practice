-- constraints(제약조건)
-- 1. not null 제약조건 - 반드시 데이터가 존재해야한다.
-- 컬럼 레벨에서만 제약조건 부여가 가능
DROP TABLE if EXISTS user_notnull;
CREATE TABLE if NOT EXISTS user_notnull (
    user_no INT NOT NULL,
    user_id VARCHAR(255) NOT NULL,
    user_pwd VARCHAR(255) NOT NULL,
    user_name VARCHAR(255) NOT NULL,
    gender VARCHAR(3),
    phone VARCHAR(255) NOT NULL,
    email VARCHAR(255)
);

INSERT
  INTO user_notnull
(user_no, user_id, user_pwd, user_name, gender, phone, email)  -- 되도록 작성 권장. 차후 협력할 때 코드 읽는데 도움이 됨. 주석도 적으면 좋을듯
VALUES
(1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@gmail.com'),
(2, 'user02', 'pass02', '유관순', '여', '010-777-7777', 'yu77@gmail.com');

DESC user_notnull;
SELECT * FROM user_notnull;

-- 2. Unique 제약조건 - 중복된 데이터가 해당 컬럼에 들어가지 않아야 한다.
-- 컬럼 레벨 + 테이블 레벨 전부 다 가능
DROP TABLE if EXISTS user_unique;
CREATE TABLE if NOT EXISTS user_unique (
    user_no INT PRIMARY KEY,
    user_id VARCHAR(255) NOT NULL,
    user_pwd VARCHAR(255) NOT NULL,
    user_name VARCHAR(255) NOT NULL,
    gender VARCHAR(3),
    phone VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    UNIQUE(phone, email)
);

INSERT
  INTO user_unique
(user_no, user_id, user_pwd, user_name, gender, phone, email)  -- 되도록 작성 권장. 차후 협력할 때 코드 읽는데 도움이 됨. 주석도 적으면 좋을듯
VALUES
(1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@gmail.com'),
(2, 'user02', 'pass02', '유관순', '여', '010-777-7777', 'yu77@gmail.com');

DESC user_unique;


SELECT * FROM user_unique;

-- ---------------------------------------------------
-- primary key 제약조건 - 모든 table마다 반드시 존재해야하고 1개만 존재해야 한다.
-- not null + unique
-- 컬럼 레벨 + 테이블 레벨 다 된다.
DROP TABLE if EXISTS user_primarykey;
CREATE TABLE if NOT EXISTS user_primarykey (
    user_no INT NOT NULL,
    user_id VARCHAR(255) NOT NULL,
    user_pwd VARCHAR(255) NOT NULL,
    user_name VARCHAR(255) NOT NULL,
    gender VARCHAR(3),
    phone VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    UNIQUE(phone),
    PRIMARY KEY(user_no, user_id)
);

INSERT
  INTO user_primarykey
(user_no, user_id, user_pwd, user_name, gender, phone, email)  -- 되도록 작성 권장. 차후 협력할 때 코드 읽는데 도움이 됨. 주석도 적으면 좋을듯
VALUES
(1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@gmail.com'),
(2, 'user02', 'pass02', '유관순', '여', '010-777-7777', 'yu77@gmail.com'),
(2, 'user03', 'pass03', '김홍도', '남', '010-9876-5432', 'hongdo67@gmail.com');
-- NULL 값이 들어가도 되는건가?
-- ---------------------------------------------------------------------------------------
-- foreign key 제약조건
-- 테이블이 두개 이상이면서 한쪽 테이블(primary key)에서 다른쪽 테이블(일반 컬럼)로 넘어간 컬럼에 작성됨
-- foreign key 제약조건은 부모 테이블의 pk값을 참조 + null 값이 들어갈 수 있다.

-- 테이블들을 지울때는 자식 테이블부터 삭제해야 한다.
DROP TABLE if EXISTS user_grade;
CREATE TABLE if NOT EXISTS user_grade (
    grade_code INT PRIMARY KEY,
    grade_name VARCHAR(255) NOT NULL
);

DROP TABLE if EXISTS user_foreignkey;
CREATE TABLE if NOT EXISTS user_foreignkey (
    user_no INT PRIMARY KEY,
    user_id VARCHAR(255) NOT NULL,
    user_pwd VARCHAR(255) NOT NULL,
    user_name VARCHAR(255) NOT NULL,
    gender VARCHAR(3),
    phone VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    grade_code INT,
    FOREIGN KEY(grade_code) REFERENCES user_grade -- table level에 있는 foreign key의 column은 반드시 컬럼 레벨에 존재해야한다.
);

INSERT
  INTO user_grade
VALUES
(10, '일반회원'),
(20, '우수회원'),
(30, '특별회원');

SELECT * FROM user_foreignkey;
SELECT * FROM user_grade;
INSERT
  INTO user_foreignkey
(user_no, user_id, user_pwd, user_name, gender, phone, email, grade_code)
VALUES 
(1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@gmail.com', 20),
(2, 'user02', 'pass02', '유관순', '여', '010-777-7777', 'yu77@gmail.com', NULL);

SELECT * FROM user_foreignkey;

-- ----------------------------------------------------------------------------------
-- 삭제룰을 적용해서 부모 Table 데이터를 먼저 삭제하는 방법
DROP TABLE if EXISTS user_foreignkey2;
DROP TABLE if EXISTS user_grade2;

CREATE TABLE if NOT EXISTS user_grade2 (
    grade_code INT PRIMARY KEY,
    grade_name VARCHAR(255) NOT NULL
);

CREATE TABLE if NOT EXISTS user_foreignkey2 (
    user_no INT PRIMARY KEY,
    user_id VARCHAR(255) NOT NULL,
    user_pwd VARCHAR(255) NOT NULL,
    user_name VARCHAR(255) NOT NULL,
    gender VARCHAR(3),
    phone VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    grade_code INT,
    FOREIGN KEY(grade_code) REFERENCES user_grade2(grade_code)
    ON DELETE SET NULL
);

INSERT
  INTO user_grade2
VALUES
(10, '일반회원'),
(20, '우수회원'),
(30, '특별회원');

INSERT
  INTO user_foreignkey2
(user_no, user_id, user_pwd, user_name, gender, phone, email, grade_code)
VALUES 
(1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@gmail.com', 10),
(2, 'user02', 'pass02', '유관순', '여', '010-777-7777', 'yu77@gmail.com', NULL);

DELETE
  FROM user_grade2
 WHERE grade_code = 10;
 
SELECT * FROM user_foreignkey2;   -- 부모 데이터인 10이 없어지니 자동으로 NULL로 채워졌다.

-- ---------------------------------------------------------------
-- CHECK 제약조건(조건식을 활용한 상세한 제약사항) 제약조건 = 주로 Validation이라고 한다.
-- DB에선 무결성=유효한 이라고 생각하면 됨. (무결성 있는 = 유효한) 값을 갖는게 목표
DROP TABLE if EXISTS user_check;
CREATE TABLE if NOT EXISTS user_check (
    user_no INT AUTO_INCREMENT PRIMARY KEY,
    user_name VARCHAR(255) NOT NULL,
    gender VARCHAR(3) CHECK(gender IN ('남','여')),  -- check 제약조건은 컬럼레벨도 컬럼을 작성한다.
    age INT,
	 CHECK(age >= 19 AND age <= 30)                   -- 제약조건은 어느 레벨이던 괜찮으나 단체 차원에서의 약속으로 통일은 해야한다.
);

INSERT
  INTO user_check
VALUES
(NULL, '홍길동', '남', 25),
(NULL, '신사임당', '여', 23);

INSERT
  INTO user_check
VALUES
(NULL, '김개똥', '중', 27);                          -- 제약조건 위반으로 인해 오류 발생

-- --------------------------------------------------------------
-- default 제약조건
DROP TABLE if EXISTS tbl_country;
CREATE TABLE if NOT EXISTS tbl_country (
    country_code INT AUTO_INCREMENT PRIMARY KEY,
    country_name VARCHAR(255) DEFAULT '한국',
    population VARCHAR(255) DEFAULT '0명',
    add_day DATE DEFAULT (CURRENT_DATE),
    add_time DATETIME DEFAULT (CURRENT_TIME)
);

INSERT
  INTO tbl_country
VALUES
(NULL, DEFAULT, DEFAULT, DEFAULT, DEFAULT);

-- INSERT
--   INTO tbl_country
-- VALUES
-- (NULL, NULL, NULL, NULL, NULL);                    -- NULL이 들어간다고 DEFAULT값이 되는 건 아니구나.

SELECT * FROM tbl_country;
DESC tbl_country;

-- ---------------------------------------------------------------
-- 제약 조건 확인
SELECT 
    TABLE_NAME as '테이블명',
    ENGINE as '엔진',
    TABLE_ROWS as '행수',
    ROUND(DATA_LENGTH/1024/1024, 2) as 'MB'
FROM information_schema.TABLES
WHERE TABLE_SCHEMA = DATABASE()
    AND TABLE_TYPE = 'BASE TABLE';                   -- 내 DB 관련 정보 확인
    

-- 현재 데이터베이스의 모든 제약조건 조회


-- 특정 테이블의 제약조건
SELECT 
    tc.CONSTRAINT_NAME,
    CONSTRAINT_TYPE,
    COLUMN_NAME
FROM information_schema.TABLE_CONSTRAINTS tc
LEFT JOIN information_schema.KEY_COLUMN_USAGE kcu 
    ON tc.CONSTRAINT_NAME = kcu.CONSTRAINT_NAME 
    AND tc.TABLE_SCHEMA = kcu.TABLE_SCHEMA 
    AND tc.TABLE_NAME = kcu.TABLE_NAME
WHERE tc.TABLE_SCHEMA = DATABASE() 
    AND tc.TABLE_NAME = 'user_check';