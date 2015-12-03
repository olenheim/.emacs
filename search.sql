--================================================================月度数据
-----移动端 搜索用户数
select  count(distinct deviceid)  
from data_raw.tbl_query_hour
where dt>='20140801'  
	and dt<='20140831' 
	and p1='0' 
	and p2 in ('00','01','02','03','07','08','09','0a','0b','0c','0d');
7月 4096164
8月 3716861 
-----M站 搜索用户数
select count (distinct letv_cookie) 
 from data_raw.tbl_pv_hour 
where dt>='20140801' 
  and dt<='20140831' 
  and product='0' 
  and p2='04' 
  and (cur_url like '%wd=%');
6月11962039 
7月20765225
8月23302248
-----TV端（tv版、乐看搜索） 搜索用户数
select  count(distinct letv_cookie) from data_raw.tbl_query_hour 
where dt>='20140801' 
 and dt<='20140831'  
 and p1='2' 
 and (p2='21' or p2='24');
6月 740174 
7月 929898
8月 766460

-----PC端 搜索用户数
select  count(distinct letv_cookie)  from
 data_raw.tbl_query_hour where dt>='20140801'  and dt<='20140831'  and  p1='1' ;
6月12441674
7月13653631
8月 12885769


--========================================================每周数据
-----M站总 搜索次数、搜索用户数
select dt, count(letv_cookie),count(distinct letv_cookie) 
 from data_raw.tbl_pv_hour 
where dt>='20141003' 
  and dt<='20141009' 
  and product='0' 
  and p2='04' 
  and (cur_url like '%wd=%')
group by dt order by dt ;
--------M站本身 搜索次数、搜索用户数
select dt,count(letv_cookie),count(distinct letv_cookie) 
 from data_raw.tbl_pv_hour 
where dt>='20141003' 
  and dt<='20141009'  
  and product='0' 
  and p2='04' 
  and (cur_url like '%wd=%')
  and ref not in ('0101' , '0102' , '0103','0104')
group by dt order by dt ;
--11793656 

--M站-app跳转 搜索次数、搜索用户数
select dt,count(letv_cookie),count(distinct letv_cookie) 
 from data_raw.tbl_pv_hour 
where dt>='20141003' 
  and dt<='20141009'  
  and product='0' 
  and p2='04' 
  and (cur_url like '%wd=%')
  and ref in ('0101' , '0102' , '0103','0104')
group by dt order by dt ;

------移动端按操作系统、终端类型统计
select  tp.dt,tt.os,tt.terminal_id,count(tp.did),count(distinct tp.did) as cnt from
(select dt,deviceid did from data_raw.tbl_query_hour where dt>='20141003' and dt<='20141009'  and product='0' and p1='0' and p2 in ('00','01','02','03','07','08','09','0a','0b','0c','0d') ) tp
left outer join
(select dt,os,terminal_id,app,mac as did from data_raw.tbl_env_hour where dt>='20141003' and dt<='20141009'  and product='0' and p1='0' and p2 in ('00','01','02','03','07','08','09','0a','0b','0c','0d')  group by dt,os,terminal_id,app,mac) tt
on (tp.dt=tt.dt and tp.did=tt.did)
group by tp.dt,tt.os,tt.terminal_id;



select tp.dt, count(tp.did) uv ,count(distinct tp.did) pv from (select dt,deviceid did from tbl_query_hour where dt in ('20141113','20141120') and product = '0' ) tp left outer join (select dt,os,terminal_id,mac as did from data_raw.tbl_env_hour where dt in ('20141113','20141120') and product = '0' and os = 'ios' and terminal_id = 'pad') tt on (tp.dt=tt.dt and tp.did = tt.did) group by tp.dt;


Total MapReduce CPU Time Spent: 0 days 1 hours 24 minutes 5 seconds 730 msec
OK
20141113	94733933	303572
20141120	61685663	130346
Time taken: 293.087 seconds
hive> 
