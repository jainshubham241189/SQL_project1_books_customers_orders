create table books(
    book_id int primary key,
    title varchar(100) not null,
    author varchar(50),
    genre varchar(50),
    published_year in,
    price numeric(10,2),
    stock int
);

create table customers(
    customer_id serial primary key,
    name varchar(50) not null,
    email varchar(50),
    phone varchar(15),
    city varchar(50),
    country varchar(50)

);

create table orders(
    order_id serial primary key,
    customer_id int references customers(customer_id),
    book_id int references books(book_id),
    order_date date,
    quantity int,
    total_price numeric(10,2),
    status varchar(20)
);

copy 
customers(customer_id, name, email, phone, city, country) 
from 'C:\Users\Shubham Jain\Desktop\sql_practice\Customers.csv' 
delimiter ','
csv header;

copy 
books(book_id, title, author, genre, published_year, price, stock)
from 'C:\Users\Shubham Jain\Desktop\sql_practice\Books.csv'
delimiter ','
csv header;

copy 
orders(order_id, customer_id, book_id, order_date, quantity, total_price, status)
from 'C:\Users\Shubham Jain\Desktop\sql_practice\Orders.csv'
delimiter ','
csv header;


select * from books
select * from customers
select * from orders

--1.retrive all book in fiction genre

select * from books where genre='Fiction'

--2.find book published after the year 1950

select * from books where published_year>=1950

--3.list all customers from the canda
select name, email, country from customers
where country='Canada'

--4.show order placed in november 2023

select * from orders
where order_date between '2023-11-01' and '2023-11-30'

--5.retrieve the total stock of books available 

select sum(stock) as total_stock from books

--6.find the details of the most expensive book

select * from books
order by price desc limit 1;

--7.show all customer who ordered more than 1 quantity of a book
select * from books
select * from customers
select * from orders

select * from orders
where quantity>1

--8.retrieve all orders where the  total amount exceed 20

select * from orders
where total_amount>20

--9.list all the genres available in the books table

select distinct(genre) as dis_genre from books

--10.find the book with the lowest stock

select * from books
order by stock  limit 10

--11.calculate total revenue generated from all orders

select sum(total_amount) as total_revenue from orders


--Advance question--------------

--1.retrieve the total number of books sold for each genre

select * from books
select * from customers
select * from orders

select b.genre, sum(o.quantity) as total_quantity 
from books b
join orders o
on b.book_id=o.book_id
group by b.genre

--2.find the average price of book in the fantasy genre

select avg(price) as avg_price
from books
where genre='Fantasy'

--3.list customers who have placed atleast 2 order

select * from customers
select * from orders

/*select c.name, o.quantity
from orders o
join customers c on c.customer_id=o.customer_id
where quantity>=2
*/

select customer_id, count(order_id) as total_order
from orders
group by customer_id
having count(order_id)>=2

select o.customer_id, c.name, count(o.order_id) as total_order
from orders o
join customers c on o.customer_id=c.customer_id
group by o.customer_id, c.name
having count(o.order_id)>=2

--4.find most frequently order book
select book_id, count(order_id) as order_count
from orders
group by book_id
order by order_count desc limit 1

select * from books

select o.book_id,b.title, count(o.order_id) as order_count
from orders o
join books b on o.book_id=b.book_id
group by o.book_id, b.title
order by order_count desc limit 1

--5.show all the top 3 most expensive books of fantsy genre

select * from books
where genre='Fantasy'
order by price desc limit  3

--6.Retrieve the total quantiy of books sold by each author
select * from books
select * from customers
select * from orders

select b.author, sum(o.quantity) as total_books_sold
from orders o
join books b on o.book_id= b.book_id
group by b.author

--7. list the cities where customers who spent over 30 are located

select * from books
select * from customers
select * from orders

select distinct c.city, o.total_amount
from customers c
join orders o on c.customer_id=o.customer_id
where o.total_amount>30

--find the customer who spent the most on orders

select c.customer_id, c.name,sum(o.total_amount) as total_expensis
from customers c
join orders o on c.customer_id=o.customer_id
group by c.customer_id,c.name
order by sum(o.total_amount) desc limit 1











