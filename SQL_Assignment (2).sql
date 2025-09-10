-- Ques 1. Create a table called employees with the following structure
 -- emp_id (integer, should not be NULL and should be a primary key)
 -- emp_name (text, should not be NULL)
 -- age (integer, should have a check constraint to ensure the age is at least 18)
 -- email (text, should be unique for each employee)
 -- salary (decimal, with a default value of 30,000).
-- Write the SQL query to create the above table with all constraints

 CREATE TABLE employees (
    emp_id INT NOT NULL PRIMARY KEY,
    emp_name VARCHAR(50) NOT NULL,
    age INT CHECK (age >= 18),
    email VARCHAR(100) UNIQUE,
    salary DECIMAL(10, 2) DEFAULT 30000
);

-- Ques2. Explain the purpose of constraints and how they help maintain data integrity in a database. Provide examples of common types of constraints.
-- Ans. The purpose of constraints is to protect the data in a database so that it stays accurate, consistent, and meaningful.
-- They act like rules that control what kind of data can be added, updated, or deleted in a table.
-- PRIMARY KEY - Each row in a table is unique.Ex-In a student table student_id is unique
-- FOREIGN KEY:-Connects two tables and ensures data matches. Ex-In an Orders table, customer_id must exist in the Customers table 
-- UNIQUE:- All values in colonm is different.Ex-In a Users table, the email column must be unique
-- NOT NULL:- Prevent empty values in a colunm.Ex-In an Employees table, name cannot be NULL
-- CHECK :- Sets a condition that data must follow.Ex- In a Products table, price must be greater than 0 → you can’t enter negative prices.
-- DEFAULT :-Assigns a default value if nothing is entered.Ex-In an Orders table, if status is not given, it defaults to "Pending".

-- Ques 3..Why would you apply the NOT NULL constraint to a column? Can a primary key contain NULL values? Justify your answer.
-- Ans:- We use NOT NULL when we want to make sure a column always has a value.
-- Example: In a Students table, the name column should not be empty → because a student must have a name.
-- A primary key cannot contain NULL values, because it must uniquely identify every record, and NULL means “unknown/missing,”
--  which would break that rule.

-- Ques 4:- Explain the steps and SQL commands used to add or remove constraints on an existing table. Provide an 
-- example for both adding and removing a constraint. 
-- Ans:-We can add or remove constraints on an existing table using the ALTER TABLE command.
-- 1.Adding a Constraint-
--  ALTER TABLE table_name
--  ADD CONSTRAINT constraint_name constraint_type (column_name);
-- Example :
 CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(100),
    email VARCHAR(100)
);
-- 2. Removing a Constraint-
--  ALTER TABLE table_name
--  DROP CONSTRAINT constraint_name;
-- Example :
 ALTER TABLE employees
 DROP CONSTRAINT uq_email;

-- Ques 5. Explain the consequences of attempting to insert, update, or delete data in a way that violates constraints. 
-- Provide an example of an error message that might occur when violating a constraint.
-- Ans - When you try to insert, update, or delete data that violates a constraint, the database rejects the operation and shows an error. Constraints protect data integrity by preventing invalid values.
-- Examples:
-- NOT NULL → inserting NULL into a required column → error.
-- UNIQUE → inserting duplicate values → error.
-- PRIMARY KEY → duplicate or NULL key → error.
-- FOREIGN KEY → inserting a value that doesn’t exist in the parent table, or deleting a parent row that has child rows → error. 

 -- 6. You created a products table without constraints as follows:
 CREATE TABLE products (
 product_id INT,
 product_name VARCHAR(50),
 price DECIMAL(10, 2));
 select *from products;
 
 -- 7.You have two tables:
 --  Write a query to fetch the student_name and class_name for each student using an INNER JOIN.

 CREATE TABLE students (
 student_id INT,
 student_name varchar(50),
 class_id int
 );
 
 insert into students
 (student_id, student_name, class_id)
 values
 (1, "Alice", 101),
 (2, "Bob", 102),
 (3, "charlie", 101);
 select * from students;
 
 CREATE TABLE classes (
 class_id int,
 class_name varchar(50)
 );
 insert into classes
 (class_id, class_name)
 values
 (101, "Math"),
 (102, "Science"),
 (103, "History");
 
 select * from classes;
 select 
 students.student_name,
 classes.class_name
 from
  students
 inner join
 classes on students.class_id = classes.class_id;
 
