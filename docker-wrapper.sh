#!/bin/bash

# Start MySQL
service mysql start
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start MySQL: $status"
  exit $status
fi

# Start Cron
service cron start
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start Cron: $status"
  exit $status
fi


# Start Apache2
service apache2 start
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start Apache: $status"
  exit $status
fi



while sleep 60; do
  ps aux |grep mysql |grep -q -v grep
  PROCESS_1_STATUS=$?
  ps aux |grep apache2 |grep -q -v grep
  PROCESS_2_STATUS=$?
  ps aux | grep cron | grep -q -v grep
  PROCESS_3_STATUS=$?
  # If the greps above find anything, they exit with 0 status
  # If they are not equal to 0, then something is wrong
  if [ $PROCESS_1_STATUS -ne 0 -o $PROCESS_2_STATUS -ne 0 -o $PROCESS_3_STATUS -ne 0 ]; then
    echo "One of the processes failed to start."
    exit 1
  fi
done
