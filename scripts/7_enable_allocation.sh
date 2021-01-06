#!/bin/bash

#Step5 - Enable allocation as default 
echo [$(date +"%Y-%m-%dT%H:%M:%S")][INFO][Allocation Setting] Enable shard allocation.. 
ALLOCATION_RESULT=$(curl -XPUT "http://${ELASTICSEARCH_HOST}:${ELASTICSEARCH_PORT}/_cluster/settings" -H 'Content-Type:application/json' -d '{"persistent" : {"cluster.routing.allocation.enable" : null}}')
  
# Fail 
if [[ ! $ALLOCATION_RESULT =~ "true" ]]; then 
    # Enable Allocation Setting Fail 
    $(echo [$(date +"%Y-%m-%dT%H:%M:%S")][ERROR][Allocation Setting] Enable allocation failed.. allocation result [${ALLOCATION_RESULT}] | tee -a ${ERROR_LOG_FILE} ${OUT_LOG_FILE})
    $(echo [$(date +"%Y-%m-%dT%H:%M:%S")][ERROR][Allocation Setting] ease check elasticsearch settings... process stopped... | tee -a ${ERROR_LOG_FILE} ${OUT_LOG_FILE})
    exit
fi

# Success
echo [$(date +"%Y-%m-%dT%H:%M:%S")][INFO][Allocation Setting] Enable shard allocation success :${ALLOCATION_RESULT}
echo [$(date +"%Y-%m-%dT%H:%M:%S")][INFO][Allocation Setting] Let me sleep for 30s ...
sleep 30s
echo [$(date +"%Y-%m-%dT%H:%M:%S")][INFO][Elasticsearch Status] _cluster/settings : $(curl ${ELASTICSEARCH_HOST}:${ELASTICSEARCH_PORT}/_cluster/settings)
