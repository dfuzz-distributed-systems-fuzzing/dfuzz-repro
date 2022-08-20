#! /bin/bash -ux
cd $(dirname "$0")
cd ..
rm -rf db_fuzz
cp -r db_fuzz_bak db_fuzz
cd -
pkill -KILL comdb2.dfuzz-counter-instruemnt.out
pkill -KILL cdb2sql.dfuzz-counter-instruemnt.out
./comdb2.dfuzz-counter-instrument.out --lrl /root/ljie_workspace/comdb2/db_fuzz/db_fuzz.lrl db_fuzz >>server.log 2>&1 &
disown
sleep 0.5
exec ./cdb2sql.dfuzz-counter-instrument.out db_fuzz >>client.log 2>&1

