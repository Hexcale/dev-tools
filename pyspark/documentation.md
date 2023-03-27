# Exemple of gpt-transformation output

def age_to_age_group(age):
    if 0 <= age <= 17:
        return "child"
    elif 18 <= age <= 64:
        return "adult"
    else:
        return "elderly"

spark = SparkSession.builder \
    .appName("Dataset Transformation") \
    .getOrCreate()

data = spark.read.csv(dataset_info["data_source"], header=True, inferSchema=True)

# Register the UDF (User-Defined Function) to be used in the DataFrame API
from pyspark.sql.functions import udf
from pyspark.sql.types import StringType

age_to_age_group_udf = udf(age_to_age_group, StringType())

# Apply the transformation
transformed_data = data.withColumn("age_group", age_to_age_group_udf(data["age"]))

# Show the transformed data
transformed_data.show()