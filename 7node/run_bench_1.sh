#!/bin/sh

nats stream create --config=templates/stream1.json 
nats consumer create --config=templates/cons1.json stream1 

nats bench --ack --size=1024 foo
