#!/bin/sh
LOG_STEP="Elasticsearch Connection"

# Step1 - Check Elasticsearch Connection. 
logger "INFO" "$LOG_STEP" "Checking elasticsearch connection..."

CONNECTION_RESULT=`connectionCheck` 
PID=`getPid`

# 1.1 - ERROR
if [[ -z ${CONNECTION_RESULT} ]] || [[ -z ${PID} ]]; then
    logger "ERROR" "$LOG_STEP" "Failed to connect to ${ELASTICSEARCH_HOST} port ${ELASTICSEARCH_PORT}: Connection refused"
    logger "ERROR" "$LOG_STEP" "curl result [${CONNECTION_RESULT}], pid result [${PID}]"
    logger "EXIT" "$LOG_STEP" "Elasticsearch has no connection.. Process stopped..."
    exit
fi

# 1.2 - SUCCESS
logger "INFO" "$LOG_STEP" "Elasticsearch is on connection to ${ELASTICSEARCH_HOST} port ${ELASTICSEARCH_PORT}"

# Log Elasticsearch Current Status 
logElasticStatus