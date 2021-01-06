
function logger() 
{
    if [ $1 == "ERROR" ]; then 
        $(echo [$(date +"%Y-%m-%dT%H:%M:%S")][$1][$2] $3 | tee -a ${ERROR_LOG_FILE} ${OUT_LOG_FILE})
    else 
        echo [$(date +"%Y-%m-%dT%H:%M:%S")][$1][$2] $3
    fi
}
