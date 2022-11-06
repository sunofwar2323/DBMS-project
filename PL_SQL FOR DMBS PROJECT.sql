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
--with Table Train
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
