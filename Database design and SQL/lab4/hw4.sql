USE ecommerce_data;

/* 1- How many distinct orders were placed from January 1, 2017, to December 31, 2017, that 
were delivered and had shipping charges above 60? */
select order_id, order_purchase_timestamp, shipping_charges
from orderitems join orders using(order_id)
where year(order_purchase_timestamp) = 2017 and shipping_charges > 60 and order_status = 'delivered';
/* 23 rows */

/*2- List product_id and category of products where the category name contains the word 
“bed” and weighs more than 1,000 grams. Sort by the order_id.  */
select product_id, order_id, product_category_name
from products join orderitems using(product_id)
where product_category_name like '%bed%' and product_weight_g > 1000
order by order_id;
/* 7 rows*/

/*3- Find the total number of customers in each state. List only states with more than 10 
customers.  */
select count(customer_id) as num_customers, customer_state
from customers
group by customer_state
having num_customers > 10;
/* 7 rows */

/*4- During 2018, what was the largest total cost (including shipping charge) of items in a 
single order? Your query should return only one number.  */
select max(total_cost) from (
select shipping_charges, price, (shipping_charges + price) as total_cost
from orderitems join orders using (order_id)
where year(order_purchase_timestamp) = 2018
) as cost_2018;

/* 5- List a pair of customers living in the same state, but in different cities. Order by the 
customer's state. List customer ID, customer city, and customer state. */
select 
a.customer_id as customer_id1, 
b.customer_id as customer_id2,
a.customer_state as state,
a.customer_city as city1,
b.customer_city as city2
from customers a join customers b 
on a.customer_state = b.customer_state
and a.customer_city <> b.customer_city
and a.customer_id < b.customer_id
order by a.customer_state;
/* 20075 rows */

/*6- Find out how many late orders and how many early orders are on the orders table. We 
call an order early if the delivery happens before the estimated time; otherwise, we call it 
late. Your query should return only two rows and two columns.  */
SELECT 
    CASE 
        WHEN order_delivered_timestamp < order_estimated_delivery_date THEN 'Early'
        ELSE 'Late'
    END AS status,
    COUNT(*) AS order_count
FROM orders
GROUP BY status;

select * from orders where order_delivered_timestamp is null;

/*7- Find the total order costs (price + shipping_charges) by city. List the city and the total 
order cost. List only cities with order costs of 50 or less. */
select sum(total_cost) as city_totoal_cost, customer_city
from (
select shipping_charges, price, (shipping_charges + price) as total_cost, customer_city
from orderitems join orders using (order_id) right join customers using (customer_id) 
) as customer_cost
group by customer_city
having city_totoal_cost <= 50;
/* 7 rows returned */

/*8- Find product categories that have more than the average number of products across all 
categories. Hint: You need to use a subquery.*/
select count(product_id) as num_products, product_category_name from products group by product_category_name
having  num_products > (
select avg(num_products) from (
select count(product_id) as num_products, product_category_name from products group by product_category_name
) as category_num);
/* 4 rows returned */

/*9- List customer cities where the average price of orders from their citizens exceeds 5 times 
the average price of all orders. Hint: Only consider price.*/
select avg(price), customer_city 
from orderitems join orders using(order_id) right join customers using(customer_id)
group by customer_city
having avg(price) > 5*(select avg(price) from orderitems);
/* 11 rows returned */

/* 10- List the top 5 customers who placed the most orders (in terms of total price) among all 
orders, calculate their total number of orders and total amount spent, and sort them in 
descending order by total amount they have spent. Only consider price as order cost. */
select sum(price) as total_amount, count(order_id) as num_orders, customer_id 
from orderitems join orders using(order_id) group by customer_id
order by total_amount desc
limit 5;
/* 5 rows returned */

/*11- Find the active sellers who have at least sold 5 products.  */
select seller_id, count(product_id) as products_sold
from orderitems group by seller_id having products_sold >= 5;
/* 15 rows returned */

/*12- Find the average shipping charge and number of orders per customer city. List only those 
who had more than 2 orders. Sort by average shipping charges in decreasing order.*/
select avg(shipping_charges), count(order_id) as num_orders, customer_city
from orderitems join orders using(order_id) join customers using (customer_id)
group by customer_city
having num_orders > 2
order by avg(shipping_charges) desc;
/* 30 rows returned */

/* 13- List the products that are heavier than the average weight of all products.  */
select * from products
where product_weight_g > (select avg(product_weight_g) from products);
/* 213 rows returned*/