#!/bin/sh

# launch a 2 node invalid JS cluster

nats-server -c s1.conf &
nats-server -c s2.conf &


