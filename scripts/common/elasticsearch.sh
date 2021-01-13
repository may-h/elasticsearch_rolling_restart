# Elasticsearch connection check  
function connectionCheck() 
{
   CONNECTION_RESULT=$(curl ${ELASTICSEARCH_HOST}:${ELASTICSEARCH_PORT}); 

   echo $CONNECTION_RESULT
}

# Get number_of_nodes of cluster 
function getNodesCount() 
{
    CLUSTER=$(curl ${ELASTICSEARCH_HOST}:${ELASTICSEARCH_PORT}/_cluster/health)
    ARR=$(echo $CLUSTER | tr "," "\n" )
    NODE=$(echo $ARR | awk '{print $4}' | tr ":" "\n")
    CURRENT_NODE_COUNT=$(echo $NODE | awk '{print $2}')

    echo $CURRENT_NODE_COUNT
}

# Get cluster status 
function getStatus() 
{
    CLUSTER=$(curl ${ELASTICSEARCH_HOST}:${ELASTICSEARCH_PORT}/_cluster/health)
    ARR=$(echo $CLUSTER | tr "," "\n" )
    CURRENT_STATUS=$(echo $ARR | awk '{print $2}' | tr ":" "\n")
    STATUS=$(echo $CURRENT_STATUS | awk '{print $2}')
    
    echo $STATUS
}

# Get elasticsearch process pid 
function getPid()
{
    PID_RESULT=$(ps -ef | grep elasticsearch | grep 'Xms'|  xargs | awk '{print $2}') 

    echo $PID_RESULT
}

# Log elasticsearch status 
function logElasticStatus() 
{
    logger "INFO" "Elasticsearch Status" "$(curl ${ELASTICSEARCH_HOST}:${ELASTICSEARCH_PORT})"
    logger "INFO" "Elasticsearch Status" "_cluster/settings : $(curl ${ELASTICSEARCH_HOST}:${ELASTICSEARCH_PORT}/_cluster/settings)"
}