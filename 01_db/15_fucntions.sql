-- functions
-- 1) 문자열 관련 함수
SELECT ASCII('a'), CHAR(97);

SELECT BIT_LENGTH('한글'), CHAR_LENGTH('한글'), LENGTH('한글');

SELECT CONCAT('nice', 'to', 'meet', 'you');
SELECT CONCAT_WS(' ', 'nice', 'to', 'meet', 'you!');
SELECT CONCAT(CAST(menu_price AS CHAR), '원') FROM tbl_menu;

SELECT
       ELT(2,'축구', '야구', '농구')
     , FIELD('축구', '야구', '농구', '축구')
     , FIND_IN_SET('축구', '야구,농구,축구')         -- comma로 이루어진 set에서 찾겠다는건데 띄어쓰기하면 인식하지 않음
     , INSTR('축구농구야구', '농구')
     , LOCATE('야구', '축구농구야구');




