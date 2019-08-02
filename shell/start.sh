#! /bin/bash

base=$(cd $(dirname $0); pwd)
cd $base

# redis
/etc/init.d/redis-server start
/etc/init.d/redis-sentinel start


# kafka
./kafka-srv.sh

# exchange server
mkdir -p /var/log/trade/

./wait-deps.sh &&\
    echo ">>> matchengine starting" &&\
    ./../matchengine/restart.sh &&\
    ./wait-for-it.sh 127.0.0.1:7316 --timeout=60 --quiet --strict -- \
    echo ">>> matchengine started on 7316"

echo ">>> readhistory starting" &&\
    ./../readhistory/restart.sh &&\
    ./wait-for-it.sh 127.0.0.1:7424 --timeout=60 --quiet --strict -- \
    echo ">>> readhistory started on 7424"

echo ">>> alertcenter starting..." &&\
    ./../alertcenter/restart.sh &&\
    ./wait-for-it.sh 127.0.0.1:4444 --timeout=60 --quiet --strict -- \
    echo ">>> alertcenter started on 4444"

echo ">>> accesshttp starting..." &&\
    ./../accesshttp/restart.sh &&\
    ./wait-for-it.sh 127.0.0.1:8080 --timeout=60 --quiet --strict -- \
    echo ">>> accesshttp started on 8080"


echo ">>> accessws starting..." &&\
    ./../accessws/restart.sh &&\
    ./wait-for-it.sh 127.0.0.1:8091 --timeout=60 --quiet --strict -- \
    echo ">>> accessws started on 8091"

echo ">>> marketprice starting..." &&\
    ./../marketprice/restart.sh &&\
    ./wait-for-it.sh 127.0.0.1:7416 --timeout=60 --quiet --strict -- \
    echo ">>> marketprice started on 7416"

ps -ef

touch /var/log/trade/matchengine.log
tail -f /var/log/trade/matchengine.log





