# ViaBTC Exchange Server

ViaBTC Exchange Server is a trading backend with high-speed performance, designed for cryptocurrency exchanges. It can support up to 10000 trades every second and real-time user/market data notification through websocket.

## Architecture

![Architecture](https://user-images.githubusercontent.com/1209350/32476113-5ffc622a-c3b0-11e7-9755-924f17bcc167.jpeg)

For this project, it is marked as Server in this picture.

## Code structure

**Required systems**

* MySQL: For saving operation log, user balance history, order history and trade history.

* Redis: A redis sentinel group is for saving market data.

* Kafka: A message system.

**Base library**

* network: An event base and high performance network programming library, easily supporting [1000K TCP connections](http://www.kegel.com/c10k.html). Include TCP/UDP/UNIX SOCKET server and client implementation, a simple timer, state machine, thread pool. 

* utils: Some basic library, including log, config parse, some data structure and http/websocket/rpc server implementation.

**Modules**

* matchengine: This is the most important part for it records user balance and executes user order. It is in memory database, saves operation log in MySQL and redoes the operation log when start. It also writes user history into MySQL, push balance, orders and deals message to kafka.

* marketprice: Reads message(s) from kafka, and generates k line data.

* readhistory: Reads history data from MySQL.

* accesshttp: Supports a simple HTTP interface and hides complexity for upper layer.

* accwssws: A websocket server that supports query and pushes for user and market data. By the way, you need nginx in front to support wss.

* alertcenter: A simple server that writes FATAL level log to redis list so we can send alert emails.

## Compile and Install

**Operating system**

Ubuntu 14.04 or Ubuntu 16.04. Not yet tested on other systems.

**Requirements**

See [requirements](https://github.com/viabtc/viabtc_exchange_server/wiki/requirements). Install the mentioned system or library.

You MUST use the depends/hiredis to install the hiredis library. Or it may not be compatible.

**Compilation**

Compile network and utils first. The rest all are independent.

**Deployment**

One single instance is given for matchengine, marketprice and alertcenter, while readhistory, accesshttp and accwssws can have multiple instances to work with loadbalancing.

Please do not install every instance on the same machine.

Every process runs in deamon and starts with a watchdog process. It will automatically restart within 1s when crashed.

The best practice of deploying the instance is in the following directory structure:

```
matchengine
|---bin
|   |---matchengine.exe
|---log
|   |---matchengine.log
|---conf
|   |---config.json
|---shell
|   |---restart.sh
|   |---check_alive.sh
```

## API

[HTTP Protocol](https://github.com/viabtc/viabtc_exchange_server/wiki/HTTP-Protocol) and [Websocket Protocol](https://github.com/viabtc/viabtc_exchange_server/wiki/WebSocket-Protocol) documents are available in Chinese. Should time permit, we will have it translated into English in the future.

### Third-party Clients

- [Python3 API realisation](https://github.com/testnet-exchange/python-viabtc-api)
- [Ruby Gem 💎](https://github.com/krmbzds/viabtc)

## Websocket authorization

The websocket protocol has an authorization method (`server.auth`) which is used to authorize the websocket connection to subscribe to user specific events (trade and balance events).

To accomodate this method your exchange frontend will need to supply an internal endpoint which takes an authorization token from the HTTP header named `Authorization` and validates that token and returns the user_id.

The internal authorization endpoint is defined by the `auth_url` setting in the config file (`accessws/config.json`).

Example response: `{"code": 0, "message": null, "data": {"user_id": 1}}`

## Websocket configuration

Nginx server is required to access websocket server.

Place the accessws.conf file in the Nginx configuration directory /etc/nginx/conf.d/ to access websocket.

The websocket is configured to accessible on the port 8090.

## Exchange Server - Installation

### kafka

$ wget http://mirror.bit.edu.cn/apache/kafka/2.3.0/kafka_2.12-2.3.0.tgz

$ sudo tar zxvf kafka_2.12-2.3.0.tgz -C /opt/

$ cd /opt

$ sudo ln -s  kafka_2.12-2.3.0  kafka

### base

$ sudo apt-get update 

$ sudo apt-get install wget vim psmisc libev-dev libssl-dev libmpdec-dev libjansson-dev libmysqlclient-dev -y

$ sudo apt-get install build-essential autoconf libtool python -y

### mysql

$ sudo apt-get install mysql-server -y

### redis

$ sudo apt-get install redis-server -y

$ sudo apt-get install zookeeperd -y

### librdkafka

$ wget https://codeload.github.com/edenhill/librdkafka/tar.gz/v0.11.3 -O librdkafka.tar.gz

$ tar xzvf librdkafka.tar.gz

$ rm -rf librdkafka.tar.gz

$ cd librdkafka-*

$ ./configure --prefix=/usr/local

$ sed -i "s/WITH_LDS=/#WITH_LDS=/g" Makefile.config

$ make 

$ sudo make install

### curl

$ wget https://codeload.github.com/curl/curl/tar.gz/curl-7_57_0 -O curl-7.57.0.tar.gz

$ tar xzvf curl-7.57.0.tar.gz

$ rm -rf curl-7.57.0.tar.gz

$ mv curl-* curl

$ cd curl

$ ./buildconf

$ ./configure --prefix=/usr/local --disable-shared --enable-static --without-libidn --without-ssl --without-librtmp --without-gnutls --without-nss --without-libssh2 --without-zlib --without-winidn --disable-rtsp --disable-ldap --disable-ldaps --disable-ipv6

$ make

$ sudo make install

### liblz4-dev

$ sudo apt-get install -y liblz4-dev

### viabtc_exchange_server build and run

$ git clone https://github.com/nathan3651/viabtc_exchange_server.git

$ cd viabtc_exchange_server/sql

$ ./install-data.sh 

$ cd ..

$ ./shell/build.sh

$ sudo ./shell/kafka-srv.sh

$ sudo ./shell/start.sh

