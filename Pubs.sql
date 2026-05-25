----------------------- publisher_country_filter ------------------------
select * from publishers
where country in ('Germany' , 'France')
----------------------- book_sales_classification------------------------
select Ti.title 
 , case when Sa.qty> 30
 then	'G1'
  when Sa.qty <30 
  then 'G2' 
  end as [Groupping] from titles Ti
  join sales Sa
  on Ti.title_id = Sa.title_id
  ----------------------- employee_experience_analysis ------------------------
  select ep.emp_id , CONCAT(ep.fname ,  Space(2) , ep.lname)  as [Full Name]  ,jo.job_desc ,
  DATEDIFF(YEAR  , hire_date , GETDATE()) as [experience]
  from employee ep
join jobs jo
on jo.job_id = ep.job_id
  ----------------------- book_price_filter ------------------------
  select title_id , title , type , price from titles
  where price between 7 and 20
  order by price desc
  ----------------------- average_price_by_category ------------------------
  select type , AVG(price) as [Average price] from titles
  group by type
  order by [Average price] desc
    ----------------------- hiring_trend_by_year ------------------------
    select  YEAR(hire_date) as [Year] , count(emp_id) as [Number of employed]  from employee 
    group by YEAR(hire_date)
----------------------- Problem 07 ------------------------
-- تعداد نویسندگان بر حسب هر ایالت --
select state , count(au_id) as [Numbers of authord] from authors
group by state
-----------------------author_distribution_by_state ------------------------
select distinct(city)  from authors
-----------------------publisher_book_mapping ------------------------
select t.title , p.pub_name from titles t
join publishers p
on p.pub_id  = t.pub_id
----------------------- price_range_by_category------------------------
select type , MAX(price) as [Max Price] , MIN(price) as [Min Price] from titles 
group by type
----------------------- top_job_roles ------------------------
select top 2 jo.job_desc , COUNT(ep.emp_id) [Numbers of employed] from employee ep
join jobs jo
on ep.job_id = jo.job_id
group by jo.job_desc
order by [Numbers of employed] desc
----------------------- most_expensive_book_by_category------------------------
with my_cte01 as
(
 select title , type , price ,
 row_number() over (partition by type  order by price desc) as [Rank] from titles
 )
 select title , type , price from my_cte01
 where Rank = 1
 -----------------------category_price_share_analysis------------------------
 with my_Cte01 as
 (
 select type,  sum(price) as [Total Price]  from titles
 group by type
 )
 select type , [Total Price] , SUM([Total Price]) as [Price Percentage] from my_Cte01 
 group by type, [Total Price]
