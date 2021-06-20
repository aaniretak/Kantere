use hotel;

/*χώροι που επισκέφθηκε άτομο με covid*/
select visit.room_id, entrance_time, exit_time
from (visit inner join room on visit.room_id = room.room_id) 
where visit.nfc_id = '12301';


/*ποιοι μολύνθηκαν*/
with covid_room as
(select visit.room_id, entrance_time as covid_entrance, exit_time as covid_exit
from (visit inner join room on visit.room_id = room.room_id) 
where visit.nfc_id = '12301')
select distinct nfc_id
from visit inner join covid_room on visit.room_id = covid_room.room_id
where (entrance_time >= covid_entrance and entrance_time <= covid_exit) 
or 
(covid_entrance >= entrance_time and covid_entrance <= exit_time)
or
(entrance_time >= covid_exit and datediff(hour, covid_exit, entrance_time) <= 1)
except
select nfc_id
from customer 
where nfc_id = '12301'



/*πιο πολυσύχναστοι χώροι ανά ηλικιακή ομάδα*/

/*τον τελευταίο χρόνο*/
/*20-40*/

with cust as
(select nfc_id
from customer
where year(getdate()) - year(customer.date_of_birth) >= 20 and year(getdate()) - year(customer.date_of_birth) <= 40),
vis as
(select nfc_id, room_id
from visit
where datediff(year, visit.entrance_time, getdate()) <= 1)
select top 3 vis.room_id, count(vis.nfc_id) as total_visits_per_year
from cust inner join vis on cust.nfc_id = vis.nfc_id
where room_id not like 'X%'
group by vis.room_id
having count(vis.nfc_id) > 0
order by count(vis.nfc_id) desc


/*τον τελευταίο μήνα*/
/*20-40*/
with cust as
(select nfc_id
from customer
where year(getdate()) - year(customer.date_of_birth) >= 20 and year(getdate()) - year(customer.date_of_birth) <= 40),
vis as 
(select nfc_id, room_id, entrance_time
from visit
where datediff(month, visit.entrance_time, getdate()) <= 1)
select top 3 vis.room_id, count(vis.nfc_id) as total_visits_per_month
from cust inner join vis on cust.nfc_id = vis.nfc_id 
where room_id not like 'X%'
group by vis.room_id
having count(vis.nfc_id) > 0
order by count(vis.nfc_id) desc


/*τον τελευταίο χρόνο*/
/*41-60*/
with cust as
(select nfc_id
from customer
where year(getdate()) - year(customer.date_of_birth) >= 41 and year(getdate()) - year(customer.date_of_birth) <= 60),
vis as
(select nfc_id, room_id, entrance_time
from visit
where datediff(year, visit.entrance_time, getdate()) <= 1)
select top 3 vis.room_id, count(vis.nfc_id) as total_visits_per_year
from cust inner join vis on cust.nfc_id = vis.nfc_id
where room_id not like 'X%'
group by vis.room_id
having count(vis.nfc_id) > 0
order by count(vis.nfc_id) desc


/*τον τελευταίο μήνα*/
/*41-60*/
with cust as
(select nfc_id
from customer
where year(getdate()) - year(customer.date_of_birth) >= 41 and year(getdate()) - year(customer.date_of_birth) <= 60),
vis as 
(select nfc_id, room_id, entrance_time
from visit
where datediff(month, visit.entrance_time, getdate()) <= 1)
select top 3 vis.room_id, count(vis.nfc_id) as total_visits_per_month
from cust inner join vis on cust.nfc_id = vis.nfc_id 
where room_id not like 'X%'
group by vis.room_id
having count(vis.nfc_id) > 0
order by count(vis.nfc_id) desc


/*τον τελευταίο χρόνο*/
/*61+*/
with cust as
(select nfc_id
from customer
where year(getdate()) - year(customer.date_of_birth) >= 61),
vis as
(select nfc_id, room_id
from visit
where datediff(year, visit.entrance_time, getdate()) <= 1)
select top 3 vis.room_id, count(vis.nfc_id) as total_visits_per_year
from cust inner join vis on cust.nfc_id = vis.nfc_id
where room_id not like 'X%'
group by vis.room_id
having count(vis.nfc_id) > 0
order by count(vis.nfc_id) desc


