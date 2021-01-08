#!/bin/sh

# launch a 3 node simple JS cluster

nats-server -s s1.conf &
nats-server -s s1.conf &
nats-server -s s3.conf &




natscli stream create --config=stream1.json 
natscli consumer create --config=cons1.json stream1 

