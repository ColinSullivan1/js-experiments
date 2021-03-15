// package io.nats.examples;

import io.nats.client.Connection;
import io.nats.client.JetStream;
import io.nats.client.Message;
import io.nats.client.Nats;
import io.nats.client.PushSubscribeOptions;
import io.nats.client.Subscription;

import java.time.Duration;

public class NatsJsSimpleSub {

    static final String usageString =
            "\nUsage: java NatsSub server <subject> <msgCount>\n"
            + "\nThe JetStream consumer must exist.";

    public static void main(String[] args) {
        String server = null;
        String subject = null;
        String durable = null;
        int count = 0;

        if (args.length >= 3) {
            server = args[0];
            subject = args[1];
            count = Integer.parseInt(args[2]);
        }
        if (args.length == 4) {
            durable = args[3];
        } else {
            System.out.println(usageString);
            System.exit(-1);
        }

        System.out.printf("Connecting to server at %s...", server);

        try (Connection nc = Nats.connect(server)) {

            System.out.println(" Connected.");

            JetStream js = nc.jetStream();
            
            System.out.printf("Subscribing to %s...", subject);
            Subscription sub;
            if (durable != null) {
                sub = js.subscribe(subject, PushSubscribeOptions.builder().durable(durable).build());
            } else {
                sub = js.subscribe(subject);
            }
            System.out.println("Subscribed.");
            
            nc.flush(Duration.ofSeconds(5));

            System.out.println("Listening for messages.");
            for(int i=0;i<count;i++) {
                Message msg = sub.nextMessage(Duration.ofHours(1));
                msg.ack();
            }
            nc.flush(Duration.ofSeconds(5));

            System.out.println("Done.");
        }
        catch (Exception exp) {
            System.err.println(exp);
        }
    }
}

