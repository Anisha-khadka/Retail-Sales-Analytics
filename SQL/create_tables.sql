CREATE DATABASE IF NOT EXISTS retail_sales_db;

USE retail_sales_db;

CREATE TABLE retail_sales(
row_id INT PRIMARY KEY,
order_id VARCHAR(50),
order_date DATE,
ship_date DATE,
ship_mode VARCHAR(50),
customer_id VARCHAR(50),
segment VARCHAR(50),
country VARCHAR(50),
city VARCHAR(100),
state VARCHAR(100),
region VARCHAR(100),
product_id VARCHAR(50),
category VARCHAR(50),
sub_category VARCHAR(50),
product_name VARCHAR(200),
sales FLOAT,
quantity INT,
discount FLOAT,
profit FLOAT
);

