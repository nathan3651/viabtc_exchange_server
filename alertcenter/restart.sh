#!/bin/bash
base=$(cd $(dirname $0); pwd)
cd $base

killall -s SIGQUIT alertcenter.exe
sleep 1
./alertcenter.exe config.json
