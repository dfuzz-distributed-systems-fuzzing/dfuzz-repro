#!/bin/bash
cd $(dirname "$0")
#id
#whoami
#strace -fetrace=connect
fuser -KILL -kn tcp 2444
rm dump.rdb
./redis-server --port 2444 >> server.log 2>&1  &
disown
sleep 0.2
./redis-cli -p 2444 >> client.log 2>&1
