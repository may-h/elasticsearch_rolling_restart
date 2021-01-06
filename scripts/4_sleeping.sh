#!/bin/bash

# Step4 - Sleeping Before Restart 
echo [$(date +"%Y-%m-%dT%H:%M:%S")][INFO][Elasticsearch PID] Sleeping for ${SLEEPING_HOUR}hrs before restart elasticsearch...  
$(sleep ${SLEEPING_HOUR}m) 