#!/bin/bash

base=$(cd $(dirname $0); pwd)
cd $base
killall -s SIGQUIT accesshttp.exe
sleep 1
./accesshttp.exe config.json
