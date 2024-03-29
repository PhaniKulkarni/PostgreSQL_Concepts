create table customer(cid serial primary key, cname varchar(50),
cemail varchar(20));
create table orders(oid serial primary key, cid int, oamt decimal(10,2));
INSERT INTO customer (cname, cemail) VALUES
    ('John Doe', 'johndoe@example.com'),
    ('Jane Smith', 'jsmith@example.com'),
    ('Bob Johnson', 'johnson@example.com');

INSERT INTO orders (cid, oamt) VALUES
    (1, 50.00),
    (1, 75.00),
    (2, 125.00),
    (3, 200.00);
select * from orders;	
select cname from customer where cid in (select cid from orders where oamt>100);