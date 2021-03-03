#!/bin/bash

curl -s localhost:8222/varz | grep \"mem\"

for (( i=1; i<=500; i++ ))
do  
   echo { \"name\": \"strm$i\", \"subjects\": [ \"foo$i\" ], \"retention\": \"limits\", \"max_consumers\": -1, \"max_msgs\": 1000000, \"max_bytes\": -1, \"max_age\": 0, \"max_msg_size\": -1, \"storage\": \"file\", \"discard\": \"old\", \"num_replicas\": 2 } > tmp.json
   natscli stream create --config=tmp.json > oo
   echo "i=$i"
   curl -s localhost:8222/varz | grep \"mem\"
done

