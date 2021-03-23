#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
export CLASSPATH=$DIR/jars/jnats-2.9.0.jar:$DIR
java -cp $CLASSPATH NatsJsSimpleSub "localhost:4222" foo 100000 cons1

