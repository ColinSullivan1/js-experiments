#!/bin/sh

nats stream create --config=stream1.json 
nats consumer create --config=cons1.json stream1 

