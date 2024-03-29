select * from sales;
select item_id,sum(quantity) from sales group by item_id;
/* WINDOW FUNCTION
here below order by is very important
By including ORDER BY quantity in the OVER() function, 
you're specifying that the window frame should only include rows with quantity values less than or equal to 
the current row's quantity within each item_id partition.
*/
select item_id,quantity, sum(quantity) over(partition by item_id order by quantity) 
as running_total, sum(quantity) over(partition by item_id) 
as without_order
from sales;

--ANALYTICAL FUNCTIONS
--1. RANK,DENSE_RANK,lag,lead,row_number
select item_id,quantity,rank() over(order by quantity desc) as rank_quantity from sales;

select item_id,quantity,
rank() over(order by quantity desc) as rank_quantity,
dense_rank() over(order by quantity desc) as rankdense_quantity,
row_number() over(order by quantity desc) as rowno_quantity,
lag(quantity) over(order by quantity desc) as lag_quantity,
lead(quantity) over(order by quantity desc) as lead_quantity from sales;

/*VIEW
-CTE exists only for the duration of the particular query
-View is a virtual table. the actual data isn't copied or stored within the view itself. 
It stores the query.
Instead, the view definition tells the database engine how to generate the data when you query the view.
-If you add or remove data in actual or backend table, It also reflects in the view table
*/
drop view sales_items;
create view sales_items as
select i.name,sum(s.quantity) from sales as s join items as i on s.item_id=i.id group by i.name;
select * from sales_items;

/*CTAS(create table as select):
--It creates a new table not like view. It stores the actual data
-- If you add or remove data in actual or backend table, It WILL NOT reflect in the ctas table
*/
create table ctas_table as select item_id,sum(quantity) from sales group by item_id;
select * from ctas_table;

/*temp table
as soon as the session ends, the temp table will be dropped
*/

/*STORED PROCEDURE
*/
create or replace function avg_quantity(iid int)
returns int
AS $$
begin
return (select avg(quantity) from sales where item_id=iid);
end;
$$ language plpgsql

select item_id, avg_quantity(item_id) from sales where item_id in(1,2,3) group by item_id;
