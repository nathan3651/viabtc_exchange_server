#!/bin/bash

base=$(cd $(dirname $0); pwd)
cd $base

killall -s SIGQUIT accessws.exe
sleep 1
./accessws.exe config.json
