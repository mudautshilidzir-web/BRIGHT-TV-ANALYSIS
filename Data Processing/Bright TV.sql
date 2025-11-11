---------------------------------------
 select *
 from BRIGHT_TV.SALES.USER_PROFILES;

 select *
 from BRIGHT_TV.SALES.VIEWERSHIP;
 
 --------------------------------------------------
---- exploring data analysis
---- Checking the matching rows  
 select a.userid,
 name,
 surname 
 from BRIGHT_TV.SALES.USER_PROFILES as a
 INNER JOIN BRIGHT_TV.SALES.VIEWERSHIP as b
 on a.userid=b.userid;

---------------------------------------------
--Checking users Max and Min Age

select max(age) as max_age
from BRIGHT_TV.SALES.USER_PROFILES;


select min(age) as min_age
from BRIGHT_TV.SALES.USER_PROFILES;
---------------------------------------------------
--checking  viewers and users total count

select count(userid)
from BRIGHT_TV.SALES.USER_PROFILES
group by all 
having count(*) >1;

select count(userid)
from BRIGHT_TV.SALES.VIEWERSHIP
group by all having count(*)> 1;

select a.name,
count(*) over() as number_of_viewers
FROM BRIGHT_TV.SALES.USER_PROFILES AS a 
inner join BRIGHT_TV.SALES.VIEWERSHIP AS b
ON a.userid = b.userid
order by number_of_viewers desc;
----------------------------------------------------------------
----counting how many time each viewer watched per channel
select
a.userid,
    a.name,
    a.surname,
    COUNT(b.channel2) AS view_count
FROM BRIGHT_TV.SALES.USER_PROFILES AS a
INNER JOIN BRIGHT_TV.SALES.VIEWERSHIP AS b
    ON a.userid = b.userid
GROUP BY a.userid, a.name, a.surname
ORDER BY view_count DESC;
-----------------------------------------
--checking the users first and last dates
select min(recorddate2) as first_timer
from BRIGHT_TV.SALES.VIEWERSHIP;

--
select max(recorddate2) as last_timer
from BRIGHT_TV.SALES.VIEWERSHIP;
----------------------------------------------
---checking the most Viewed or Top ch recorddate2,

select a.province,
    b.channel2, 
    count(*) AS total_count
from BRIGHT_TV.SALES.USER_PROFILES as a
inner join  BRIGHT_TV.SALES.VIEWERSHIP as b
on  a.userid = b.userid
group by a.province, b.channel2
order by a.province, total_count DESC;
-------------------------------------------------------------
--checking the last-watched-day
select max(RECORDDATE2) AS last_watched_day
from BRIGHT_TV.SALES.VIEWERSHIP;
--checking the first-watched-day
select min(recorddate2) as first_watched_day
from BRIGHT_TV.SALES.VIEWERSHIP;
------------------------------------
-------displaying user and viewership per race
select a.race,
count(a.userid) as user_count
from BRIGHT_TV.SALES.USER_PROFILES as a
inner join BRIGHT_TV.SALES.VIEWERSHIP as b
on a.userid=b.userid
group by race
order by user_count desc;

------------------------------------------------
--displaying total watch time per channel

SELECT a.channel2, count(a.duration2) AS total_minutes
from BRIGHT_TV.SALES.VIEWERSHIP as a
inner join BRIGHT_TV.SALES.USER_PROFILES as b
on  a.userid = b.userid,
GROUP BY channel2 
ORDER BY total_minutes DESC;
----------------------------------------------------

select a.userid,
a.name,
a.surname,
a.gender,
a.race,
a.age,
a.province,
b.channel2,
CASE 
when a.age between 0 and 18 then 'Child'
when a.age between 19 and 59 then 'Adult'
when a.age between 60 and 114 then 'Elderly'
else 'Unknown'
end as age_group,
b.duration2,
case 
when b.duration2 ='00:00:00' then 'mid_nght'
when b.duration2 between '00:01:00' and '11:00:00' then 'morning'
else 'unknown'
end as watch_duration,
b.recorddate2,
case
when b.recorddate2 between '2016/01/01 00:00:00' and '2016/01/31 23:59:59' then 'january'
when b.recorddate2 between '2016/02/01 00:00:00' and '2016/02:29 23:59:59' then 'february'
when b.recorddate2 between '2016/03/01 00:00:00' and '2016/03/31 23:59:59' then 'march'
else 'unknown'
end as datetime_classification,
count(a.userid) over() as number_of_viewers
FROM BRIGHT_TV.SALES.USER_PROFILES AS a 
inner join BRIGHT_TV.SALES.VIEWERSHIP AS b
ON a.userid = b.userid;
----------------------------------------


 

