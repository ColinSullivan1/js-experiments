#!/bin/sh

natscli stream create --config=templates/stream1.json 
natscli consumer create --config=templates/cons1.json stream1 

natscli bench --ack --size=1024 foo
