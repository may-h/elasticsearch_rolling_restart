#!/bin/bash

# Step5 - Restart Elasticsearch
echo [$(date +"%Y-%m-%dT%H:%M:%S")][INFO][Elasticsearch Restart] Starting elasticsearch... 
echo [$(date +"%Y-%m-%dT%H:%M:%S")][INFO][Elasticsearch Restart] Elasticsearch directory [${ELASTICSEARCH_PATH}/bin/elasticsearch]
${ELASTICSEARCH_PATH}/bin/elasticsearch -d  

echo [$(date +"%Y-%m-%dT%H:%M:%S")][INFO][Elasticsearch Restart] Waiting for 30s until elasticsearch is on process  
sleep 30s 

# Elasticsearch Connection Check 
source ${SCRIPT_PATH}/1_els_connection.sh
source ${SCRIPT_PATH}/1.2_log_elaticssearch_status.sh
