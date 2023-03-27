## Spark Project Tools

This repository contains scripts that help you set up a Spark Scala SBT or a PySpark project with Kafka and Delta Lake dependencies. The first script is a bash script that creates the folder structure and configuration files for a Spark project. The second script is a Spark job that reads data from Kafka and writes it to a Delta Lake table.

### Scala
#### Prerequisites for Scala

    Scala
    SBT (Scala Build Tool)
    Apache Kafka
    Delta Lake

#### Scripts
create_spark_scala_sbt_project.sh

This bash script creates the folder structure and configuration files for a new Spark Scala SBT project. The generated project will include the necessary dependencies for Spark SQL, Spark SQL Kafka, and Delta Lake.
#### Usage

```bash
./create_spark_scala_sbt_project.sh <project_name>
```
Replace <project_name> with your desired project name.
KafkaToDeltaLake.scala

This Scala script is a Spark Structured Streaming job that reads data from a Kafka topic and writes it to a Delta Lake table.
Usage

    Copy the KafkaToDeltaLake.scala script into the src/main/scala/<project_name> folder of your SBT project.
    Replace the Kafka broker address, topic name, and paths for the Delta Lake table and checkpoint location in the script.
    Run the Spark job using SBT:

```bash
sbt run
```
Setup Instructions

    Clone this repository:

```bash
git clone https://github.com/your_username/spark-scala-sbt-project-creator.git
```
    Navigate to the project directory:

```bash
cd spark-scala-sbt-project-creator
```
    Give execute permissions to the bash script:

```bash
chmod +x create_spark_scala_sbt_project.sh
```
    Run the bash script with your desired project name:

```bash
./create_spark_scala_sbt_project.sh MySparkProject
```
    Copy the KafkaToDeltaLake.scala script into the src/main/scala/<project_name> folder of your SBT project.
    Replace the Kafka broker address, topic name, and paths for the Delta Lake table and checkpoint location in the script.
    Run the Spark job using SBT:

```bash
sbt run
```
License

This project is licensed under the MIT License - see the LICENSE file for details.

Please note that the example scripts and instructions provided in this README are for educational purposes only. Be sure to test and adapt them to your specific needs before using them in a production environment.