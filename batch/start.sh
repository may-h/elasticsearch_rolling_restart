#!/bin/sh

# Set directory
SCRIPT=$0
APP_ROOT=`dirname "$SCRIPT"`
APP_ROOT=`cd "$APP_ROOT"/..; pwd`
SCRIPT_PATH=${APP_ROOT}/scripts
ERROR_LOG_FILE=${APP_ROOT}/logs/err_$(date +"%y%m%d").log
OUT_LOG_FILE=${APP_ROOT}/logs/out_$(date +"%y%m%d").log

# Include environment
source $APP_ROOT/config/env.sh
source $SCRIPT_PATH/common/logger.sh

# Step 0 - Validate & Print Configuration 
source ${SCRIPT_PATH}/0_validate_config.sh >> ${OUT_LOG_FILE}

# Step 1 - Check Elasticsearch Connection. 
source ${SCRIPT_PATH}/1_els_connection.sh >> ${OUT_LOG_FILE}

# Step 2 - Disable Shard Allocation 
source ${SCRIPT_PATH}/2_disable_allocation.sh >> ${OUT_LOG_FILE}

# Step 3 - Elasticsearch PID CHECK & KILL 
source ${SCRIPT_PATH}/3_pid_kill.sh >> ${OUT_LOG_FILE}

# Step 4 - Sleeping Before Restart 
source ${SCRIPT_PATH}/4_sleeping.sh >> ${OUT_LOG_FILE}

# Step 5 - Restart Elasticsearch
source ${SCRIPT_PATH}/5_restart_elasticsearch.sh >> ${OUT_LOG_FILE}

# Step 6 - Cluster Check
source ${SCRIPT_PATH}/6_cluster_check.sh >> ${OUT_LOG_FILE}

# Step 7 - Enable allocation as default 
source ${SCRIPT_PATH}/7_enable_allocation.sh >> ${OUT_LOG_FILE}

# Process End 
source ${SCRIPT_PATH}/8_print_end.sh >> ${OUT_LOG_FILE}
