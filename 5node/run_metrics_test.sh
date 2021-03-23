#!/bin/sh

SaveMetric() {
    sdate=`date +"%T"`
    prefix="$1,`date +"%T"`"
    echo ${prefix}
    echo "server_name, server_id, mem, in_msgs, out_msgs, in_bytes, out_bytes, cpu, js_storage" > metrics/$3.csv
    curl -s $2/varz cat | jq -r '[.server_name, .server_id, .mem, .in_msgs, .out_msgs, .in_bytes, .out_bytes, .cpu, .jetstream.stats.storage] |  @csv'  >> metrics/$3.csv
    curl -s $2/routez   | jq -r '(.routes[0] | keys_unsorted), (.routes[] | to_entries | map(.value))|@csv' >> metrics/$3.csv
    sed 's/^/'"$prefix"',/' metrics/$3.csv >> metrics/$3.complete.csv
}

GetMetrics() {
   SaveMetric $1 "localhost:8221" s1
   SaveMetric $1 "localhost:8222" s2
   SaveMetric $1 "localhost:8223" s3
   SaveMetric $1 "localhost:8224" s4
   SaveMetric $1 "localhost:8225" s5
}

../scripts/kill_servers.sh

mkdir -p metrics
mkdir -p logs
mkdir -p storage
rm -rf metrics/*
rm -rf storage/*

./launch_cluster.sh

sleep 1

GetMetrics "Initial_Metrics"
sleep 60
GetMetrics "1_Minute_Idle_No_Stream" 

GetMetrics "Before_1_Stream"
nats stream create --config=stream.json foostream
sleep 60
GetMetrics "1_Minute_One_Stream" 

GetMetrics "Before_Publishing_100MB"
nats request foo "{{Random 1024 1024}}" --count 100000
sleep 20
GetMetrics "After_Publishing"

GetMetrics "Before_Consumer_Creation"
nats consumer create foostream cons1 --config=consumer.json
sleep 60
GetMetrics "1_Minute_One_Stream_and_One_Consumer" 

GetMetrics "Before_Consumption"
simplesub/sub.sh
sleep 10
GetMetrics "After_Consumption"

