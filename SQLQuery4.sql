/*QUERIES*/

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
select nfc_id
from visit inner join covid_room on visit.room_id = covid_room.room_id
where (entrance_time >= covid_entrance and entrance_time <= covid_exit) 
or 
(entrance_time >= covid_exit and year(covid_exit) = year(entrance_time) and month(covid_exit) = month(entrance_time) and day(covid_exit) = day(entrance_time) and 
datepart(hour, entrance_time) - datepart(hour, covid_exit) < 1 or (datepart(hour, entrance_time) - datepart(hour ,covid_exit) = 1 and 
datepart(minute, entrance_time) + datepart(minute ,covid_exit) <= 60)) 
or
(entrance_time >= covid_exit and year(covid_exit) = year(entrance_time) and month(covid_exit) = month(entrance_time) and day(entrance_time) - day(covid_exit) = 1 and
datepart(hour, entrance_time) <= 1 and datepart(hour, covid_exit) >= 23 and datepart(minute, covid_exit) + datepart(minute, entrance_time) <= 60)
or
(entrance_time >= covid_exit and year(covid_exit) = year(entrance_time) and month(entrance_time) - month(covid_exit) = 1 and day(entrance_time) = 1
and day(covid_exit) = 30 or day(covid_exit) = 31 and datepart(hour, entrance_time) <= 1 and datepart(hour, covid_exit) >= 23 and 
datepart(minute, covid_exit) + datepart(minute, entrance_time) <= 60)
or
(entrance_time >= covid_exit and year(entrance_time) - year(covid_exit) = 1 and month(covid_exit) = 12 and month(entrance_time) = 1 and
datepart(hour, entrance_time) <= 1 and datepart(hour, covid_exit) >= 23 and datepart(minute, covid_exit) + datepart(minute, entrance_time) <= 60)



/*πιο πολυσύχναστοι χώροι ανά ηλικιακή ομάδα*/

/*τον τελευταίο χρόνο*/
/*20-40*/

with cust as
(select nfc_id
from customer
where year(getdate()) - year(customer.date_of_birth) >= 20 or year(getdate()) - year(customer.date_of_birth) <= 41),
vis as
(select nfc_id, room_id
from visit
where year(visit.entrance_time) = year(getdate()) or 
(year(getdate()) - year(visit.entrance_time) = 1 and month(entrance_time) - month(getdate()) >= 0))
select top 3 vis.room_id, count(vis.nfc_id) as total_visits_per_year
from cust inner join vis on cust.nfc_id = vis.nfc_id
group by vis.room_id
having count(vis.nfc_id) > 0
order by count(vis.nfc_id) desc


/*τον τελευταίο μήνα*/
/*20-40*/
with cust as
(select nfc_id
from customer
where year(getdate()) - year(customer.date_of_birth) >= 20 or year(getdate()) - year(customer.date_of_birth) <= 40),
vis as 
(select nfc_id, room_id, entrance_time
from visit
where (month(getdate()) = month(visit.entrance_time) and year(getdate()) = year(visit.entrance_time)) 
or (month(getdate()) - month(visit.entrance_time) = 1 and year(getdate()) = year(visit.entrance_time) and day(getdate()) + day(visit.entrance_time) <= 30) 
or year(getdate()) - year(visit.entrance_time) = 1 and month(getdate()) + month(visit.entrance_time) = 13 and day(getdate()) + day(visit.entrance_time) <= 30)
select top 3 vis.room_id, count(vis.nfc_id) as total_visits_per_month
from cust inner join vis on cust.nfc_id = vis.nfc_id 
group by vis.room_id
having count(vis.nfc_id) > 0
order by count(vis.nfc_id) desc


/*τον τελευταίο χρόνο*/
/*41-60*/
with cust as
(select nfc_id
from customer
where year(getdate()) - year(customer.date_of_birth) >= 41 or year(getdate()) - year(customer.date_of_birth) <= 60),
vis as
(select nfc_id, room_id, entrance_time
from visit
where year(visit.entrance_time) = year(getdate()) or 
(year(getdate()) - year(visit.entrance_time) = 1 and month(entrance_time) - month(getdate()) >= 0))
select top 3 vis.room_id, count(vis.nfc_id) as total_visits_per_year
from cust inner join vis on cust.nfc_id = vis.nfc_id
group by vis.room_id
having count(vis.nfc_id) > 0
order by count(vis.nfc_id) desc


