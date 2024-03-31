# Use the official Airflow image as the base
FROM apache/airflow:2.2.3-python3.8

# Install the AWS CLI
USER root
RUN mkdir ${AIRFLOW_HOME}/data
RUN chmod 777 ${AIRFLOW_HOME}/data
RUN apt-get update && \
    apt-get install -y unzip && \
    curl "https://d1vvhvl2y92vvt.cloudfront.net/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    sudo ./aws/install

# Switch back to the airflow user
USER airflow

# Copy your dags and plugins into the image
COPY dags /opt/airflow/dags
COPY plugins /opt/airflow/plugins

# Set the entrypoint to airflow
ENTRYPOINT ["/usr/bin/dumb-init", "--", "airflow"]
