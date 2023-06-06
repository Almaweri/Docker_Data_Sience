CREATE TABLE sql_python.web_events (
	id integer,
	account_id integer,
	occurred_at timestamp,
	channel char(10)
);

select id, account_id, occurred_at
FROM web_events
limit 50


// sorting by account_ID and total amount to see the largest mumber for each order 
Select account_id, total_amt_usd
From orders
ORDER BY account_id, total_amt_usd DESC

// order the results first by total_amt_usd in descending order and then account_id

select account_id, total_amt_usd
from orders
order by total_amt_usd DESC, account_id


//Write a query that displays the order ID, account ID, and total dollar amount for all the orders,
// sorted first by the account ID (in ascending order), and then by the total dollar amount (in descending order).

SELECT account_id, total_amt_usd
FROM orders 
ORDER BY account_id, total_amt_usd DESC


// Now write a query that again displays order ID, account ID, and total dollar amount for each order,
// but this time sorted first by total dollar amount (in descending order), 
// and then by account ID (in ascending order).

SELECT account_id, total_amt_usd
FROM orders
ORDER BY total_amt_usd DESC, account_id


//Compare the results of these two queries above.
// How are the results different when you switch the column you sort on first?

// WHERE CLAUSE to get the data for one accont ID

SELECT *
FROM orders
WHERE orders.account_id = 4251
ORDER BY account_id 
limit 1000



//Pulls the first 5 rows and all columns from the orders table that have a dollar amount of
// gloss_amt_usd greater than or equal to 1000.

select * from orders
where gloss_amt_usd >= 1000
limit 5


//Pulls the first 10 rows and all columns from the orders table that have a total_amt_usd less than 500.

select  * from orders
where total_amt_usd < 500
limit 10

// Where with non-Numeric Data

Select *
From accounts
where name = 'Ford Motor'

Select *
From accounts
where name != 'United Technologies'


SELECT name, website, primary_poc 
FROM accounts 
where name = 'Exxon Mobil'

//Drived Column

SELECT account_id,
        occurred_at,
        standard_qty,
        gloss_qty,
        poster_qty,
        gloss_qty + poster_qty as nonstandard_qty
From orders

SELECT id, (standard_amt_usd/total_amt_usd) * 100 AS std_percent, total_amt_usd
FROM orders
limit 10;

// Create a column that divides the standard_amt_usd by the standard_qty to find the unit price for standard paper 
//for each order. Limit the results to the first 10 orders, and include the id and account_id fields.

select id, account_id, standard_amt_usd, standard_qty,
(standard_amt_usd/standard_qty) AS unit_price
from orders
limit 10;


SELECT
  id,
  account_id,
  standard_amt_usd,
  standard_qty,
  (standard_amt_usd / standard_qty) AS unit_price
FROM
  orders
LIMIT 10;

//Write a query that finds the percentage of revenue that comes from poster paper for each order. You will need to use only the columns that end with _usd. 
// (Try to do this without using the total column.) Display the id and account_id fields also.

Select id, account_id,standard_amt_usd, gloss_amt_usd, poster_amt_usd, 
      (poster_amt_usd / (standard_amt_usd + gloss_amt_usd + poster_amt_usd) * 100) as total 
FROM orders;


// ====== LIKE ============= always use wild cards %% with it


SELECT *
From sql_python.accounts
where website like '%Google%';

// All the companies whose names start with 'C'.
SELECT *
FROM sql_python.accounts
WHERE name LIKE 'C%';

// Get the words that ENDs with ene
SELECT *
FROM accounts
WHERE name  LIKE '%ene'

// All companies whose names contain the string 'one' somewhere in the name.

SELECT *
FROM accounts
WHERE name  LIKE '%one%'

// =============  IN ============= filter data based on several possible values.//
SELECT *
FROM accounts 
where name IN ('walmart','apple','Oneok')

select *
from orders
where orders.account_id IN (1001, 1021)

// Use the accounts table to find the account name, primary_poc, and sales_rep_id for Walmart, Target, and Nordstrom.
SELECT name, primary_poc, sales_rep_id
FROM accounts
WHERE name IN ('Walmart', 'Target', 'Nordstrom')

// Use the web_events table to find all information regarding individuals who were contacted via the channel of organic or adwords.
SELECT *
FROM sql_python.web_events
WHERE web_events.channel IN ('organic','adwords')

// ========= NOT IN ========================
// It worked prtgect with IN and LIKE operators [ NOT LIKE, NOT IN]

