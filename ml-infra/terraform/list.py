import boto3

# Initialize the S3 client
s3 = boto3.client('s3')

# Replace 'your_bucket_name' with your actual bucket name
bucket_name = 'mlflowpraveen'

try:
    # List objects within the bucket
    response = s3.list_objects_v2(Bucket=bucket_name)

    # Iterate over the objects and print their keys
    if 'Contents' in response:
        for obj in response['Contents']:
            print(obj['Key'])
    else:
        print("No objects found in the bucket.")

except Exception as e:
    print("An error occurred:", e)
