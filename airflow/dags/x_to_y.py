import datetime

from airflow import DAG
from airflow.operators.postgres_operator import PostgresOperator
from airflow.hooks.postgres_hook import PostgresHook

with DAG(
        dag_id='x_to_y',
        start_date=datetime.datetime(year=2021, month=10, day=1),
        schedule_interval=datetime.timedelta(minutes=60),
) as dag:

    src = PostgresHook(postgres_conn_id='postgres_source')
    src_conn = src.get_conn()
    src_cursor = src_conn.cursor()
    dest = PostgresHook(postgres_conn_id='postgres_default')
    dest_conn = dest.get_conn()
    dest_cursor = dest_conn.cursor()
    dest_cursor.execute("SELECT MAX(creation_date) FROM table_y;")
    dest_date = dest_cursor.fetchone()[0]
    if dest_date is None:
        dest_date = '1990-01-01'
    src_cursor.execute("SELECT * FROM table_x WHERE creation_date > %s", [dest_date])
    dest.insert_rows(table="table_y", rows=src_cursor)