import org.apache.spark.sql.{SparkSession, functions => F}
import org.apache.spark.sql.streaming.OutputMode
import org.apache.spark.sql.types._

object KafkaToDeltaLake {
  def main(args: Array[String]): Unit = {
    val spark = SparkSession.builder
      .appName("KafkaToDeltaLake")
      .config("spark.jars.packages", "org.apache.spark:spark-sql-kafka-0-10_2.12:3.1.2,io.delta:delta-core_2.12:1.0.0")
      .config("spark.sql.extensions", "io.delta.sql.DeltaSparkSessionExtension")
      .config("spark.sql.catalog.spark_catalog", "org.apache.spark.sql.delta.catalog.DeltaCatalog")
      .getOrCreate()

    val schema = StructType(Seq(
      StructField("id", IntegerType, true),
      StructField("name", StringType, true),
      StructField("timestamp", TimestampType, true)
    ))

    val kafkaStreamDF = spark.readStream
      .format("kafka")
      .option("kafka.bootstrap.servers", "localhost:9092")
      .option("subscribe", "kafka-topic")
      .option("startingOffsets", "latest")
      .load()

    val jsonDeserializedDF = kafkaStreamDF.selectExpr("CAST(value AS STRING)")
      .select(F.from_json(F.col("value"), schema).as("data"))
      .select("data.*")

    val outputPath = "/path/to/delta-lake-table"

    val deltaStreamWriter = jsonDeserializedDF
      .writeStream
      .format("delta")
      .option("checkpointLocation", "/path/to/checkpoint")
      .outputMode(OutputMode.Append)
      .start(outputPath)

    deltaStreamWriter.awaitTermination()
  }
}