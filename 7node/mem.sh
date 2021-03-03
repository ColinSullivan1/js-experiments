#!/bin/sh

for (( i=1; i<=8; i++ ))
do
   echo to "Memory from server s$i"
   curl -s localhost:822$i/varz | grep \"mem\"
   echo ""
done

