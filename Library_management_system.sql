-- Create the database
create database library;
use library;

create table Branch (
    Branch_no int primary key,
    Manager_Id int,
    Branch_address varchar(100),
    Contact_no varchar(15)
);

create table Employee (
    Emp_Id int primary key,
    Emp_name varchar(100),
    Position varchar(100),
    Salary decimal(10, 2),
    Branch_no int,
    foreign key (Branch_no) references Branch(Branch_no)
);

create table Books (
    ISBN varchar(20) primary key,
    Book_title varchar(100),
    Category varchar(100),
    Rental_Price decimal(10, 2),
    Status enum('Yes', 'No'),
    Author varchar(100),
    Publisher varchar(100)
);

create table Customer (
    Customer_Id int primary key,
    Customer_name varchar(100),
    Customer_address varchar(120),
    Reg_date date
);

create table IssueStatus (
    Issue_Id int primary key,
    Issued_cust int,
    Issued_book_name varchar(100),
    Issue_date date,
    Isbn_book varchar(20),
	foreign key (Issued_cust) references Customer(Customer_Id),
    foreign key (Isbn_book) references Books(ISBN)
);

create table ReturnStatus (
    Return_Id int primary key,
    Return_cust int,
    Return_book_name varchar(100),
    Return_date date,
    Isbn_book2 varchar(20),
    foreign key (Isbn_book2) references Books(ISBN)
);

insert into Branch (Branch_no, Manager_Id, Branch_address, Contact_no) values 
(1, 11, 'Street 45 Bangalore', '1454567890'),
(2, 12, 'Street 46 Bangalore', '9986543210'),
(3, 13, 'Street 47 Bangalore', '1134334455'),
(4, 14, 'Street 48 Bangalore', '1454334455'),
(5, 15, 'Street 49 Bangalore', '2234334455');
select* from Branch;

insert into Employee (Emp_Id, Emp_name, Position, Salary, Branch_no) values 
(11, 'Divya Sarath', 'Manager', 60000, 1),
(12, 'Rajesh Shankar', 'Manager', 55000, 2),
(13, 'Rani Manoj', 'Manager', 52000, 3),
(14, 'Manav Singh', 'Librarian', 45000, 4),
(15, 'Mahesh Swaraj', 'Clerk', 30000, 5);
select* from Employee;

insert into Books (ISBN, Book_title, Category, Rental_Price, Status, Author, Publisher) values 
('ISBN001', 'Alices Adventures in Wonderland', 'Novel', 130.00, 'Yes', 'Lewis Carroll', 'abcd'),
('ISBN002', 'Advanced Mathematics', 'Education', 125.00, 'Yes', 'Jane Roe', 'efgh'),
('ISBN003', 'The Covenant of Water', 'Fiction', 120.00, 'No', 'Abraham Verghese', 'ijkl'),
('ISBN004', 'Beautiful World, Where Are You', 'Fiction', 120.00, 'No', 'Sally Rooney', 'mnop'),
('ISBN005', 'Modern Art Explained', 'Art', 135.00, 'Yes', 'Picasso', 'qrst');
select* from Books;

insert into Customer (Customer_Id, Customer_name, Customer_address, Reg_date) values 
(31, 'Sony Thomas', 'Street 1, Mumbai', '2021-12-20'),
(32, 'Anil Samuel', 'Street 2, Mumbai', '2022-05-15'),
(33, 'Raj Mohan', 'Street 3, Mumbai', '2022-05-15'),
(34, 'Praveen Raj', 'Street 4, Mumbai', '2022-05-15'),
(35, 'Akhila Dev', 'Street 5, Mumbai', '2020-11-10');
select* from Customer;

insert into IssueStatus (Issue_Id, Issued_cust, Issued_book_name, Issue_date, Isbn_book) values 
(1001, 31, 'Alices Adventures in Wonderland', '2023-06-15', 'ISBN001'),
(1002, 32, 'Advanced Mathematics', '2023-06-16', 'ISBN002'),
(1003, 33, 'The Covenant of Water', '2023-06-17', 'ISBN003'),
(1004, 34, 'Modern Art Explained', '2023-06-19', 'ISBN005');
select* from IssueStatus;

insert into ReturnStatus (Return_Id, Return_cust, Return_book_name, Return_date, Isbn_book2) values 
(3001, 31, 'Alices Adventures in Wonderland', '2023-06-25', 'ISBN001'),
(3002, 32, 'Advanced Mathematics', '2023-06-26', 'ISBN002'),
(3003, 33, 'The Covenant of Water', '2023-06-27', 'ISBN003');
select* from ReturnStatus;

/*Retrieve the book title, category, and rental price of all available books*/
select Book_title, Category, Rental_Price from Books where Status = 'Yes';

/*List the employee names and their respective salaries in descending order of salary*/
select Emp_name, Salary from Employee order by Salary desc;

/*Retrieve the book titles and the corresponding customers who have issued those books*/
select B.Book_title, C.Customer_name from IssueStatus I
join Books B on I.Isbn_book = B.ISBN
join Customer C on I.Issued_cust = C.Customer_Id;

/*Display the total count of books in each category*/
select Category, count(*) as Total_Books from Books group by Category;

/*Retrieve the employee names and their positions for the employees whose salaries 
are above Rs.50,000*/
select Emp_name, Position from Employee where Salary > 50000;

/* List the customer names who registered before 2022-01-01 and have not issued any books yet*/
select C.Customer_name from Customer C 
left join IssueStatus I on C.Customer_Id = I.Issued_cust
where C.Reg_date < '2022-01-01' and I.Issue_Id is null;

/*Display the branch numbers and the total count of employees in each branch*/
select Branch_no, count(*) as Total_Employees from Employee group by Branch_no;

/*Display the names of customers who have issued books in the month of June 2023*/
select C.Customer_name from IssueStatus I
join Customer C on I.Issued_cust = C.Customer_Id
where Issue_date between '2023-06-01' and '2023-06-30';

/*Retrieve book_title from book table containing history*/
select Book_title from Books where Book_title like '%history%';

/*Retrieve the branch numbers along with the count of employees for branches 
having more than 5 employees*/
select Branch_no, count(*) as Total_Employees from Employee group by Branch_no having
count(*) > 5;

/*Retrieve the names of employees who manage branches and their respective branch addresses*/
select E.Emp_name, B.Branch_address from Employee E
join Branch B on E.Emp_Id = B.Manager_Id;

/*Display the names of customers who have issued books with a rental price higher than Rs. 25*/
select distinct C.Customer_name from IssueStatus I
join Books B on I.Isbn_book = B.ISBN
join Customer C on I.Issued_cust = C.Customer_Id where B.Rental_Price > 25;








