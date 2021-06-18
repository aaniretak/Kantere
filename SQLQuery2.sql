/*VIEWS*/

use hotel;

create view services_sales as
select nfc_id, charging_time, charge_amount, service_type
from service_charge inner join serv on service_charge.service_id = serv.service_id;

create view customers_view as
select first_name, last_name, mail, phone_num
from customer 
inner join email on customer.nfc_id = email.nfc_id
inner join phone on phone.nfc_id = email.nfc_id;

