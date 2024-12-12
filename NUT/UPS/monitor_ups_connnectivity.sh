#!/bin/bash

# UPS name and host
UPS_NAME="ups@localhost"

# Command to check battery charge
UPS_COMMAND="upsc $UPS_NAME battery.charge"

# Run the command and capture the output
OUTPUT=$($UPS_COMMAND 2>&1)

# Check for "Error: Data stale" in the output
if echo "$OUTPUT" | grep -q "Error: Data stale"; then
    echo "Error: Data stale detected. Restarting NUT services..."

    # Log to syslog
    logger "ERROR: Detected 'Data stale' error for $UPS_NAME. Restarting NUT services."

    # Restart NUT services
    systemctl stop nut-server
    systemctl stop nut-monitor
    systemctl start nut-monitor
    systemctl start nut-server

    echo "NUT services restarted."
else
    echo "UPS status OK: $OUTPUT"
fi
