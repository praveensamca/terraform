#!/bin/bash

sudo yum install httpd -y

sudo amazon-linux-extras install postgresql10 -y

sudo yum install gcc  -y

sudo yum install python3-devel -y

sudo yum install -y postgresql-devel

sudo pip3 install boto3

sudo pip3 install scikit-learn

sudo pip3 install psycopg2

sudo pip3 install urllib3==1.26.8

sudo pip3 install mlflow

echo 'mlflow server --backend-store-uri postgresql://postgres:avoid-plaintext-passwords@database-2.cz8vhnitws92.us-east-1.rds.amazonaws.com:5432/  --default-artifact-root=s3://mlflowpraveen -h 0.0.0.0 -p 5000' > /tmp/sam

