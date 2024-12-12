#!/bin/bash

# Define the remote host and user
REMOTE_USER="username"
REMOTE_HOST="ip_address"

# Define the command to run on the remote host
REMOTE_COMMAND="/usr/sbin/shutdown"  # Replace with your desired command

# Define the log file to store the output
LOG_FILE="/data/logfile_computer_01.txt"

# Execute the command on the remote host and capture the output
ssh "$REMOTE_USER@$REMOTE_HOST" "$REMOTE_COMMAND" >> "$LOG_FILE" 2>&1

# Add a timestamp to the log
echo "Executed on: $(date)" >> "$LOG_FILE"
echo "---------------------------------------" >> "$LOG_FILE"
