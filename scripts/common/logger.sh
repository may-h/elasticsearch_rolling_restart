#!/bin/sh

function logger() 
{
    if [ $1 == "ERROR" ]; then 
        $(echo [$(date +"%Y-%m-%dT%H:%M:%S")][$1][$2] $3 | tee -a ${ERROR_LOG_FILE} ${OUT_LOG_FILE})
    elif [ $1 == "EXIT" ]; then 
        $(echo [$(date +"%Y-%m-%dT%H:%M:%S")][$1][$2] $3 | tee -a ${ERROR_LOG_FILE} ${OUT_LOG_FILE})
        if [[ $SEND_EMAIL_MODE == "Y" ]]; then 
            $(node ${SCRIPT_PATH}/email/send.js ${USER} ${PASSWORD} ${ERROR_LOG_FILE} ${OUT_LOG_FILE} ${EMAIL_TO})
        fi 
    else
        echo [$(date +"%Y-%m-%dT%H:%M:%S")][$1][$2] $3
    fi
}
