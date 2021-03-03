#!/bin/sh

natscli stream create --config=stream1.json 
natscli consumer create --config=cons1.json stream1 

