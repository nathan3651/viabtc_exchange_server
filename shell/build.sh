#!/bin/bash
base=$(cd $(dirname $0); pwd)

DIR_LIST=("network utils depends/hiredis matchengine marketprice accesshttp accessws alertcenter readhistory")

for i in ${DIR_LIST[@]}; 
do 
    # echo $i; 
    make -C $base/../$i
done

$base/clean_obj.sh

