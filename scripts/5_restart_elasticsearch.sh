#!/bin/bash
LOG_STEP="Elasticsearch Restart"

# Step5 - Restart Elasticsearch
logger "INFO" "$LOG_STEP" "Starting elasticsearch... "
${ELASTICSEARCH_PATH}/bin/elasticsearch -d  

logger "INFO" "$LOG_STEP" "Waiting for 30s until elasticsearch is on process"
sleep 30s 

# Elasticsearch Connection Check 
source ${SCRIPT_PATH}/1_els_connection.sh