/*τον τελευταίο μήνα*/
/*41-60*/
with cust as
(select nfc_id
from customer
where year(getdate()) - year(customer.date_of_birth) >= 41 or year(getdate()) - year(customer.date_of_birth) <= 60),
vis as 
(select nfc_id, room_id, entrance_time
from visit
where (month(getdate()) = month(visit.entrance_time) and year(getdate()) = year(visit.entrance_time)) 
or (month(getdate()) - month(visit.entrance_time) = 1 and year(getdate()) = year(visit.entrance_time) and day(getdate()) + day(visit.entrance_time) <= 30) 
or year(getdate()) - year(visit.entrance_time) = 1 and month(getdate()) + month(visit.entrance_time) = 13 and day(getdate()) + day(visit.entrance_time) <= 30)
select top 3 vis.room_id, count(vis.nfc_id) as total_visits_per_month
from cust inner join vis on cust.nfc_id = vis.nfc_id 
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
where year(visit.entrance_time) = year(getdate()) or 
(year(getdate()) - year(visit.entrance_time) = 1 and month(entrance_time) - month(getdate()) >= 0))
select top 3 vis.room_id, count(vis.nfc_id) as total_visits_per_year
from cust inner join vis on cust.nfc_id = vis.nfc_id
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
where (month(getdate()) = month(visit.entrance_time) and year(getdate()) = year(visit.entrance_time)) 
or (month(getdate()) - month(visit.entrance_time) = 1 and year(getdate()) = year(visit.entrance_time) and day(getdate()) + day(visit.entrance_time) <= 30) 
or year(getdate()) - year(visit.entrance_time) = 1 and month(getdate()) + month(visit.entrance_time) = 13 and day(getdate()) + day(visit.entrance_time) <= 30)
select top 3 vis.room_id, count(vis.nfc_id) as total_visits_per_month
from cust inner join vis on cust.nfc_id = vis.nfc_id 
group by vis.room_id
having count(vis.nfc_id) > 0
order by count(vis.nfc_id) desc

/*οι συχνότερα χρησιμοποιούμενες υπηρεσίες*/

/*τον τελευταίο χρόνο*/
/*20-40*/
with cust as 
(select nfc_id
from customer
where year(getdate()) - year(customer.date_of_birth) >= 20 or year(getdate()) - year(customer.date_of_birth) <= 40),
vis as 
(select nfc_id, room_id
from visit
where year(visit.entrance_time) = year(getdate()) or 
(year(getdate()) - year(visit.entrance_time) = 1 and month(entrance_time) - month(getdate()) >= 0))
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
where year(getdate()) - year(customer.date_of_birth) >= 20 or year(getdate()) - year(customer.date_of_birth) <= 40),
vis as 
(select nfc_id, room_id
from visit
where (month(getdate()) = month(visit.entrance_time) and year(getdate()) = year(visit.entrance_time)) 
or (month(getdate()) - month(visit.entrance_time) = 1 and year(getdate()) = year(visit.entrance_time) and day(getdate()) + day(visit.entrance_time) <= 30) 
or year(getdate()) - year(visit.entrance_time) = 1 and month(getdate()) + month(visit.entrance_time) = 13 and day(getdate()) + day(visit.entrance_time) <= 30)
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
where year(getdate()) - year(customer.date_of_birth) >= 41 or year(getdate()) - year(customer.date_of_birth) <= 60),
vis as 
(select nfc_id, room_id, entrance_time
from visit
where year(visit.entrance_time) = year(getdate()) or 
(year(getdate()) - year(visit.entrance_time) = 1 and month(entrance_time) - month(getdate()) >= 0))
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
where year(getdate()) - year(customer.date_of_birth) >= 41 or year(getdate()) - year(customer.date_of_birth) <= 60),
vis as 
(select nfc_id, room_id, entrance_time
from visit
where (month(getdate()) = month(visit.entrance_time) and year(getdate()) = year(visit.entrance_time)) 
or (month(getdate()) - month(visit.entrance_time) = 1 and year(getdate()) = year(visit.entrance_time) and day(getdate()) + day(visit.entrance_time) <= 30) 
or year(getdate()) - year(visit.entrance_time) = 1 and month(getdate()) + month(visit.entrance_time) = 13 and day(getdate()) + day(visit.entrance_time) <= 30)
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
where year(visit.entrance_time) = year(getdate()) or 
(year(getdate()) - year(visit.entrance_time) = 1 and month(entrance_time) - month(getdate()) >= 0))
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
where (month(getdate()) = month(visit.entrance_time) and year(getdate()) = year(visit.entrance_time)) 
or (month(getdate()) - month(visit.entrance_time) = 1 and year(getdate()) = year(visit.entrance_time) and day(getdate()) + day(visit.entrance_time) <= 30) 
or year(getdate()) - year(visit.entrance_time) = 1 and month(getdate()) + month(visit.entrance_time) = 13 and day(getdate()) + day(visit.entrance_time) <= 30)
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
where year(getdate()) - year(customer.date_of_birth) >= 20 or year(getdate()) - year(customer.date_of_birth) <= 40),
vis as
(select nfc_id, room_id
from visit
where year(visit.entrance_time) = year(getdate()) or 
(year(getdate()) - year(visit.entrance_time) = 1 and month(entrance_time) - month(getdate()) >= 0))
select top 3 service_id, count(vis.nfc_id) as num_of_visitors_per_year
from (cust inner join vis on cust.nfc_id = vis.nfc_id
inner join provided on provided.room_id = vis.room_id)
group by service_id
order by count(distinct vis.nfc_id) desc

