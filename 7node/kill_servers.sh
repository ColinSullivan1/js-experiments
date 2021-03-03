#!/bin/sh

kill `ps -aef | grep nats-server | cut -c 7-12`

