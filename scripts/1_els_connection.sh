#!/bin/sh

# Step1 - Check Elasticsearch Connection. 
# Elasticsearch Connection Check 
echo "[$(date +"%Y-%m-%dT%H:%M:%S")][INFO][Elasticsearch Connection] Checking elasticsearch connection..."
CONNECTION_RESULT=$(curl ${ELASTICSEARCH_HOST}:${ELASTICSEARCH_PORT}); 
PID_RESULT=$(ps -ef | grep elasticsearch | grep 'Xms'|  xargs | awk '{print $2}') 

# 1.1 - ERROR
if [[ -z ${CONNECTION_RESULT} ]] || [[ -z ${PID_RESULT} ]]; then
  $(echo [$(date +"%Y-%m-%dT%H:%M:%S")][ERROR][Elasticsearch Connection] Failed to connect to ${ELASTICSEARCH_HOST} port ${ELASTICSEARCH_PORT}: Connection refused | tee -a ${ERROR_LOG_FILE} ${OUT_LOG_FILE})
  $(echo [$(date +"%Y-%m-%dT%H:%M:%S")][ERROR][Elasticsearch Connection] curl result [${CONNECTION_RESULT}], pid result [${PID_RESULT}] | tee -a ${ERROR_LOG_FILE} ${OUT_LOG_FILE})
  $(echo [$(date +"%Y-%m-%dT%H:%M:%S")][ERROR][Exit] Elasticsearch has no connection.. Process stopped... | tee -a ${ERROR_LOG_FILE} ${OUT_LOG_FILE})
  echo ''
  exit
fi

# 1.2 - SUCCESS
echo [$(date +"%Y-%m-%dT%H:%M:%S")][INFO][Elasticsearch Connection] Elasticsearch is on connection to ${ELASTICSEARCH_HOST} port ${ELASTICSEARCH_PORT}

# Log Elasticsearch Current Status 
source ${SCRIPT_PATH}/1.2_log_elaticssearch_status.sh