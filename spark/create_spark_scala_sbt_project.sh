#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: $0 <project_name>"
    exit 1
fi

PROJECT_NAME="$1"
PROJECT_DIR="${PROJECT_NAME}"
SCALA_VERSION="2.12.10"
SPARK_VERSION="3.1.2"
DELTA_VERSION="1.0.0"

mkdir -p "${PROJECT_DIR}/src/main/scala/${PROJECT_NAME}"
mkdir -p "${PROJECT_DIR}/project"

echo "name := \"${PROJECT_NAME}\"
version := \"0.1\"
scalaVersion := \"${SCALA_VERSION}\"

libraryDependencies ++= Seq(
  \"org.apache.spark\" %% \"spark-sql\" % \"${SPARK_VERSION}\",
  \"org.apache.spark\" %% \"spark-sql-kafka-0-10\" % \"${SPARK_VERSION}\",
  \"io.delta\" %% \"delta-core\" % \"${DELTA_VERSION}\"
)
" > "${PROJECT_DIR}/build.sbt"

echo "sbt.version = 1.5.5" > "${PROJECT_DIR}/project/build.properties"

echo "Created SBT project in ${PROJECT_DIR}"
