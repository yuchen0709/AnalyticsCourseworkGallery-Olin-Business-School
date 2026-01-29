/*1- Find the number of orders per purchase year with the highest number of orders coming on top.*/
select count(order_id) as num_orders, year(order_purchase_timestamp) as purchase_year
from orders
group by purchase_year
order by num_orders desc;
/* 3 rows returned */

/*2- Retrieve unique customers who placed an order but never received a delivery. */
select distinct(customer_id), customer_city, customer_state, order_status, order_purchase_timestamp
from orders join customers using (customer_id)
where order_purchase_timestamp is not null and order_status != 'delivered';
/* 153 rows returned */

/* 3- List the number of orders per product. List the product_id, and number of orders, and 
order by the number of orders.  */
select count(order_id) as num_orders, product_id
from orderitems
group by product_id
order by num_orders;
/* 475 rows returned */
SELECT DISTINCT Products.product_id, count(Orderitems.order_id)
FROM Products LEFT JOIN OrderItems
USING (product_id)
GROUP BY product_id
ORDER BY count(order_id);


/*4- Find the top 3 sellers who sold the most products. */
select count(product_id) as num_products, seller_id
from orderitems
group by seller_id
order by num_products desc
limit 3;

/* 5- For each order, list the customer state, order price, and product weight. Sort the table by 
weight in decreasing order.  */
select customers.customer_state, orderitems.price, products.product_weight_g, order_id
from customers join orders using(customer_id) 
	join orderitems using(order_id)
		join products using(product_id)
order by product_weight_g desc;
/* 500 rows returned */

/*6- Find the top product categories that generated the most revenue. List only ones with a 
total revenue of $500 or more. */
select sum(price) as revenue, products.product_category_name
from orderitems join products using (product_id)
group by product_category_name
having revenue >= 500;
/* 17 rows returned*/

/*7- Retrieve all orders placed on June 6 of any year, along with the customer city, customer 
state. */
select order_id, customer_city, customer_state, order_purchase_timestamp
from orders join customers using(customer_id)
where month(order_purchase_timestamp) = 6 and day(order_purchase_timestamp) = 6;
/* 3 rows returned */

/*8- Retrieve all delivered order details along with the corresponding customer ID, city, and 
state. Order by customer state.  */
select customer_id, customer_city, customer_state
from customers join orders using(customer_id)
where order_status = 'delivered'
order by customer_state;
/* 347 rows returned */

/*9- Retrieve products without any sellers and their sold products. List product ID and 
category. */
select product_id, product_category_name
from products left join orderitems using(product_id)
where seller_id is null;
/* 497 rows returned */

/* 10- Find the total revenue generated from orders placed on November 12. In the revenue 
calculation, consider the shipping charge and price of the product.  */
select sum(price - shipping_charges)
from orderitems join orders using(order_id)
where month(order_purchase_timestamp) = 11 and day(order_purchase_timestamp) = 12;
/* 1 row returned */

/*11- Retrieve all product orders along with their sellers and customer locations (city and state). 
List only the customers from the city of “Belem”. */
select order_id, seller_id, customer_city, customer_state
from customers join orders using(customer_id) join orderitems using (order_id)
where customer_city = 'Belem';
/* 4 rows returned */

/* 12- Identify the top 5 most expensive products, but only if they have been purchased at least 
3 times. */
select max(price), product_id, count(order_id) as times_purchased
from orderitems join products using(product_id)
group by product_id
having times_purchased >= 3
order by max(price) desc
limit 5;
/* 5 rows returned */

select product_id, product_category_name from products where product_id = 'SLTlrWtcYt1m';


/*13- Find the number of orders per purchase month. Which month has the lowest number of 
orders? List the purchase month and the number of orders.*/
select count(order_id) as num_orders, month(order_purchase_timestamp) as purchased_month
from orders
group by purchased_month
order by num_orders;
/* 12 rows returned */


