#!/bin/bash
base=$(cd $(dirname $0); pwd)

DIR_LIST=("matchengine marketprice accesshttp accessws alertcenter 
    readhistory hashex network utils depends/hiredis")

for i in ${DIR_LIST[@]}; 
do 
    # echo $i; 
    make -C $base/../$i clean
    rm -rf $base/../$i/core
done

# vscode ipch
rm -rf $base/../.vscode/ipch

find $base/../ -name "*.exe" -type f  -print -exec rm -rf '{}' \;
find $base/../ -name "*core" -type f  -print -exec rm -rf '{}' \;