SELECT sales_rep_id, name
FROM accounts
Where sales_rep_id NOT IN (321500, 321570)  // any sales rep id but not 321500 and 321570
ORDER BY sales_rep_id

SELECT sales_rep_id, name
FROM accounts
Where sales_rep_id IN (321500, 321570)
ORDER BY sales_rep_id


SELECT *
FROM accounts
WHERE website NOT LIKE '%com%'

// ============ Questions using the NOT operator

// Use the accounts table to find the account name, primary poc, and sales rep id for all stores except Walmart, Target, and Nordstrom.

SELECT name, accounts.website, primary_poc, sales_rep_id
FROM accounts
WHERE name NOT IN ('Walmart','Target','Nordstrom')

// Use the web_events table to find all information regarding individuals who were contacted via any method except using organic or adwords methods.
SELECT *
FROM web_events
WHERE channel NOT in ('organic', 'adwords')

// Use the accounts table to find 
// 1- All the companies whose names do not start with 'C'.

SELECT *
FROM accounts 
WHERE name NOT LIKE 'C%'

// All companies whose names do not contain the string 'one' somewhere in the name.
SELECT *
FROM accounts
WHERE name NOT LIKE '%one%'

//All companies whose names do not end with 's'.
SELECT *
FROM accounts
WHERE name NOT LIKE '%s'

// ========== AND and BETWEEN ================
// AND
SELECT *
FROM orders
WHERE occurred_at >= '2016-04-01' AND occurred_at <= '2016-10-01'
ORDER BY occurred_at DESC  // DESC so we could get the latest orders


// BETWEEN

SELECT *
FROM orders
WHERE occurred_at BETWEEN '2016-04-01' AND '2016-10-01'
ORDER BY occurred_at DESC

// Quiz: AND and BETWEEN


// Write a query that returns all the orders where the standard_qty is over 1000, the poster_qty is 0, and the gloss_qty is 0.

SELECT *
FROM orders
WHERE standard_qty > '1000' AND poster_qty = '0'AND gloss_qty = '0'



// ====================  OR ============================
USE sql_python;
Select account_id,
        occurred_at,
        standard_qty,
        gloss_qty,
        poster_qty
   From orders
   WHERE standard_qty = 0 OR gloss_amt_usd = 0 OR poster_qty = 0
   

// use parentheses to assure that logic we want to perform is being executed correctly
USE sql_python;
Select account_id,
        occurred_at,
        standard_qty,
        gloss_qty,
        poster_qty
   From orders
   WHERE (standard_qty = 0 OR gloss_amt_usd = 0 OR poster_qty = 0) // without the parentheses all results will be wrong
   AND occurred_at >= '2016-10-01'

//Questions using the OR operator

// 1- Find list of orders ids where either gloss_qty or poster_qty is greater than 4000. Only include the id field in the resulting table.
USE sql_python;
SELECT id
FROM orders 
WHERE gloss_qty > 4000 OR poster_qty > 4000

// 2-Write a query that returns a list of orders where the standard_qty is zero and either the gloss_qty or poster_qty is over 1000.
SELECT *
FROM sql_python.orders
WHERE (gloss_qty > 1000 OR poster_qty > 1000)
AND standard_qty = 0

// 3- Find all the company names that start with a 'C' or 'W',
// and the primary contact contains 'ana' or 'Ana',
// but it doesn't contain 'eana'.

SELECT * from sql_python.accounts
WHERE (name LIKE 'C%' OR name LIKE 'C%')
AND (primary_poc LIKE '%ana%' or primary_poc LIKE '%Ana%')
AND (primary_poc NOT LIKE '%eana%')

 // ==============================================================
      ============================= JOIN  =================
 // ==============================================================
   
// INNER JOIN
================ THINK about JOIN AS FROM ===================

SELECT sql_python.orders.*,
       orders.id, orders.account_id, orders.occurred_at, orders.standard_qty, orders.gloss_qty, orders.poster_qty, orders.total, orders.standard_amt_usd, orders.gloss_amt_usd, orders.poster_amt_usd, orders.total_amt_usd
   FROM sql_python.orders
   JOIN sql_python.accounts   
   ON orders.account_id = accounts.id

## // Enhanced Query

SELECT o.*, o.id, o.account_id, o.occurred_at, o.standard_qty, o.gloss_qty,
       o.poster_qty, o.total, o.standard_amt_usd, o.gloss_amt_usd,
       o.poster_amt_usd, o.total_amt_usd
FROM sql_python.orders AS o
JOIN sql_python.accounts AS a
    ON o.account_id = a.id;