-- Ques8. Write a query that shows all order_id, customer_name, and product_name, ensuring that all products are 
-- listed even if they are not associated with an order Hint: (use INNER JOIN and LEFT JOIN).
select order_id, customer_name, product_name
from orders.o
 join products.p on o.customer_id = p.customer_id
 left join products.p on o.order_id = p.order_id;
 

 -- 9.Write a query to find the total sales amount for each product using an INNER JOIN and the SUM() function.
 select product_name.p,sum(s.amount * s.unit_price) as total_sales_amount 
 from sales s
 inner join products p on s.product_id = p.product_id
 group by p.product_name;
 
 -- 10. Write a query to display the order_id, customer_name, and the quantity of products ordered by each 
-- customer using an INNER JOIN between all three tables.
select order_id, customer_name, quantity
from orders o
inner join customers c on o.customer_id = c.customer_id
inner join orders o on od.order_id = o.order_id;

-- SQL COMMONDS:

-- 1-Identify the primary keys and foreign keys in maven movies db. Discuss the differences.
SELECT 
    TABLE_NAME, 
    COLUMN_NAME, 
    CONSTRAINT_NAME
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = 'mavenmovies'
  AND CONSTRAINT_NAME = 'PRIMARY';
  
  SELECT 
    TABLE_NAME, 
    COLUMN_NAME, 
    CONSTRAINT_NAME, 
    REFERENCED_TABLE_NAME, 
    REFERENCED_COLUMN_NAME
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = 'mavenmovies'
  AND REFERENCED_TABLE_NAME IS NOT NULL;

-- 2- List all details of actors.
select * from actor;

-- 3-List all customer information from DB.
select * from customer;

-- 4-List different countries.
select distinct country from country;

--  5-Display all active customers.
select * from customer where active = 1;

-- 6-List of all rental IDs for customer with ID 1.
select rental_id from rental where customer_id = 1;

--  7- Display all the films whose rental duration is greater than 5 .
select * from film where rental_duration>5;

-- 8- List the total number of films whose replacement cost is greater than $15 and less than $20.
select count(*) from film where replacement_cost > 15 and replacement_cost< 20;

-- 9- Display the count of unique first names of actors.
select count(distinct(first_name)) as unique_first_name from actor;

-- 10- Display the first 10 records from the customer table.
select * from customer
record limit 10;

-- 11- Display the first 3 records from the customer table whose first name starts with ‘b’.
select * from customer
where first_name like 'b%'
limit 3;

-- 12-Display the names of the first 5 movies which are rated as ‘G’.
select title from film 
where rating = 'G'
limit 5;

-- 13-Find all customers whose first name starts with "a".
select * from customer where first_name like 'a%';

-- 14- Find all customers whose first name ends with "a".
select * from customer where first_name like '%a' ;

-- 15- Display the list of first 4 cities which start and end with ‘a’ .
select city from city where city  like "A%a"
limit 4 ;

-- 16- Find all customers whose first name have "NI" in any position.
select * from customer where first_name like '%NI%';

-- 17- Find all customers whose first name have "r" in the second position .
select * from customer 
where first_name like '_r%';

-- 18- Find all customers whose first name starts with "a" and are at least 5 characters in length.
select * from customer where first_name like "a%" 
and length(first_name)>= 5;

-- 19- Find all customers whose first name starts with "a" and ends with "o".
select * from customer 
where first_name like "a%o";


-- 20- Get the films with pg and pg-13 rating using IN operator.
select * from film 
where  rating IN ('pg', 'pg-13');

-- 21- Get the films with length between 50 to 100 using between operator.
select * from film 
where length between 50 and 100;

-- 22- Get the top 50 actors using limit operator.
select * from actor
 limit 50;

-- 23- Get the distinct film ids from inventory table.
select distinct (film_id ) from inventory;

-- FUNCTION QUESTION.......

