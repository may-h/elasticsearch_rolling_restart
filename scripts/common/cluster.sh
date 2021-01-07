function getNodesCount() 
{
    CLUSTER=$(curl ${ELASTICSEARCH_HOST}:${ELASTICSEARCH_PORT}/_cluster/health)
    ARR=$(echo $CLUSTER | tr "," "\n" )
    NODE=$(echo $ARR | awk '{print $4}' | tr ":" "\n")
    CURRENT_NODE_COUNT=$(echo $NODE | awk '{print $2}')

    echo $CURRENT_NODE_COUNT
}

function getStatus() 
{
    CLUSTER=$(curl ${ELASTICSEARCH_HOST}:${ELASTICSEARCH_PORT}/_cluster/health)
    ARR=$(echo $CLUSTER | tr "," "\n" )
    CURRENT_STATUS=$(echo $ARR | awk '{print $2}' | tr ":" "\n")
    STATUS=$(echo $CURRENT_STATUS | awk '{print $2}')
    
    echo $STATUS
}


function getPid()
{
    PID_RESULT=$(ps -ef | grep elasticsearch | grep 'Xms'|  xargs | awk '{print $2}') 

    echo $PID_RESULT
}

function logElasticStatus() 
{
    logger "INFO" "Elasticsearch Status" "$(curl ${ELASTICSEARCH_HOST}:${ELASTICSEARCH_PORT})"
    logger "INFO" "Elasticsearch Status" "_cluster/settings : $(curl ${ELASTICSEARCH_HOST}:${ELASTICSEARCH_PORT}/_cluster/settings)"
}