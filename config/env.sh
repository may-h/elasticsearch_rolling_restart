#!/bin/sh

# Set Elasticsearch Info(required) 
export ELASTICSEARCH_HOST=127.0.0.1
export ELASTICSEARCH_PORT=9200 
export ELASTICSEARCH_PATH=/Users/may-han/Documents/ELK/elasticsearch/elasticsearch-6.5.4

# Set Hours(required)
# 실행 시간으로부터 얼마나 엘라스틱서치가 정지되어 있을지 설정. 
export SLEEPING_HOUR=1

# Set Sending Email Mode 
export SEND_EMAIL_MODE=Y
export USER=mayhan9210@gmail.com
export PASSWORD=puubxbhazojxdowj
export EMAIL_TO=hms9210@naver.com