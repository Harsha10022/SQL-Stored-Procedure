#TASK

# For every given product and the quantity
#      1.Check if the product is available based on the required quantity.
#      2.If available then modify the database tables accordingly.

delimiter $$
create procedure pd_buy_product(p_product_name varchar(25),p_quantity int)
begin
	declare v_productcode int;
	declare v_price int;
	declare v_count int;

	select count(*) into v_count
	from products where product_name=p_product_name and quan_rem>=p_quantity;

	if v_count>0 then
		select product_code,price
		into v_productcode,v_price from products 
		where product_name=p_product_name;
		
		insert into sales(product_code,product_name,quantity,price)
		values(v_productcode,p_product_name,p_quantity,(v_price*p_quantity));
		
		update products set quantity_remaining=(quantity_remaining - p_quantity),
		quantity_sold=(quantity_sold + p_quantity) where product_code=v_pcode;
		
		select 'Quantity Sold';
	else 
		select 'Insufficient Quantity';
	end if;
end $$   

call pd_buy_product('iphone 13 pro max',1);