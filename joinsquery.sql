create table employee(id int primary key, 
name varchar(50),dept varchar(50));
create table salart(id int primary key, 
eid int,salary int);

alter table salart rename to salaries;
alter table salaries rename salary to sal;

INSERT INTO employee(id,name, dept)
VALUES (1,'John Smith', 'Sales'),
       (2,'Jane Doe', 'Marketing'),
       (3,'Bob Brown', 'Sales'),
       (5,'Sarah Anderson', 'Marketing');

INSERT INTO salaries (id,eid, sal)
VALUES (1, 1, 50000),
       (2, 2, 60000),
       (3, 3, 70000),
	   (4, 4, 80000);
select * from employee;	   
select * from salaries;
/*left join*/
select * from employee as e left join salaries 
as s on e.id=s.eid;
/*inner join*/
select * from employee e1 join employee e2 on e1.id=e2.id;
/*self join*/
alter table employee add column Managerid varchar(10);
update employee set Managerid =
case
 when id=1 then NULL
 when id=2 then 1
 when id=3 then 2
 when id=5 then 3
end;

select e1.name,e2.name from employee e1 left join employee e2 on e2.id =CAST(e1.managerid AS INTEGER);