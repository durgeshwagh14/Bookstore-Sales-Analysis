create database onlinebookstore_db;
use onlinebookstore_db;
show tables;

select * from books;
select * from customers;
SELECT * FROM orders;

-- Basic Level: 
-- 1. Retrieve all books in the “Fiction” genre. 
select * from books where Genre = "Fiction";

-- 2. Find books published after the year 1950. 
select * from books where Published_Year >= 1950;

-- 3. List all customers from Canada. 
select * from customers where Country = "Canada";

-- 4. Show orders placed in November 2023. 
select * from orders where Order_Date like "2023-11%";

-- 5. Retrieve the total stock of books available. 
select sum(Stock) as Total_Stock_of_Books from books;
 
-- 6. Find the details of the most expensive book. 
SELECT * FROM books WHERE Price = (SELECT MAX(Price) FROM books);

-- 7. Show all customers who ordered more than 1 quantity of a book.
SELECT DISTINCT c.*
FROM customers c
JOIN orders o ON c.Customer_ID = o.Customer_ID
WHERE o.Quantity > 1;

-- 8. Retrieve all orders where the total amount exceeds $20. 
select * from orders where Total_Amount > 20;

-- 9. List all distinct genres in the bookstore. 
select distinct Genre from books;

-- 10. Find the book with the lowest stock available. 
SELECT * FROM books WHERE Stock = (SELECT min(Stock) FROM books);

-- 11. Calculate the total revenue from all orders. 
select round(sum(Total_Amount),2) as Total_Revenue from orders;

-- Intermediate Level: 
-- 12. Retrieve the total number of books sold for each genre. 
select Genre, Sum(Stock) as Total_No_of_Book_sold from books group by Genre;

-- 9. List all distinct genres in the bookstore.
select distinct Genre from books;

-- 10. Find the book with the lowest stock available.
select * from books where Stock=(select min(Stock) from books);

-- 11. Calculate the total revenue from all orders.
select sum(Total_Amount) as Total_Revenue from orders;

-- Intermediate Level:
-- 12. Retrieve the total number of books sold for each genre.
SELECT b.Genre, SUM(o.Quantity) AS total_number_of_books_sold
FROM books AS b 
JOIN orders AS o ON b.Book_ID = o.Book_ID
GROUP BY b.Genre;

-- 13. Find the average price of books in the “Fantasy” genre.
select avg(Price) from books where Genre='Fantasy';

-- 14. List customers who have placed at least 2 orders.
select c.Name,o.Quantity from customers as c
join orders as o
on c.Customer_ID 
where c.Quantity>=2;

-- 15. Find the most frequently ordered book.
SELECT b.Title, SUM(o.Quantity) AS total_ordered
FROM orders o
JOIN books b ON o.Book_ID = b.Book_ID
GROUP BY b.Title
ORDER BY total_ordered DESC
LIMIT 1;

-- 16. Show the top 3 most expensive books of the “Fantasy” genre.
SELECT Title, Price
FROM books
WHERE Genre = 'Fantasy'
ORDER BY Price DESC
LIMIT 3;

-- Advanced Level: 
-- 17. Retrieve the total quantity of books sold by each author. 
select b.Author,sum(o.Quantity) as Total_quantity_of_books_sold 
from books as b
join orders as o on b.Book_ID = o.Book_ID
group by b.Author;

-- 18. List the cities of customers who spent over $30. 
select c.City from customers as c
join orders as o on c.Customer_ID = o.Customer_ID
where Total_Amount > 30
group by c.City;

-- 19. Find the customer who spent the most on orders. 
SELECT c.Customer_ID, c.Name, SUM(o.Total_Amount) AS Customer_Total_Amount_Spent
FROM customers c
JOIN orders o ON c.Customer_ID = o.Customer_ID
GROUP BY c.Customer_ID, c.Name
ORDER BY Customer_Total_Amount_Spent DESC
LIMIT 1;


-- 20. Calculate the stock remaining after fulfilling all orders.
SELECT 
    b.Book_ID,
    b.Stock - IFNULL(SUM(o.Quantity), 0) AS Stock_Remaining
FROM books b
LEFT JOIN orders o ON b.Book_ID = o.Book_ID
GROUP BY b.Book_ID;