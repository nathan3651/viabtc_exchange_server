#!/bin/bash
base=$(cd $(dirname $0); pwd)
cd $base

killall -s SIGQUIT matchengine.exe
sleep 1
./matchengine.exe config.json
