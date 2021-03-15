#!/bin/sh

# launch a 3 node simple JS cluster

mkdir -p storage
mkdir -p logs

rm logs/*.log

nats-server -c conf/s1.conf &
nats-server -c conf/s2.conf &
nats-server -c conf/s3.conf &
nats-server -c conf/s4.conf &
nats-server -c conf/s5.conf &

