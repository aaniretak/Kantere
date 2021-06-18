/*INDEXES*/

use hotel;

create index entr_time_ind 
on visit(entrance_time)

create index serv_type_ind 
on serv(service_type)

create index charge_ind
on service_charge(charge_amount)