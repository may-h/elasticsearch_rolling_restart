#!/bin/sh
LOG_STEP="Config Validation"

# Validate Configuration Value 
if [[ -z ${SLEEPING_HOUR} ]] || [[ -z ${ELASTICSEARCH_HOST} ]] || [[ -z ${ELASTICSEARCH_PORT} ]] || [[ -z ${ELASTICSEARCH_PATH} ]]; then 
    logger "ERROR" "$LOG_STEP" "Everything in \"./config/env.sh\" must be setted up"
    logger "ERROR" "$LOG_STEP" "Please check and set up the file"
    logger "EXIT" "$LOG_STEP" "Process stopped..."
    exit
fi

cd $ELASTICSEARCH_PATH
if [[ ! $? -eq 0 ]]; then 
    logger "ERROR" "$LOG_STEP" "\"ELASTICSEARCH_PATH\" is not validated"
    logger "ERROR" "$LOG_STEP" "Please check \"ELASTICSEARCH_PATH\" in \"./config/env.sh\" file"
    logger "EXIT" "$LOG_STEP" "Process stopped..."
    exit
fi 

if [[ ! -z ${SLEEPING_HOUR//[0-9]/} ]]; then 
    logger "ERROR" "$LOG_STEP" "\"SLEEPING_HOUR\" in \"config/env.sh\" must to be number"
    logger "ERROR" "$LOG_STEP" "Please set up \"SLEEPING_HOUR\" and retry"
    logger "EXIT" "$LOG_STEP" "Process stopped..."
    exit
fi

# Get Cluster Info (number_of_nodes, status)
CURRENT_NODES=`getNodesCount`
CLUSTER_STATUS=`getStatus`


# Print Configuration 
echo '************************ START ***************************'
echo '* START_TIME : ' $(date +"%Y-%m-%dT%H:%M:%S")
echo '* ELASTICSEARCH_HOST : '${ELASTICSEARCH_HOST}
echo '* ELASTICSEARCH_PORT : '${ELASTICSEARCH_PORT}
echo '* ELASTICSEARCH_PATH : '${ELASTICSEARCH_PATH}
echo '* CURRENT_NODE_NUM : '${CURRENT_NODES}
echo '* CLUSTER_STATUS : '${CLUSTER_STATUS}
echo '* SLEEPING_HOUR : '${SLEEPING_HOUR}hr
echo '**********************************************************'
echo ''