/*τον τελευταίο μήνα*/
/*61+*/
with cust as
(select nfc_id
from customer
where year(getdate()) - year(customer.date_of_birth) >= 61),
vis as 
(select nfc_id, room_id
from visit
where datediff(month, visit.entrance_time, getdate()) <= 1)
select top 3 vis.room_id, count(vis.nfc_id) as total_visits_per_month
from cust inner join vis on cust.nfc_id = vis.nfc_id 
where room_id not like 'X%'
group by vis.room_id
having count(vis.nfc_id) > 0
order by count(vis.nfc_id) desc

/*οι συχνότερα χρησιμοποιούμενες υπηρεσίες*/

/*τον τελευταίο χρόνο*/
/*20-40*/
with cust as 
(select nfc_id
from customer
where year(getdate()) - year(customer.date_of_birth) >= 20 and year(getdate()) - year(customer.date_of_birth) <= 40),
vis as 
(select nfc_id, room_id
from visit
where datediff(year, visit.entrance_time, getdate()) <= 1)
select top 3 service_id, count(vis.nfc_id) as visits_per_year
from (cust inner join vis on cust.nfc_id = vis.nfc_id
inner join provided on provided.room_id = vis.room_id)
group by service_id
having count(vis.nfc_id) > 0
order by count(vis.nfc_id) desc


/*τον τελευταίο μήνα*/
/*20-40*/
with cust as 
(select nfc_id
from customer
where year(getdate()) - year(customer.date_of_birth) >= 20 and year(getdate()) - year(customer.date_of_birth) <= 40),
vis as 
(select nfc_id, room_id
from visit
where datediff(month, visit.entrance_time, getdate()) <= 1)
select top 3 service_id, count(vis.nfc_id) as visits_per_month
from (cust inner join vis on cust.nfc_id = vis.nfc_id
inner join provided on provided.room_id = vis.room_id)
group by service_id
having count(vis.nfc_id) > 0
order by count(vis.nfc_id) desc


/*τον τελευταίο χρόνο*/
/*41-60*/
with cust as 
(select nfc_id
from customer
where year(getdate()) - year(customer.date_of_birth) >= 41 and year(getdate()) - year(customer.date_of_birth) <= 60),
vis as 
(select nfc_id, room_id, entrance_time
from visit
where datediff(year, visit.entrance_time, getdate()) <= 1)
select top 3 service_id, count(vis.nfc_id) as visits_per_year
from (cust inner join vis on cust.nfc_id = vis.nfc_id
inner join provided on provided.room_id = vis.room_id)
group by service_id
having count(vis.nfc_id) > 0
order by count(vis.nfc_id) desc


/*τον τελευταίο μήνα*/
/*41-60*/
with cust as 
(select nfc_id
from customer
where year(getdate()) - year(customer.date_of_birth) >= 41 and year(getdate()) - year(customer.date_of_birth) <= 60),
vis as 
(select nfc_id, room_id, entrance_time
from visit
where datediff(month, visit.entrance_time, getdate()) <= 1)
select top 3 service_id, count(vis.nfc_id) as visits_per_month
from (cust inner join vis on cust.nfc_id = vis.nfc_id
inner join provided on provided.room_id = vis.room_id)
group by service_id
having count(vis.nfc_id) > 0
order by count(vis.nfc_id) desc


/*τον τελευταίο χρόνο*/
/*61+*/
with cust as 
(select nfc_id
from customer
where year(getdate()) - year(customer.date_of_birth) >= 61),
vis as 
(select nfc_id, room_id, entrance_time
from visit
where datediff(year, visit.entrance_time, getdate()) <= 1)
select top 3 service_id, count(vis.nfc_id) as visits_per_year
from (cust inner join vis on cust.nfc_id = vis.nfc_id
inner join provided on provided.room_id = vis.room_id)
group by service_id
having count(vis.nfc_id) > 0
order by count(vis.nfc_id) desc


