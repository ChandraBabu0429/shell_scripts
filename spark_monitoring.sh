#!/bin/bash

# Set the Spark home directory
SPARK_HOME="/path/to/your/spark"

EMAIL_TO="your-email@example.com"
SMTP_SERVER="smtp.example.com"
SMTP_PORT="587"
SMTP_USER="your-smtp-username"
SMTP_PASS="your-smtp-password"

THRESHOLD_PERCENTAGE=80
ACCEPTED_THRESHOLD=$((THRESHOLD_PERCENTAGE * 10)) # Convert percentage to actual value out of 1000

while true; do
    # Run the spark-submit command to retrieve the application list
    APPLICATION_LIST=$($SPARK_HOME/bin/spark2-class org.apache.spark.deploy.yarn.Client -list 2>/dev/null)

    # Extract the status column and count the occurrences of each status
    ACCEPTED_COUNT=$(echo "$APPLICATION_LIST" | grep -w "ACCEPTED" | wc -l)
    UNDEFINED_COUNT=$(echo "$APPLICATION_LIST" | grep -w "UNDEFINED" | wc -l)
    RUNNING_COUNT=$(echo "$APPLICATION_LIST" | grep -w "RUNNING" | wc -l)

    # Calculate the accepted threshold
    ACCEPTED_THRESHOLD_COUNT=$((ACCEPTED_THRESHOLD * ACCEPTED_COUNT))

    # Print the counts
    echo "ACCEPTED sessions: $ACCEPTED_COUNT"
    echo "UNDEFINED sessions: $UNDEFINED_COUNT"
    echo "RUNNING sessions: $RUNNING_COUNT"

    # Check if the accepted sessions exceed the threshold
    if [ "$ACCEPTED_COUNT" -ge "$ACCEPTED_THRESHOLD_COUNT" ]; then
        # Prepare the email message
        EMAIL_SUBJECT="High Number of ACCEPTED Sessions"
        EMAIL_MESSAGE="ACCEPTED sessions have exceeded the $THRESHOLD_PERCENTAGE% threshold.\n\nACCEPTED sessions: $ACCEPTED_COUNT\nUNDEFINED sessions: $UNDEFINED_COUNT\nRUNNING sessions: $RUNNING_COUNT"

        # Send email
        echo -e "$EMAIL_MESSAGE" | mail -s "$EMAIL_SUBJECT" -S smtp="smtp://$SMTP_SERVER:$SMTP_PORT" -S smtp-auth=login -S smtp-auth-user="$SMTP_USER" -S smtp-auth-password="$SMTP_PASS" "$EMAIL_TO"
    fi

    # Wait for 1 minute (60 seconds) before the next iteration
    sleep 60
done
