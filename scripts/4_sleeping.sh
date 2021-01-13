#!/bin/bash

# Step4 - Sleeping Before Restart 
logger "INFO" "sleeping" "Sleeping for ${SLEEPING_HOUR}hrs before restart elasticsearch..."
$(sleep ${SLEEPING_HOUR}m) 
