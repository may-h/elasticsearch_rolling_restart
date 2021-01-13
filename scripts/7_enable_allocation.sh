#!/bin/bash
LOG_STEP="Allocation Setting"

#Step5 - Enable allocation as default 
logger "INFO" "$LOG_STEP" "Enable shard allocation.."

ALLOCATION_RESULT=$(curl -XPUT "http://${ELASTICSEARCH_HOST}:${ELASTICSEARCH_PORT}/_cluster/settings" -H 'Content-Type:application/json' -d '{"persistent" : {"cluster.routing.allocation.enable" : null}}')
  
# Fail 
if [[ ! $ALLOCATION_RESULT =~ "true" ]]; then 
    # Enable Allocation Setting Fail 
    logger "ERROR" "$LOG_STEP" "Disable allocation failed. allocation result [${ALLOCATION_RESULT}]"
    logger "EXIT" "$LOG_STEP" "Please check elasticsearch setting.. process stopped.."
    exit
fi

# Success
logger "INFO" "$LOG_STEP" "Enable shard allocation success"
logger "INFO" "$LOG_STEP" "Let me sleep for 30s.."
sleep 30s
logger "INFO" "$LOG_STEP" "_cluster/settings : $(curl ${ELASTICSEARCH_HOST}:${ELASTICSEARCH_PORT}/_cluster/settings)"
