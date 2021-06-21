/*TRIGGER - access - visit*/

create trigger access_to_visit
before insert on visit
for each row 
begin 
     if ((new.nfc_id, new.room_id) not in 
       (select nfc_id, room_id
       from access inner join)
     ) then
      print 'Δεν είστε εγγεγραμμένος στην υπηρεσία που προσφέρει αυτό το δωμάτιο.'
     end if
end
