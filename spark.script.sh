#!/bin/bash

# Set the Spark home directory
SPARK_HOME="/home/ec2-user/opt/spark"

while true; do
    # Run the spark-submit command to retrieve the application list
    APPLICATION_LIST=$($SPARK_HOME/bin/spark2-class org.apache.spark.deploy.yarn.Client -list 2>/dev/null)

    # Extract the status column and count the occurrences of each status
    ACCEPTED_COUNT=$(echo "$APPLICATION_LIST" | grep -w "ACCEPTED" | wc -l)
    UNDEFINED_COUNT=$(echo "$APPLICATION_LIST" | grep -w "UNDEFINED" | wc -l)
    RUNNING_COUNT=$(echo "$APPLICATION_LIST" | grep -w "RUNNING" | wc -l)

    # Print the counts
    echo "ACCEPTED sessions: $ACCEPTED_COUNT"
    echo "UNDEFINED sessions: $UNDEFINED_COUNT"
    echo "RUNNING sessions: $RUNNING_COUNT"

    # Wait for 1 minutes (60 seconds) before the next iteration
    sleep 60
done
