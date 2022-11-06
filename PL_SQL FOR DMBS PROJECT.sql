--1. Display the name 
declare
U_id USER1.user_id%type:=1701;
U_name USER1.first_Name%type;

begin
Select first_name into U_name
from USER1
where user_id=U_id;
dbms_output.put_line('Employee Name is '||U_name);
end;

--2.Under age checking from database
declare
EE_id USER1.user_id%type:=1702;
EE_name USER1.first_name%type;
EE_age USER1.age%type;

begin
Select first_name, age into EE_name,EE_age
from USER1
where user_id=EE_id;
if EE_age<19
  then 
     dbms_output.put_line('Person is under age');
 else
 dbms_output.put_line('Person is not under age');
end if;
end;

---------------------


--3.Courser using
declare 

 EE_id USER1.user_id%type;
 EE_name USER1.first_name%type;
 EE_Addr USER1.state%type;

cursor curs_E is
 select user_id, first_name ,state from USER1 where user_id=1703;
begin
  open curs_E;
    fetch curs_E into EE_id,EE_name,EE_Addr;
     dbms_output.put_line('Name is '||EE_name);
  close curs_E;
end;


---------------------
---4.
cursor curs_E is
    select user_id, first_name, state from USER1 ;
begin
    open curs_E;
    loop
        fetch curs_E into EE_id, EE_name, EE_Addr;
        exit when curs_E%notfound;
            dbms_output.put_line('ID is ' || EE_id ||'with Name' || EE_name);
    end loop;
    close curs_E;
end;

------------
--5.with Table Train
create table  TRAIN
( 
train_no int primary key,  
train_name varchar(50), 
arrival_time varchar(50),  
departure_time varchar(50),  
availability_of_seats char, 
date1 int
)

insert into TRAIN values(12711,'pinakini exp','113000','114000','A',20170410);
insert into TRAIN values(12315,'cormandel exp','124500','125000','B',20170411);
insert into TRAIN values(12235,'khaudu exp','112300','1125400','C',20170412);

declare 
EE_rec TRAIN%rowtype;
begin 
select * into EE_rec 
from TRAIN
where train_no=12711;

dbms_output.put_line('Train Number id is ' || EE_rec.train_no);
dbms_output.put_line('Train Name ' || EE_rec.train_name);
dbms_output.put_line('Alloted seat ' || EE_rec.availability_of_seats);
dbms_output.put_line('Arrival Time ' || EE_rec.arrival_time);
dbms_output.put_line('Departure Time ' || EE_rec.departure_time);
end;

--6. Exceptional handling
create table  TICKET 
( 
ticket_id int primary key,  
user_id int,  
status varchar(30),  
no_of_passengers int,  
train_no int 
)

insert into TICKET values(4001,1701,'Booked',1,12711);
insert into TICKET values(4002,1702,'Booked',1,12315);
insert into TICKET values(4003,1703,'Processing',1,12231);

--(id, user_id, status, no_of passengers, train_no)



DECLARE  
   c_id TICKET.user_id%type ;   
   c_ticket  TICKET.ticket_id%type;  
   c_addr TICKET.status%type;  
BEGIN  
   SELECT  user_id, ticket_id, status INTO  c_id, c_ticket, c_addr  
   FROM TICKET  
   WHERE  user_id= 1703;  
DBMS_OUTPUT.PUT_LINE ('User ID is '||  c_id); 
DBMS_OUTPUT.PUT_LINE ('Name is '||  c_ticket);
DBMS_OUTPUT.PUT_LINE ('With with current status '|| c_addr); 

 
EXCEPTION   
   WHEN no_data_found THEN   
      dbms_output.put_line('No such  Customer!');  
   WHEN others THEN  
      dbms_output.put_line(' Internal Error!');  
END;

----------
--7.Exceptional Handle

create table BOOKING 
(
passenger_id int primary key,  
pnr_no int,  
age int,  
gender char,  
user_id int,  
reservation_status char,  
seat_number varchar(5), 
pname varchar(50),  
ticket_id int,
ticket_price int,
ticket_status varchar(20)
)
insert into BOOKING values(5001,78965,45, 'M',1701,'C','B6-45','ramesh',4001, 10000,'sleeperClass');
insert into BOOKING values(5002,54523,54,'F',1702,'W','B3-21','surekha',4002, 5400, 'GeneralClass');
insert into BOOKING values(5003,89233,64,'F',1703,'W','B3-25','surekha',4002, 4500, 'GeneralClass');


DECLARE  
EE_id BOOKING.user_id%type:=1701;  
EE_name  BOOKING.pname%type;  
EE_addr BOOKING.age%type;
EE_status BOOKING.ticket_status%type;
exception_invalid exception;

BEGIN  

if EE_id<0 then
    raise exception_invalid;
else
  select user_id,pname,age,ticket_status into EE_id,EE_Name,EE_addr,EE_status
  from(select * from BOOKING where ticket_price>3000)
  where user_id=EE_id;
dbms_output.put_line('With User Id '||EE_id ||' '||EE_name ||' who is '||EE_addr ||' years old has '||EE_status ||' ticket ');

end if;

EXCEPTION  
WHEN exception_invalid then
    dbms_output.put_line('id value must be greater than zero');  
When no_data_found then
    dbms_output.put_line('No entries available');
when others then
    dbms_output.put_line('internal error');
END;

-----------------
--8.Tigger

create table BOOKING 
(
passenger_id int primary key,  
pnr_no int,  
age int,  
gender char,  
user_id int,  
reservation_status char,  
seat_number varchar(5), 
pname varchar(50),  
ticket_id int,
ticket_price int,
ticket_status varchar(20)
)

insert into BOOKING values(5001,78965,45, 'M',1701,'C','B6-45','ramesh',4001, 10000,'sleeperClass');
insert into BOOKING values(5002,54523,54,'F',1702,'W','B3-21','surekha',4002, 5400, 'GeneralClass');
insert into BOOKING values(5003,89233,64,'F',1703,'W','B3-25','surekha',4002, 4500, 'GeneralClass');


create or replace trigger trig_1 before update on BOOKING
begin
dbms_output.put_line('record updated');
end;

update BOOKING set ticket_price=ticket_price+1.5 where ticket_price>1000;


