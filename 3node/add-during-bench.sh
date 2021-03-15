#!/bin/sh

nats stream create --config=stream1.json 
nats consumer create --config=cons-noack.json stream1 

sleep 1
nats bench --pub=0 --sub=1 bar &
sleep 1
nats bench --pub=1 --ack --sub=0 foo &

nats-server -c add.conf &
