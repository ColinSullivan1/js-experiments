#!/bin/sh

# launch a 3 node simple JS cluster

nats-server -c s1.conf &
nats-server -c s2.conf &
nats-server -c s3.conf &




# natscli stream create --config=stream1.json 
# natscli consumer create --config=cons1.json stream1 

