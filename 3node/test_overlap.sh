#!/bin/bash

echo { \"name\": \"strm_a\", \"subjects\": [ \"foo\" ], \"retention\": \"limits\", \"max_consumers\": -1, \"max_msgs\": 1000000, \"max_bytes\": -1, \"max_age\": 0, \"max_msg_size\": -1, \"storage\": \"file\", \"discard\": \"old\", \"num_replicas\": 2 } > tmp.json

natscli stream create --config=tmp.json > oo

echo { \"name\": \"strm_b\", \"subjects\": [ \"foo\" ], \"retention\": \"limits\", \"max_consumers\": -1, \"max_msgs\": 1000000, \"max_bytes\": -1, \"max_age\": 0, \"max_msg_size\": -1, \"storage\": \"file\", \"discard\": \"old\", \"num_replicas\": 2 } > tmp.json

natscli stream create --config=tmp.json > oo
