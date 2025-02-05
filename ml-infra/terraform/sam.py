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

