#!/bin/bash
base=$(cd $(dirname $0); pwd)
cd $base

killall -s SIGQUIT readhistory.exe
sleep 1
./readhistory.exe config.json
