-- Data Cleaning
select *
from disbursments;
 select *
 from repayments;
 
-- cleaning disbursment table
 create table disbursments2
 like disbursments;
 
 select *
 from disbursments2;
  
  insert disbursments2
  select *
  from disbursments;
  
  select *,
  row_number() over(
  partition by customer_id, disb_date, tenure, account_num, loan_amount, loan_fee) row_num
  from disbursments2;
  
  with duplicate_cte as(
  select *,
  row_number() over(
  partition by customer_id, disb_date, tenure, account_num, loan_amount, loan_fee) row_num
  from disbursments2
  )
  select *
  from duplicate_cte
  where row_num >1;
  
  CREATE TABLE `disbursments3` (
  `customer_id` text,
  `disb_date` text,
  `tenure` text,
  `account_num` text,
  `loan_amount` int DEFAULT NULL,
  `loan_fee` double DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

  select *
  from disbursments3;
  
  insert into disbursments3
   select *,
  row_number() over(
  partition by customer_id, disb_date, tenure, account_num, loan_amount, loan_fee) row_num
  from disbursments2 ;
  
  delete
  from disbursments3
  where row_num >1
  ;
  
select *
  from disbursments3
  ;
  
  -- standardizing data in disbursments table
  select *
  from disbursments3
  ;
  
update disbursments3
set disb_date= STR_TO_DATE(disb_date, '%d-%b-%y');
  
alter table disbursments3
modify column disb_date date; 
  
alter table disbursments3
drop column row_num;  

 
 
 
 
 
  
  
  
  
  
  
  
  
  
  
  
 
 