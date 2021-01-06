#!/bin/sh

echo I am in test


# if [[ ! $TEST =~ "true" ]]; then 
#     echo its false!!
#     exit
# fi
CLUSTER='{"cluster_name":"elasticsearch","status":"yellow","timed_out":false,"number_of_nodes":2,"number_of_data_nodes":1,"active_primary_shards":5,"active_shards":5,"relocating_shards":0,"initializing_shards":0,"unassigned_shards":5,"delayed_unassigned_shards":0,"number_of_pending_tasks":0,"number_of_in_flight_fetch":0,"task_max_waiting_in_queue_millis":0,"active_shards_percent_as_number":50.0}'
ALLOCATION='{"persistent":{"cluster":{"routing":{"allocation":{"enable":"primaries"}}}},"transient":{}}'
# if [[ $ALLOCATION == '{"persistent":{},"transient":{}}' ]]; then 
#     echo same
# fi

ARR=$(echo $CLUSTER | tr "," "\n" )

SHARDS_NUM=$(echo $ARR | awk '{print $4}' | tr ":" "\n")
echo $SHARDS_NUM | awk '{print $2}'
# for ar in $ARR
# do 
#     echo $ar
#done

SLEEPING_HOUR=asdgd
if [[ -z ${SLEEPING_HOUR//[0-9]/} ]]; then
   echo $SLEEPING_HOUR is number 
   exit
fi

echo $SLEEPING_HOUR it not number