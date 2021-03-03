#!/bin/bash

curl -s localhost:8222/varz | grep \"mem\"

for (( i=1; i<=100; i++ ))
do  
   echo { \"durable_name\": \"cons$i\", \"deliver_subject\": \"bar\", \"deliver_policy\": \"new\", \"ack_policy\": \"all\", \"max_deliver\": 1024, \"replay_policy\": \"instant\", \"max_ack_pending\": 1024 } > tmp.json
   natscli consumer create --config=tmp.json strm$i
   echo "i=$i"
done

curl -s localhost:8222/varz | grep \"mem\"

