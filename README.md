PRE-REQUISITE:
Installed Docker, PostgreSQL, and Python.
Available PostgreSQL in docker containers, each for a source and destination.

For source : navigate to directory ./postgres_src/ then run docker-compose up
it will insert few samples of data.

For destination : navigate to directory ./postgres_dest/ then run docker-compose up
Leave the table empty for now, we will insert data from source to dest later on.

HOW TO:
1. Make sure docker is running.
2. in ./docker-compose.yaml, modify the following variables:
   - AIRFLOW_CONN_POSTGRES_DEFAULT -> connection to your PostgreSQL destination
   - AIRFLOW_CONN_POSTGRES_SOURCE -> connection to your PostgreSQL source
   into a format postgres://USERNAME:PASSWORD@HOST:PORT/DBNAME
3. Open terminal and navigate to directory airflow-test/ then run docker-compose up
4. Open a web browser and go to http://localhost:5884/
5. Input username and password to login into airflow
6. Enable DAG x_to_y.py and run it.