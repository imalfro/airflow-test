#!/bin/bash

set -e
export PGPASSWORD=$POSTGRES_PASSWORD;
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
  CREATE USER $APP_DB_USER WITH PASSWORD '$APP_DB_PASS';
  CREATE DATABASE $APP_DB_NAME;
  GRANT ALL PRIVILEGES ON DATABASE $APP_DB_NAME TO $APP_DB_USER;
  \connect $APP_DB_NAME $APP_DB_USER
  BEGIN;
    CREATE TABLE IF NOT EXISTS table_x(
      id serial primary key,
      creation_date date not null default current_date,
      sale_value int
    );
    insert into table_x(sale_value) values(1);
    insert into table_x(sale_value) values(3);
    insert into table_x(sale_value) values(4);
  COMMIT;
EOSQL