/*τον τελευταίο μήνα*/
/*61+*/
with cust as 
(select nfc_id
from customer
where year(getdate()) - year(customer.date_of_birth) >= 61),
vis as 
(select nfc_id, room_id, entrance_time
from visit
where datediff(month, visit.entrance_time, getdate()) <= 1)
select top 3 service_id, count(vis.nfc_id) as visits_per_month
from (cust inner join vis on cust.nfc_id = vis.nfc_id
inner join provided on provided.room_id = vis.room_id)
group by service_id
having count(vis.nfc_id) > 0
order by count(vis.nfc_id) desc


/*οι υπηρεσίες που χρησιμοποιούνται από τους περισσότερους πελάτες*/

/*τον τελευταίο χρόνο*/
/*20-40*/
with cust as 
(select nfc_id
from customer
where year(getdate()) - year(customer.date_of_birth) >= 20 and year(getdate()) - year(customer.date_of_birth) <= 40),
vis as 
(select nfc_id, room_id
from visit
where datediff(year, visit.entrance_time, getdate()) <= 1)
select top 3 service_id, count(vis.nfc_id) as visits_per_year
from (cust inner join vis on cust.nfc_id = vis.nfc_id
inner join provided on provided.room_id = vis.room_id)
group by service_id
having count(vis.nfc_id) > 0
order by count(vis.nfc_id) desc


/*τον τελευταίο μήνα*/
/*20-40*/
with cust as 
(select nfc_id
from customer
where year(getdate()) - year(customer.date_of_birth) >= 20 and year(getdate()) - year(customer.date_of_birth) <= 40),
vis as 
(select nfc_id, room_id
from visit
where datediff(month, visit.entrance_time, getdate()) <= 1)
select top 3 service_id, count(vis.nfc_id) as visits_per_month
from (cust inner join vis on cust.nfc_id = vis.nfc_id
inner join provided on provided.room_id = vis.room_id)
group by service_id
having count(vis.nfc_id) > 0
order by count(vis.nfc_id) desc


/*τον τελευταίο χρόνο*/
/*41-60*/
with cust as 
(select nfc_id
from customer
where year(getdate()) - year(customer.date_of_birth) >= 41 and year(getdate()) - year(customer.date_of_birth) <= 60),
vis as 
(select nfc_id, room_id, entrance_time
from visit
where datediff(year, visit.entrance_time, getdate()) <= 1)
select top 3 service_id, count(vis.nfc_id) as visits_per_year
from (cust inner join vis on cust.nfc_id = vis.nfc_id
inner join provided on provided.room_id = vis.room_id)
group by service_id
having count(vis.nfc_id) > 0
order by count(vis.nfc_id) desc


/*τον τελευταίο μήνα*/
/*41-60*/
with cust as 
(select nfc_id
from customer
where year(getdate()) - year(customer.date_of_birth) >= 41 and year(getdate()) - year(customer.date_of_birth) <= 60),
vis as 
(select nfc_id, room_id, entrance_time
from visit
where datediff(month, visit.entrance_time, getdate()) <= 1)
select top 3 service_id, count(vis.nfc_id) as visits_per_month
from (cust inner join vis on cust.nfc_id = vis.nfc_id
inner join provided on provided.room_id = vis.room_id)
group by service_id
having count(vis.nfc_id) > 0
order by count(vis.nfc_id) desc


/*τον τελευταίο χρόνο*/
/*61+*/
with cust as 
(select nfc_id
from customer
where year(getdate()) - year(customer.date_of_birth) >= 61),
vis as 
(select nfc_id, room_id, entrance_time
from visit
where datediff(year, visit.entrance_time, getdate()) <= 1)
select top 3 service_id, count(vis.nfc_id) as visits_per_year
from (cust inner join vis on cust.nfc_id = vis.nfc_id
inner join provided on provided.room_id = vis.room_id)
group by service_id
having count(vis.nfc_id) > 0
order by count(vis.nfc_id) desc


