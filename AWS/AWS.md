<h1 align="center">Hi 👋, I'm AVINESH MASIH</h1>
<p align="center">
  <a href="https://github.com/avinesh-masih">
    <img src="https://readme-typing-svg.demolab.com/?lines=%F0%9F%9A%80+Welcome+to+My+AWS+Assignment!+%F0%9F%91%8B&font=Fira%20Code&center=true&width=600&height=50&color=ceff18&vCenter=true&pause=1000&size=24" />
  </a>
</p>

---

[![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/avineshlko/)  [![Portfolio](https://img.shields.io/badge/Portfolio-000000?style=for-the-badge&logo=githubpages&logoColor=white)](https://avinesh-masih.github.io/)  [![Email](https://img.shields.io/badge/Email-D14836?style=for-the-badge&logo=gmail&logoColor=white)](mailto:skmasih11@gmail.com)  [![PayPal](https://img.shields.io/badge/PayPal-009CDE?style=for-the-badge&logo=paypal&logoColor=white)](https://paypal.me/AVINESHMASIH)  [![Buy Me A Coffee](https://img.shields.io/badge/Buy%20Me%20A%20Coffee-FFDD00?style=for-the-badge&logo=buy-me-a-coffee&logoColor=black)](https://buymeacoffee.com/avineshlko)

---



## Q1. Explain the difference between AWS Regions, Availability Zones, and Edge Locations. Why is this important for data analysis and latency-sensitive applications?

**Answer:**

AWS infrastructure is organized into **Regions**, **Availability Zones (AZs)**, and **Edge Locations**, each serving different purposes to optimize performance, availability, and latency.

- **AWS Regions:** A Region is a geographically separate area around the world where AWS has data centers. Each Region contains multiple Availability Zones and operates independently. Examples include `us-east-1` (N. Virginia), `eu-west-1` (Ireland). Regions allow customers to deploy applications closer to their users or comply with local data regulations.

- **Availability Zones (AZs):** An Availability Zone is one or more discrete data centers within a Region that are engineered to be isolated from failures in other AZs. AZs provide high availability and fault tolerance by allowing users to deploy redundant resources across zones within the same Region.

- **Edge Locations:** Edge Locations are data centers located globally to serve content through the AWS Content Delivery Network (CloudFront). They cache copies of data closer to users to reduce latency and improve performance for content delivery.

**Why is this important for data analysis and latency-sensitive applications?**

For data analysis and latency-sensitive workloads, choosing the right Region and AZ is critical because it affects the speed and availability of data processing. Deploying resources in Regions close to data sources or end users reduces network latency. Using multiple AZs enhances fault tolerance and uptime for critical applications. Edge Locations improve response time by caching data nearer to users, which is essential for applications requiring fast content delivery and minimal delay.

----

## Q2. Using the AWS CLI, list all available AWS regions. Share the command used and the output.

**Answer:**

To list all available AWS regions using the AWS CLI, the following command can be executed. This command queries the AWS EC2 service for all regions:

```bash
aws ec2 describe-regions --query "Regions[].RegionName" --output text
```
**Screenshot:**

![AWS CLI Screenshot](assets/Q2_AWS_CLI_List_Regions.png)

---

## Q3. Create a new IAM user with least privilege access to Amazon S3. Share your attached policies (JSON or screenshot).

**Answer:**  
**Steps Performed:**
1. Created a new IAM user named `avinesh-pw `.
2. Created a custom IAM policy to allow limited S3 access (List, Get, Put, Delete) only for the bucket: `S3Access-avinesh-pw-bucket`.
3. Attached the policy to the user using IAM Console.

**Policy JSON Used:**
```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllowLimitedS3Access",
      "Effect": "Allow",
      "Action": [
        "s3:ListBucket",
        "s3:GetObject",
        "s3:PutObject",
        "s3:DeleteObject"
      ],
      "Resource": [
        "arn:aws:s3:::avinesh-pw-bucket",
        "arn:aws:s3:::avinesh-pw-bucket/*"
      ]
    }
  ]
}
```
**Screenshot:**

![IAM User with S3 Access Policy](assets/Q3_IAM_User_S3_Policy.png)

---

## Q4: Compare different Amazon S3 storage classes (Standard, Intelligent-Tiering, Glacier). When should each be used in data analytics workflows?

**Answer:**

Amazon S3 offers multiple storage classes optimized for different use cases:

- **S3 Standard:**  
  - Designed for frequently accessed data.  
  - Provides low latency and high throughput.  
  - Best for active datasets and real-time analytics where quick access to data is crucial.  
  - Use Case: Storing raw or processed data actively queried or updated during analysis.

- **S3 Intelligent-Tiering:**  
  - Automatically moves data between two access tiers (frequent and infrequent) based on usage patterns.  
  - Ideal for datasets with unpredictable or changing access patterns.  
  - Saves cost without performance impact as it shifts data to cheaper tiers automatically.  
  - Use Case: When usage patterns are unknown or variable during analytics projects.

- **S3 Glacier:**  
  - Designed for archival and long-term backup.  
  - Much cheaper but retrieval takes minutes to hours.  
  - Suitable for historical data or audit logs that rarely need to be accessed but must be retained.  
  - Use Case: Storing old analytical data or backups that aren’t accessed regularly but kept for compliance or trend analysis.

In data analytics workflows, choosing the right storage class balances cost with performance and access needs.

---

## Q5. Create an S3 bucket and upload a sample dataset (CSV or JSON). Enable versioning and show at least two versions of one file.

**Answer:**


1. Created an S3 bucket named `avinesh-pw-bucket`.
2. Enabled versioning on the bucket through the AWS Management Console.
3. Uploaded a JSON file `avinesh-pw-json.json` with the original data:

```json
{
  "name": "Avinesh Masih",
  "age": 30,
  "gender": "Male"
}

```
4. Uploaded a second version of the same file `avinesh-pw-json.json` with updated age:

```json
{
  "name": "Avinesh Masih",
  "age": 23,
  "gender": "Male"
}
```

**Screenshot:**

![S3 Bucket Versioning Screenshot](assets/Q4_S3_Bucket_Versioning.png)

---
## Q6. Write and apply a lifecycle policy to move files to Glacier after 30 days and delete them after 90 days. Share the policy JSON or Screenshot.

**Answer:**

1. Created and applied a lifecycle policy on the S3 bucket (`avinesh-pw-bucket`) to automatically transition objects to Glacier storage after 30 days and delete them after 90 day.


2. Used the AWS Management Console > S3 > Management > Lifecycle Rules to add and enable this rule.

3. Verified that the lifecycle rule is active on the bucket.

**Json:**

```json
{
  "Rules": [
    {
      "ID": "MoveToGlacierAfter30Days_DeleteAfter90Days",
      "Filter": {
        "Prefix": ""
      },
      "Status": "Enabled",
      "Transitions": [
        {
          "Days": 30,
          "StorageClass": "GLACIER"
        }
      ],
      "Expiration": {
        "Days": 90
      }
    }
  ]
}
```

---

## Q7. Compare RDS, DynamoDB, and Redshift for use in different stages of a data pipeline. Give one use case for each.

**Answer:**

| Service            | Best Use Stage in Data Pipeline        | Description                                                                 | Example Use Case                                                       |
|--------------------|----------------------------------------|-----------------------------------------------------------------------------|------------------------------------------------------------------------|
| **Amazon RDS**     | Data Ingestion & OLTP (Transactional)  | Managed relational DB (MySQL, PostgreSQL, etc.) for structured transactional data. | Storing user registration and order data for a retail web app.         |
| **Amazon DynamoDB**| Real-Time Ingestion & NoSQL Workloads  | Fully managed NoSQL DB for low-latency key-value/document use cases.        | Tracking real-time session data and product catalog in e-commerce.     |
| **Amazon Redshift**| Data Analytics & BI (Data Warehouse)   | Managed columnar data warehouse for running complex analytical queries.     | Generating monthly business reports and visualizations from sales data.|

---
## Q8. Create a DynamoDB table and insert 3 records manually. Then write a Lambda function that adds records when triggered by S3 uploads.

**Answer:**

**1. Created DynamoDB Table**
I logged into the AWS Management Console, navigated to DynamoDB, and created a new table named `AvineshTable` with `id` as the Partition Key (string).

**2. Inserted 3 Records Manually**
In the DynamoDB console, I selected the table, clicked on "Explore Table Items," then clicked "Create Item."  
I added the following 3 records in this format:
```json
{
  "id": { "S": "1" },
  "name": { "S": "Avinesh" },
  "age": { "N": "23" }
}
```
**3. Wrote Lambda Function** 
- I wrote the following AWS Lambda function in Python. This function triggers on S3 upload events, reads the JSON file uploaded to S3, parses it, and inserts the data as a record in DynamoDB.

```python
import json
import boto3

s3 = boto3.client('s3')
dynamodb = boto3.client('dynamodb')
table_name = 'AvineshTable'

def lambda_handler(event, context):
    for record in event['Records']:
        bucket = record['s3']['bucket']['name']
        key = record['s3']['object']['key']

        response = s3.get_object(Bucket=bucket, Key=key)
        content = response['Body'].read().decode('utf-8')

        data = json.loads(content)

        item = {}
        for k, v in data.items():
            if isinstance(v, int):
                item[k] = {'N': str(v)}
            else:
                item[k] = {'S': str(v)}

        dynamodb.put_item(TableName=table_name, Item=item)

    return {
        'statusCode': 200,
        'body': json.dumps('Record inserted successfully')
    }
```
**4. Created S3 Bucket and Configured Trigger**
I created an S3 bucket and configured it to trigger the Lambda function on `PUT` object events.

**5. Tested Lambda by Uploading JSON Files**
I uploaded JSON files to the S3 bucket with content like:

```json
{
  "id": "4",
  "name": "Shivam",
  "age": 22
}
```
After uploading, I verified in DynamoDB that the new record was inserted successfully.

**6. Verified Everything Worked**
Checked Lambda logs in CloudWatch to confirm no errors.

Checked DynamoDB table to confirm new items from S3 uploads were added.

**Screenshot:**

![Q8 DynamoDBSetup](assets/Q8_DynamoDBSetup_Screenshot.png)

![Q8 Logs](assets/Q8_logs_Screenshot.png)

---

## Q9. What is serverless computing? Discuss pros and cons of using AWS Lambda for data pipelines.

**Answer:**

Serverless computing is a cloud computing execution model where the cloud provider dynamically manages the allocation and provisioning of servers. Developers write and deploy code without having to manage infrastructure, allowing them to focus on application logic. AWS Lambda is a popular serverless compute service that runs code in response to events and automatically manages the underlying compute resources.

**Pros of using AWS Lambda for data pipelines:**
- **Scalability:** Automatically scales based on the number of incoming events without manual intervention.
- **Cost-effective:** You pay only for the compute time you consume, no charges when code is not running.
- **Reduced operational overhead:** No need to manage servers or runtime environments.
- **Event-driven:** Integrates seamlessly with other AWS services, triggering functions based on data uploads, database changes, etc.

**Cons of using AWS Lambda for data pipelines:**
- **Execution time limits:** Functions have a maximum execution timeout (currently 15 minutes), which may be limiting for long-running tasks.
- **Cold start latency:** Initial invocation of functions can have latency, which might affect real-time data processing.
- **Resource limits:** Limited CPU, memory, and temporary storage compared to dedicated servers.
- **Complex debugging:** Distributed event-driven architecture can make debugging and monitoring more challenging.

---
## Q10. Create a Lambda function triggered by S3 uploads that logs file name, size, and timestamp to CloudWatch. Share code and a log screenshot.

**Answer:**

1. **Created an S3 bucket** named `avinesh-masih-log`.
2. **Created a Lambda function** named `LogS3UploadInfo`.
3. **Gave necessary permissions** to Lambda for S3 and CloudWatch.
4. **Set up S3 as a trigger** for the Lambda function (event type: `ObjectCreated`).
5. **Used the following Python code** in the Lambda function to log required details:

**Lambda Function Code:**

```python
import json
import boto3
from datetime import datetime

def lambda_handler(event, context):
    for record in event['Records']:
        bucket = record['s3']['bucket']['name']
        key = record['s3']['object']['key']
        size = record['s3']['object']['size']
        time = record['eventTime']

        print(f"File uploaded:")
        print(f"- Bucket: {bucket}")
        print(f"- File Name: {key}")
        print(f"- File Size: {size} bytes")
        print(f"- Upload Time: {time}")

    return {
        'statusCode': 200,
        'body': json.dumps('File info logged successfully')
    }
```

**Screenshot:**

![Lambda CloudWatch Log 1 Screenshot](assets/lambda-cloudwatch-log.png)

![Lambda CloudWatch Log 2 Screenshot](assets/lambda-cloudwatch-log-2.png)

---
## Q11. Use AWS Glue to crawl your S3 dataset, create a Data Catalog table, and run a Glue job to convert CSV data to parquet. Share job code and output location.

**Answer:**

**S3 Dataset Source**
- **Bucket Name**: `avinesh-pw-bucket`
- **Folder**: `csv-data/`
- **CSV File Example**: `s3://avinesh-pw-bucket/csv-data/pw-sample.csv`

**1. Crawled the S3 Dataset**

- **Service Used**: AWS Glue Crawler
- **Crawler Name**: `CSVToParquetCrawler`
- **Output Database**: `csv_database`
- **Table Name Created**: `csv_data`


**2. Created a Glue Job to Convert CSV to Parquet**

- **Job Name**: `CSVtoParquetJob`
- **IAM Role**: `AWSGlueServiceRole-avinesh`
- **Type**: Spark
- **Script Language**: Python

**Glue Job Code:**

```python
import sys
from awsglue.transforms import *
from awsglue.utils import getResolvedOptions
from pyspark.context import SparkContext
from awsglue.context import GlueContext
from awsglue.job import Job

# Initialize Glue context
args = getResolvedOptions(sys.argv, ['JOB_NAME'])
sc = SparkContext()
glueContext = GlueContext(sc)
spark = glueContext.spark_session
job = Job(glueContext)
job.init(args['JOB_NAME'], args)

# --------------------------------------------
# Step 1: Read CSV data from Data Catalog table
# --------------------------------------------
datasource = glueContext.create_dynamic_frame.from_catalog(
    database="csv_database",
    table_name="csv_data", 
    transformation_ctx="datasource"
)

# --------------------------------------------
# Step 2: Write data to Parquet format in S3
# --------------------------------------------
glueContext.write_dynamic_frame.from_options(
    frame=datasource,
    connection_type="s3",
    connection_options={
        "path": "s3://avinesh-pw-bucket/parquet-data/"
    },
    format="parquet",
    transformation_ctx="datasink"
)

# --------------------------------------------
# Finalize job
# --------------------------------------------
job.commit()

```
**Output Location:**

```bash
s3://avinesh-pw-bucket/parquet-data/part-00000-fa7eba9f-21d5-453f-a382-463dab9d8c3c-c000.snappy.parquet

```
**Screenshot:**

![Crawler Setup](assets/glue-crawler-setup.png)

![Glue Job Run](assets/glue-job-csv-to-parquet-run.png)

![Parquet File in S3](assets/s3-parquet-file-path.png)

---

## Q12. Explain the difference between Kinesis Data Streams, Kinesis Firehose, and Kinesis Data Analytics. Provide a real-world example of how each would be used.

**Answer:**

- Difference Between Kinesis Data Streams, Kinesis Firehose, and Kinesis Data Analytics

| Service                | Description                                                                                          | Real-World Example                                                      |
|------------------------|--------------------------------------------------------------------------------------------------|------------------------------------------------------------------------|
| **Kinesis Data Streams** | A scalable and durable real-time data streaming service. Allows custom processing and storage of streaming data. | Real-time log processing from thousands of web servers to detect anomalies immediately. |
| **Kinesis Firehose**     | Fully managed service to load streaming data into data stores like S3, Redshift, or Elasticsearch with minimal setup. Automatically batches, compresses, and encrypts data. | Streaming social media feeds directly into an S3 data lake for later analysis. |
| **Kinesis Data Analytics** | Service to process and analyze streaming data in real-time using SQL or Apache Flink without managing infrastructure. | Monitoring live IoT sensor data to generate alerts based on thresholds or trends. |

**Summary:**

- **Kinesis Data Streams** is for custom real-time stream processing and storage.
- **Kinesis Firehose** is for simple loading of streaming data into AWS data stores.
- **Kinesis Data Analytics** is for real-time analytics on streaming data using SQL or Flink.

---
## Q13. What is columnar storage and how does it benefit Redshift performance for analytics workloads?

**Answer:**

**Columnar Storage** is a method of storing data in a database where the data is stored column-wise rather than row-wise. Instead of storing all fields of a single row together, the values of each column are stored sequentially.

**Benefits of Columnar Storage in Redshift for Analytics:**

- **Efficient Data Compression:** Since data in a column tends to be of the same type and similar values, it compresses better, reducing storage costs and speeding up data retrieval.

- **Faster Query Performance:** Analytics queries often involve scanning a subset of columns. Columnar storage allows Redshift to read only the relevant columns, minimizing I/O and improving query speed.

- **Improved Parallel Processing:** Redshift distributes column data across nodes, enabling parallel processing and faster aggregation and filtering operations.

- **Optimized for Aggregations:** Since columns are stored contiguously, aggregation functions like SUM, AVG, COUNT can be computed more efficiently.

**Summary:**
Columnar storage enables Redshift to process large-scale analytic workloads efficiently by reducing I/O, improving compression, and leveraging parallelism.

---
## Q14.  Load a CSV file from S3 into Redshift using the COPY command. Share table schema, command used, and sample output from a query.

**Answer:**

Loading a CSV File from S3 into Redshift Using the COPY Command

**Table Schema:** 
I created a table named `sales_data` in Amazon Redshift with the following schema:

```sql
CREATE TABLE sales_data (
    id INT,
    product_name VARCHAR(100),
    quantity INT,
    price DECIMAL(10, 2),
    sale_date DATE
);
```
**COPY Command Used:**
To load the CSV file from my S3 bucket `(s3://avinesh-pw-bucket/csv-data/sales_data.csv)` into the `sales_data` table, I used the following COPY command:

```sql
COPY sales_data
FROM 's3://avinesh-pw-bucket/csv-data/sales_data.csv'
IAM_ROLE 'arn:aws:iam::938320847089:role/MyRedshiftS3Role'
CSV
IGNOREHEADER 1
DATEFORMAT 'DD-MM-YYYY';
```
- The `IAM_ROLE` used has permission to access the S3 bucket.

- `IGNOREHEADER 1` skips the header row.

- DATEFORMAT `DD-MM-YYYY` ensures the date column is parsed correctly.

**Output from Query:**

| id | product\_name      | quantity | price  | sale\_date |
| -- | ------------------ | -------- | ------ | ---------- |
| 1  | Apple iPhone 14    | 10       | 799.99 | 2023-05-01 |
| 2  | Samsung Galaxy S23 | 15       | 699.99 | 2023-05-02 |
| 3  | Google Pixel 7     | 8        | 599.99 | 2023-05-03 |
| 4  | OnePlus 11         | 12       | 649.99 | 2023-05-04 |
| 5  | Sony Xperia 5      | 5        | 899.99 | 2023-05-05 |

**Screenshot:**


![Redshift COPY Command Execution](assets/redshift-copy-command.png)

![Redshift Query Editor with SELECT Output](assets/redshift-query-output.png)

---
## Q15. What is the role of the AWS Glue Data Catalog in Athena? How does schema-on-read work?

**Answer:**

The **AWS Glue Data Catalog** acts as a centralized metadata repository for Athena. It stores table definitions, schema information, and location details of data stored in Amazon S3. When I query data using Athena, it refers to the Glue Data Catalog to understand the structure of the data files without needing to move or transform the data.

**Schema-on-read** means that Athena applies the schema to the data at the time of the query, not when the data is stored. This allows me to store raw data in S3 in formats like CSV, JSON, or Parquet, and define or change the schema later without reprocessing the data. Athena reads the data files and interprets them according to the schema defined in the Glue Data Catalog only when I run a query, providing great flexibility for analytics on semi-structured or evolving datasets.

---

## Q16. Create an Athena table from S3 data using Glue Catalog. Run a query and share the SQL + result screenshot


**Answer:**

Creating an Athena Table from S3 Data Using Glue Data Catalog and Running a Query

**1. Crawl S3 Data with AWS Glue**

- I uploaded my dataset (CSV files) to the S3 bucket: `s3://avinesh-pw-bucket/csv-data/`.
- In AWS Glue, I created a crawler to scan this S3 location.
- The crawler created a database named `csv_database` and a table named `csv_data` in the Glue Data Catalog.

**2. Create Athena Table Using Glue Catalog**

- In the Athena console, I selected the database `csv_database`.
- I found the table `csv_data` automatically created by the Glue crawler.
- No manual table creation SQL was needed as Glue Catalog provided the metadata.

**3. Run a Query in Athena**

I ran a sample query to fetch all records:

```sql
SELECT * FROM csv_database.csv_data LIMIT 10;
```

**4. View Query Results**

- The query successfully returned the data stored in my S3 bucket.

- I took a screenshot of the Athena query editor showing the SQL query and the result table.

**SQL Query Used:**

```sql
SELECT * FROM csv_database.csv_data LIMIT 10;
```

**Screenshot:**

![Athena Query Result Screenshot](assets/athena_query_result.png)

---

## Q17. Describe how Amazon Quicksight supports business intelligence in a serverless data architecture. What are SPICE and embedded dashboards?

Amazon QuickSight is a fully managed, serverless business intelligence (BI) service offered by AWS. It lets businesses create interactive dashboards and reports without having to worry about managing servers or infrastructure. Since it’s serverless, AWS automatically handles scaling and maintenance, making it easy to analyze data quickly and cost-effectively.

QuickSight works smoothly with many AWS data sources like S3, Redshift, Athena, and RDS, allowing users to connect to their data directly and get insights fast. This fits well in modern cloud architectures where resources scale on demand.

**What is SPICE?**

SPICE stands for Super-fast, Parallel, In-memory Calculation Engine. It is QuickSight’s in-memory engine designed to speed up data queries and analytics. Here’s why SPICE is important:

- It loads and compresses data in memory for super fast access.
- It speeds up query responses, even with large datasets.
- By doing the heavy lifting in-memory, it reduces the load on your main databases.
- It supports many users accessing dashboards at the same time without slowing down.

Because of SPICE, QuickSight can deliver quick, interactive data exploration without performance issues.

**What are Embedded Dashboards?**

Embedded dashboards let developers integrate QuickSight reports and visuals directly into their own websites or applications. This means:

- Users can view and interact with analytics without leaving the app.
- Organizations can provide analytics as part of their product or service.
- Access can be secured and customized for different users.
- Embedding is done via APIs, making integration smooth and flexible.

**Summary:**

Amazon QuickSight makes business intelligence easy by providing a serverless, scalable solution. With SPICE, it offers fast in-memory data processing, and with embedded dashboards, it allows analytics to be seamlessly integrated into apps. Together, these features help organizations get actionable insights quickly and efficiently.

---

## Q18. Connect Quicksight to Athena or Redshift and build a dashboard with at least one calculated field and one filter. Share a screenshot of your final dashboard.

**Answer:**

I connected **Amazon QuickSight** to **Amazon Athena** as the data source. The data was stored in an **S3 bucket** (`s3://avinesh-pw-us/sales/`) and queried using **Athena** after setting up the external table.

## Steps Performed

- Created a dataset using the Athena table.
- Built a **bar chart visualization** to analyze sales data by product and region.
- Created a **calculated field** named `Profit`, calculated as:

  ```sql
  Profit = revenue - cost
  ```
- Applied a filter on the region field to allow users to view performance by specific regions.

- Designed the dashboard with additional visuals for better insight.

**Screenshot:**

![Query Output](assets/athena-query-output.png)

![QuickSight Dashboard](assets/quicksight-dashboard.png)

---

## Q19. Explain how AWS CloudWatch and CloudTrail differ. IN a data analytics pipeline, what role does each play in monitoring, auditing, and troubleshooting?

**Answer:**

**AWS CloudWatch** is a monitoring and observability service that collects and tracks metrics, logs, and events from AWS resources and applications. It helps you understand the operational health and performance of your systems in real time. You can set alarms, create dashboards, and get notifications for unusual activity.

**AWS CloudTrail**, on the other hand, is a governance, compliance, and auditing service. It records API calls and user activity across your AWS account. CloudTrail provides a history of actions taken through the AWS Management Console, SDKs, command-line tools, and other AWS services.

### Roles in a Data Analytics Pipeline

- **CloudWatch in Data Analytics Pipeline:**
  - Monitors the health and performance of analytics services like AWS Glue, Lambda functions, Redshift clusters, or EC2 instances.
  - Tracks resource usage (CPU, memory, disk, etc.) and data pipeline metrics.
  - Sends alerts if jobs fail, slow down, or if there are capacity issues.
  - Helps troubleshoot pipeline performance issues through log analysis.

- **CloudTrail in Data Analytics Pipeline:**
  - Audits user and service activity related to data access, configuration changes, and permission modifications.
  - Tracks who triggered pipeline runs, changes to data sources, or modifications in security policies.
  - Supports compliance and forensic analysis by providing a detailed record of all API calls.
  - Helps detect unauthorized or unexpected actions that may affect data security.

**Summary:**

In a data analytics pipeline, CloudWatch focuses on **monitoring** the system’s health and performance in real time, while CloudTrail provides **auditing** and **security oversight** by recording all activity for compliance and troubleshooting. Together, they ensure the pipeline runs smoothly, securely, and transparently.

---

## Q20. Describe a complete end-to-end data analytics pipeline using AWS services. Include services for data ingestion, storage, transformation, querying, and visualization. (Example: S3 -+ Lambda Glue Quicksight) Explain why you would choose each service for the stage it's used in.

**Answer:**

**End-to-End Data Analytics Pipeline on AWS**

This pipeline demonstrates how to build a scalable, cost-effective, and serverless data analytics workflow using AWS services.

**1. Data Ingestion – Amazon Kinesis or AWS Lambda**

- **Service Used:** `Amazon Kinesis Data Streams` or `AWS Lambda`
- **Purpose:** Capture real-time or batch data from sources like IoT devices, web apps, or external APIs.
- **Why Kinesis?** Ideal for streaming large-scale, real-time data.
- **Why Lambda?** Perfect for event-based ingestion (e.g., uploading CSV to S3 triggers processing).

**2. Data Storage – Amazon S3**

- **Service Used:** `Amazon S3`
- **Purpose:** Serves as a durable, scalable, and cost-efficient storage layer for raw and processed data.
- **Why S3?** Can handle both structured and unstructured data. Integrates seamlessly with almost all AWS analytics tools.

**3. Metadata Management – AWS Glue Data Catalog**

- **Service Used:** `AWS Glue Data Catalog`
- **Purpose:** Automatically catalogs and organizes datasets stored in S3 for easy discovery.
- **Why Glue Catalog?** Provides a central metadata repository used by Glue, Athena, and Quicksight.

**4. Data Transformation – AWS Glue**

- **Service Used:** `AWS Glue (ETL Jobs)`
- **Purpose:** Cleans, transforms, and prepares data for analytics (e.g., converting CSV to Parquet, removing duplicates).
- **Why Glue?** It's serverless, supports both visual and code-based transformations, and scales automatically.

**5. Query & Analysis – Amazon Athena**

- **Service Used:** `Amazon Athena`
- **Purpose:** SQL-based querying directly on data stored in S3.
- **Why Athena?** Serverless, pay-per-query, and integrates well with Glue Catalog. Great for ad hoc analysis.

**6. Data Warehousing (Optional) – Amazon Redshift**

- **Service Used:** `Amazon Redshift`
- **Purpose:** For complex, high-performance analytics on large structured datasets.
- **Why Redshift?** Best when needing optimized performance on large-scale joins and aggregations.

**7. Visualization – Amazon QuickSight**

- **Service Used:** `Amazon QuickSight`
- **Purpose:** Create interactive dashboards, reports, and business intelligence visualizations.
- **Why QuickSight?** It's serverless, integrates with Athena, Redshift, and S3, and uses SPICE for fast performance.

**Bonus: Monitoring & Auditing**

- **CloudWatch:** Monitors ETL job metrics, Lambda invocations, system performance.
- **CloudTrail:** Tracks user activities and access logs across the pipeline.

**Summary of the Pipeline**

| Stage             | AWS Service       | Role |
|------------------|-------------------|------|
| Ingestion         | Kinesis / Lambda  | Real-time or event-based data capture |
| Storage           | S3                | Central data lake |
| Metadata          | Glue Data Catalog | Discover & structure data |
| Transformation    | Glue Jobs         | ETL processing |
| Query             | Athena / Redshift | SQL-based analytics |
| Visualization     | QuickSight        | Dashboards and BI |
| Monitoring/Audit  | CloudWatch / CloudTrail | Observability and compliance |

This architecture ensures high scalability, cost-efficiency (serverless), and flexibility. It can be used for everything from basic reporting to complex machine learning pipelines.

---

<footer style="text-align: center; padding: 1rem; font-size: 0.9rem; color: #666;">
  &copy; 2025 <a href="https://avinesh-masih.github.io/" target="_blank" style="color: inherit; text-decoration: underline;">Avinesh Masih</a>. All rights reserved.
</footer>

---
