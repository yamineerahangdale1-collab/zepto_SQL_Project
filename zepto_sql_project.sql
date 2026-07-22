drop table if exists zepto

create table Zepto(

sku_id SERIAL PRIMARY KEY,
Category VARCHAR(150),
 name VARCHAR(100) NOT NULL,
 mrp NUMERIC(8,2),
 discountPercent NUMERIC(5,2),
 availableQuantity INTEGER,
 discountedSellingPrice NUMERIC(8,2),
 weightInGms NUMERIC,
 outOfStock	BOOL,
 quantity Integer

)

Select * FROM Zepto

copy zepto(Category, name, mrp, discountPercent, availableQuantity, discountedSellingPrice,	weightInGms, outOfStock, quantity
)
from 'C:\csvfiles\zepto_v2.csv'
delimiter ','
csv header ;



--data exploration

--count of rows
select count(*) from zepto

--different product category
select distinct category
from zepto 
order by category

--products in stock vs out of stock
select  outOfStock, count(sku_id)
from zepto
group by  outOfStock

--products name present multiple times
select name, count(sku_id) as "number_of_skus"
from zepto
group by name
having count(sku_id) > 1
order by number_of_skus desc

--data cleaning

--products with price with 0
select * from zepto
where mrp = 0 or discountedSellingPrice = 0

delete from zepto
where mrp = 0

--convert paise to rupees
update zepto
set mrp = mrp/100.0,
discountedSellingPrice = discountedSellingPrice/100.0

select mrp, discountedSellingPrice from zepto

--Q.1.find the top 10 best value products based on the dicount percentage.
select distinct name, mrp, discountPercent
from zepto
order by discountPercent desc
limit 10

--Q.2.what are the products with high mrp but out of stock
select distinct name, mrp
from zepto
where outOfStock = True and mrp > 300
order by mrp desc

--Q.3. Calculated estimated revenue by each category
select distinct category, sum(discountedSellingPrice * availableQuantity) as revenue
from zepto
group by category
order by revenue 

--Q.4. Find all Products where mrp is greater than 500 and discount is less than 10%
select distinct name, mrp, discountPercent 
from zepto
where mrp > 500 and discountPercent < 10
order by mrp desc, discountPercent desc

--Q.5. Identify the top 5 categories offering the highest average discount percentage.
select category,round(avg(discountPercent),2) as avgdiscountPercent
from zepto
group by category
order by avgdiscountPercent desc
limit 5

select * from zepto

--Q.6. find the price per gram for products and above 100gms and sort by best value
select distinct name, weightingms, discountedSellingPrice,
round(discountedSellingPrice/weightingms,2) as pricepergms
from zepto
where weightingms >= 100
order by pricepergms 

--Q.7. Group the products into categories like low,medium,bulk.
select distinct name, weightingms,
case when weightingms < 1000 then 'low'
	 when weightingms < 5000 then 'Medium'
	 else 'Bulk'
	 end as weigh_category
from zepto

--Q.8. what is the total inventory weight per category
select category, sum(weightingms * availableQuantity) as total_weight 
from zepto
group by category
order by total_weight