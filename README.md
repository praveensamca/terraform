Project Title: Machine Learning Model Training and Monitoring in AWS using Terraform and MLflow
1. Overview
This project involves building a machine learning model training pipeline that is hosted in an AWS environment. The entire infrastructure is provisioned using Terraform. Model training is conducted using a sample CSV dataset, and MLflow is used for experiment tracking and model monitoring.

2. Project Architecture
Components:
AWS Infrastructure:

EC2 instances for model training.
S3 for storage of data, artifacts, and models.
IAM roles for access management.
VPC, Security Groups for networking.
CloudWatch for logging and monitoring infrastructure.
Machine Learning:

Python environment for model training.
Libraries used: pandas, scikit-learn, etc.
Training data: A sample CSV file.
Model type: (Specify model, e.g., Linear Regression, Random Forest, etc.).
MLflow:

Used for logging model parameters, metrics, and artifacts.
Facilitates comparison of multiple models and experiment tracking.
Terraform:

Infrastructure as Code (IaC) for provisioning AWS resources.
All configurations stored in the GitHub repo Project Repository.
3. Prerequisites
AWS account with necessary permissions to create EC2, S3, VPC, IAM roles, etc.
Terraform installed locally.
Python installed with required ML libraries.
MLflow tracking server (if not using the local server, set up a remote MLflow server or use the hosted version).
Git installed for cloning the repository.
4. Setup and Configuration
Terraform Setup:
Clone the Repository:

bash
Copy code
git clone https://github.com/praveensamca/terraform
cd terraform
Terraform Init: Initialize Terraform to download required providers.

bash
Copy code
terraform init
Terraform Plan: Review the execution plan and verify the resources.

bash
Copy code
terraform plan
Terraform Apply: Apply the Terraform scripts to create the environment in AWS.

bash
Copy code
terraform apply
AWS Setup:
EC2 instances will be provisioned for the model training environment.
S3 buckets will be used to store datasets, model artifacts, and logs.
MLflow Setup:
Start MLflow server (if local):

bash
Copy code
mlflow server --backend-store-uri sqlite:///mlflow.db --default-artifact-root ./artifacts
Access MLflow UI by navigating to http://localhost:5000 or the remote tracking URI if using a remote server.

5. Model Training Pipeline
Steps:
Data Preprocessing:

Load the sample CSV data into a Pandas DataFrame.
Perform any necessary preprocessing like data cleaning, normalization, or feature engineering.
Model Training:

Select a machine learning algorithm.
Train the model on the dataset.
Log parameters, metrics, and the model using MLflow.
Example code:

from sklearn import *
import pandas as pd
import numpy as np
import boto3
from sklearn import metrics
import mlflow
import pickle


access_key = "XXXXXXXXXXXXXXXXXXXXXXXXXXX"
secret_key = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"

# Initialize the S3 resource with the access key and secret key
s3_resource = boto3.resource('s3', region_name='us-east-1', aws_access_key_id=access_key, aws_secret_access_key=secret_key)


bucket_name = 'mlflowpraveen'
object_key = 'home/Salary_Data.csv'

try:
    # Retrieve the S3 object
    s3_object = s3_resource.Object(bucket_name, object_key)
    
    # Read the CSV data directly into a pandas DataFrame
    df = pd.read_csv(s3_object.get()['Body'])
    
    # Now you can work with the DataFrame 'df'
    #print(df.head())  # Display the first few rows of the CSV data
except Exception as e:
    print(f"An error occurred: {e}")

print(dir(df))
my_data = df.copy()

x=my_data.iloc[:,:-1].values
y=my_data.iloc[:,-1].values
print(x,y)

x_train,x_test,y_train,y_test=model_selection.train_test_split(x,y,train_size=0.8,random_state=42)

mlflow.set_tracking_uri("http://52.55.153.228:5000")
mlflow.set_experiment("myexp")
with mlflow.start_run() as mlops:
        model=tree.DecisionTreeRegressor()
        model.fit(x_train,y_train)

        ans=model.predict(x_test)

        mse= metrics.mean_squared_error(ans,y_test)

        mlflow.log_metric("mse",mse)

        mlflow.log_param("max_depth",8)

        mlflow.sklearn.log_model(model,"model",registered_model_name = "demo-model")

Model Monitoring:

Use MLflow to monitor the training run and compare it with previous runs.
Store logs and artifacts in S3.
6. Outputs and Results
The output includes trained models, performance metrics (accuracy, F1 score, etc.), and logs.
MLflow captures the following:
Parameters used for training.
Model metrics (e.g., accuracy, loss).
Model artifacts (saved models, plots, etc.).
Comparison of different models based on experiments.
7. Monitoring and Maintenance
Use CloudWatch to monitor the health of AWS infrastructure.
MLflow UI allows you to compare models, view performance over time, and monitor the deployed model’s behavior.
8. Conclusion
This project demonstrates how to set up a scalable machine learning model training pipeline on AWS, with monitoring facilitated through MLflow. Terraform simplifies the infrastructure setup, while AWS services provide scalability and storage.

