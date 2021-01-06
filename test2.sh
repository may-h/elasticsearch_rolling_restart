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
# time="$(date +"%Y-%m-%dT%H:%M:%S")"
# msg="[$time][tt][ss] msg"
# $(echo $time $msg|tee -a ${ERROR_LOG_FILE} ${OUT_LOG_FILE})

test() 
{
    echo ""
    return "hello"
    
}

MSG="`test`"

echo $?