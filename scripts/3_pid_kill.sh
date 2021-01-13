#!/bin/bash

# Step3 - Elasticsearch PID CHECK & KILL 
LOG_STEP="Elasticsearch PID"
PID=`getPid`
 
# 3.1 PID CHECK 
if [[ -z ${PID} ]]; then 
    logger "ERROR" "$LOG_STEP" "Expect PID is not empty but it's empty.."
    logger "ERROR" "$LOG_STEP" "Please check elasticsearch process by below command "
    logger "ERROR" "$LOG_STEP" "'ps -ef | grep elasticsearch'"
    logger "EXIT" "$LOG_STEP" "Process stopped..."
    exit
fi

logger "INFO" "$LOG_STEP" "Elasticsearch process ID check... PID is [${PID}]"
logger "INFO" "$LOG_STEP" "Elasticsearch will be killed."

# 3.2 PID KILL 
KILL_RESULT=$(kill -9 ${PID})

# PID KILL ERROR - Retry
if [[ ! -z ${KILL_RESULT} ]]; then 
    logger "ERROR" "$LOG_STEP" "Got something wrong while killing the PID [${PID}]"
    logger "ERROR" "$LOG_STEP" "Killing result is [${KILL_RESULT}], which is supposed to be empty."
    logger "ERROR" "$LOG_STEP" "Retry.."

    PID=`getPid`
    KILL_RESULT=$(kill -9 ${PID})

    if [[ ! -z ${KILL_RESULT} ]]; then 
        logger "ERROR" "$LOG_STEP" "Can not kill [${PID}] PID process. Please check."
        logger "EXIT" "$LOG_STEP" "Process stopped..."
        exit
    fi
fi



# PID KILL SUCCESS (if KILL_RESULT="", CONNECTION_RESULT="")
CONNECTION_RESULT=`connectionCheck`
if [[ -z ${CONNECTION_RESULT} ]] && [[ -z ${KILL_RESULT} ]]; then
    logger "INFO" "$LOG_STEP" "Elasticsearch process [${PID}] is successfully killed"
else  
    # ERROR 
    logger "ERROR" "$LOG_STEP" "Elassticsearch process seems to be still running"
    logger "ERROR" "$LOG_STEP" "Killing result is [${KILL_RESULT}], curl result is [${CONNECTION_RESULT}]"
    logger "EXIT" "$LOG_STEP" "Process stopped..."
    exit
fi 


     