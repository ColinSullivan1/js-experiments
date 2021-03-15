#!/bin/sh

SaveMetric() {
    echo `date +"%T"` $1 >> $3
    echo "server_name, server_id, mem, in_msgs, out_msgs, in_bytes, out_bytes, cpu, js_storage" >> $3
    curl -s $2/varz cat | jq -r '[.server_name, .server_id, .mem, .in_msgs, .out_msgs, .in_bytes, .out_bytes, .cpu, .jetstream.stats.storage] |  @csv'  >> $3
    curl -s $2/routez   | jq -r '(.routes[0] | keys_unsorted), (.routes[] | to_entries | map(.value))|@csv' >> $3
    echo ""
}

GetMetrics() {
   SaveMetric $1 "localhost:8221" metrics/s1.metrics
   SaveMetric $1 "localhost:8222" metrics/s2.metrics
   SaveMetric $1 "localhost:8223" metrics/s3.metrics
   SaveMetric $1 "localhost:8224" metrics/s4.metrics
   SaveMetric $1 "localhost:8225" metrics/s5.metrics
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

GetMetrics "Before_Publishing"
nats request foo "{{Random 1024 1024}}" --count 10000
GetMetrics "After_Publishing"

GetMetrics "Before_Consumer_Creation"
nats consumer create foostream cons1 --config=consumer.json
sleep 60
GetMetrics "1_Minute_One_Stream_and_One_Consumer" 

GetMetrics "Before_Consumption"
simplesub/sub.sh
sleep 1
GetMetrics "After_Consumption"

