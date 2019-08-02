#! /bin/bash

PROCESS_LIST=("marketprice accessws accesshttp alertcenter readhistory matchengine")

for process in ${PROCESS_LIST[@]}; 
do 
    echo "-> kill "$process
    pids=`pgrep $process`
    for pid in ${pids[@]}; 
    do 
        #echo "pid="$pid; 
        kill -9 $pid;
    done

    rm -rf /tmp/$process.lock
done



