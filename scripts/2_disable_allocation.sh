#!/bin/bash

# Step 2 - Disable Shard Allocation 
echo [$(date +"%Y-%m-%dT%H:%M:%S")][INFO][Allocation Setting] Disable shard allocation.. 
ALLOCATION_RESULT=$(curl -XPUT "http://${ELASTICSEARCH_HOST}:${ELASTICSEARCH_PORT}/_cluster/settings" -H 'Content-Type:application/json' -d '{"persistent" : {"cluster.routing.allocation.enable" : "primaries"}}')
  
# 2.1 ERRPR | If response's "acknowledged" is not true  
if [[ ! $ALLOCATION_RESULT =~ "true" ]]; then 
    # Diable Shard Allocation Setting Fail 
    $(echo [$(date +"%Y-%m-%dT%H:%M:%S")][ERROR][Allocation Setting] Disable allocation failed.. allocation result [${ALLOCATION_RESULT}] | tee -a ${ERROR_LOG_FILE} ${OUT_LOG_FILE})
    $(echo [$(date +"%Y-%m-%dT%H:%M:%S")][ERROR][Allocation Setting] ease check elasticsearch settings... process stopped... | tee -a ${ERROR_LOG_FILE} ${OUT_LOG_FILE})
    exit
fi 

# 2.2 SUCCESS
echo [$(date +"%Y-%m-%dT%H:%M:%S")][INFO][Allocation Setting] Disable shard allocation success : ${ALLOCATION_RESULT}
echo [$(date +"%Y-%m-%dT%H:%M:%S")][INFO][Allocation Setting] sleeping for 30s...
sleep 30s