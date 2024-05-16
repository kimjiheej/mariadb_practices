-- DDL/DML 


drop table member;

create table member(
      no int not null auto_increment, 
      email varchar(200) not null default '', 
      password varchar(64) not null, 
      name varchar(50) not null, 
      department varchar(100), 
      primary key(no)
);

desc member;

alter table member add column juminbunho char(13) not null; 

alter table member drop juminbunho;

alter table member add column juminbunho char(13) not null after email;

alter table member change column department dept varchar(100) not null; 

alter table member add column self_intro text; 

alter table member drop juminbunho; 
desc member;

-- insert 
insert into member values (null, 'glp0509@naver.com', password('1234'), '김지희', '개발팀', null);

select * from member;

insert into member(no, email, name, dept, password) values (null,'glp0509@naer.com','김지희','개발팀2', password('1234'));
select * from member;

-- update 
update member 
set email='glp0509@naver.com', password=password('4321') 
where no = 2;

select * from member;

delete from member where no=2; 

select * from member;

-- transaction (insert.update.delete) 

select no, email from member;

select @@autocommit; -- 1 

insert into member (no,email,name,dept,password) 
values(null,'glp0509@naver.com','김지희2','개발팀2', password('1234'));


select no, email from member;

-- tx begin 
set autocommit = 0; 
select @@autocommit; -- 0 

insert into member (no,email,name,dept,password) 
values(null,'glp0509@naver.com','김지희3','개발팀3', password('1234'));

insert into member (no,email,name,dept,password) 
values(null,'glp0509@naver.com','김지희4','개발팀4', password('1234'));

-- tx end 
commit;

























