/* 1. Which drivers did not have any requests? Use “Having” in SQL to identify these drivers. */
USE lyft;
select DriverName, RequestID
from drivers left join requests using (DriverName)
where RequestID IS NULL;

/*2. Calculate the number of requests for each day of the week. What is the least busy day?*/
select count(RequestID) as num_requests, DayOfWeek
from requests
group by DayOfWeek
order by num_requests;

/*3. Find the total number of unique customers who have driven in black cars. Separate these 
customers by gender. How many male customers were in black cars? */
select distinct(CustomerName), Gender, Color
from drivers join requests using (drivername) join customers using (CustomerName)
where color = 'black'
order by gender;

/*4. Calculate the average distance for requests in the “Evening” for each destination. Show only 
destinations with an average distance of more than 8 miles. Sort the results based on 
decreasing order of the average distance. Which destination has the shortest average 
distance? */
select avg(Distance), Destination
from requests
where TimeOfDay = 'evening' 
group by Destination
having avg(Distance) > 8
order by avg(Distance) desc;

/*5. Find the driver of the oldest car (Use a subquery). Your SQL code should show only the 
driver’s name.  */
select drivername
from drivers where year = (select min(year) from drivers);

/*6. Convert the previous query to a subquery in order to identify how many rides have been 
requested from that driver.  */
select count(RequestID) as num_requests, DriverName
from requests where drivername = (select drivername
from drivers where year = (select min(year) from drivers))
group by DriverName;

/*7. Are certain car colors more popular? For each car color, calculate: the number of rides, the 
number of cars, and the average number of rides per car. Include all cars in this query. 
Optional: calculate the average distance per car of that color. */
select count(requestid) as num_rides, count(model) as num_cars, count(requestid)/count(model) as avg_ride_percar, color
from drivers left join requests using (drivername)
group by color;

/*8. For each customer, find the total number of rides they had, both in the past and in the current 
week. Is there any relationship between the number of rides a customer had in the past and 
the number of rides in the current week? Sort your results by the total number of rides and 
return only the 12 customers with the fewest rides, in total. */
select current_rides, CustomerName, PastTrips, current_rides+if(PastTrips is null, 0, PastTrips) as total_trips
from
(select count(RequestID) as current_rides, CustomerName 
from customers left join requests using(customername) group by customername) as currentrides
join (select CustomerName, PastTrips from customers) as pasttrips using (customername)
order by total_trips
limit 12;

/*9. Convert the previous question (Question #8) into a subquery to find the average total number 
of trips for each address. Remember that the address is the city the customer lives in. Sort 
results in increasing order of average number of trips. */
select address, avg(total_trips)
from (
select current_rides, CustomerName, address, PastTrips, current_rides+if(PastTrips is null, 0, PastTrips) as total_trips
from
(select count(RequestID) as current_rides, CustomerName 
from customers left join requests using(customername) group by customername) as currentrides
join (select CustomerName, address, PastTrips from customers) as pasttrips using (customername)
order by total_trips
limit 12) as totoaltrips
group by address
order by avg(total_trips);

/*10. List the number of requests by time of day on each day. List only times with more than 5 
requests. */
select count(num_day) as num_requests, TimeOfDay 
from 
group by TimeOfDay