/*τον τελευταίο μήνα*/
/*20-40*/
with cust as
(select nfc_id
from customer 
where year(getdate()) - year(customer.date_of_birth) >= 20 or year(getdate()) - year(customer.date_of_birth) <= 40),
vis as
(select nfc_id, room_id
from visit
where (month(getdate()) = month(visit.entrance_time) and year(getdate()) = year(visit.entrance_time)) 
or (month(getdate()) - month(visit.entrance_time) = 1 and year(getdate()) = year(visit.entrance_time) and day(getdate()) + day(visit.entrance_time) <= 30) 
or (year(getdate()) - year(visit.entrance_time) = 1 and month(getdate()) + month(visit.entrance_time) = 13 and day(getdate()) + day(visit.entrance_time) <= 30))
select top 3 service_id, count(vis.nfc_id) as num_of_visitors_per_month
from (cust inner join vis on cust.nfc_id = vis.nfc_id
inner join provided on provided.room_id = vis.room_id)
group by service_id
order by count(distinct vis.nfc_id) desc


/*τον τελευταίο χρόνο*/
/*41-60*/
with cust as
(select nfc_id
from customer 
where year(getdate()) - year(customer.date_of_birth) >= 41 or year(getdate()) - year(customer.date_of_birth) <= 60),
vis as
(select nfc_id, room_id
from visit
where year(visit.entrance_time) = year(getdate()) or 
(year(getdate()) - year(visit.entrance_time) = 1 and month(entrance_time) - month(getdate()) >= 0))
select top 3 service_id, count(vis.nfc_id) as num_of_visitors
from (cust inner join vis on cust.nfc_id = vis.nfc_id
inner join provided on provided.room_id = vis.room_id)
group by service_id
order by count(distinct vis.nfc_id) desc


/*τον τελευταίο μήνα*/
/*41-60*/
with cust as
(select nfc_id
from customer 
where year(getdate()) - year(customer.date_of_birth) >= 41 or year(getdate()) - year(customer.date_of_birth) <= 60),
vis as
(select nfc_id, room_id
from visit
where (month(getdate()) = month(visit.entrance_time) and year(getdate()) = year(visit.entrance_time)) 
or (month(getdate()) - month(visit.entrance_time) = 1 and year(getdate()) = year(visit.entrance_time) and day(getdate()) + day(visit.entrance_time) <= 30) 
or (year(getdate()) - year(visit.entrance_time) = 1 and month(getdate()) + month(visit.entrance_time) = 13 and day(getdate()) + day(visit.entrance_time) <= 30))
select top 3 service_id, count(vis.nfc_id) as num_of_visitors
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
where year(visit.entrance_time) = year(getdate()) or 
(year(getdate()) - year(visit.entrance_time) = 1 and month(entrance_time) - month(getdate()) >= 0))
select top 3 service_id, count(vis.nfc_id) as num_of_visitors
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
where (month(getdate()) = month(visit.entrance_time) and year(getdate()) = year(visit.entrance_time)) 
or (month(getdate()) - month(visit.entrance_time) = 1 and year(getdate()) = year(visit.entrance_time) and day(getdate()) + day(visit.entrance_time) <= 30) 
or (year(getdate()) - year(visit.entrance_time) = 1 and month(getdate()) + month(visit.entrance_time) = 13 and day(getdate()) + day(visit.entrance_time) <= 30))
select top 3 service_id, count(vis.nfc_id) as num_of_visitors
from (cust inner join vis on cust.nfc_id = vis.nfc_id
inner join provided on provided.room_id = vis.room_id)
group by service_id
order by count(distinct vis.nfc_id) desc