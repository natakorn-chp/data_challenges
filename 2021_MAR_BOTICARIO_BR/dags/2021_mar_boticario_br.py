
from airflow import DAG
from airflow.operators.python import PythonOperator
from airflow.providers.postgres.operators.postgres import PostgresOperator
from datetime import datetime,timedelta

from sqlalchemy import create_engine 

from airflow_conn import conn_string

import pandas as pd
import glob
import os

def ingest_data():
    root_file="<enter_src_file_path>"
    db = create_engine(conn_string) 
    conn = db.connect() 

    all_files = glob.glob(os.path.join(root_file , "*.csv"))
  
    df = pd.concat((pd.read_csv(f, delimiter=';') for f in all_files))
    df.columns = ['id_marca','marca','id_linha','linha','data_venda','qtd_venda']
    df['data_venda'] = pd.to_datetime(df['data_venda'])

    df.to_sql('sale_info',schema='dev_raw', con=conn, if_exists='append', index=False) 
    
    conn.close() # conn.commit() 

def chk_sts():
    print('done')


args_info={
    'owner':'tony_test',
    'reties':3,
    'retrydelay':timedelta(minutes=2)
}

with DAG(
    dag_id='sale_dag_challenge',
    default_args=args_info,
    description='sale data for report',
    start_date=datetime(2023, 10, 14, 2),
    schedule_interval='@daily'

) as dag:

    create_tb_pst=PostgresOperator(
        task_id='create_sale_tb_pst',
        postgres_conn_id='postgres_conn', 
        sql="""create table if not exists dev_pst.sale_info(
ID_MARCA int not null,
MARCA varchar(100) not null,
ID_LINHA int not null,
LINHA varchar(100) not null,
DATA_VENDA timestamp not null,
QTD_VENDA int not null );"""
    )

    create_tb_raw=PostgresOperator(
        task_id='create_sale_tb_raw',
        postgres_conn_id='postgres_conn', 
        sql="""create table if not exists dev_raw.sale_info(
	ID_MARCA varchar(10) not null,
	MARCA varchar(100) not null,
	ID_LINHA varchar(10) not null,
	LINHA varchar(100) not null,
	DATA_VENDA varchar(100) not null,
	QTD_VENDA varchar(5000) not null );
    truncate table dev_raw.sale_info;
    """
    )

    get_data_raw=PythonOperator(
        task_id='extract_data_files',
        python_callable=ingest_data,
    )

    insert_pst=PostgresOperator(
        task_id='insert_to_pst',
        postgres_conn_id='postgres_conn', 
        sql="""insert into dev_pst.sale_info 
select cast(ID_MARCA as integer),
MARCA,
cast(ID_LINHA as integer),
LINHA,
cast(DATA_VENDA as timestamp),
cast(QTD_VENDA as integer)
from dev_raw.sale_info;"""
    )

    create_tb_raw >> create_tb_pst >> get_data_raw >> insert_pst
