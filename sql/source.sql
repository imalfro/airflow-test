CREATE DATABASE IF NOT EXISTS db_x;

USE db_x;

CREATE TABLE IF NOT EXISTS table_x(
    id serial primary key,
    creation_date date not null default current_date,
    sale_value int
);

insert into table_x(sale_value) values(1);
insert into table_x(sale_value) values(3);
insert into table_x(sale_value) values(4);