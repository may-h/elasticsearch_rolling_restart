#!/bin/bash

# Step3 - Elasticsearch PID CHECK & KILL 
 
PID=$(ps -ef | grep elasticsearch | grep 'Xms'|  xargs | awk '{print $2}')

# 3.1 PID CHECK ERROR (if PID is empty) 
if [[ -z ${PID} ]]; then 
      $(echo [$(date +"%Y-%m-%dT%H:%M:%S")][ERROR][Elasticsearch PID] PID not found.. [${PID}] | tee -a ${ERROR_LOG_FILE} ${OUT_LOG_FILE})
      $(echo [$(date +"%Y-%m-%dT%H:%M:%S")][ERROR][Elasticsearch PID] Please check elasticsearch process by below command | tee -a ${ERROR_LOG_FILE} ${OUT_LOG_FILE})
      $(echo [$(date +"%Y-%m-%dT%H:%M:%S")][ERROR][Elasticsearch PID] 'ps -ef | grep elasticsearch' | tee -a ${ERROR_LOG_FILE} ${OUT_LOG_FILE})
      $(echo [$(date +"%Y-%m-%dT%H:%M:%S")][ERROR][EXIT] Process stopped... | tee -a ${ERROR_LOG_FILE} ${OUT_LOG_FILE})
      exit
fi

# 3.2 PID CHECK SUCCESS 
echo [$(date +"%Y-%m-%dT%H:%M:%S")][INFO][Elasticsearch PID] Elasticsearch process ID check... The PID is [${PID}]
echo [$(date +"%Y-%m-%dT%H:%M:%S")][INFO][Elasticsearch PID] Elasticsearch will be killed.. 


# PID KILL 
KILL_RESULT=$(kill -9 ${PID})

# 3.3 PID KILL ERROR
if [[ ! -z ${KILL_RESULT} ]]; then 
    $(echo [$(date +"%Y-%m-%dT%H:%M:%S")][ERROR][Elasticsearch PID] Killing elsaticsearch PID [${PID}] went something wrong.. | tee -a ${ERROR_LOG_FILE} ${OUT_LOG_FILE})
    $(echo [$(date +"%Y-%m-%dT%H:%M:%S")][ERROR][Elasticsearch PID] Killing result is [${KILL_RESULT}], which is supposed to be empty | tee -a ${ERROR_LOG_FILE} ${OUT_LOG_FILE})
    $(echo [$(date +"%Y-%m-%dT%H:%M:%S")][EXIT] Process stopped... | tee -a ${ERROR_LOG_FILE} ${OUT_LOG_FILE})      exit
    exit
fi

# PROCESS DOUBLE CHECK 
CONNECTION_RESULT=$(curl ${ELASTICSEARCH_HOST}:${ELASTICSEARCH_PORT}); 

if [[ -z ${CONNECTION_RESULT} ]] && [[ -z ${KILL_RESULT} ]]; then
    # 3.4 PID KILL SUCCESS (KILL_RESULT="", CONNECTION_RESULT="")
    echo [$(date +"%Y-%m-%dT%H:%M:%S")][INFO][Elasticsearch PID] Elasticsearch process [${PID}] is successfully killed
    echo [$(date +"%Y-%m-%dT%H:%M:%S")][INFO][Elasticsearch PID] Check process ps -ef [$(ps -ef | grep elasticsearch | grep 'Xms'|  xargs | awk '{print $2}')]... 
else  
    # ERROR 
    $(echo [$(date +"%Y-%m-%dT%H:%M:%S")][ERROR][Elasticsearch PID] Elassticsearch process seems to be still running | tee -a ${ERROR_LOG_FILE} ${OUT_LOG_FILE})
    $(echo [$(date +"%Y-%m-%dT%H:%M:%S")][ERROR][Elasticsearch PID] Killing result is [${KILL_RESULT}], curl result is [${CONNECTION_RESULT}] | tee -a ${ERROR_LOG_FILE} ${OUT_LOG_FILE})
    $(echo [$(date +"%Y-%m-%dT%H:%M:%S")][EXIT] Process stopped... | tee -a ${ERROR_LOG_FILE} ${OUT_LOG_FILE})  
    exit
fi 


     