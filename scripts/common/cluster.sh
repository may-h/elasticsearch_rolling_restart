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
    SHARDS_NUM=$(echo $ARR | awk '{print $4}' | tr ":" "\n")
    CURRENT_NODE_COUNT=$(echo $SHARDS_NUM | awk '{print $2}')
    CURRENT_STATUS=$(echo $ARR | awk '{print $2}' | tr ":" "\n")
    STATUS=$(echo $CURRENT_STATUS | awk '{print $2}')
    
    echo $STATUS
}