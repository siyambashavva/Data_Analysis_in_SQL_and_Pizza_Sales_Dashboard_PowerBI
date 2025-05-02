
use [Pizza DB]
-- tablodaki verilerin göüntülenmesi
select * from pizza_sales1;
--1.Sorgu toplam cironun hesaplanması
select SUM(total_price)  as Toplam_Ciro from pizza_sales1;

--2.Sorgu ortalama sipariş değerinin bulunması
select (SUM(total_price) / COUNT(distinct order_id)) as Ortalama_Sipariş_Değeri from pizza_sales1;

--3.Sorgu satılan toplam sipariş pizza sayısının bulunması
select SUM(quantity) as Satılan_Toplam_Pizza_Sayısı from pizza_sales1;

--4.Sorgu toplam sipariş değerinin bulunması
select count(distinct order_id)  as Toplam_Sipariş_Sayısı from pizza_sales1;

--5.Sorgu sipariş başına düşen pizza sayısının bulunması 
select cast(cast(SUM(quantity) as decimal(10,2)) / 
cast (COUNT( distinct order_id) as decimal(10,2)) as decimal(10,2)) as Sipariş_Başına_Düşen_Pizza_Sayısı from pizza_sales1;

--6.Sorgu haftanın günlerine göre toplam sipariş sayısının bulunması
select DATENAME(DW, order_date) as sipariş_günü, COUNT(distinct order_id) as toplam_sipariş_sayısı
from pizza_sales1
group by DATENAME(DW, order_date);

--7.Sorgu günün saatine göre toplam sipariş sayısının bulunması
select DATEPART(HOUR, order_time) as Sipariş_Saati , COUNT(distinct order_id) as Toplam_Sipariş_Sayısı 
from pizza_sales1
group by DATEPART(HOUR, order_time)
order by DATEPART(HOUR, order_time)

--8.Sorgu pizza kategorisine göre satılan toplam pizza miktarının bulunması
select pizza_category, SUM(quantity) as Satılan_Pizza_Miktarı
from pizza_sales1
group by pizza_category

--9.Sorgu pizza isimlerine göre en çok satan 5 pizzanın bulunması
select top 5 pizza_name, SUM(quantity) as Satılan_Pizza_Miktarı
from pizza_sales1
group by pizza_name
order by Satılan_Pizza_Miktarı desc 

--10.Sorgu pizza isimlerine göre en az satan 5 pizzanın bulunması
select top 5 pizza_name, SUM(quantity) as Satılan_Pizza_Miktarı
from pizza_sales1
group by pizza_name
order by Satılan_Pizza_Miktarı asc

-- 11.Sorgu pizza kategorisine göre cirolar ve toplam ciro içindeki yüzdelik dilimleri
select pizza_category, cast(SUM(total_price) as decimal (10,2)) as toplam_ciro,
cast((SUM(total_price)* 100/ (select SUM(total_price) from pizza_sales1)) as decimal(10,2)) as yüzdelik_dilim
from pizza_sales1
group by pizza_category
order by yüzdelik_dilim desc;