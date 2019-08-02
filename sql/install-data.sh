#!/bin/bash
MYSQL_ROOT_PASSWORD="root"

mysql -uroot -p$MYSQL_ROOT_PASSWORD <<EOF
source create_trade_history.sql;
source create_trade_log.sql;
EOF
#
./init_trade_history.sh
