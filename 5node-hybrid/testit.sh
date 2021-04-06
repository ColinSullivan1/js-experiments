#!/bin/sh

echo "Creating stream on non-js node"
nats -s "127.0.0.1:4222" stream create --config=stream.json orders

echo ""

echo "Creating stream on js node"
nats -s "127.0.0.1:4223" stream create --config=stream.json orders

