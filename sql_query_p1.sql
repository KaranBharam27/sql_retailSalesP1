create database sqlproject1;
use sqlproject1;

create table retailSales(
		transactions_id	Int Primary key,
        sale_date date,
        sale_time time,
        customer_id int,	
        gender varchar(15),
        age int,
        category varchar(15),
        quantiy int,
        price_per_unit float,
		cogs float,
        total_sale float
);

select count(DISTINCT customer_id) as total_sales from retailSales;

# 1. write a sql query to retireve all columns fro sales made on '2022-11-05'
Select * from retailSales where sale_date="2022-11-05";

# 2. retrieve all the transaction when category is Clothing and qty sold is more than 10 in month of nov 2022

SELECT * 
FROM retailSales
WHERE LOWER(category) = 'clothing'
  AND quantiy > 10
  AND DATE_FORMAT(sale_date, '%Y-%m') = '2022-11';

# 3. sql query to calculate total sales (total_sale) for each category;
Select category,
		sum(total_sale) AS total_sale,
        count(*) As total_orders
from retailSales
group by Category;
	
# 4. Find the avg age pof customer who purchased from category 'Beauty'

Select category,
		Round(avg(age), 2) As age
From retailsales
Where Category = 'Beauty';
        
# 5. find all transaction where total sales is greater than 1000;

Select * from retailSales
     where total_sale > 1000;
	
# 6. find total number of transaction (transactions_id) made by each gender in each category
 
 Select Category, gender,
		count(transaction_id) AS Total_Transaction
from retailSales 
group by gender, category;

# 7. calulate the average sale for each month. find out best selling month in each year

SELECT 
    year, month, total_sales,
    RANK() OVER (PARTITION BY year ORDER BY total_sales DESC) AS sales_rank
FROM (
    SELECT 
        YEAR(sale_date) AS year,
        MONTH(sale_date) AS month,
        SUM(total_sale) AS total_sales
    FROM retailSales
    GROUP BY year, month
) AS sub;

# 8. SQL query to find top 5 customers based on the highest total sales;

Select customer_id,
	   sum(total_sale) as total_sale
from retailSales 
Group by customer_id
Order by total_sale DESC
LIMIT 5;

# 9. no of unique customer who purcahsed items from each category

Select category,
	   count(DISTINCT customer_id)
From retailSales
GROUP BY Category;

# 10. sql query to create SHIFT  and number of records (eg.Morning<=12 Afternoon betn 12& 17, Evening >17)
 
 Select *,
	case 
		When Extract(Hour from Sale_time) < 12 then 'Morning'
        When Extract(Hour from Sale_time) Between 12 and 17 then 'Afternoon'
        Else 'Evening'
        end as shift
	From retailSales;
        
# end of project