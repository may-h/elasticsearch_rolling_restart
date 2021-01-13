#!/bin/sh

CURRENT_NODES_NUM=`getNodesCount`
CLUSTER_STATUS=`getStatus`
ELASTICSEARCH_PID=`getPid`

# END - Print END 
echo '************************* END **************************'
echo '* END_TIME : ' $(date +"%Y-%m-%dT%H:%M:%S")
echo '* CURRENT_NODE_NUM : '${CURRENT_NODES_NUM}
echo '* CLUSTER_STATUS : '${CLUSTER_STATUS}
echo '* ELASTICSEARCH_PID : '${ELASTICSEARCH_PID}
echo '********************************************************'
echo ''