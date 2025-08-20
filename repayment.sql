 -- cleaning repayments table 
 -- identifying and removing duplicates
 
 select*
 from repayments;
 
 create table repayments2
 like repayments;
 
 select *
  from repayments2;
  
  insert repayments2
  select *
  from repayments;
 
 select *,
  row_number() over( partition by 
  date_time, customer_id, amount, rep_month, repayment_type) as row_num
  from repayments2; 
  
   with duplicate_cte as
 (
  select *,
  row_number() over( partition by 
  date_time, customer_id, amount, rep_month, repayment_type) as row_num
  from repayments2
 )
 select *
 from duplicate_cte
 where row_num > 1;
  
  CREATE TABLE `repayments3` (
  `date_time` text,
  `customer_id` text,
  `amount` double DEFAULT NULL,
  `rep_month` int DEFAULT NULL,
  `repayment_type` text,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
  
   select *
 from repayments3;
  
  insert into repayments3
 select *,
  row_number() over( partition by 
  date_time, customer_id, amount, rep_month, repayment_type) as row_num
  from repayments2;
  
  delete 
 from repayments3
 where row_num > 1
 ;
 
 select *
 from repayments3
 ;
  
  -- deleting columns
  alter table repayments3
  drop column row_num;
  -- splitting date_time column into two
 select *
 from repayments3;
  
  select left (date_time, 10) `Date`, right(date_time, 21)`Time`
 from repayments3;
  
  alter table repayments3 
add column `Date` varchar(10), 
add column `Time` varchar(21);

update repayments3 
set `Date` = left(date_time, 10), 
    `Time` = right(date_time, 21);
  
-- adding a hyphen and changinf rep_month into date  
  select rep_month, 
    CONCAT(left(rep_month, 4), '-', right(rep_month, 2)) AS formatted_date
from repayments3;

alter table repayments3
modify rep_month varchar(7);
  
 update repayments3
set rep_month = CONCAT(left(rep_month, 4), '-', right(rep_month, 2)) ;
 
  select *
  from repayments3;
  
  alter table repayments3
  drop column date_time;
  
  
  
  
  
  
  
  
  
  
  
  
  