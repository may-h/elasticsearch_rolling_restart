#!/bin/bash 

LOG_STEP="Cluster Check"

CLUSTER_STATUS=`getStatus`
CURRENT_NODES_NUM=`getNodesCount`

# Check cluster status 
if [[ $CLUSTER_STATUS == "red" ]]; then 
    logger "ERROR" "$LOG_STEP" "Cluster status is [red], service might be not working"
    logger "ERROR" "$LOG_STEP" "please check elasticsearch cluster"
    logger "EXIT" "$LOG_STEP" "Process stopped..."
    exit
fi

if [[ ! $CLUSTER_STATUS =~ "green" ]]; then 
    logger "DEBUG" "$LOG_STEP" "Expect cluster status is [\"green\"] but [${CLUSTER_STATUS}], please check elasticsearch cluster"
fi

# Check number of nodes 
# Compare current nodes count with before nodes count 
if [[ ! $CURRENT_NODES_NUM =~ $START_NODES_NUM ]]; then 
    logger "DEBUG" "$LOG_STEP" "Expect 'num_of_noes' is [${START_NODES_NUM}] but [${CURRENT_NODES_NUM}]."
fi
