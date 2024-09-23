select * from books;
select * from employees ;
select * from return_status ; 
SELECT * from issued_status ;
select * from branch ;
select * from members ;


/* Create a New Book Record -- "978-1-60129-456-2', 
'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')"*/
insert into books 
values('978-1-60129-456-2' ,'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.');
select * from books ;

--Update an Existing Member's Address
UPDATE members
set member_address = '124 Main St'
where member_id = 'C101' ;
select * from members ;

-- Delete a Record from the Issued Status Table 
-- Objective: Delete the record with issued_id = 'IS121' from the issued_status table.

delete from issued_status
where issued_id = 'IS121' ;

select * from issued_status 
where issued_id = 'IS121' ;

-- List Members Who Have Issued More Than One Book 
SELECT
    issued_emp_id,
    COUNT(*)
FROM issued_status
GROUP BY 1
HAVING COUNT(*) > 1

--Create Summary Tables: Used CTAS to generate new tables based on query results - each book and total book_issued_cnt
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

--Find Total Rental Income by Category:
select 
	b.category ,
	sum(b.rental_price) 
from books b
join issued_status ist
on b.isbn = ist.issued_book_isbn
GROUP by 1	;


-- List Members Who Registered in the Last 180 Days:
select * from members 
where reg_date >= current_date - interval '180 days';



-- List Employees with Their Branch Manager's Name and their branch details:
select 
	em.*,
	br.manager_id ,
	em2.emp_name as manger_name
from employees em
join branch br
on em.branch_id = br.branch_id
join employees em2
on br.manager_id = em2.emp_id;

--Create a Table of Books with Rental Price Above a Certain Threshold:
CREATE TABLE expensive_books AS
SELECT * FROM books
WHERE rental_price > 7.00;

select *from expensive_books ;

--Retrieve the List of Books Not Yet Returned



select * 
from return_status rs
join issued_status ist
on ist.issued_id = rs.issued_id 
where return_id is null ;
