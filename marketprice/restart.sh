#!/bin/bash
base=$(cd $(dirname $0); pwd)
cd $base

killall -s SIGQUIT marketprice.exe
sleep 1
./marketprice.exe config.json
