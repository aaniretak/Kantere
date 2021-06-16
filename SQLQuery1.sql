 create database hotel;

 use hotel;

 create table customer(
 nfc_id int,
 first_name varchar(30), 
 last_name varchar(30) not null,
 doc_number varchar(20) not null,
 doc_type varchar(10),
 iss_auth varchar(30),
 date_of_birth date,
 primary key(nfc_id),
 check (doc_type in ('Ταυτότητα','Διαβατήριο'))
 );

 create table email(
 nfc_id int,
 mail varchar(250),
 primary key(mail),
 foreign key (nfc_id) references customer(nfc_id)
 );
 
 create table phone(
 nfc_id int,
 phone_num tinyint,
 primary key(phone_num),
 foreign key (nfc_id) references customer(nfc_id)
 );

 create table room(
 room_id int, /*φτιαξε τον τυπο ωστε τα πρωτα γραμματα να υπονοουν τον τυπο*/
 num_of_beds numeric(1,0),
 room_name varchar(19),
 room_description varchar(100),
 primary key(room_id),
 check (room_name in ('Δωμάτιο','Ανελκυστήρας','Διάδρομος','Εστιατόριο','Μπαρ','Αίθουσα Συνεδρίασης','Γυμναστήριο','Σάουνα','Κομμωτήριο'))
 );

 create table serv(
 service_id int,
 service_type numeric(1,0), /* 0 αν ΔΕΝ απαιτεί εγγραφή, 1 αλλιώς */
 service_description varchar(100),
 primary key (service_id)
 );

 create table access(
 nfc_id int,
 room_id int,
 start_time smalldatetime not null,
 finish_time smalldatetime not null,
 foreign key (nfc_id) references customer(nfc_id),
 foreign key (room_id) references room(room_id)
 );

 create table registered(
 nfc_id int,
 service_id int,
 registration_time smalldatetime,
 foreign key (nfc_id) references customer(nfc_id),
 foreign key (service_id) references services_av(service_id)
 );

 create table visit(
 nfc_id int,
 room_id int,
 entrance_time smalldatetime not null,
 exit_time smalldatetime not null,
 foreign key (nfc_id) references customer(nfc_id),
 foreign key (room_id) references room(room_id)
 );


 create table provided(
 room_id int,
 service_id int,
 foreign key (service_id) references services_av(service_id),
 foreign key (room_id) references room(room_id)
 );

 create table service_charge(
 charging_time smalldatetime,
 nfc_id int,
 service_id int,
 charge_description varchar(100),
 charge_amount int,
 primary key(charging_time),
 foreign key (nfc_id) references customer(nfc_id),
 foreign key (service_id) references services_av(service_id)
 );
