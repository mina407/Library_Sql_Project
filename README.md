#Library Management System using SQL Project
# Project Overview
##### Project Title: Library Management System
##### Database: library_db 

This project demonstrates the implementation of a Library Management System using SQL. It includes creating and managing tables, performing CRUD operations, and executing advanced SQL queries. The goal is to showcase skills in database design, manipulation, and querying.

![](https://github.com/mina407/Library_Sql_Project/blob/main/library.jpg)
 # Objectives
 
1. Set up the Library Management System Database: Create and populate the database with tables for branches, employees, members, books, issued status, and return status.
2. CRUD Operations: Perform Create, Read, Update, and Delete operations on the data.
3. CTAS (Create Table As Select): Utilize CTAS to create new tables based on query results.
4. Advanced SQL Queries: Develop complex queries to analyze and retrieve specific data.

# Project Structure
![](https://github.com/mina407/Library_Sql_Project/blob/main/Schema.png)

* Database Creation: Created a database named library_db.
* Table Creation: Created tables for branches, employees, members, books, issued status, and return status. Each table includes relevant columns and relationships.

```sql
-- Library Mangement System 
create DATABASE library_db;
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
```

