--1.top selling product last 30 days
select 
	p.product_name,
	SUM(oi.quantity) as total_quantity_sold,
	SUM(oi.price) as total_sale
from products.products p
join sales.order_items oi ON oi.product_id = p.product_id
join sales.orders o ON o.order_id = oi.order_id
where o.order_date= current_date - interval '30days'
group by p.product_name
order by total_sale;

--2. Daily Sales Summary
select 
	DATE(o.order_date) as sale_date,
	COUNT(DISTINCT(o.order_id)) as total_orders,
	SUM(oi.price) as total_revenue
from sales.orders o
join sales.order_items oi ON o.order_id = oi.order_id
group by sale_date
order by sale_date;

--3. Region wise revenue
select 
	r.region_name,
	SUM(oi.price) as total_revenue
from sales.regions r
join sales.orders o ON o.region_id=r.region_id
join sales.order_items oi ON oi.order_id=o.order_id
group by r.region_name
order by total_revenue desc;

--4. Customer Lifetime value
select 
	c.customer_id,
	c.customer_name,
	COUNT(o.order_id) as total_orders,
	SUM(oi.price) as lifetime_value
from customers.customers c
join sales.orders o ON o.customer_id = c.customer_id
join sales.order_items oi ON oi.order_id = o.order_id
group by c.customer_id,c.customer_name
order by lifetime_value desc;

--5. Low Stock Products
select
	p.product_name,
	w.warehouse_name,
	s.quantity
from products.products p
join inventory.stock s ON s.product_id = p.product_id
join inventory.warehouses w ON s.warehouse_id = w.warehouse_id
where s.quantity < 20
order by s.quantity asc;
