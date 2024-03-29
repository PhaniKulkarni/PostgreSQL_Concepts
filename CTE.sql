CREATE TABLE items (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  price INTEGER NOT NULL
);

CREATE TABLE sales (
  id SERIAL PRIMARY KEY,
  item_id INTEGER NOT NULL,
  quantity INTEGER NOT NULL,
  sale_date DATE NOT NULL
);

INSERT INTO items (name, price) VALUES
  ('Product A', 100),
  ('Product B', 200),
  ('Product C', 300);

INSERT INTO sales (item_id, quantity, sale_date) VALUES
  (1, 10, '2022-01-01'),
  (2, 5, '2022-01-01'),
  (3, 2, '2022-01-01'),
  (1, 20, '2022-02-01'),
  (2, 10, '2022-02-01'),
  (3, 4, '2022-02-01'),
  (1, 30, '2022-03-01'),
  (2, 15, '2022-03-01'),
  (3, 6, '2022-03-01');


With monthly_revenue as(select extract('month' from s.sale_date) as sale_month,
sum(s.quantity*i.price) 
from sales s join items i on s.item_id=i.id group by sale_month)
select * from monthly_revenue;