use sakila;
-- Ques 1:Retrieve the total number of rentals made in the Sakila database.
select count(*) As total_rentals from rental;

-- Question 2:Find the average rental duration (in days) of movies rented from the Sakila database.
select avg(rental_duration) As average_rental_duration_days
 from film ;

--  Question 3:Display the first name and last name of customers in uppercase.
select upper(first_name) As upper_first_name
, upper(last_name )As upper_last_name from customer;

-- Question 4:Extract the month from the rental date and display it alongside the rental ID.
select rental_id, month(rental_date) As rental_month from rental;

--  Question 5:Retrieve the count of rentals for each customer (display customer ID and the count of rentals).
select customer_id,count(*) As Total_rentals from rental
group by customer_id;
 
-- Question 6:Find the total revenue generated by each store.

select s.store_id, sum(p.amount) As total_revenue from payment p
join staff st on p.staff_id = st.staff_id
join store s on st.store_id = s.store_id
group by s.store_id;

-- Question 7:Determine the total number of rentals for each category of movies.
select c.name, count(r.rental_id) As total_rentals from rental r
join inventory i on r.inventory_id = i.inventory_id
join film_category fc on i.film_id = fc.film_id
join category c on fc.category_id = c.category_id
group by c.name
order by total_rentals desc;

--  Question 8: Find the average rental rate of movies in each language.
select f.title, avg(rental_rate)As avg_rental_rate from film f
join language l on f.language_id = l.language_id
group by f.title
order by avg_rental_rate desc;

-- JOIN QUESTIONS......

-- Questions 9. Display the title of the movie, customer s first name, and last name who rented it.
 -- Hint: Use JOIN between the film, inventory, rental, and customer tables.
select f.title,c.first_name, c.last_name from customer c
join rental r on c.customer_id = r.customer_id
join inventory i on r.inventory_id = i.inventory_id
join film f on i.film_id = f.film_id
order by f.title,c.first_name,c.last_name;

-- Question 10:Retrieve the names of all actors who have appeared in the film "Gone with the Wind."
 -- Hint: Use JOIN between the film actor, film, and actor tables.
select a.first_name, a.last_name from actor a
join film_actor fa on a.actor_id = fa.actor_id
join film f on fa.film_id = f.film_id
where f.title = 'Gone with the Wind'
;

-- Question 11:Retrieve the customer names along with the total amount they've spent on rentals.
-- Hint: JOIN customer, payment, and rental tables, then use SUM() and GROUP BY.
select c.first_name,
c.last_name,
 sum(p.amount)As total_amount 
 from rental r
joiN payment p On r.rental_id = p.rental_id
join customer c on p.customer_id = c.customer_id
group by c.first_name, c.last_name
order by total_amount desc;

-- Question 12:List the titles of movies rented by each customer in a particular city (e.g., 'London').
-- Hincustomert: JOIN customer, address, city, rental, inventory, and film tables, then use GROUP BY.
select f.title, c.first_name, c.last_name from customer c
join address ad on c.address_id = ad.address_id
join city ci on ad.city_id = ci.city_id
join rental r on c.customer_id = r.customer_id
join inventory i on r.inventory_id = i.inventory_id
join film f on i.film_id = f.film_id
where ci.city = 'London'
order by f.title, c.first_name, c.last_name;

--  Advanced Joins and GROUP BY......
 
-- Question 13:Display the top 5 rented movies along with the number of times they've been rented.
-- Hint: JOIN film, inventory, and rental tables, then use COUNT () and GROUP BY, and limit the results.
select f.title, count(r.rental_id) As total_rentals from rental r
join inventory i on r.inventory_id = i.inventory_id
join film f on i.film_id = f.film_id
group by f.title 
order by total_rentals desc
limit 5;

-- Question 14: Determine the customers who have rented movies from both stores (store ID 1 and store ID 2).
-- Hint: Use JOINS with rental, inventory, and customer tables and consider COUNT() and GROUP BY.
select c.customer_id, c.first_name, c.last_name 
from customer c
join rental r on c.customer_id = r.customer_id
join inventory i on r.inventory_id = i.inventory_id
group by  c.customer_id,c.first_name,c.last_name
having count(distinct i.store_id) = 2;

