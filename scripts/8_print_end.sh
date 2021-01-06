#!/bin/sh

# END - Print END 
echo '************************* END **************************'
echo '* END_TIME : ' $(date +"%Y-%m-%dT%H:%M:%S")
echo '* ELASTICSEARCH_HOST : '$(curl ${ELASTICSEARCH_HOST}:${ELASTICSEARCH_PORT}/_cluster/health)
echo '********************************************************'
echo ''