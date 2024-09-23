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
#### 1. DataBase Setup

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
#### 2.CRUD Operations
1. Create: Inserted sample records into the books table.
2. Read: Retrieved and displayed data from various tables.
3. Update: Updated records in the employees table.
4. Delete: Removed records from the members table as needed.

* Task 1 :- Create a New Book Record -- "978-1-60129-456-2', 
'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')"*/
```sql
insert into books 
values('978-1-60129-456-2' ,'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.');
select * from books ;
```

* Task 2 :_ Update an Existing Member's Address
``` sql
UPDATE members
set member_address = '124 Main St'
where member_id = 'C101' ;
select * from members ;
```

* Task 3 :-Delete a Record from the Issued Status Table Objective: Delete the record with issued_id = 'IS121' from the issued_status table.
``` sql
delete from issued_status
where issued_id = 'IS121' ;

select * from issued_status 
where issued_id = 'IS121' ;
```

* Task 4: Retrieve All Books Issued by a Specific Employee -- Objective: Select all books issued by the employee with emp_id = 'E101'.
```sql
SELECT * FROM issued_status
WHERE issued_emp_id = 'E101'
```
* Task 5: List Members Who Have Issued More Than One Book
```sql 
SELECT
    issued_emp_id,
    COUNT(*)
FROM issued_status
GROUP BY 1
HAVING COUNT(*) > 1
```
#### 3. CTAS (Create Table As Select)
* Task 6: Create Summary Tables: Used CTAS to generate new tables based on query results - each book and total book_issued_cnt**
```sql
create table book_sum
as
select books.isbn ,
		book_title ,
		count(issued_id) as total_number
from books 
join issued_status it
on books.isbn = it.issued_book_isbn
GROUP by 1,2 
order by total_number desc;

select * 
from book_sum ;
```
#### 4. Data Analysis & Findings

* Task 7. Retrieve All Books in a Specific Category
``` sql
 SELECT * FROM books
WHERE category = 'Classic';
```

* Task 8: Find Total Rental Income by Category
 ``` sql
select 
	b.category ,
	sum(b.rental_price) 
from books b
join issued_status ist
on b.isbn = ist.issued_book_isbn
GROUP by 1 ;
```
* Task :-9 List Members Who Registered in the Last 180 Days
```sql
select * from members 
where reg_date >= current_date - interval '180 days';
```
* Task 10:- List Employees with Their Branch Manager's Name and their branch details:

``` sql
select 
	em.*,
	br.manager_id ,
	em2.emp_name as manger_name
from employees em
join branch br
on em.branch_id = br.branch_id
join employees em2
on br.manager_id = em2.emp_id;
```
* Task 11:- Create a Table of Books with Rental Price Above a Certain Threshold:
```sql
CREATE TABLE expensive_books AS
SELECT * FROM books
WHERE rental_price > 7.00;

select *from expensive_books ;
```
* Task 12:- Retrieve the List of Books Not Yet Returned
``` sql
select * 
from return_status rs
join issued_status ist
on ist.issued_id = rs.issued_id 
where return_id is null ;
```
