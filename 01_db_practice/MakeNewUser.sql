-- 권한이 있는 User 만들기

-- 1) 새로운 practice 계정 만들기
CREATE USER 'practice'@'%' IDENTIFIED BY 'practice'; -- localhost 대신 % 쓰면 외부 IP로 접속 가능하다는건 %는 무슨 기능?
SHOW DATABASES;
USE mysql;
SELECT * FROM user;
CREATE DATABASE employeedb;
SHOW GRANTS FOR 'practice'@'%';
GRANT ALL PRIVILEGES ON employeedb.* TO 'practice'@'%';
