-- set operator

-- UNION(합집합)
SELECT
       menu_code
     , menu_name
     , menu_price
     , category_code
     , orderable_status
  FROM tbl_menu
 WHERE category_code = 10
 UNION
SELECT
       menu_code
     , menu_name
     , menu_price
     , category_code
     , orderable_status
  FROM tbl_menu
 WHERE menu_price < 9000;
 
 
-- UNION ALL
SELECT
       menu_code
     , menu_name
     , menu_price
     , category_code
     , orderable_status
  FROM tbl_menu
 WHERE category_code = 10
 UNION ALL
SELECT
       menu_code
     , menu_name
     , menu_price
     , category_code
     , orderable_status
  FROM tbl_menu
 WHERE menu_price < 9000
 ORDER BY 3, 4;
 
--  intersect(교집합)
-- INNER JOIN으로 구현
SELECT
       a.menu_code
     , a.menu_name
     , a.menu_price
     , a.category_code
     , a.orderable_status
  FROM tbl_menu a
  JOIN (SELECT
               b.menu_code
             , b.menu_name
             , b.menu_price
             , b.category_code
             , b.orderable_status
          FROM tbl_menu b
         WHERE b.menu_price < 9000
       ) c ON a.menu_code = c.menu_code
 WHERE a.category_code = 10;

-- IN 연산자 활용
SELECT
       a.menu_code
     , a.menu_name
     , a.menu_price
     , a.category_code
     , a.orderable_status
  FROM tbl_menu a
 WHERE a.category_code = 10
   AND a.menu_code IN (SELECT
                              b.menu_code
           					 FROM tbl_menu b
           					WHERE b.menu_price < 9000
           				 );

-- --------------------------------------------------
-- MINUS(차집합)
-- 1) inner join
SELECT
       a.menu_code
     , a.menu_name
     , a.menu_price
     , a.category_code
     , a.orderable_status
  FROM tbl_menu a
  LEFT JOIN (SELECT
                    b.menu_code
                  , b.menu_name
                  , b.menu_price
                  , b.category_code
                  , b.orderable_status
               FROM tbl_menu b
              WHERE b.menu_price < 9000
            )c ON a.menu_code = c.menu_code
 WHERE a.category_code = 10
   AND c.menu_code IS NULL;
         

