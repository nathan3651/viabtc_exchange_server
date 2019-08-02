#! /bin/bash
base=$(cd $(dirname $0); pwd)
cd $base
./wait-for-it.sh 127.0.0.1:6379 --timeout=60 --strict -- \
    ./wait-for-it.sh 127.0.0.1:26379 --timeout=60 --strict -- \
    ./wait-for-it.sh 127.0.0.1:9092 --timeout=60 --strict -- \
    ./wait-for-it.sh 127.0.0.1:3306 --timeout=60 --strict