/*τον τελευταίο μήνα*/
/*61+*/
with cust as 
(select nfc_id
from customer
where year(getdate()) - year(customer.date_of_birth) >= 61),
vis as 
(select nfc_id, room_id, entrance_time
from visit
where datediff(month, visit.entrance_time, getdate()) <= 1)
select top 3 service_id, count(vis.nfc_id) as visits_per_month
from (cust inner join vis on cust.nfc_id = vis.nfc_id
inner join provided on provided.room_id = vis.room_id)
group by service_id
having count(vis.nfc_id) > 0
order by count(vis.nfc_id) desc


/*οι υπηρεσίες που χρησιμοποιούνται από τους περισσότερους πελάτες*/

/*τον τελευταίο χρόνο*/
/*20-40*/
with cust as
(select nfc_id
from customer 
where year(getdate()) - year(customer.date_of_birth) >= 20 and year(getdate()) - year(customer.date_of_birth) <= 40),
vis as
(select nfc_id, room_id
from visit
where datediff(year, visit.entrance_time, getdate()) <= 1)
select top 3 service_id, count(distinct vis.nfc_id) as num_of_visitors_per_year
from (cust inner join vis on cust.nfc_id = vis.nfc_id
inner join provided on provided.room_id = vis.room_id)
group by service_id
order by count(distinct vis.nfc_id) desc

/*τον τελευταίο μήνα*/
/*20-40*/
with cust as
(select nfc_id
from customer 
where year(getdate()) - year(customer.date_of_birth) >= 20 and year(getdate()) - year(customer.date_of_birth) <= 40),
vis as
(select nfc_id, room_id
from visit
where datediff(month, visit.entrance_time, getdate()) <= 1)
select top 3 service_id, count(distinct vis.nfc_id) as num_of_visitors_per_month
from (cust inner join vis on cust.nfc_id = vis.nfc_id
inner join provided on provided.room_id = vis.room_id)
group by service_id
order by count(distinct vis.nfc_id) desc


/*τον τελευταίο χρόνο*/
/*41-60*/
with cust as
(select nfc_id
from customer 
where year(getdate()) - year(customer.date_of_birth) >= 41 and year(getdate()) - year(customer.date_of_birth) <= 60),
vis as
(select nfc_id, room_id
from visit
where datediff(year, visit.entrance_time, getdate()) <= 1)
select top 3 service_id, count(distinct vis.nfc_id) as num_of_visitors
from (cust inner join vis on cust.nfc_id = vis.nfc_id
inner join provided on provided.room_id = vis.room_id)
group by service_id
order by count(distinct vis.nfc_id) desc


/*τον τελευταίο μήνα*/
/*41-60*/
with cust as
(select nfc_id
from customer 
where year(getdate()) - year(customer.date_of_birth) >= 41 and year(getdate()) - year(customer.date_of_birth) <= 60),
vis as
(select nfc_id, room_id
from visit
where datediff(month, visit.entrance_time, getdate()) <= 1)
select top 3 service_id, count(distinct vis.nfc_id) as num_of_visitors
from (cust inner join vis on cust.nfc_id = vis.nfc_id
inner join provided on provided.room_id = vis.room_id)
group by service_id
order by count(distinct vis.nfc_id) desc


/*τον τελευταίο χρόνο*/
/*61+*/
with cust as
(select nfc_id
from customer 
where year(getdate()) - year(customer.date_of_birth) >= 61),
vis as
(select nfc_id, room_id
from visit
where datediff(year, visit.entrance_time, getdate()) <= 1)
select top 3 service_id, count(distinct vis.nfc_id) as num_of_visitors
from (cust inner join vis on cust.nfc_id = vis.nfc_id
inner join provided on provided.room_id = vis.room_id)
group by service_id
order by count(distinct vis.nfc_id) desc


/*τον τελευταίο μήνα*/
/*61+*/
with cust as
(select nfc_id
from customer 
where year(getdate()) - year(customer.date_of_birth) >= 61),
vis as
(select nfc_id, room_id
from visit
where datediff(month, visit.entrance_time, getdate()) <= 1)
select top 3 service_id, count(distinct vis.nfc_id) as num_of_visitors
from (cust inner join vis on cust.nfc_id = vis.nfc_id
inner join provided on provided.room_id = vis.room_id)
group by service_id
order by count(distinct vis.nfc_id) desc
