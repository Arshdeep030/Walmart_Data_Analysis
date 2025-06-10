USE walmartSales;

SELECT
	*
FROM sales;

-- Create table
CREATE TABLE IF NOT EXISTS sales(
	invoice_id VARCHAR(30) NOT NULL PRIMARY KEY,
    branch VARCHAR(5) NOT NULL,
    city VARCHAR(30) NOT NULL,
    customer_type VARCHAR(30) NOT NULL,
    gender VARCHAR(30) NOT NULL,
    product_line VARCHAR(100) NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL,
    tax_pct FLOAT(6,4) NOT NULL,
    total DECIMAL(12, 4) NOT NULL,
    date DATETIME NOT NULL,
    time TIME NOT NULL,
    payment VARCHAR(15) NOT NULL,
    cogs DECIMAL(10,2) NOT NULL,
    gross_margin_pct FLOAT(11,9),
    gross_income DECIMAL(12, 4),
    rating FLOAT(2, 1)
);

-- Add the time_of_day column
UPDATE sales
SET time_of_day = 
    CASE
        WHEN `time` BETWEEN '00:00:00' AND '12:00:00' THEN 'Morning'
        WHEN `time` BETWEEN '12:01:00' AND '16:00:00' THEN 'Afternoon'
        ELSE 'Evening'
    END;


-- Add day_name column
ALTER TABLE sales ADD COLUMN day__name VARCHAR(10);

UPDATE sales
SET day__name = DAYNAME(date);

-- Add month_name column
ALTER TABLE sales ADD COLUMN month__name VARCHAR(10);

UPDATE sales
SET month__name = MONTHNAME(date);

-- --------------------------------------------------------------------
-- ---------------------------- Generic ------------------------------
-- --------------------------------------------------------------------
-- How many unique cities does the data have?
select distinct city from sales;

-- In which city is each branch?
select distinct branch, city from sales;
-- --------------------------------------------------------------------
-- ---------------------------- Product -------------------------------
-- --------------------------------------------------------------------
select * from sales;
-- How many unique product lines does the data have?
select distinct product_line from sales;

-- What is the most selling product line
select SUM(quantity) as most_sold from sales 
order by sum(quantity) desc
limit 1;

-- What is the total revenue by month
select sum(total) as revenue,month__name from sales
group by month__name;

-- What month had the largest COGS?
select sum(cogs) as largest_cogs,month__name from sales
group by month__name
order by sum(cogs) desc
limit 1;

-- What product line had the largest revenue?
select sum(total) as product_largest_revenue, product_line from sales
group by product_line
order by sum(total) desc;

-- What is the city with the largest revenue?
select sum(total) as city_largest_revenue, city from sales
group by city
order by sum(total) desc;

-- Classify each product line as "Good" or "Bad" based on average quantity sold.
-- If the average quantity sold for a product line is greater than the overall average quantity, label it as "Good"; otherwise, label it as "Bad".
select
	avg(quantity) as avg_qnty
from sales;

select
	avg(quantity) as avg_qnty,product_line
from sales
group by product_line;

select product_line,
        Case when avg(quantity) > '5.4995'then "Good"
        else "Bad"
        END as remark
	from sales
    group by product_line;

select * from sales;
-- Which branch sold more products than average product sold?
select branch, sum(quantity) as qnt from sales
group by branch
having sum(quantity) > (select avg(quantity) from sales );

-- What is the most common product line by gender
select product_line,gender, count(gender) as cmp from sales
group by product_line, gender
order by count(gender) desc;

-- What is the average rating of each product line
select product_line, round(avg(rating),2) as avg_rating from sales
group by product_line
order by avg_rating desc;

-- --------------------------------------------------------------------
-- --------------------------------------------------------------------
-- --------------------------------------------------------------------
-- -------------------------- Customers -------------------------------
-- --------------------------------------------------------------------
-- How many unique customer types does the data have?
select distinct customer_type from sales;

-- How many unique payment methods does the data have?
select distinct payment from sales;

-- What is the most common customer type?
select customer_type, count(customer_type) as common_customer_type from sales
group by customer_type
order by common_customer_type desc;

-- What is the gender of most of the customers?
select gender, count(gender) as most_common_gender from sales
group by gender
order by most_common_gender desc;

-- What is the gender distribution per branch?
select branch,gender, count(gender) as dist from sales
group by branch,gender
order by branch asc;

-- Which time of the day do customers give most ratings?
select avg(rating) as highest_rating , time_of_day from sales
group by time_of_day
order by highest_rating desc;

-- Which time of the day do customers give most ratings per branch?
select avg(rating) as highest_ratings , branch from sales
group by branch
order by highest_ratings desc;

-- --------------------------------------------------------------------
-- --------------------------------------------------------------------
-- --------------------------------------------------------------------
-- ---------------------------- Sales ---------------------------------
-- --------------------------------------------------------------------
-- Number of sales made in each time of the day for each weekday
select day__name, time_of_day,  COUNT(*) AS total_sales from sales
group by day__name, time_of_day
order by total_sales desc;

-- Which of the customer types brings the most revenue?
select customer_type, sum(total) as revn from sales
group by customer_type
order by revn desc;

-- Which city has the largest tax/VAT percent?
select city, round(avg(tax_pct),2) as largest_tax from sales
group by city
order by largest_tax desc;

-- Which customer type pays the most in VAT?
select customer_type, avg(tax_pct) as total_tax from sales
group by customer_type
order by total_tax desc;

-- --------------------------------------------------------------------
-- --------------------------------------------------------------------
-- -----------------------------End------------------------------------
-- --------------------------------------------------------------------
-- --------------------------------------------------------------------

