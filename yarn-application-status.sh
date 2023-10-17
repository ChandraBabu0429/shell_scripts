#!/bin/bash
## Function to count applications and display the results
count_applications() {
    # Run the yarn application -list command using the provided path
    applications=$($YARN_PATH application -list 2>&1)

    accepted_count=$(echo "$applications" | awk 'NR>2 {print $6}' | grep -c "ACCEPTED")
    running_count=$(echo "$applications" | awk 'NR>2 {print $6}' | grep -c "RUNNING")
    submitted_count=$(echo "$applications" | awk 'NR>2 {print $6}' | grep -c "SUBMITTED")

    # Append the output to the output.log file
    echo "Number of ACCEPTED applications: $accepted_count" >> /home/ec2-user/output.log
    echo "Number of RUNNING applications: $running_count" >> /home/ec2-user/output.log
    echo "Number of SUBMITTED applications: $submitted_count" >> /home/ec2-user/output.log

    # Create the email body with all counts
    email_body="Number of ACCEPTED applications: $accepted_count\n"
    email_body+="Number of RUNNING applications: $running_count\n"
    email_body+="Number of SUBMITTED applications: $submitted_count\n"

    # Send email notification
    echo -e "$email_body" | mail -s "YARN Application Counts" seenathur.chandrababu@gmail.com

}

# Call the function to count applications and append output to the file
count_applications
