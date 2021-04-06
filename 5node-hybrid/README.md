# Test

## Servers

- s1,no JS, 127.0.0.1:4221
- s2,no JS, 127.0.0.1:4222
- s3, JS, 127.0.0.1:4223
- s4, JS, 127.0.0.1:4224
- s5, JS, 127.0.0.1:4225


## Testing

```text
 $ ./launch_cluster.sh 
 $ ./testit.sh 
Creating stream on non-js node
nats: error: could not create Stream: nats: no responders available for request

Creating stream on js node
Stream orders was created

Information for Stream orders created 2021-04-06T11:41:01-06:00

Configuration:

             Subjects: foo
     Acknowledgements: true
            Retention: File - Limits
             Replicas: 3
       Discard Policy: Old
     Duplicate Window: 2m0s
     Maximum Messages: 1,000,000
        Maximum Bytes: unlimited
          Maximum Age: 0.00s
 Maximum Message Size: unlimited
    Maximum Consumers: unlimited


Cluster Information:

                 Name: c1
               Leader: s3
              Replica: s4, current, seen 0.00s ago
              Replica: s5, current, seen 0.00s ago

State:

             Messages: 0
                Bytes: 0 B
             FirstSeq: 0
              LastSeq: 0
     Active Consumers: 0
$ ../scripts/kill_servers.sh 
```
