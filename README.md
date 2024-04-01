# Real-Estate-Data-Analysis

## Workflow/Architecture
![alt text](./img/architecture.png)


## Urban Planning and Real Estate Data: Enhancing Community Development and Housing Diversity
For this project I've tried to build a batch pipeline to process real estate data of the state of Connecticut from (`https://catalog.data.gov/`,An official website of the GSA's Technology Transformation Services). The potential question I try to answer is, How can real estate professionals and investors leverage market data to identify trends and make data-driven decisions to optimize property portfolio performance?

## Dataset
[Real Estate dataset website](https://catalog.data.gov/dataset/real-estate-sales-2001-2018/resource/f7cb94d8-283c-476f-a966-cc8c9e1308b4)

[Real Estate dataset direct link](https://data.ct.gov/api/views/5mzw-sjtu/rows.csv?accessType=DOWNLOAD)

## Technologies
- **Amazon Web Services** (AWS):
  - VM Instance to run project on it.
  - Cloud Storage to store data.
- **Terraform** to create cloud infrastructure.
- **Docker** for containerization (docker-compose)
- **Python** main programming language
- **Airflow** to run data pipelines as DAGs.
- **Snowflake** data warehouse for the project.
- **Google data studio** to visualize data.

# Reproducing from scratch
## 1. To reproduce this code entirely from scratch, you will need to create a AWS account:
Refer [here](https://github.com/adityachaudhary99/dataengineering-real-estate-analysis-project/blob/main/pre-reqs.md) for AWS setup details

## 2. You'll need your IaC to build your infrastructure. In this project, Terraform is used
Download Terraform!
* Download here: https://www.terraform.io/downloads

Initializing Terraform
* Create a new directory with `main.tf`, and initialize your config file. [Details](https://docs.aws.amazon.com/search/doc-search.html?searchPath=documentation&searchQuery=terraform+aws)
    * *OPTIONAL* Create `variables.tf` files to store your variables
* `terraform init`
* `terraform plan`
* `terraform apply`

## 3. Set up Docker, Dockerfile, and docker-compose to run Airflow

#### Data pipelines
The dataset data download, process and upload to cloud storage, transfer to data warehouse is done via these Airflow DAGs:

**Local to AWS Dag**  
  - Downloads the dataset file in the csv format. This task runs by a bash script, which downloads the data. 
  - This file is then uploaded to project Cloud Storage(Data Lake).

## 4. Run the DAGs
* run the `local_to_aws_dag` in the airflow UI after setting up airflow. 

## 5. Snowflake
The snowflake environment is setup up using the files [here](https://github.com/adityachaudhary99/dataengineering-real-estate-analysis-project/blob/main/snowflake_scripts).
A snowpipe is configured in snowflake that is triggered by the event notification setup in the project s3 bucket(send notification as soon as a new file is uploaded in the project s3 bucket). This snowpipe transfers the data from the s3 bucket into an external stage in a metadata base in snowflake in the form of table. This table is then used to load the transformed data in the main data warehouse for the project. 

### 6. Create your dashboard
* Go to [Google Data Studio](https://datastudio.google.com) 
* Click `Create` > `Data Source`
* Select `BigQuery` > Your Project ID > Dataset > Table
* Click on `Connect` on the top-right and your data should now be imported to use for your dashboard!

#### Dashboard
Simple dashboard at Google Data studio with few graphs.
- Average Accessed Value by Year.
- Sale Amount vs. Accessed Value.​
- Average Accessed Value Over the Years​.
- Residential Type Distribution.

Below is a screenshot of my [dashboard](https://lookerstudio.google.com/s/raoYn0w6ehQ).
![alt text](./img/Dashboard.png)
