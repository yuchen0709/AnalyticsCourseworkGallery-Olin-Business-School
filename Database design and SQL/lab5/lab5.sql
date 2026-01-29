use lyft;
/*1.Find the number of requests per car-manufactured-year and gender. Are men more interested 
in newer cars than older cars? */
select year, count(requestid), gender
from drivers join requests using(drivername) join customers using(customername)
group by year, gender;

/*2.Identify the oldest customer(s). List the name(s) and age(s). Try this with the ALL operator. */
select customername, age 
from customers where age >= all (select age from customers);

/*3. Among the customers who requested a ride to the Park, how many of them have names 
starting with the character ‘S’? */
select customername, destination
from requests 
where Destination = 'park' and customername like 's%';

/*4. List all customers, except the youngest one. Try this with the ANY operator.*/
select customername, age
from customers where age > any (select	age from customers);

/*5.Find the drivers whose average distance driven is larger than the average distance of all rides 
taken by Clayton residents. Sort the results by the average distance.*/
select drivername, avg(distance)
from requests group by drivername
having avg(distance)> (select avg(distance) 
from requests join customers using(customername) 
where address = 'Clayton');

/*6.Find the number of requests per gender per destination. Select only destinations that have the 
character ‘t’ in them. Sort results by destination then gender. */
select count(requestid), gender, destination
from requests join customers using (customername)
where destination like '%t%'
group by destination, gender
order by destination, gender;

/*7.List the customers who had a ride to WashU in a silver car. Among these customers, who is 
the youngest? Use a subquery in the WHERE clause in your answer. Sort the results by age. */
select customername, age
from requests join customers using (customername) join drivers using (drivername)
where destination = 'WashU' and color = 'silver' order by age;

select customername, age
from requests join customers using (customername) join drivers using (drivername)
where destination = 'WashU' and color = 'silver' and age <= all (select age
from requests join customers using (customername) join drivers using (drivername)
where destination = 'WashU' and color = 'silver');

/*8.List the customers who are younger than the average age. Also, list those customers that all 
their rides are shorter than the average distance of all trips in any individual ride. Show all 
of these customers in one query. Sort the results by customer name is increasing order.*/
select customername
from customers
where age < (select avg(age) from customers)
union
select customername
from customers
where customername in (select customername
from requests group by customername
having max(distance) < (select avg(distance) from requests))
order by customername;

/*9.Find the customers who have more than the average number of requests in the current week. 
List their names and number of trips in the current week. Sort by the number of trips. */
select customername, count(requestid) as num_requests
from requests group by customername
having num_requests >  
(
select avg(num_requests) from
	(select customername, count(requestid) as num_requests
	from requests group by customername) as num_requests_table
);

/*10.Among the customers in the previous query, which ones do not live in ‘St. Louis’? (Hint: 
Use NOT IN) */
select customername, count(requestid) as num_requests
from requests group by customername
having num_requests >  
(
select avg(num_requests) from
	(select customername, count(requestid) as num_requests
	from requests group by customername) as num_requests_table
)
and customername not in (select customername from customers where address = 'St. Louis');


/*13.*/
select distinct(model) from drivers
where exists (select drivername from requests where drivers.drivername = requests.drivername and dayofweek = 'tuesday');