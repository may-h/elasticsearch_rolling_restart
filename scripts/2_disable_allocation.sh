#!/bin/bash
LOG_STEP="Allocation Setting"

# Step 2 - Disable Shard Allocation 
logger "INFO" "$LOG_STEP" "Disable shard allocation.."

ALLOCATION_RESULT=$(curl -XPUT "http://${ELASTICSEARCH_HOST}:${ELASTICSEARCH_PORT}/_cluster/settings" -H 'Content-Type:application/json' -d '{"persistent" : {"cluster.routing.allocation.enable" : "primaries"}}')
  
# 2.1 ERRPR | If response's "acknowledged" is not true  
if [[ ! $ALLOCATION_RESULT =~ "true" ]]; then 
    # Diable Shard Allocation Setting Fail 
    logger "ERROR" "$LOG_STEP" "Disable allocation failed. allocation result [${ALLOCATION_RESULT}]"
    logger "EXIT" "$LOG_STEP" "Pldease check elasticsearch process.. process stopped.."
    exit
fi 

# 2.2 SUCCESS
logger "INFO" "$LOG_STEP" "Disable shard allocation success : ${ALLOCATION_RESULT}"
logger "INFO" "$LOG_STEP" "sleeping for 30s.."
sleep 30s