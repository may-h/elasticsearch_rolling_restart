#!/bin/bash 

CLUSTER=$(curl ${ELASTICSEARCH_HOST}:${ELASTICSEARCH_PORT}/_cluster/health)
ALLOCATION=$(curl ${ELASTICSEARCH_HOST}:${ELASTICSEARCH_PORT}/_cluster/settings)

# If cluster status is red 
if [[ $CLUSTER == '"status":"red"' ]]; then 
    $(echo "[$(date +"%Y-%m-%dT%H:%M:%S")][ERROR][CLUSTER CHECK] Cluster status is [red], service might be not working" | tee -a ${ERROR_LOG_FILE} ${OUT_LOG_FILE})
    $(echo "[$(date +"%Y-%m-%dT%H:%M:%S")][ERROR][CLUSTER CHECK] please check elasticsearch cluster" | tee -a ${ERROR_LOG_FILE} ${OUT_LOG_FILE})
    $(echo "[$(date +"%Y-%m-%dT%H:%M:%S")][ERROR][EXIT] process stopped..." | tee -a ${ERROR_LOG_FILE} ${OUT_LOG_FILE})
    exit
fi

# Check number of nodes 
if [[ ! $CLUSTER =~ 'number_of_nodes":2' ]]; then 
    $(echo "[$(date +"%Y-%m-%dT%H:%M:%S")][DEBUG][CLUSTER CHECK] Number of nodes is not [2], please check elasticsearch cluster" | tee -a ${ERROR_LOG_FILE} ${OUT_LOG_FILE})
fi

# Check cluster status 
if [[ ! $CLUSTER =~ '"status":"green"' ]]; then 
    $(echo "[$(date +"%Y-%m-%dT%H:%M:%S")][DEBUG][CLUSTER CHECK] Cluster status is not [green], please check elasticsearch cluster" | tee -a ${ERROR_LOG_FILE} ${OUT_LOG_FILE})
fi

# Check allocation settings 
if [[ ! $ALLOCATION == '{"persistent":{},"transient":{}}' ]]; then 
    $(echo "[$(date +"%Y-%m-%dT%H:%M:%S")][ERROR][CLUSTER CHECK] Enable shard allocation is not succesfully setted up" | tee -a ${ERROR_LOG_FILE} ${OUT_LOG_FILE})
    $(echo "[$(date +"%Y-%m-%dT%H:%M:%S")][ERROR][CLUSTER CHECK] Cluster setting supposed to be [{"persistent":{},"transient":{}}] but current setting is [$ALLOCATION]" | tee -a ${ERROR_LOG_FILE} ${OUT_LOG_FILE})
    $(echo "[$(date +"%Y-%m-%dT%H:%M:%S")][ERROR][CLUSTER CHECK] Please set up cluster setting manually by below curl command" | tee -a ${ERROR_LOG_FILE} ${OUT_LOG_FILE})
    $(echo "[$(date +"%Y-%m-%dT%H:%M:%S")][ERROR][CLUSTER CHECK] curl -XPUT "http://${ELASTICSEARCH_HOST}:${ELASTICSEARCH_PORT}/_cluster/settings" -H 'Content-Type:application/json' -d '{"persistent" : {"cluster.routing.allocation.enable" : null}}'" | tee -a ${ERROR_LOG_FILE} ${OUT_LOG_FILE})
    $(echo "[$(date +"%Y-%m-%dT%H:%M:%S")][ERROR][EXIT] Process stopped..." | tee -a ${ERROR_LOG_FILE} ${OUT_LOG_FILE})
    exit
fi

