#!/bin/sh

USER="mayhan9210@gmail.com"
PASSWORD="puubxbhazojxdowj"
SCRIPT=$0
APP_ROOT=`dirname "$SCRIPT"`
APP_ROOT=`cd "$APP_ROOT"/..; pwd`
SCRIPT_PATH=${APP_ROOT}/scripts
ERROR_LOG_FILE=${APP_ROOT}/logs/err_$(date +"%y%m%d").log
OUT_LOG_FILE=${APP_ROOT}/logs/out_$(date +"%y%m%d").log
EMAIL_TO=hms9210@naver.com

node ../scripts/email/send.js ${USER} ${PASSWORD} ${ERROR_LOG_FILE} ${OUT_LOG_FILE} ${EMAIL_TO}