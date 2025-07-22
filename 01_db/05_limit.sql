-- Limit -- 데이터 열 중 일부를 끊어내는 것
-- 페이징 처리(Page 끊기, 10줄 넘어가면 다음 페이지로 넘어가기), 스크롤 등에 주로 사용

SELECT
       menu_code
     , menu_name
     , menu_price
  FROM tbl_menu
 ORDER BY menu_price DESC, menu_code DESC            -- 1차 정렬기준은 가격 내림차순, 2차 정렬기준은 가격이 같을 시 이름 내림차순
 LIMIT 6, 6;                                         -- (INDEX 넘버링을 쓰므로) (0,1,2,3,4,5) 6번째부터 6개씩 짤라보기
 
SELECT
       *
  FROM tbl_menu
 ORDER BY menu_code
 LIMIT 5;                                            -- 첫 행부터 작성된 숫자 길이만큼 추출