#!/bin/bash

# Prompt user for project name
read -p "Enter project name: " project_name

# Create project folder structure
mkdir -p "${project_name}/src/jobs"
mkdir "${project_name}/conf"

# Create .gitignore file
cat <<EOT > "${project_name}/.gitignore"
__pycache__/
*.pyc
*.pyo
*.egg-info/
dist/
*.log
*.csv
*.tsv
*.json
*.parquet
*.zip
*.gz
*.tar
*.tgz
*.snappy
*.avro
*.xml
*.tmp
*.bak
*.swp
*.swo
*.pickle
*.txt
.DS_Store
.idea/
.vscode/
*.iml
*.pyproj
*.sln
*.suo
*.user
*.sqlite3
*.db
*.pid
*.pid.lock
EOT

# Create a default configuration file
cat <<EOT > "${project_name}/conf/default.conf"
spark {
  app {
    name = "DefaultJob"
  }
}
EOT

# Create a default job
cat <<EOT > "${project_name}/src/jobs/default_job.py"
from pyspark.sql import SparkSession

if __name__ == "__main__":
    spark = SparkSession.builder \
        .appName("DefaultJob") \
        .getOrCreate()

    # Write your job logic here
    print("Hello, PySpark!")

    spark.stop()
EOT

# Initialize git repository
cd "${project_name}"
git init
git add .
git commit -m "Initial commit"

echo "Project ${project_name} has been created successfully."
