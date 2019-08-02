#!/bin/bash

base=$(cd $(dirname $0); pwd)

DIR_LIST=("matchengine marketprice accesshttp accessws alertcenter 
    readhistory network utils depends/hiredis")

for i in ${DIR_LIST[@]}; 
do 
    # echo $i; 
    rm -rf $base/../$i/*.o
done

