select version(), current_date, now()  from dual;


-- 수학함수, 사칙연산도 된다. 

select sin(pi()/4), 1+2 * 3 - 4 /5 from dual;

-- 대소문자 구분이 없다. 
SELECT VERSION(), current_DATE(), NOW() From Dual;

-- table 생성 : DDL 
create table pet(
       name varchar(100), 
       owner varchar(50),
       species varchar(20),
       gender char(1),
       birth date,
       death date
);

-- schema 확인 
describe pet;
desc pet;

-- table 삭제 
drop table pet;
show tables;

-- insert :  DML(C) 
insert into pet values ('성탄이','김지희','dog','m','2007-12-25',null);

-- select : DML(R)
select * from pet;

-- update : DML(U) 
update pet set name='성타니' where name='성탄이';








