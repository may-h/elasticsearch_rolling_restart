# ELASTICSEARCH_PATH="/Users/may-han/Documents/ELK/elasticsearch\elasticsearch-6.8.5"



  
# cd $ELASTICSEARCH_PATH
# if [ $? -eq 0 ];then 

#     PWD=$(pwd)
#     echo ${PWD}
# else  
#     echo 'ERROR'
#     exit
# fi 
# echo 'DONE'

ERROR_LOG_FILE=/Users/may-han/study/elastic_rolling_restart/logs/error_test.log 
OUT_LOG_FILE=/Users/may-han/study/elastic_rolling_restart/logs/out_test.log

source .scripts/common/logger.sh
PID=312324
logger "ERROR" "test" "May is the great"
logger "INFO" "test2" "Elasticsearch process [${PID}] is successfully killed"