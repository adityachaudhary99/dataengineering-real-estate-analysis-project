from datetime import timedelta, datetime
import os
import glob
import boto3
from airflow import DAG
from airflow.operators.python_operator import PythonOperator
from airflow.providers.amazon.aws.hooks.s3 import S3Hook
from airflow.operators.bash import BashOperator

# Replace 'your_s3_bucket' with your actual S3 bucket name
# Replace 'your_s3_key' with the desired S3 key (file path within the bucket)
# Replace 'your_url' with the URL of the data you want to download
data = 'data/dataset.csv'

BUCKET_NAME = 'bucket-911'
S3_KEY = 'csv'
URL = 'https://data.ct.gov/api/views/5mzw-sjtu/rows.csv?accessType=DOWNLOAD'

AIRFLOW_HOME = os.environ.get("AIRFLOW_HOME", "/opt/airflow/")

default_args = {
    'owner': 'airflow',
    'depends_on_past': False,
    'start_date': datetime(2024, 3, 10),
    'email_on_failure': False,
    'email_on_retry': False,
    'retries': 1,
    'retry_delay': timedelta(minutes=5),
}


def _upload_to_s3(bucket, object_name, local_path):
    """
    Uploads a file or files in a directory to S3 bucket.
    :param bucket: S3 bucket name
    :param object_name: target path & file-name in S3
    :param local_path: source path & file-name on local
    :return:
    """
    assert os.path.isdir(local_path), 'Provide a valid directory path'

    # Create an S3 client
    s3_client = boto3.client('s3')

    # Recursively upload files from the directory to S3
    for local_file in glob.glob(local_path + '/**', recursive=True):
        if os.path.isfile(local_file):
            # Define the full path for the file on S3
            remote_path = os.path.join(object_name, local_file[len(local_path)+1:])
            
            s3_client.upload_file(local_file, bucket, remote_path)

with DAG(
    dag_id = "local_to_aws_dag",
    default_args=default_args,
    schedule_interval=timedelta(days=1),
    catchup=False,
    max_active_runs=1
) as dag:

    download_dataset_task = BashOperator(
            task_id="download_dataset_task",
            bash_command=f"wget {URL} -O {AIRFLOW_HOME}/{data}"
        )
    
    upload_task = PythonOperator(
        task_id='upload_to_s3',
        python_callable=_upload_to_s3,
        op_kwargs={
            "bucket": BUCKET_NAME,
            "object_name": S3_KEY,
            'local_path':f"{AIRFLOW_HOME}/data"
        },
        provide_context=True
    )

download_dataset_task >> upload_task
