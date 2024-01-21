Create Database walmart;
use walmart;

-- -----------------------------------------------------------------------------------------------------------------------
############################           Feature Engineering            #####################################################

select
	time,
    (Case
        when `time` between "00:00:00" and "12:00:00" then "Morning"
		when `time` between "12:01:00" and "16:00:00" then "Afternoon"
        Else "Evening"
	end
	) As time_of_date
From data;

Alter table data add column time_of_day varchar(20);

Update data
set time_of_day = (
	Case
		when `time` between "00:00:00" and "12:00:00" then "Morning"
		when `time` between "12:01:00" and "16:00:00" then "Afternoon"
        Else "Evening"
	end
);

-- day_name----
select
    date,
    dayname(date) as day_name 
from data;

alter table data add column day_name varchar(10);

####Converting the date format to YYYY-MM-DD
update data
set date = DATE_FORMAT(STR_TO_DATE(date, '%m/%d/%Y'), '%Y-%m-%d');

update data
set day_name = dayname(date);

--    month name  -- 
select 
	date, 
	monthname(date) as mth_name
from data;

ALter table data add column mth_name varchar(10);

update data 
set mth_name = monthname(date);

-- ------------------------------------------------------------------------------------------------------------------ 
#######################################  Questions    ###################################################

#Fecting all data
Select * from data;

#1. How many number of unique cities?
Select distinct city from data;

#2. How many branch particular city has?
Select distinct city, branch from data;

#3. How many unique product lines does the data have?
Select distinct Product_line from data;
Select count(distinct Product_line) as number_of_productline from data;

#4. what is the most common payment method
Select Payment, count(payment) as counts from data
group by payment
order by count(payment) desc;

#5. what is the most selling product line?
Select product_line, count(product_line) as count from data
group by product_line
order by total desc;

#6. what is the total revenue by month
Select monthname(date), sum(total) as Revenue from data
group by monthname(date)
order by Revenue desc;

#7. what month had the largest cogs?
Select mth_name, sum(cogs) as total_cogs from data
group by mth_name
order by total_cogs desc;

#8. what product line had the largest revenue
Select product_line, sum(total) as revenue from data
group by product_line 
order by revenue desc;

#9. what is the city with the largest revenue
Select city, branch, sum(total) as revenue from data
group by city 
order by revenue desc;


select * from data;

#10. which branch sold more products than average product sold?
Select branch, sum(quantity) as Total_quantity from data
group by branch
having sum(quantity) > avg(quantity);

#11. what is the most common product line by gender
Select product_line, gender, count(gender) as total_cnt from data
group by gender, product_line 
order by total_cnt desc;

#12. what is the average rating of each product line
Select round(avg(rating), 2) as avg_rating, product_line from data
group by product_line
order by avg_rating desc;

#13. How many total sales in each time on monday
Select time_of_day, sum(invoice_id) as total_sales from data
where day_name = "Monday"
group by time_of_day
order by total_sales desc;

#14. which of the customer types brings the most revenue
Select customer_type, sum(total) as revenue from data
group by customer_type
order by revenue desc;

#15.which city has the largest tax percent/ VAT (Value added tax)?
Select city, avg(tax_5%) from data
group by city
order by avg(tax_5%) desc;

#16. how many unique customer types does the data have
Select distinct customer_type from data;

#16. how many unique payment methods does the data have
Select distinct payment from data;

select * from data;

#18. which customer type buys the most
select
     customer_type,
     count(*) as cstm_cnt
from data
group by customer_type; 

#19. what is the gender of most of the customers
Select gender, count(*) from data
group by gender;

#20. what is the gender distribution per branch at brach c
Select branch, gender, count(*) as count from data
where branch ='c'
group by gender;

#21. which time of the day do customer give most ratings-
Select time_of_day, avg(rating) as avg_rating from data
group by time_of_day
order by avg_rating;

#22. which time of the day customers give most ratings per branch
Select time_of_day, avg(rating) as avg_rating from data
where branch = 'c'
group by time_of_day
order by avg_rating;


#23. which day of the week has the best avg ra6ings
Select DAY_NAME, avg(rating) as avg_rating from data
group by DAY_NAME
order by avg_rating DESC;

#24 which day of the week has the best avg ratings for branch A
Select DAY_NAME, avg(rating) as avg_rating from data
where branch = 'a'
group by DAY_NAME
order by avg_rating DESC;