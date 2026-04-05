import boto3
import os
import uuid
from PIL import Image
import io

s3 = boto3.client('s3')
dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('ImageProcessingLogs')

def thumbnail_handler(event, context):
    # 1. Get bucket and file name from the S3 event
    source_bucket = event['Records'][0]['s3']['bucket']['name']
    key = event['Records'][0]['s3']['object']['key']
    dest_bucket = os.environ['DEST_BUCKET']
    
    # 2. Download image into memory
    response = s3.get_object(Bucket=source_bucket, Key=key)
    original_size = response['ContentLength']
    image_content = response['Body'].read()
    
    # 3. Resize image using Pillow
    img = Image.open(io.BytesIO(image_content))
    img.thumbnail((128, 128)) # Standard thumbnail size
    
    buffer = io.BytesIO()
    img.save(buffer, format=img.format)
    buffer.seek(0)
    
    # 4. Upload to processed bucket
    new_key = f"thumb-{key}"
    s3.put_object(Bucket=dest_bucket, Key=new_key, Body=buffer)
    
    # 5. Log metadata to DynamoDB
    table.put_item(Item={
        'ImageID': str(uuid.uuid4()),
        'OriginalName': key,
        'OriginalSize': f"{original_size / 1024:.2f} KB",
        'Status': 'PROCESSED'
    })
    
    return {"status": "success"}