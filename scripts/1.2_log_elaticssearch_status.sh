#!/bin/sh
#LOG_STEP="Elasticsearch Status"

# Log Elasticsearch Status  
#logElasticStatus
# logger "INFO" "$LOG_STEP" "$(curl ${ELASTICSEARCH_HOST}:${ELASTICSEARCH_PORT})"
# logger "INFO" "$LOG_STEP" "_cluster/settings : $(curl ${ELASTICSEARCH_HOST}:${ELASTICSEARCH_PORT}/_cluster/settings)"

#echo [$(date +"%Y-%m-%dT%H:%M:%S")][INFO][Elasticsearch Status] $(curl ${ELASTICSEARCH_HOST}:${ELASTICSEARCH_PORT})
#echo [$(date +"%Y-%m-%dT%H:%M:%S")][INFO][Elasticsearch Status] _cat/health : $(curl ${ELASTICSEARCH_HOST}:${ELASTICSEARCH_PORT}/_cat/health)
#echo [$(date +"%Y-%m-%dT%H:%M:%S")][INFO][Elasticsearch Status] _cluster/health : $(curl ${ELASTICSEARCH_HOST}:${ELASTICSEARCH_PORT}/_cluster/health)
#echo [$(date +"%Y-%m-%dT%H:%M:%S")][INFO][Elasticsearch Status] _cluster/settings : $(curl ${ELASTICSEARCH_HOST}:${ELASTICSEARCH_PORT}/_cluster/settings)
  
  