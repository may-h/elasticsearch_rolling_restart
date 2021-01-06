#!/bin/sh

# Validate Configuration Value 
if [[ -z ${SLEEPING_HOUR} ]] || [[ -z ${ELASTICSEARCH_HOST} ]] || [[ -z ${ELASTICSEARCH_PORT} ]] || [[ -z ${ELASTICSEARCH_PATH} ]]; then 
    $(echo [$(date +"%Y-%m-%dT%H:%M:%S")][ERROR][Config Validation] Everything in \"./config/env.sh\" must be setted up | tee -a ${ERROR_LOG_FILE} ${OUT_LOG_FILE})
    $(echo [$(date +"%Y-%m-%dT%H:%M:%S")][ERROR][Config Validation] Please check and set up the file   | tee -a ${ERROR_LOG_FILE} ${OUT_LOG_FILE})
    $(echo [$(date +"%Y-%m-%dT%H:%M:%S")][EXIT][Config Validation] Process stopped... | tee -a ${ERROR_LOG_FILE} ${OUT_LOG_FILE})
    exit
fi

if [[ ! -z ${SLEEPING_HOUR//[0-9]/} ]]; then 
    $(echo [$(date +"%Y-%m-%dT%H:%M:%S")][ERROR][Config Validation] \"SLEEPING_HOUR\" in \"config/env.sh\" must to be number  | tee -a ${ERROR_LOG_FILE} ${OUT_LOG_FILE})
    $(echo [$(date +"%Y-%m-%dT%H:%M:%S")][ERROR][Config Validation] Please set up \"SLEEPING_HOUR\" and retry   | tee -a ${ERROR_LOG_FILE} ${OUT_LOG_FILE})
    $(echo [$(date +"%Y-%m-%dT%H:%M:%S")][EXIT][Config Validation] Process stopped...   | tee -a ${ERROR_LOG_FILE} ${OUT_LOG_FILE})
    exit
fi


# Print Configuration 
echo '******************** Configuration **********************'
echo '* START_TIME : ' $(date +"%Y-%m-%dT%H:%M:%S")
echo '* ELASTICSEARCH_HOST : '${ELASTICSEARCH_HOST}
echo '* ELASTICSEARCH_PORT : '${ELASTICSEARCH_PORT}
echo '* ELASTICSEARCH_PATH : '${ELASTICSEARCH_PATH}
echo '* SLEEPING_HOUR : '${SLEEPING_HOUR}hr
echo '**********************************************************'
echo ''