#!/bin/bash

# kafka
/etc/init.d/zookeeper stop
cd /opt/kafka; sudo nohup bin/kafka-server-stop.sh config/server.properties > /tmp/kafka.log 2>&1 &

sleep 3

/etc/init.d/zookeeper start
cd /opt/kafka; sudo nohup bin/kafka-server-start.sh config/server.properties > /tmp/kafka.log 2>&1 &

