#!/bin/bash

# Define the UPS name and host
UPS_NAME="ups@localhost"  # Change if your UPS name or host is different

# Define battery thresholds and corresponding scripts
THRESHOLD_computer_01=30
THRESHOLD_computer_02=40
THRESHOLD_computer_03=50
THRESHOLD_computer_04=35
THRESHOLD_computer_05=45
THRESHOLD_computer_06=55

SCRIPT_01="/data/shutdown_computer_01.sh"
SCRIPT_02="/data/shutdown_computer_02.sh"
SCRIPT_03="/data/shutdown_computer_03.sh"
SCRIPT_04="/data/shutdown_computer_04.sh"
SCRIPT_05="/data/shutdown_computer_05.sh"
SCRIPT_06="/data/shutdown_computer_05.sh"

# Get the current battery charge level
BATTERY_LEVEL=$(upsc $UPS_NAME battery.charge)

# Log the battery level for reference
LOG_FILE="/var/log/battery_log.txt"
echo "Current battery level: $BATTERY_LEVEL%" >> $LOG_FILE

# Check for each threshold and execute the corresponding script
if [[ "$BATTERY_LEVEL" -le "$THRESHOLD_computer_01" ]]; then
    echo "Battery level is $BATTERY_LEVEL%, below $THRESHOLD_computer_01%. Running $SCRIPT_01." >> $LOG_FILE
    $SCRIPT_01  # Run the script to shutdown computer_01
elif [[ "$BATTERY_LEVEL" -le "$THRESHOLD_computer_02" ]]; then
    echo "Battery level is $BATTERY_LEVEL%, below $THRESHOLD_computer_02%. Running $SCRIPT_02." >> $LOG_FILE
    $SCRIPT_02  # Run the script to shutdown computer_02
elif [[ "$BATTERY_LEVEL" -le "$THRESHOLD_computer_03" ]]; then
    echo "Battery level is $BATTERY_LEVEL%, below $THRESHOLD_computer_03%. Running $SCRIPT_03." >> $LOG_FILE
    $SCRIPT_03  # Run the script to shutdown computer_03
elif [[ "$BATTERY_LEVEL" -le "$THRESHOLD_computer_04" ]]; then
    echo "Battery level is $BATTERY_LEVEL%, below $THRESHOLD_computer_04%. Running $SCRIPT_04." >> $LOG_FILE
    $SCRIPT_04  # Run the script to shutdown computer_04
elif [[ "$BATTERY_LEVEL" -le "$THRESHOLD_computer_05" ]]; then
    echo "Battery level is $BATTERY_LEVEL%, below $THRESHOLD_computer_05%. Running $SCRIPT_05." >> $LOG_FILE
    $SCRIPT_05  # Run the script to shutdown computer_05
elif [[ "$BATTERY_LEVEL" -le "$THRESHOLD_computer_06" ]]; then
    echo "Battery level is $BATTERY_LEVEL%, below $THRESHOLD_computer_06%. Running $SCRIPT_06." >> $LOG_FILE
    $SCRIPT_06  # Run the script to shutdown computer_06
else
    echo "Battery level is above $THRESHOLD_06%, no action needed." >> $LOG_FILE
fi
