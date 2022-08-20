#!/bin/bash -x

#mkdir -p /root/xyxu_workspace/data-runs
#ROOT=$(mktemp --directory --tmpdir=/root/xyxu_workspace/data-runs)
#echo root dir $ROOT

export ASAN_OPTIONS=detect_leaks=0
#export PGDATA=$ROOT
#/root/xyxu_workspace/postgres/src/backend/initdb $PGDATA

#/root/xyxu_workspace/postgres/src/backend/postgres --single -D $PGDATA postgres << EOF
#create database root
#EOF
pkill -KILL postgres
/root/zhiyong_workshop/Quaff_DBMS/databases/postgres_source_1/src/backend/postgres.dfuzz-export,dfuzz-counter,dfuzz-normalize-instrument.out -D /root/zhiyong_workshop/Quaff_DBMS/fuzz/postgres/data_sqlsmith -p 3333 &
sleep 2

while true; do

/root/zhiyong_workshop/Quaff_DBMS/databases/postgres_source_1/src/bin/psql/psql.dfuzz-export,dfuzz-counter,dfuzz-normalize-instrument.out -d postgres  -p 3333
sleep 2

done;
