#!/bin/sh

mkdir -p storage
rm -rf storage/*

mkdir -p logs
rm logs/*.log

nats-server -c conf/s1.conf &
nats-server -c conf/s2.conf &
nats-server -c conf/s3.conf &
nats-server -c conf/s4.conf &
nats-server -c conf/s5.conf &

