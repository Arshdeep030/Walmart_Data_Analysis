# Walmart Sales Data Analysis

## Overview

This project analyzes Walmart Sales data to uncover insights about branch performance, product trends, and customer behavior. The goal is to support decision-making to optimize sales strategies. The dataset used is derived from a public dataset simulating sales across Walmart branches in Mandalay, Yangon, and Naypyitaw.

Dataset Source: [Kaggle Walmart Sales Forecasting Competition](https://www.kaggle.com/c/walmart-recruiting-store-sales-forecasting)

## Project Goals

The primary objectives are:

- Understand sales trends by product, time, and customer type.
- Classify product performance.
- Identify peak sales periods and locations.
- Analyze customer preferences and behaviors.

## Dataset Description

The dataset contains **1000 rows** and **17 columns**:

| Column Name             | Description                             | Data Type      |
|------------------------|-----------------------------------------|----------------|
| invoice_id             | Unique invoice identifier               | VARCHAR(30)    |
| branch                 | Branch code                             | VARCHAR(5)     |
| city                   | Branch location                         | VARCHAR(30)    |
| customer_type          | Customer type                           | VARCHAR(30)    |
| gender                 | Customer gender                         | VARCHAR(30)    |
| product_line           | Product category                        | VARCHAR(100)   |
| unit_price             | Price per unit                          | DECIMAL(10,2)  |
| quantity               | Number of units sold                    | INT            |
| tax_pct                | Value Added Tax                         | FLOAT(6,4)     |
| total                  | Total bill (VAT + COGS)                 | DECIMAL(12,4)  |
| date                   | Date of transaction                     | DATETIME       |
| time                   | Time of transaction                     | TIME           |
| payment                | Payment method                          | VARCHAR(15)    |
| cogs                   | Cost of Goods Sold                      | DECIMAL(10,2)  |
| gross_margin_pct       | Gross margin percentage                 | FLOAT(11,9)    |
| gross_income           | Gross income                            | DECIMAL(12,4)  |
| rating                 | Customer rating                         | FLOAT(2,1)     |

## Data Preparation

1. **Data Wrangling**
   - Built a SQL database and created a `sales` table.
   - Ensured all fields were set to `NOT NULL` to exclude null entries.

2. **Feature Engineering**
   - `time_of_day`: Categorized time into Morning, Afternoon, Evening.
   - `day_-name`: Extracted weekday name from transaction date.
   - `month__name`: Extracted month name from transaction date.

## Business Questions Answered

### Generic
- How many unique cities does the data have?
- In which city is each branch?

### Product
- How many unique product lines does the data have?
- What is the most selling product line?
- What is the total revenue by month?
- What month had the largest COGS?
- What product line had the largest revenue?
- What is the city with the largest revenue?
- Classify each product line as "Good" or "Bad" based on average quantity sold.
- Which branch sold more products than average product sold?
- What is the most common product line by gender?
- What is the average rating of each product line?

### Sales
- Number of sales made in each time of the day for each weekday.
- Which of the customer types brings the most revenue?
- Which city has the largest tax/VAT percent?
- Which customer type pays the most in VAT?

### Customer
- How many unique customer types does the data have?
- How many unique payment methods does the data have?
- What is the most common customer type?
- What is the gender of most of the customers?
- What is the gender distribution per branch?
- Which time of the day do customers give most ratings?
- Which time of the day do customers give most ratings per branch?


## SQL Table Schema

```sql
CREATE DATABASE IF NOT EXISTS walmartSales;

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