-- Windows Function Question......

 -- 1. Rank the customers based on the total amount they've spent on rentals.
 select c.customer_id, c.first_name, c.last_name, sum(p.amount) As total_amount, 
 rank() over (order by sum(p.amount) desc) As rank_position
 from customer c
join payment p on c.customer_id = p.customer_id
 group by c.customer_id, c.first_name, c.last_name
 order by total_amount desc; 
 
-- 2.Calculate the cumulative revenue generated by each film over time. 
SELECT 
    f.film_id,
    f.title,
    DATE(p.payment_date) AS revenue_date,
    SUM(p.amount) AS daily_revenue,
    SUM(SUM(p.amount)) OVER (
        PARTITION BY f.film_id 
        ORDER BY DATE(p.payment_date)
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS cumulative_revenue
FROM payment p
JOIN rental r ON p.rental_id = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
GROUP BY f.film_id, f.title, DATE(p.payment_date)
ORDER BY f.film_id, revenue_date;

-- 3. Determine the average rental duration for each film, considering films with similar lengths.
select f.length As film_length ,
f.title, 
avg(datediff(r.return_date, r.rental_date)) As avg_rental_duration
 from rental r
 join inventory i on r.inventory_id = i.inventory_id
 join film f on i.film_id = f.film_id
 group by f.length, f.title
 order by f.length , avg_rental_duration Desc;
 
-- 4.Identify the top 3 films in each category based on their rental counts.
SELECT category, film_title, rental_count
FROM (
    SELECT 
        c.name AS category,
        f.title AS film_title,
        COUNT(r.rental_id) AS rental_count,
        ROW_NUMBER() OVER (
            PARTITION BY c.name 
            ORDER BY COUNT(r.rental_id) DESC
        ) AS row_num
    FROM rental r
    JOIN inventory i ON r.inventory_id = i.inventory_id
    JOIN film f ON i.film_id = f.film_id
    JOIN film_category fc ON f.film_id = fc.film_id
    JOIN category c ON fc.category_id = c.category_id
    GROUP BY c.name, f.title
) ranked
WHERE row_num <= 3
ORDER BY category, row_num;

--  5. Calculate the difference in rental counts between each customer's total rentals and the average rentals across all customers.
SELECT customer_id,
       total_rentals,
       total_rentals - AVG(total_rentals) OVER () AS diff_from_avg
FROM (
    SELECT r.customer_id,
           COUNT(r.rental_id) AS total_rentals
    FROM rental r
    GROUP BY r.customer_id
) customer_rentals;

-- 6.Find the monthly revenue trend for the entire rental store over time.
SELECT month,
       total_revenue,
       SUM(total_revenue) OVER (ORDER BY month) AS cumulative_revenue
FROM (
    SELECT DATE_FORMAT(payment_date, '%Y-%m') AS month,
           SUM(amount) AS total_revenue
    FROM payment
    GROUP BY DATE_FORMAT(payment_date, '%Y-%m')
) monthly_revenue
ORDER BY month;

 -- 7.Identify the customers whose total spending on rentals falls within the top 20% of all customers.
  WITH customer_spending AS (
    SELECT customer_id,
           SUM(amount) AS total_spent
    FROM payment
    GROUP BY customer_id
),
ranked_customers AS (
    SELECT customer_id,
           total_spent,
           PERCENT_RANK() OVER (ORDER BY total_spent DESC) AS spending_percentile
    FROM customer_spending
)
SELECT customer_id,
       total_spent,
       spending_percentile
FROM ranked_customers
WHERE spending_percentile <= 0.20
ORDER BY total_spent DESC;

-- 8.Calculate the running total of rentals per category, ordered by rental count.
WITH category_rentals AS (
    SELECT c.name AS category,
           COUNT(r.rental_id) AS rental_count
    FROM rental r
    JOIN inventory i ON r.inventory_id = i.inventory_id
    JOIN film f ON i.film_id = f.film_id
    JOIN film_category fc ON f.film_id = fc.film_id
    JOIN category c ON fc.category_id = c.category_id
    GROUP BY c.name
)
SELECT category,
       rental_count,
       SUM(rental_count) OVER (ORDER BY rental_count DESC) AS running_total
FROM category_rentals
ORDER BY rental_count DESC;

-- 9.Find the films that have been rented less than the average rental count for their respective categories.
WITH film_rentals AS (
    SELECT c.name AS category,
           f.title,
           COUNT(r.rental_id) AS rental_count
    FROM rental r
    JOIN inventory i ON r.inventory_id = i.inventory_id
    JOIN film f ON i.film_id = f.film_id
    JOIN film_category fc ON f.film_id = fc.film_id
    JOIN category c ON fc.category_id = c.category_id
    GROUP BY c.name, f.title
)
SELECT category,
       title,
       rental_count,
       AVG(rental_count) OVER (PARTITION BY category) AS avg_category_rentals
FROM film_rentals
WHERE rental_count < AVG(rental_count) OVER (PARTITION BY category)
ORDER BY category, rental_count;

-- 10.Identify the top 5 months with the highest revenue and display the revenue generated in each month. 
WITH monthly_revenue AS (
    SELECT DATE_FORMAT(payment_date, '%Y-%m') AS month,
           SUM(amount) AS total_revenue
    FROM payment
    GROUP BY DATE_FORMAT(payment_date, '%Y-%m')
)
SELECT month,
       total_revenue
FROM (
    SELECT month,
           total_revenue,
           RANK() OVER (ORDER BY total_revenue DESC) AS revenue_rank
    FROM monthly_revenue
) ranked_months
WHERE revenue_rank <= 5
ORDER BY total_revenue DESc;

# Normalisation & CTE....

 -- 1. First Normal Form (1NF):
 -- Ques a. Identify a table in the Sakila database that violates 1NF. Explain how you would normalize it to achieve 1NF.
 -- Ans-In the Sakila database, the film table violates 1NF because the column special_features stores multiple values
      -- (e.g., “Deleted Scenes, Behind the Scenes”) in a single field, which is not atomic.
      -- To normalize it into 1NF, we should create a separate table (e.g., film_special_features)
      --  where each row stores only one feature per film. This removes multi-valued attributes and makes the data atomic.

-- 2.Second Normal Form (2NF):
-- Ques a. Choose a table in Sakila and describe how you would determine whether it is in 2NF. 
         -- If it violates 2NF, explain the steps to normalize it.
-- Ans- 1.It is already in 1NF (atomic values, no repeating groups).
      -- 2.Every non-key attribute depends on the whole primary key, not just part of it.
      -- the film_actor table to see if it is in 2NF. The primary key of this table is a composite key (film_id, actor_id).
	  -- To be in 2NF, all non-key columns must depend on the whole primary key, not just part of it.
      -- If the table had a column like film_title, it would depend only on film_id (part of the key), which is a partial dependence
      -- and violates 2NF.To normalize, we would move film_title to the film table (where it belongs) and keep film_actor only 
      -- for linking films and actors.

-- 3.Third Normal Form (3NF):
-- Ques a. Identify a table in Sakila that violates 3NF. Describe the transitive dependencies 
-- present and outline the steps to normalize the table to 3NF.
-- Ans-The payment table would violate 3NF if it included attributes like customer_name or staff_name, because
-- these depend on customer_id or staff_id (non-key columns), not on the primary key. To normalize, we move those attributes to
-- their respective tables (customer, staff) and keep only foreign keys in payment.

-- 4.Normalization Process:
-- Ques a. Take a specific table in Sakila and guide through the process of normalizing it from the initial 
-- unnormalized form up to at least 2NF.
-- Ans-UNF: film table had multi-valued columns (special_features, actor_names).
-- 1NF: Split multi-valued attributes into separate tables with atomic values.
-- 2NF: Removed partial dependency by moving actor details into their own table, leaving only keys in the relationship table.


-- 5. CTE Basics: 
-- Ques a. Write a query using a CTE to retrieve the distinct list of actor names and the number of films
-- they have acted in from the actor and film_actor tables.
with actor_film_count as (
select a.actor_id,
concat(a.first_name,' ',a.last_name) As actor_name,
count(fa.film_id) As film_count
from actor a
join film_actor fa on a.actor_id = fa.actor_id
group by a.actor_id,a.first_name, a.last_name
)
select actor_name, film_count
from actor_film_count
order by actor_name;

-- 7.CTE for Aggregation:
--  a. Write a query using a CTE to find the total revenue generated by each customer (sum of payments) from the customer and payment tables. 
with customer_revenue As (
select c.customer_id,
concat(c.first_name,' ',c.last_name) As customer_name,
 sum(p.amount) As Total_revenue 
from customer c
join payment p on c.customer_id = p.customer_id
group by c.customer_id, c.first_name , c.last_name
)
select customer_name,Total_revenue
from customer_revenue
order by Total_revenue desc;


-- 8.CTE with Window Functions:
-- a. Utilize a CTE with a window function to rank films based on their rental duration from the film table.
WITH FilmRanking AS (
    SELECT 
        film_id,
        title,
        rental_duration,
        RANK() OVER (ORDER BY rental_duration DESC) AS rental_rank
    FROM film
)
SELECT film_id, title, rental_duration, rental_rank
FROM FilmRanking
ORDER BY rental_rank, title;

-- 9. CTE and Filtering:
-- a. Create a CTE to list customers who have made more than two rentals, and then join this CTE with the customer table to retrieve additional customer details.
WITH FrequentRenters AS (
    SELECT 
        r.customer_id,
        COUNT(r.rental_id) AS rental_count
    FROM rental r
    GROUP BY r.customer_id
    HAVING COUNT(r.rental_id) > 2
)
SELECT 
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    c.email,
    f.rental_count
FROM FrequentRenters f
JOIN customer c 
    ON f.customer_id = c.customer_id
ORDER BY f.rental_count DESC;

-- 10.CTE for Date Calculations:
-- a. Write a query using a CTE to find the total number of rentals made each month, considering the rental_date from the rental table.
WITH MonthlyRentals AS (
    SELECT 
        DATE_FORMAT(rental_date, '%Y-%m') AS rental_month,
        COUNT(rental_id) AS total_rentals
    FROM rental
    GROUP BY DATE_FORMAT(rental_date, '%Y-%m')
)
SELECT rental_month, total_rentals
FROM MonthlyRentals
ORDER BY rental_month;

-- 11. CTE and Self-Join:
-- a. Create a CTE to generate a report showing pairs of actors who have appeared in the same film together, using the film_actor table.
WITH ActorPairs AS (
    SELECT 
        fa1.film_id,
        fa1.actor_id AS actor1_id,
        fa2.actor_id AS actor2_id
    FROM film_actor fa1
    JOIN film_actor fa2
        ON fa1.film_id = fa2.film_id
       AND fa1.actor_id < fa2.actor_id   -- avoid duplicates and self-pairs
)
SELECT 
    f.title AS film_title,
    CONCAT(a1.first_name, ' ', a1.last_name) AS actor1,
    CONCAT(a2.first_name, ' ', a2.last_name) AS actor2
FROM ActorPairs ap
JOIN film f ON ap.film_id = f.film_id
JOIN actor a1 ON ap.actor1_id = a1.actor_id
JOIN actor a2 ON ap.actor2_id = a2.actor_id
ORDER BY f.title, actor1, actor2;

use mavenmovies;
-- 12.12. CTE for Recursive Search:
 -- a. Implement a recursive CTE to find all employees in the staff table who report to a specific manager, considering the reports_to column
WITH RECURSIVE EmployeeHierarchy AS (
    -- Anchor member: start with the specific manager
    SELECT 
        s.staff_id,
        CONCAT(s.first_name, ' ', s.last_name) AS employee_name,
        s.reports_to,
        0 AS level
    FROM staff s
    WHERE s.staff_id = 1   -- 🔹 Replace with the manager’s staff_id

    UNION ALL

    -- Recursive member: find employees who report to the previous level
    SELECT 
        e.staff_id,
        CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
        e.reports_to,
        eh.level + 1
    FROM staff e
    JOIN EmployeeHierarchy eh 
        ON e.reports_to = eh.staff_id
)
SELECT staff_id, employee_name, reports_to, level
FROM EmployeeHierarchy
ORDER BY level, employee_name;
