-- Library Mangement System 

-- create branch table
create table branch 
	(
	branch_id varchar(10) PRIMARY key,
	manager_id varchar(10) , 
	branch_address varchar(50),
	contact_no varchar(10)
	) ;

-- create employees table 
drop table if exists employees ;
create table employees 
	(
	emp_id varchar(10) PRIMARY key , 
	emp_name varchar(25) ,
	position varchar(20),
	salary int ,
	branch_id varchar(10) --fk
	);

--create books table 
drop table if exists books ;
create table books 
	(
	isbn varchar(20) PRIMARY key , 
	book_title varchar(75) ,
	category varchar(10) ,
	rental_price float ,
	status varchar(15),
	author varchar(35),
	publisher varchar(55)
	);

-- create members table 
DROP table if exists members ;
create table members 
	(
	member_id varchar(10) PRIMARY key ,
	member_name varchar(25) ,
	member_address varchar(75) , 
	reg_date date 
	) ; 

-- issued_status 
drop table if exists issued_status ;
create table issued_status 
	(
	issued_id varchar(10) PRIMARY key ,
	issued_member_id varchar(10) , --fk
	issued_book_name varchar(75) ,
	issued_date date ,
	issued_book_isbn varchar(5) , --fk
	issued_emp_id varchar(10) --fk
	) ;

-- retuen_table
drop table if exists return_status ;
create table return_status 
	(
	return_id varchar(10) PRIMARY key ,
	issued_id varchar(10) ,--fk
	return_book_name varchar(75),
	return_date	date ,
	return_book_isbn varchar(20)
	);

-- adding foreign key	
alter table issued_status
add constraint fk_members
FOREIGN key(issued_member_id)
REFERENCES members(member_id) ;

alter table issued_status
add constraint fk_books
FOREIGN key(issued_book_isbn)
REFERENCES books(isbn);

alter table issued_status
add constraint fk_employees
FOREIGN key(issued_emp_id)
REFERENCES employees(emp_id);

alter table employees
add constraint fk_branch
FOREIGN key(branch_id)
REFERENCES branch(branch_id);

alter table return_status
add constraint fk_return_stauts
FOREIGN key(issued_id)
REFERENCES issued_status(issued_id);


-- adjusting type of columns in each specific table
ALTER TABLE branch 
ALTER COLUMN contact_no TYPE varchar(25);


alter table books
alter COLUMN category type varchar(25);


alter table issued_status
alter COLUMN issued_book_isbn type varchar(20) ; 

select * from books;
select * from employees ;
select * from return_status ; 
select * from employees ;
SELECT * from issued_status ;
select * from branch ; 
